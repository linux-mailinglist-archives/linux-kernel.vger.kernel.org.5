Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1FF7CC5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbjJQOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjJQOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:14:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145EEA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:14:56 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso3348088a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697552096; x=1698156896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYKaXFgMh27zA77Sv57kQ1nHe4k54A3JXG9co3ghebM=;
        b=VQKkDoG+1kSDOhN/rf1NJPHPhPcb/2Eab58lhcrFv9hRmFNUUpjW8HfchBY7ofCIcA
         j+issxA4BTQEKAE0UbPRh5h2l2oxlbaQBbLZ7EDqcuKRmcql9aREbo0g6NAzFv/gh7QV
         gOnPWJdoL/olhS0VAJNwXoK2h4SNNg752YPd3VJkJ5f+VfYOd6If7ltqDkZlVnGhE151
         swNb9IqRVciTgmsOS9+oFGwC9M+RfA4X/hQ6HIsnG0zh5PrpPwZ4K3L6GyLS6LseQRGM
         zXnq2Vc2IPkzSJHR+dd2Tl/NdtekChQanawL0ryKQZj6Gec5Bz08NPGpkhMgjVF4+pXt
         09ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552096; x=1698156896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYKaXFgMh27zA77Sv57kQ1nHe4k54A3JXG9co3ghebM=;
        b=t7GKb+Xe6E1JGIcIdjwW9Fwcb8tKX/+ax9ji6PFJ6Xsgb6Jm3c13AzKGaSnOZqu0fO
         Q/nk2AofP+lNNH4iKiIY/krGYjVkDQ1RhUJXiRI8YBstKIev7oLT2dcrTVWCOyWz1utn
         luwsoxPJCTH/SfyWHis1JDI46djI+2RuSsBS9D134ersacs7biNGXYxcvFvB7NTKKuZ4
         e9NA6GOOTizBbpa+0iZvGW3tFZevldv1u0KhT3Y+jfopfap+BMsZGizETiAHQx2E+L2n
         L2QTIbexJIFAN3Zz3wHG2BzBrEmNStZnZUAL3mAVGLNA896kl+CP1MCbRNIsWDro0BcC
         8jdg==
X-Gm-Message-State: AOJu0Yxvs7vHbLxBTnhCmloImBjEa0+Drv7MOYMSU4g298KqTCvvGBgx
        Jg5ICejaBDHX7MqWFhzhZQM=
X-Google-Smtp-Source: AGHT+IFTh+i5lRJT5UHhn0MJgDRAKM0QS/BrTLXJflKkvMML7uQTuYYeZ0C0+ZeJfYM4S56pLwKeXA==
X-Received: by 2002:a05:6a20:4429:b0:17a:4890:fa31 with SMTP id ce41-20020a056a20442900b0017a4890fa31mr2598983pzb.56.1697552095737;
        Tue, 17 Oct 2023 07:14:55 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id kx14-20020a170902f94e00b001c1f4edfb9csm1592789plb.173.2023.10.17.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:14:55 -0700 (PDT)
Date:   Tue, 17 Oct 2023 07:14:51 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <20231017141451.GB3156@ubuntu>
References: <20231016201154.GA14625@ubuntu>
 <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433b9d45-bb21-49eb-8062-c03bcffa90ff@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 07:02:33AM +0300, Dan Carpenter wrote:
> On Mon, Oct 16, 2023 at 01:11:54PM -0700, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > CHECK: Prefer using the BIT macro
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >  drivers/staging/rts5208/rtsx_card.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rts5208/rtsx_card.h b/drivers/staging/rts5208/rtsx_card.h
> > index 39727371cd7a..9d2504fddb13 100644
> > --- a/drivers/staging/rts5208/rtsx_card.h
> > +++ b/drivers/staging/rts5208/rtsx_card.h
> > @@ -338,7 +338,7 @@
> >  #define DMA_DIR_FROM_CARD		0x02
> >  #define DMA_EN				0x01
> >  #define DMA_128				(0 << 4)
> > -#define DMA_256				(1 << 4)
> > +#define DMA_256				BIT(4)
> >  #define DMA_512				(2 << 4)
> 
> No.  :P.  Look at the lines around it.  Now it's the odd duckling.
> 
> >  #define DMA_1024			(3 << 4)
> >  #define DMA_PACK_SIZE_MASK		0x30
> > @@ -542,7 +542,7 @@
> >  
> >  #define BLINK_EN			0x08
> >  #define LED_GPIO0			(0 << 4)
> > -#define LED_GPIO1			(1 << 4)
> > +#define LED_GPIO1			BIT(4)
> >  #define LED_GPIO2			(2 << 4)
> > 
> 
> Same.
> 
> regards,
> dan carpenter
>

Yeah, I understand now. Thanks for the review dan.

Regards,
Nandha Kumar Singaram
