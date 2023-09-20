Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6557A87C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjITPBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjITPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:01:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADF191;
        Wed, 20 Sep 2023 08:01:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-402d499580dso75008185e9.1;
        Wed, 20 Sep 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222068; x=1695826868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0MPgiZbxZbSzUsXqTDVKwoPGRFcJqc+1YPwRP9UNJI=;
        b=hZgj0W6EFlCR2WlTMr4kM7OM6nYpWxXNPWDaopCx+kGFzO2E/6+QXLF/rVHqFt9Ac6
         6vSn2vw06OREX0jBG14HpyYwLeRH01o+BuSqNx4PpC+wDwirKnJpXZdQIF3W2tbcKaep
         7zVUikc9wQ8rQBWQfvxdk22W+pLRjfsWH40mRXIocMrKUcxdRunkBJZN/wN9vmLID3t3
         wsiz6J1Cl0ID9KBfM+M7SbQRNgXnSLb/Z+U79nI8IfveyyyU20JJTw43Q/SnDV/5H7Bs
         3xeypfEh4jmwp8V3QXG73qn8On6ZUlOF6F6Qbl5bqKseygHFf1JawvbzLJD+dcp2+Bal
         XznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222068; x=1695826868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0MPgiZbxZbSzUsXqTDVKwoPGRFcJqc+1YPwRP9UNJI=;
        b=olRrtFhdY2E7qidtFx2dMj/Lx3NEqn4LdPvkAqL3TbtNt2+NoE+cUdDR+gdIwY1HYK
         akbHl+PIOm5o2/+KYqVF/UOkmJA8VSy86SDJHq76NREytCS/Sm/vkMWb5Zup+sJyQSA1
         XlUUHKlsyzKb/mHun6l0r5cwQgS2EyDzWOMeRQBlZtrGT5u+SwBLk6oCOQs+yiHR0L1+
         dFXfP9w7gdilG3fmz7ddeWSjeAcbqdBUElc3TLedh0unQzoE/tJqRA/Yn5fADS10tW7W
         pryQIP0Vyrehek2fBLuWunBmGqLwdIoMJLFBFhBnFXMhZbpiQ0X+K+A6u1A73BKJ8rzp
         TFgg==
X-Gm-Message-State: AOJu0Yx1GJtD5dMT+0SIBWSmrcK4wFU8cnBtGJvRRsaI/hG9l0efZ7YC
        oGnV4BJuTE/+GXodOYe5bkH+mfMhurRQGNs7fEc=
X-Google-Smtp-Source: AGHT+IER8+VELFzpEVI2XHFwY0rPDpYyCVCmhJX++vO0mopYjoeBzOgJ7ln8g04ac+lGVxO2UpImhg==
X-Received: by 2002:a7b:c859:0:b0:402:95a0:b2ae with SMTP id c25-20020a7bc859000000b0040295a0b2aemr2444890wml.32.1695222067223;
        Wed, 20 Sep 2023 08:01:07 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id a24-20020a05600c225800b00402d7105035sm2170550wmm.26.2023.09.20.08.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:01:06 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:47:38 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 05/15] USB: typec: Check for EEPROM present
Message-ID: <ZQsGChGBq93Rh35U@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-6-alkuor@gmail.com>
 <ZQhGUKocVc+yjOVL@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhGUKocVc+yjOVL@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:45:04PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:29AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > When an EEPROM is present, tps25750 loads the binary configuration from
> > EEPROM. Hence, all we need to do is wait for the device to switch to APP
> > mode
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> > ---
> >  drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
> >  drivers/usb/typec/tipd/tps6598x.h |  3 +++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index fea139c72d6d..b3d4b2b5bf5f 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -37,6 +37,7 @@
> >  #define TPS_REG_STATUS			0x1a
> >  #define TPS_REG_SYSTEM_CONF		0x28
> >  #define TPS_REG_CTRL_CONF		0x29
> > +#define TPS_REG_BOOT_STATUS		0x2D
> >  #define TPS_REG_POWER_STATUS		0x3f
> >  #define TPS_REG_RX_IDENTITY_SOP		0x48
> >  #define TPS_REG_DATA_STATUS		0x5f
> > @@ -897,6 +898,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
> >  	int ret;
> >  	unsigned long timeout;
> >  	u8 mode;
> > +	u64 status = 0;
> > +
> > +	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * Nothing to be done if the configuration
> > +	 * is being loaded from EERPOM
> > +	 */
> > +	if (status & TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT)
> > +		goto wait_for_app;
> >  
> >  	ret = tps25750_start_patch_burst_mode(tps);
> >  	if (ret) {
> > @@ -908,6 +920,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
> >  	if (ret)
> >  		return ret;
> >  
> > +wait_for_app:
> >  	timeout = jiffies + msecs_to_jiffies(1000);
> >  
> >  	do {
> > diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> > index 527857549d69..5e942c089c27 100644
> > --- a/drivers/usb/typec/tipd/tps6598x.h
> > +++ b/drivers/usb/typec/tipd/tps6598x.h
> > @@ -199,4 +199,7 @@
> >  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
> >  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
> >  
> > +/* BOOT STATUS REG*/
> > +#define TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
> 
> That's not TPS25750 specific bit, so please rename that to
> TPS_BOOT_STATUS_I2C_EEPROM_PRESENT
> 
I will fix it in v6.
> thanks,
> 
> -- 
> heikki

Thanks,
Abdel
