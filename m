Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC67CBD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjJQI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJQI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:28:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9F393;
        Tue, 17 Oct 2023 01:28:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9adb9fa7200so1119564666b.0;
        Tue, 17 Oct 2023 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697531292; x=1698136092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3/wMuFLDLQySrQ1vNWs6CM5lnw8VddXrmIygItc0fo=;
        b=iS4br1xb6e8v+nSqHeHbG3b7QTjRUlLvhtvSi4KPninzoFClRVHAifzZKcGLmPmj5y
         jwHE+W0tO6Ui4kvW4zhQyAaeePuParwfo8yt/CNWMVq/lVaf0ZmkBf4eDO+UGm4Pt99B
         NOFj4CARL5nlJaQG4pSJqXJV+g3kwUSD5VbVWhFfNJcrw1OF696w/MH0Tmr+PwOrt2pi
         VVEwVP1JvJHWVFb1asn6w06+K3UQwTFziijW/Ybc5Y7B3hV19ztbLhcSALfMu4mq8H/0
         Fb6NDV3f30GuzNJrwCN7WzYzmbTZ5493RK25u1actpjb1z2xlRx9JRGQcexZS3f7T1Wd
         qm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531292; x=1698136092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3/wMuFLDLQySrQ1vNWs6CM5lnw8VddXrmIygItc0fo=;
        b=Nd1xs5H0TTO942wed9q3qqkdkFoZrsKLeCMFTs0nuRGF4M4Ufdy9lZIhPYy0SqcTYO
         n5Bt618ZDCHDCZX6W07NL1SNrNupZecQb0s2jjELRPVmb1BCQuFOoA/lVYrjC6ZA1+Ce
         1WDnH2crhq+bHcfKth8GtV+Tsf1XQc6KZi1a5UEjld/ZphRWgRaBAkee6O+J6z0fDNZr
         HoVGGF6zICRX+RKZlrNCZz90uFZuCKulEQBejxb1i484W9adRkIVyNrxrV+WljLMm5KY
         cnMbyA7unpOuHcHhTI+qC8HvL5XC8uuRIr5j9/31VFoOscEsw2QSUOhoEvg9V2wxJNh4
         GEHQ==
X-Gm-Message-State: AOJu0YzRObd8opJR6xWQzcpP4edPdBsIJ9L4AYIzizvrlpP+oMB0ftMy
        AuLWxktmueotEOzBfqYqIw==
X-Google-Smtp-Source: AGHT+IE5+yPNJCUjbAr15GkqYf43d4kmr1CxhVlh2iRhKG68i11ikT+sqUupHp7/AZLASdaSTXYfJw==
X-Received: by 2002:a17:907:86ac:b0:9ad:8641:e91b with SMTP id qa44-20020a17090786ac00b009ad8641e91bmr1091481ejc.11.1697531291363;
        Tue, 17 Oct 2023 01:28:11 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906195500b009adc7733f98sm777452eje.97.2023.10.17.01.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:28:10 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:28:06 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, andi.shyti@linux.intel.com
Subject: Re: [PATCH v2 1/5] Staging: sm750fb: Rename
 displayControlAdjust_SM750E
Message-ID: <ZS5FlsCPETnr8T5D@dorcaslitunya-virtual-machine>
References: <20231016201434.7880-1-anonolitunya@gmail.com>
 <20231016201434.7880-2-anonolitunya@gmail.com>
 <2023101724-diagram-legwork-0e53@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101724-diagram-legwork-0e53@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:50:50AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 16, 2023 at 11:14:08PM +0300, Dorcas AnonoLitunya wrote:
> > Rename function displayControlAdjust_SM750E to
> > display_control_adjust_SM750E. This follows snakecase naming convention
> > and ensures a consistent naming style throughout the file. Issue found by
> > checkpatch.
> > 
> > Mutes the following error:
> > CHECK:Avoid CamelCase: <displayControlAdjust_SM750E>
> > 
> > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index e00a6cb31947..8708995f676c 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -14,8 +14,8 @@
> >   * in bit 29:27 of Display Control register.
> >   */
> >  static unsigned long
> > -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> > -			     unsigned long dispControl)
> > +display_control_adjust_SM750LE(struct mode_parameter *pModeParam,
> > +			       unsigned long dispControl)
> >  {
> >  	unsigned long x, y;
> >  
> > @@ -125,7 +125,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
> >  			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
> >  
> >  		if (sm750_get_chip_type() == SM750LE) {
> > -			displayControlAdjust_SM750LE(pModeParam, tmp);
> > +			display_control_adjust_SM750LE(pModeParam, tmp);
> 
> Why is this function returning a value if it is just being ignored?
> 
> It's not the issue here in the patch, but for future changes.
>
Hi Greg,

I will do the correction in the next patchset to correct both functions
return value as this patchset was not focused on that. Does this mean
that this patchset has been accepted? Or should I submit another
patchset that includes the two changes suggested on function return
values?

thanks,

Dorcas
> thanks,
> 
> greg k-h
