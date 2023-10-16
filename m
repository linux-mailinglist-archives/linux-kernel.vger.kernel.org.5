Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5E7CB4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjJPUbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjJPUa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:30:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20661F3;
        Mon, 16 Oct 2023 13:30:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405417465aaso48609365e9.1;
        Mon, 16 Oct 2023 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697488254; x=1698093054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP03Yjd+YrRnUI9Z4/vJQB7dAVo1TlzSZV/Wwx+jtHQ=;
        b=FgngYESc8iguPN8DdepLB/f4jQ1lqeXzJNAj3rw9jDVmEJPdB17syfhgOs2NOEdEF8
         dIfQg1aJvQUuhrTiXtpjRNCTKDwWTdluyPphNkAX23uWtDN/HG60aFLCP9NmQVfPCiBp
         S/yxehQxzpXMQjtG0tFTFXhw4xDQM49NFbYeDD/6QOQt3zpi4pC15J2pgloR7eBbaQWS
         3o1jpFmKD41QueM/0hISteUKr2VVDfN6tghI3vepWaSl05YD492XCPkQF/FfkTKqwkjk
         uDqeXpN58Vamlexi31OiXW8SPRHMNs4MpYjFbVipBwthycnuQ0LzuVxbVr5O8o0mxZH7
         ckXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488254; x=1698093054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP03Yjd+YrRnUI9Z4/vJQB7dAVo1TlzSZV/Wwx+jtHQ=;
        b=uPrwttExOjmj2NwhtH1Daxt+baCO/TRE9OlbKFiDysIKbGydgWYdTIIzif3pUiYhvV
         ZR2VQENVYHLboqyPXm+EFhVUUNaMsKGcDnyKe+aHLXZHeLiyo8XvmJtZl0pkjE/+hadm
         tVJcTl7FewpjTq5GcioWkkCgvepZwtxzO5PeBfZ4kFSkRX6oJ/3SUSmNZMMndWK5eGGX
         geMpEfid40ycX0tp0/tm1Pm40W9nxxXoSy7mWxSOt1r920Zl5aredRpxETANylV2JwBc
         yJ/tMpkyI05B1h8LIUEcxnPjw7utsrja2f3hm2cEPWkq64yjPstthdzH7QxthzMLRZHV
         9YbQ==
X-Gm-Message-State: AOJu0YzPM9ktbRzGQZAxdSSPhcFi/jy3qDVE7CH2PbPjKIcsemd5t428
        U5rSJaLzYM8aRoCBh4zK0Q==
X-Google-Smtp-Source: AGHT+IGR2WYyvQGDSVWvcnP9TKmfjCt0gbYLkfoAC0FYqIYNl1BRisa6qK/vHorshbbX/iwXh4QmBw==
X-Received: by 2002:a05:600c:19cd:b0:405:1baf:cedf with SMTP id u13-20020a05600c19cd00b004051bafcedfmr172204wmq.24.1697488254326;
        Mon, 16 Oct 2023 13:30:54 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.1.143])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c230d00b004068495910csm7946115wmo.23.2023.10.16.13.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:30:54 -0700 (PDT)
Date:   Mon, 16 Oct 2023 23:30:50 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] Staging: sm750fb: Rename displayControl
Message-ID: <ZS2deicLPyamwb5T@dorcaslitunya-virtual-machine>
References: <cover.1697400022.git.anonolitunya@gmail.com>
 <596de9b4cf3483d872b1ba25e1b02194aec34bac.1697400022.git.anonolitunya@gmail.com>
 <a5cbf027-7990-c54d-8bfc-dc042ac166f@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5cbf027-7990-c54d-8bfc-dc042ac166f@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 10:23:54PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 15 Oct 2023, Dorcas AnonoLitunya wrote:
> 
> > Rename variable displayControl to display_control. This follows
> > snakecase naming convention and ensures consistent naming style
> > throughout the file.Issue by checkpatch.
> 
> Actually, the variable seems to be dispControl?
> 
I had actually missed this. Thanks for the correction. Its now corrected
in v2.

Dorcas
> julia
> 
> >
> > Mutes the following checkpatch error:
> > CHECK: Avoid CamelCase: <dispControl>
> >
> > Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> > ---
> >  drivers/staging/sm750fb/ddk750_mode.c | 32 +++++++++++++--------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> > index 431b273a347a..fc3db09de9ae 100644
> > --- a/drivers/staging/sm750fb/ddk750_mode.c
> > +++ b/drivers/staging/sm750fb/ddk750_mode.c
> > @@ -15,7 +15,7 @@
> >   */
> >  static unsigned long
> >  display_control_adjust_SM750LE(struct mode_parameter *mode_param,
> > -			       unsigned long dispControl)
> > +			       unsigned long disp_control)
> >  {
> >  	unsigned long x, y;
> >
> > @@ -36,42 +36,42 @@ display_control_adjust_SM750LE(struct mode_parameter *mode_param,
> >  	       ((x - 1) & CRT_AUTO_CENTERING_BR_RIGHT_MASK));
> >
> >  	/*
> > -	 * Assume common fields in dispControl have been properly set before
> > +	 * Assume common fields in disp_control have been properly set before
> >  	 * calling this function.
> > -	 * This function only sets the extra fields in dispControl.
> > +	 * This function only sets the extra fields in disp_control.
> >  	 */
> >
> >  	/* Clear bit 29:27 of display control register */
> > -	dispControl &= ~CRT_DISPLAY_CTRL_CLK_MASK;
> > +	disp_control &= ~CRT_DISPLAY_CTRL_CLK_MASK;
> >
> >  	/* Set bit 29:27 of display control register for the right clock */
> >  	/* Note that SM750LE only need to supported 7 resolutions. */
> >  	if (x == 800 && y == 600)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL41;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL41;
> >  	else if (x == 1024 && y == 768)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL65;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL65;
> >  	else if (x == 1152 && y == 864)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
> >  	else if (x == 1280 && y == 768)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL80;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL80;
> >  	else if (x == 1280 && y == 720)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL74;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL74;
> >  	else if (x == 1280 && y == 960)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
> >  	else if (x == 1280 && y == 1024)
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL108;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL108;
> >  	else /* default to VGA clock */
> > -		dispControl |= CRT_DISPLAY_CTRL_CLK_PLL25;
> > +		disp_control |= CRT_DISPLAY_CTRL_CLK_PLL25;
> >
> >  	/* Set bit 25:24 of display controller */
> > -	dispControl |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
> > +	disp_control |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
> >
> >  	/* Set bit 14 of display controller */
> > -	dispControl |= DISPLAY_CTRL_CLOCK_PHASE;
> > +	disp_control |= DISPLAY_CTRL_CLOCK_PHASE;
> >
> > -	poke32(CRT_DISPLAY_CTRL, dispControl);
> > +	poke32(CRT_DISPLAY_CTRL, disp_control);
> >
> > -	return dispControl;
> > +	return disp_control;
> >  }
> >
> >  /* only timing related registers will be  programed */
> > --
> > 2.42.0.345.gaab89be2eb
> >
> >
> >
