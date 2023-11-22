Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964E77F43FA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjKVKdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVKdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:33:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0F6D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:33:49 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77d66c7af31so28919385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700649228; x=1701254028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PTuvgdJsaL7l1CgYZKvzYqjZuoxEs3GDgWysnbP/+Eo=;
        b=bFv77YKNSaazuFZBTgO0zs+bAFd/5/7MOM89Ca/vcRJZGjv9x9Y5BcxrzRYbZb2mC0
         Raj56ABf86qFHUKfURxoaVgpQnFKziHUFSgv7pLJy+511Z9F3zGKnuw0c/78Gczx82hr
         UDQ7j+rs4uBkqCTUpzMlQxNl9VYU6D1OKvJnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649228; x=1701254028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTuvgdJsaL7l1CgYZKvzYqjZuoxEs3GDgWysnbP/+Eo=;
        b=cMrMRVAQsOpA5inmqLRbohkTeifrmC4DN6xvhDIhJ2nOrG9EUE8DULomlfIEdDzyte
         K54aViQP+xCulhc/TtEZW35lFxvx//YUyUXGNyWAK20hhyoEeYUjLrpbaWL91Vzxc0fi
         JJh+6LI2I/GmeMo3ApmbOSUlfdnJlOWISvOkyCe6F67gXCHZLf0YR0OIpMQeW3Vumjti
         2+6QPgMKcU0fCBDv9V6XkJAbiEidIlENgcYYq1zxUdndLNcVMcky8Wa5y34StWa+Jjk0
         4bRKPZjnON43G4BocDrmUPjJ9rZQNCjhF5tdRCAvdbqqhICYJSevtjHNAW5jf8mKqIoV
         +DfA==
X-Gm-Message-State: AOJu0YxbL1z9pUo8rQNl7ikUCVQ8Nq5vGuUCduhyIWpmxvrDuYlOl6cS
        g9qzXZSKE0r4l1AMEH2DgSaSbiLlgccc+exkuA3eRg==
X-Google-Smtp-Source: AGHT+IFatB5ZVUhUD4VSZlGoDvcI+lacgfzUpIY16hq8TK7RTKuRbxYTsFqo+bev6PvOZuMk1+psHg==
X-Received: by 2002:a05:6214:c63:b0:66d:59d2:4310 with SMTP id t3-20020a0562140c6300b0066d59d24310mr3695220qvj.14.1700649228065;
        Wed, 22 Nov 2023 02:33:48 -0800 (PST)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id v11-20020ad4528b000000b00677f7cf3ee9sm4496927qvr.81.2023.11.22.02.33.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 02:33:47 -0800 (PST)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-66d0760cd20so5861966d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:33:47 -0800 (PST)
X-Received: by 2002:a05:6214:d6d:b0:66f:b0c0:93bc with SMTP id
 13-20020a0562140d6d00b0066fb0c093bcmr3335961qvs.22.1700649226645; Wed, 22 Nov
 2023 02:33:46 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org> <ZV3QtDOLj-6js07v@valkosipuli.retiisi.eu>
In-Reply-To: <ZV3QtDOLj-6js07v@valkosipuli.retiisi.eu>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 11:33:35 +0100
X-Gmail-Original-Message-ID: <CANiDSCsuX93fQur92A_4TE1SHZSXGaTFEZwqqM9RBqpxKbnxLw@mail.gmail.com>
Message-ID: <CANiDSCsuX93fQur92A_4TE1SHZSXGaTFEZwqqM9RBqpxKbnxLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Always use uvc_status_stop()
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On Wed, 22 Nov 2023 at 10:58, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Tue, Nov 21, 2023 at 07:53:48PM +0000, Ricardo Ribalda wrote:
> > uvc_status_stop() handles properly the race conditions with the
> > asynchronous worker.
> > Let's use uvc_status_stop() for all the code paths that require stopping
> > it.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Thanks! I have slightly changed the code in v3 and kept your tag, hope
that it is fine.

Regards!

>
> --
> Sakari Ailus



-- 
Ricardo Ribalda
