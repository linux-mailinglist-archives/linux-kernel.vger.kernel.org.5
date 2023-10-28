Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8507DA946
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjJ1UZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1UZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 16:25:41 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2628AC2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:25:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b2f28caab9so1918803b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698524737; x=1699129537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6s/dbIiHsKw5qILIs0FnO/CHdVCCm522luSBKh8UXM=;
        b=ngF+86yTnPmVwkdBmzrES1X1CBeMciC1hz2SuYgB0I2VSAgg8RVztUpt12MjPLP9D9
         z8Hg/fjHOW1+FtMDAztP90eSsAau+3RWGwid4+gxtoOjo3LQAo0cvz4megKQGh0QkCFl
         pqRAk3xRczDpo9gc0I0lDMS6OnTTuefZf2RoSBWrcBmuMkxlAlc3o4f5EmqeHpJRoMGT
         BGr79HDtc1qZhXqEJR9NF5ldtUyTM6ViqI12KH6YkCkWz7rC8hVhfxnbed+9pxGprZIK
         K7bfTgFrxd1jcyQuC0DSC6LqDRlianwYAxCWx8+ghY+eT/Nga5fHOYFdoUyVkg5Jyxy0
         gATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698524737; x=1699129537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6s/dbIiHsKw5qILIs0FnO/CHdVCCm522luSBKh8UXM=;
        b=PtO7dVEqxFLvSBoT8+CNXGia2jLUzhSvwGXvUj0bAm8fF7RQbr8CNnxbTFs3zXZ8Ps
         JppDX5O2vV7C50gkgCBNIeDOGYl39c9qTukC79I4C6WrJeUoRj58FZ56XbEHSIDUq4bY
         fSXvyL1MMxh47XiFKTxfE9LHvq7jemtsMY7+X9NAqQmAQDnRPUn5aZnsbqQLuzkhZysh
         tJaDxy8txXnQxc4cOq8Y5Yuz33MppMIuVT4qskt2QhjrBnHEZ19o48HbN0onZwHXPSoo
         EwD8IlgosnuOgLodJ6ptoYlTLUi+MshqW6H/ofyhZa0tBFFnIjHck0CZrkB/m5TktXb6
         xmuw==
X-Gm-Message-State: AOJu0Yz2XLpAm2W9Pcn2fmk8qYVfI5+x9XM6p7rmP63yXoWnPDD5ESyk
        yAhsMRM9aKqdsyJX8fXQxv5KQS0K/jk=
X-Google-Smtp-Source: AGHT+IHgdcrSFcttPGdKfN9SFlEHz8t+uTkvmaSR08wn5o7z7JDWzEKSLWaWmcv5gBShAZhWs2kn5A==
X-Received: by 2002:a05:6808:2a87:b0:3ad:f536:2f26 with SMTP id fc7-20020a0568082a8700b003adf5362f26mr6254410oib.18.1698524737423;
        Sat, 28 Oct 2023 13:25:37 -0700 (PDT)
Received: from ubuntu ([122.171.167.85])
        by smtp.gmail.com with ESMTPSA id a18-20020aa780d2000000b006c06804cd39sm3288830pfn.153.2023.10.28.13.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 13:25:37 -0700 (PDT)
Date:   Sat, 28 Oct 2023 13:25:31 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Alex Elder <elder@ieee.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 3/3] staging: greybus: bootrom: fixed prefer using
 ftrace warning
Message-ID: <20231028202531.GB2432@ubuntu>
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
 <39be7bb04ce1362b00aa31a638ebe2e88dd81fec.1697976302.git.nandhakumar.singaram@gmail.com>
 <5d457162-d20a-43a5-989e-ef263fbd91b2@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d457162-d20a-43a5-989e-ef263fbd91b2@ieee.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 01:20:47PM -0500, Alex Elder wrote:
> On 10/22/23 7:22 AM, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> 
> This change looks reasonable to me, though I don't think
> ftrace provides device information.
> 
> Acked-by: Alex Elder <elder@linaro.org>
> 
> > ---
> >   drivers/staging/greybus/bootrom.c | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
> > index a8efb86de140..79581457c4af 100644
> > --- a/drivers/staging/greybus/bootrom.c
> > +++ b/drivers/staging/greybus/bootrom.c
> > @@ -491,8 +491,6 @@ static void gb_bootrom_disconnect(struct gb_bundle *bundle)
> >   {
> >   	struct gb_bootrom *bootrom = greybus_get_drvdata(bundle);
> > -	dev_dbg(&bundle->dev, "%s\n", __func__);
> > -
> >   	gb_connection_disable(bootrom->connection);
> >   	/* Disable timeouts */
>

Thanks Alex for the review and feedback.

Regards,
Nandha Kumar
