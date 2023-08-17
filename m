Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50F877F678
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350880AbjHQMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbjHQMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:32:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB277271F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692275490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j+xsGM0xCcV9RwUrKQrUxI1E3eQXED1KqHZXvIE2BI4=;
        b=Mp2znDCpx20zLTxH3+NDm97sUn13LBf8rHPOowdlhR/QnNQtPXniGYGk+lsKd96DGe5WqW
        p5iMeAfJWRnhfvichh6O2imkAhvo5OV8iIO8UoctN6WdE41n+Ab1vOTTd39FzUC3N7Jp6r
        BDtFbruMyFUbgE6mANxV2FHP8rciA5E=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-iqslg-6BNMSQ47JrH3_UsQ-1; Thu, 17 Aug 2023 08:31:28 -0400
X-MC-Unique: iqslg-6BNMSQ47JrH3_UsQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6b9c82f64b7so6096774a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692275487; x=1692880287;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+xsGM0xCcV9RwUrKQrUxI1E3eQXED1KqHZXvIE2BI4=;
        b=ipkCNkVP/xjo82YQsZKaCsn76l1caAGopHN3MB6p4BJop3ndJKa7IsG8k8460fMvB3
         WA/fPFl6LwEMRaMjSdEBF01jciyaOnVAz/xXjDo2yKl9YEYfbU3CMwwKZEv0tWDcfPNX
         RDGwI1y/XGOwYD89oLjh/FUMSbxfshNuni3V5RcfiAa3Pi8P5Eevps30gsnij2lG8nEj
         nFaRV508XoCMSwz2CzeiYqbjGzYdN3SYgcHbJc4zfMqbiIAthWfHN6rEABTXRCm+hSkD
         3ORqHSM/ogL2gIi4bihTnHto/vAA5dAyXRgpTNy7d9DcYMOIFdXELp1pZWz/qSQqRHb5
         +lFw==
X-Gm-Message-State: AOJu0YzCWdrl7HExbNUU5HYIj4Gozcf2KwPr2FRsUEUMeTTZaUu2YQFq
        OR8CzvWcwbSzcJ26v7M+AlEtPI9BaYGyNbMpZQ8Wnyhca1hfqmQZnz0Es8gr/7c2Fk9Kbk1zW3p
        EJ6vlPvZn+/0ISb9Ypg+gYtpG
X-Received: by 2002:a05:6830:1314:b0:6bc:f328:696e with SMTP id p20-20020a056830131400b006bcf328696emr4382922otq.0.1692275487740;
        Thu, 17 Aug 2023 05:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbLMPcppybJV+jOD4Mzdj/MSx7jY9uLAskDT3+YlZ3091KhVbY1KfqBrUcpg47H2FQH6IE8A==
X-Received: by 2002:a05:6830:1314:b0:6bc:f328:696e with SMTP id p20-20020a056830131400b006bcf328696emr4382911otq.0.1692275487502;
        Thu, 17 Aug 2023 05:31:27 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id a9-20020a05683012c900b006b74bea76c0sm7126970otq.47.2023.08.17.05.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:31:27 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Simple DRM frame buffer driver not working on Dell desktop with
 Nvidia card
In-Reply-To: <7287c4cc-2ac4-43a7-a60d-466d5299f576@molgen.mpg.de>
References: <7287c4cc-2ac4-43a7-a60d-466d5299f576@molgen.mpg.de>
Date:   Thu, 17 Aug 2023 14:31:24 +0200
Message-ID: <87bkf5g89v.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menzel <pmenzel@molgen.mpg.de> writes:

Hello Paul,

> Dear Linux folks,
>
>
> On the Dell OptiPlex 7021 with a dedicated Nvidia card, the monitor is 
> only connect to that, Linux 6.1.39 does not display any messages, and 
> the GRUB messages stay until the X.Org X Server starts.
>

It's a known issue. The Nvidia proprietary driver doesn't register an
emulated fbdev device and it relies on efifb to have fbcon/VT support.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

