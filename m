Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28F77978FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjIGQ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243254AbjIGQmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:42:53 -0400
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC53E65
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:41:44 -0700 (PDT)
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-52a3ff5f0abso1601273a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104530; x=1694709330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V94N1ORYrLaXKL1qzREjQHJ4JwS/WOj3pdtg65MWaAk=;
        b=k5Z1zos0nG6Y+vD6AZ6QmugUsv7Wpt8bhRYsH08CiXp+cfXAGnu/3GXDPz67f4Qdne
         cu1Og8qb73MjhQvNfH6R+QWuGN1vZA+qQHlFFIc1k7XiOpOoMz6KRx8d4jqbRzFj5dQs
         CfLs2rxv0lUJZmSpxhLXENhSMGem0aLb5OBKgUN8GgYoo1PmjLRD49cbYTGrf6Z1dWpO
         knQKBb3cBQ5jp5JPLmPcw9xaej+PZ6U1ErUL7MGyYHKyWV8M5LSPDQvnvpLUi5fQWnIm
         5kk010raS3Jmgvs8Jvk7Z0peRSf+duB/Aih9GwMd1iuVJKP+LyqYbbi2DZehfiAu0kcE
         wklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104530; x=1694709330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V94N1ORYrLaXKL1qzREjQHJ4JwS/WOj3pdtg65MWaAk=;
        b=bK3oTLphLJW14VoagsA99zyVLguBJVe6RqEj/HROFEbdjg+ctosz07gy9MFXe0LYHy
         FhNpgmMBEDFGymwSFxzUxM0tyn8J12AXiETmIiCrbyiNQnnTotaHV4n90ETHgt8Ar2yJ
         NEro5BdUtj2WZhTDXM1YiJ0QJ6/2iylYU1vVQYgBnE8HXeFYLFFylnr3QIMeT6j8q+mE
         L9j2l6bUeLTuVPtiAQiiUVx+axVs7EbnyW8jyxtS0NnG5q3kXRZfJAruNkknkuyXfe0p
         6woSsl/hBQ49xy9IsuCPv70+ilx9sbcxaQpz33H/XINKpaqarxgVGLAxqq80rJaOjf20
         sR8Q==
X-Gm-Message-State: AOJu0Yzs+sCsxNu99dlU7+MruG5XmXOJCYjdTvEbbzu9smeZzY2Nfi8m
        8DMCgthfE2vo3Mj+/g/sox8nFbRDGzNGJQ==
X-Google-Smtp-Source: AGHT+IFSokuvidPb1pXREVhfaW7eDebj6W9QXi1Pae06YNBdw+btfNaTUKU6LAI1FFxmeA8DOiJk+A==
X-Received: by 2002:a7b:cb87:0:b0:401:cc0f:f866 with SMTP id m7-20020a7bcb87000000b00401cc0ff866mr149074wmi.12.1694103735822;
        Thu, 07 Sep 2023 09:22:15 -0700 (PDT)
Received: from ubuntu ([2a02:810d:1640:10d8:bdda:474a:9786:1e73])
        by smtp.gmail.com with ESMTPSA id l5-20020adfe585000000b0031c71693449sm23623180wrm.1.2023.09.07.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:22:15 -0700 (PDT)
Date:   Thu, 7 Sep 2023 18:21:50 +0200
From:   Joerg Schambacher <joerg.hifiberry@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Message-ID: <ZPn4nsypsSXdB3J7@ubuntu>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
 <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.09.2023 um 15:21 hat Mark Brown geschrieben:
> On Thu, Sep 07, 2023 at 06:12:05PM +0200, Joerg Schambacher wrote:
> 
> > +		if (pcm512x->tas_device) {
> > +			/* set necessary PLL coeffs for amp
> > +			 * according to spec only 2x and 4x MCLKs
> > +			 * possible
> > +			 */
> > +			ret = regmap_write(pcm512x->regmap,
> > +					   PCM512x_PLL_COEFF_0, 0x01);
> > +			if (mck_rate > 25000000UL)
> > +				ret = regmap_write(pcm512x->regmap,
> > +						   PCM512x_PLL_COEFF_1, 0x02);
> > +			else
> > +				ret = regmap_write(pcm512x->regmap,
> > +						   PCM512x_PLL_COEFF_1, 0x04);
> 
> I would name this quirk something a bit more specific - it seems likely
> that there might be future TASxxxx devices which need different quirks.
> If it's a limited range of MCLK multipliers perhaps something about how
> the PLL is limited, or just make the quirk data being to specify min/max
> for the multiplier?
The spec allows a maximum input Clk of 50MHz. Useful for the concerned
mode are only clocks with 22.5792/45.1584MHz for the 44.1ksps family rates
and 24.576/49.152MHz for the 48ksps. The only thing we need
to make sure is to divide the master clock by 2 in case of a MCLK input
of >25MHz to use the the same settings hereafter.
And yes, we cannot be sure that future devices may require different
settings, but I can hardly imagine anything completely different than
this approach with the usual audio MCLK frequencies.
> 
> > +		if (!pcm512x->tas_device) {
> > +			ret = regmap_update_bits(pcm512x->regmap,
> > +						 PCM512x_PLL_EN, PCM512x_PLLE, 0);
> > +		} else {
> > +			/* leave PLL enabled for amp clocking */
> > +			ret = regmap_write(pcm512x->regmap,
> > +					   PCM512x_PLL_EN, 0x01);
> > +			dev_dbg(component->dev, "Enabling PLL for TAS575x\n");
> > +		}
> 
> This is probably a separate quirk?  I'm a bit concerned about what's
> turning the PLL off here...
The PLL should not be used in this specific case where all divisions are
just divide-by-2's. Your original code does reflect that and turns the
PLL off. It improves jitter and finally audio performance.
But in the case of the TAS-devices we even then need the PLL to
drive the AMP clocks.
My code changes only address the case 'TAS-device and external audio MCLK'.
All other constellations like clock slave mode or e.g. 12MHz MCLK input
require the PLL anyhow. THe 12MHz clock input even requires the FLEX mode
through the PLL using the GPIOs as PLL-in and -out.
I hope I could clarify things a bit.



-- 


