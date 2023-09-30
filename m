Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2947B42D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjI3R5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjI3R5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:57:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF63E3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c724577e1fso51598335ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696096628; x=1696701428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye4XTAWb4daUNWZiDSISaHwk+X7iJoEzGWCL7sgi0rE=;
        b=FggECs0mPLgxcWtFYGjkFui3NvNmMxZ9Xr9H8G4dQUZKr+MYBiC5Z9+4EOt6b2NFiq
         oybo/ah6svBaPp5fG67JFoOlCUFkroXPiBHV+1iK4ShllGYbaTaH6+Uvw+jsEfuxGJxb
         LZBz0cWqvi6bN3Ntz0QR+QIxAqbNiqSTWa7E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696096628; x=1696701428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ye4XTAWb4daUNWZiDSISaHwk+X7iJoEzGWCL7sgi0rE=;
        b=ds1MBNwNYLG2Op3oXJ/Ux76JTzhEfIxsrb9HRg3kotSnKyyP+6/P2Q/weBSGf3oont
         qWvXysqINjzDtnyNqAbf3zqv902s4CCnkl1Q6tCP2V5BaqEH4DVwosJ68alRjJyXCZXx
         2jDbCW0f6CVx7Rg7K2orOnB7QL+Zb+DiA6oBkuSLOh4g1DcTiNLBTOBamHVXCJIXdPFk
         crvRpxu0+DYAudc320qhkc5WOpHPFrNVfzmIL7QSb28FYN9j5yuFsDuycN6dTfwY+Yqs
         00VAmSc8+pYBUji5GkBljnCRyoPH4anKqUeYx53gu3AHwM2JzK7cOGH2G7pHaulIHFHC
         oPIQ==
X-Gm-Message-State: AOJu0YwvipDuTojfi6O9kj6CRCAJFcN4Wgb2GX4c33Of3TGDSsMbpmwf
        Qsmr7U5INukQmKIyEY7q6RV8dw==
X-Google-Smtp-Source: AGHT+IFTEuvq+b7y368t9GEXwnKx90oqxSX/2b3AsPpSe1C2LnJOYtXNrap0hYgQfFUMDxuxcnPy6A==
X-Received: by 2002:a17:902:ee89:b0:1c5:f68d:cec3 with SMTP id a9-20020a170902ee8900b001c5f68dcec3mr6686648pld.64.1696096628167;
        Sat, 30 Sep 2023 10:57:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902820a00b001c1f161949fsm18920114pln.96.2023.09.30.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 10:57:07 -0700 (PDT)
Date:   Sat, 30 Sep 2023 10:57:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-adc: replace deprecated strncpy
Message-ID: <202309301056.5A21C37D5@keescook>
References: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
 <202309232006.690F89A@keescook>
 <20230930184118.73d7465a@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930184118.73d7465a@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 06:41:18PM +0100, Jonathan Cameron wrote:
> On Sat, 23 Sep 2023 20:15:09 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Thu, Sep 21, 2023 at 04:54:00AM +0000, Justin Stitt wrote:
> > > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > > 
> > > We should prefer more robust and less ambiguous string interfaces.
> > > 
> > > We expect adc->chan_name[val] to be NUL-terminated based on ch_name's
> > > use within functions that expect NUL-terminated strings like strncmp and
> > > printf-likes:
> > > | 	if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> > > | 		/* Check internal channel availability */
> > > | 		switch (i) {
> > > | 		case STM32_ADC_INT_CH_VDDCORE:
> > > | 			if (!adc->cfg->regs->or_vddcore.reg)
> > > | 				dev_warn(&indio_dev->dev,
> > > | 					 "%s channel not available\n", ch_name);
> > > ...
> > > 
> > > There is no evidence that NUL-padding is needed either.  
> > 
> > Agreed -- it's used as a C string everywhere I can see.
> > 
> > > 
> > > Considering the above, a suitable replacement is `strscpy` [2] due to
> > > the fact that it guarantees NUL-termination on the destination buffer
> > > without unnecessarily NUL-padding. If, for any reason, NUL-padding _is_
> > > required we should go for `strscpy_pad`.
> > > 
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > > Link: https://github.com/KSPP/linux/issues/90
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: build-tested
> > > ---
> > >  drivers/iio/adc/stm32-adc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > > index f7613efb870d..9cdcf396d901 100644
> > > --- a/drivers/iio/adc/stm32-adc.c
> > > +++ b/drivers/iio/adc/stm32-adc.c
> > > @@ -2209,7 +2209,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
> > >  				ret = -EINVAL;
> > >  				goto err;
> > >  			}
> > > -			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
> > > +			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);  
> > 
> > I still prefer sizeof($dst), but yes, these are the same:
> > 
> >         char chan_name[STM32_ADC_CH_MAX][STM32_ADC_CH_SZ];
> > 
> > If this needs a v2, please improve the Subject, but it is technically
> > correct, so:
> 
> Hi Kees,
> 
> I can tweak the subject whilst applying.  What did you have in mind
> as a better one?

I would use "iio: adc: stm32-adc: Replace deprecated strncpy() with strscpy()"

Thanks!

-Kees

-- 
Kees Cook
