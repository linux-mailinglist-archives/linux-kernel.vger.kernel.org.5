Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA497F43BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjKVJ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:55:39 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52605173D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:55:30 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7c44f5f3ca2so18961241.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700646928; x=1701251728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R43NIo2R73VFGzF1JM47RjgeeYfm8PK9++R7O6siHDc=;
        b=C93DymPHwAeqrJ61DqxMBceoZr5Dleo4gbsUe9uqNfgEncXtZ3nH0YmQ0nb4pVJYQc
         wB1/Lb5ulr7noGMjYgC6+/e0/8IkOGI6Bk4aP5Va3en/kPGCaiWia4Ss11UgypNnyaqN
         FyBeuTQMp5xIrv+86vzggkLPvLWZ9m+sJoZoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646928; x=1701251728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R43NIo2R73VFGzF1JM47RjgeeYfm8PK9++R7O6siHDc=;
        b=X4yXZPhiJkyWGeL4Vws8aMApbSU5GV9bPMq3vQBm+n+WkKzI3mfdnXyOyXHC2lr+Xw
         nLCJA7nNvg1EMI33iU/RQmFioSZLUQU06/emSBn7PwTy/OW7LquyODSz60BqACYQFteu
         hITsTAp0dcWTB3ZRNDTMskRauZtJTJrZunSXLEBlQf7wMBpJbi9tU+mhcn6gcF8qRlpZ
         7nckiDuLGWCuhAHHCb9r82ZXoV/AIvtiajo6ju8/CWjqON5btAUsA+yaZWUsMuxnHtBc
         aKq+iSMz2AGuUejghyD6Xa0JnrIdRU0hFVJzV0XZZH5zxyDBK+R2DccM6scNgDF9gh5f
         fP/A==
X-Gm-Message-State: AOJu0Yzbjyk/sd7JkTNyEQI3kHLXZq3CwgGezp1Qq6EYPJ+zCh47pbQm
        8PxZihr9ecNyaESFL+05reVCT8TmAzHvxa7Gy4SLvw==
X-Google-Smtp-Source: AGHT+IF4hxW4BfWJquZ6SEAXxCvyebWuAtDLL8X1mH2lwDzUEaDYRFQcpNKIjPWsyJgoJtYYotQUiQ==
X-Received: by 2002:a67:be19:0:b0:462:8087:6ad7 with SMTP id x25-20020a67be19000000b0046280876ad7mr2038410vsq.17.1700646928579;
        Wed, 22 Nov 2023 01:55:28 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id ks23-20020ac86217000000b00419ab6ffedasm4284186qtb.29.2023.11.22.01.55.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 01:55:28 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-679dc22f2b7so17460076d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:55:28 -0800 (PST)
X-Received: by 2002:a05:6214:27c9:b0:679:e48e:1ec1 with SMTP id
 ge9-20020a05621427c900b00679e48e1ec1mr1682833qvb.38.1700646927641; Wed, 22
 Nov 2023 01:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org> <20231122074742.GB1465745@google.com>
 <20231122080132.GA1526356@google.com>
In-Reply-To: <20231122080132.GA1526356@google.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 10:55:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCuT6uK+qGJJus=s2DjsnvqxKg4ek9xbssOw5bpmQm_e-A@mail.gmail.com>
Message-ID: <CANiDSCuT6uK+qGJJus=s2DjsnvqxKg4ek9xbssOw5bpmQm_e-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after disconnect
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
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

Hi Sergey

On Wed, 22 Nov 2023 at 09:01, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/11/22 16:47), Sergey Senozhatsky wrote:
> > Can the following happen?
>
> Consider the following case (when CPU1 experienced a delay, a preemption
> or anything):
>
> > CPU0                                            CPU1
> >  uvc_disconnect()
> >                                               uvc_video_stop_streaming()
> >  usb_set_intfdata()
> >  uvc_unregister_video()
> >
> >                                               if (!smp_load(&dev->disconnected))
> >
> >  smp_store_release(&dev->disconnected, true);
> >
> >  kref_put(&dev->ref, uvc_delete);
>
> >                                                       uvc_video_halt()
>
> That uvc_video_halt() cannot be legal, right?

This patch only takes care of calls to uvc_video_stop_streaming()
after .disconnect.

Guenter's patch from this series should take care of the concurrent
calls. I will resend making it explicit.

Thanks!


-- 
Ricardo Ribalda
