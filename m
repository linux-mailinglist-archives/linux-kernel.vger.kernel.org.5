Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3AD786079
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbjHWTPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjHWTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:15:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55C10D0;
        Wed, 23 Aug 2023 12:15:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64a0176b1easo35085776d6.3;
        Wed, 23 Aug 2023 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818108; x=1693422908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ISfTpPb1V2P+jzT7DRqJg3+P9Rpp6ZuddKf1v0Q69Bg=;
        b=KFjN1bVnsq2ecwzbZvnrSAX8HUoJYlMSih4uyjLyOzesfPHaRY3HhKzghx/38BGT5q
         gfL8oDqED1zr9ZwPUrSKRobECWUW8KPaKQF/1g0FvSqSkDodK7PEcMy+HCOaIHpak6/j
         IjmbwCvDaH5I27pm2XrBJSTI5xuIu01qAxfjYQGQc+LGoghJAFb5b3AOm84eeTjqN2DN
         jmguWVBajtT4eDngMEL1cPSRIGdg7onV5kJqhDOg+J3Hun5yC310Oh3cg5bE63vYIO3R
         zflAQALyH2AtnfT1gLOY7bnBVX58JE2gNrfaL0gtGJL1t5EuCuVHGn+i6Q2IO2YMgXTE
         xwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818108; x=1693422908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISfTpPb1V2P+jzT7DRqJg3+P9Rpp6ZuddKf1v0Q69Bg=;
        b=XXshiijCUpTECT1/Aaqnewmzmq4gtfnTAJPa5WUH8AwCa9/TuAqBkv4GF7kAlbLdu0
         uc52Kz0fA460F/Qfv0VlrxkV+dUB/jeFmiLJL35/BMO3/Gigaa6X8XrVrI31egoNB3yT
         RwmaqVc0QYSKxwCNCbAWHveWIhrQ+S1QsyQipXgEXbQ7BSrM/6fDouzIUXRIk5zcqdvB
         J3GXHjTZgYw3cjnK/1z+lc1PckKnjl7HfgLDJvhOLmwqZ/X30wADafEdCLbf4Oxx82Es
         Ed9XnJsXm65nTkKHhiQWcHDMsDvQt/w8lYYMkuO39aL57ee/JjvGb5xpF5UABLKUxRrx
         8dhg==
X-Gm-Message-State: AOJu0YyyPtbyi64sXRz1g8NdYKhrt9llCRnKmBALe4zNcjnLDEuUvMdr
        IfqYj0WFj4XDDmJlB3Za2nU=
X-Google-Smtp-Source: AGHT+IFfaRfpPJ21GEsT5Ao87FJteBSmW6mCf5mGefHgD9XZmcrxWpqJ7YiikryeJ7mgcf+pWmmN4Q==
X-Received: by 2002:a05:6214:5489:b0:63d:4813:6a6a with SMTP id lg9-20020a056214548900b0063d48136a6amr14360059qvb.44.1692818108031;
        Wed, 23 Aug 2023 12:15:08 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id c16-20020a0cca10000000b0064b502fdeecsm4245322qvk.68.2023.08.23.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:15:07 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:15:06 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 3/3] clk: lmk04832: Support using PLL1_LD as SPI readback
 pin
Message-ID: <20230823191506.GC2572839@shaak>
References: <20230802064100.15793-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ec2b609-3eb5-4de3-93d2-a352a16683c8@emailsignatures365.codetwo.com>
 <20230802064100.15793-3-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802064100.15793-3-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:41:00AM +0200, Mike Looijmans wrote:
> The PLL1_PD pin (a.k.a. STATUS_LD1) can be used as SPI readback pin. Make
> this possible.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/clk/clk-lmk04832.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index dd1f0c59ee71..99b271c1278a 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -134,6 +134,11 @@
>  /* 0x14b - 0x152 Holdover */
>  
>  /* 0x153 - 0x15f PLL1 Configuration */
> +#define LMK04832_REG_PLL1_LD		0x15f
> +#define LMK04832_BIT_PLL1_LD_MUX		GENMASK(7, 3)
> +#define LMK04832_VAL_PLL1_LD_MUX_SPI_RDBK		0x07
> +#define LMK04832_BIT_PLL1_LD_TYPE		GENMASK(2, 0)
> +#define LMK04832_VAL_PLL1_LD_TYPE_OUT_PP		0x03
>  
>  /* 0x160 - 0x16e PLL2 Configuration */
>  #define LMK04832_REG_PLL2_R_MSB		0x160
> @@ -206,6 +211,7 @@ enum lmk04832_rdbk_type {
>  	RDBK_CLKIN_SEL0,
>  	RDBK_CLKIN_SEL1,
>  	RDBK_RESET,
> +	RDBK_PLL1_LD,
>  };
>  
>  struct lmk_dclk {
> @@ -1346,6 +1352,10 @@ static int lmk04832_set_spi_rdbk(const struct lmk04832 *lmk, const int rdbk_pin)
>  {
>  	int reg;
>  	int ret;
> +	int val = FIELD_PREP(LMK04832_BIT_CLKIN_SEL_MUX,
> +			     LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDBK) |
> +		  FIELD_PREP(LMK04832_BIT_CLKIN_SEL_TYPE,
> +			     LMK04832_VAL_CLKIN_SEL_TYPE_OUT);
>  
>  	dev_info(lmk->dev, "setting up 4-wire mode\n");
>  	ret = regmap_write(lmk->regmap, LMK04832_REG_RST3W,
> @@ -1363,15 +1373,18 @@ static int lmk04832_set_spi_rdbk(const struct lmk04832 *lmk, const int rdbk_pin)
>  	case RDBK_RESET:
>  		reg = LMK04832_REG_CLKIN_RST;
>  		break;
> +	case RDBK_PLL1_LD:
> +		reg = LMK04832_REG_PLL1_LD;
> +		val = FIELD_PREP(LMK04832_BIT_PLL1_LD_MUX,
> +				 LMK04832_VAL_PLL1_LD_MUX_SPI_RDBK) |
> +		      FIELD_PREP(LMK04832_BIT_PLL1_LD_TYPE,
> +				 LMK04832_VAL_PLL1_LD_TYPE_OUT_PP);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return regmap_write(lmk->regmap, reg,
> -			    FIELD_PREP(LMK04832_BIT_CLKIN_SEL_MUX,
> -				       LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDBK) |
> -			    FIELD_PREP(LMK04832_BIT_CLKIN_SEL_TYPE,
> -				       LMK04832_VAL_CLKIN_SEL_TYPE_OUT));
> +	return regmap_write(lmk->regmap, reg, val);
>  }
>  
>  static int lmk04832_probe(struct spi_device *spi)
> -- 
> 2.17.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
