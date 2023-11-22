Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2CC7F3F68
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjKVIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKVIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:01:40 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA7B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:01:37 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso5298932b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700640097; x=1701244897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vMmjhnu0PvfBZhQhustU0DH60MxPgIkfUurMB4lRK1U=;
        b=R9zSnFGKEZ5FPcLqarhekvkDlcMotsnh9Bv36hA5B0s8COuClFyhr4P5aC9lM6ftTj
         ks+WdrB06oV0PsSEHXUQ3eu0HsTxygpHA11tCXeHOdjSFRmIoHE4oED9Wx+fXj9Lklgk
         9ice6PrrNTy2bvUjM0T1Ivomxpv6JHBNUqL5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700640097; x=1701244897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMmjhnu0PvfBZhQhustU0DH60MxPgIkfUurMB4lRK1U=;
        b=WyFyCeSluLQCMbo4IO4z4nnU3HGgKinLLxiM9SQsZdJtgIwZE+Is1pckAKh/d4IWkQ
         GHId5qAD+G+R4kI8ZGizDZHWI6sdfmSAjJUa6p3GO/NAo/+vBn/trXSTRZiVdyykAyn9
         R8UpdwaI6U3z76JHIMkNrlM9U542TJZINwW8SNm5bzITGZ3F7zv1MTFvLQIolqAtQNz4
         9W0CKWamT81N7HNr8nDPaf1118Auu1etDEN8qkrJYiGA0aSW2qytZXKGNAci6Q1K0jDl
         EoksqoCYjhJra7f27dxplCnivKjDjH0h7F6wttYPz6j367Sxgs6eivxOOw0XbeLWDq0R
         OM9A==
X-Gm-Message-State: AOJu0Yw8mJqaVt1dec8cvzMoDOfxoIRtiWPMu1+1KQIYixtvRikS1mmJ
        wNMRIxoBMMvSD3IIIpzxcX2SMQ==
X-Google-Smtp-Source: AGHT+IHN/u7HmN+bTOEsR0eDkQ7DJteSflN8Sc29ZQN2H1z6RusngfhDIKmoCGd6Y4A8KibwRamZIA==
X-Received: by 2002:a05:6a00:1c9c:b0:6cb:a60c:2143 with SMTP id y28-20020a056a001c9c00b006cba60c2143mr1807945pfw.9.1700640096790;
        Wed, 22 Nov 2023 00:01:36 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1aba:fb75:807e:7620])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78081000000b0065a1b05193asm9219898pff.185.2023.11.22.00.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:01:36 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:01:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after
 disconnect
Message-ID: <20231122080132.GA1526356@google.com>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org>
 <20231122074742.GB1465745@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122074742.GB1465745@google.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/22 16:47), Sergey Senozhatsky wrote:
> Can the following happen?

Consider the following case (when CPU1 experienced a delay, a preemption
or anything):

> CPU0                                            CPU1
>  uvc_disconnect()
> 						uvc_video_stop_streaming()
>  usb_set_intfdata()
>  uvc_unregister_video()
> 
> 						if (!smp_load(&dev->disconnected))
> 
>  smp_store_release(&dev->disconnected, true);
> 
>  kref_put(&dev->ref, uvc_delete);

> 							uvc_video_halt()

That uvc_video_halt() cannot be legal, right?
