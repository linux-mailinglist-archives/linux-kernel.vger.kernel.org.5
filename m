Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA00774927
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHHTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjHHTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:36:32 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651863D68;
        Tue,  8 Aug 2023 10:10:03 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so9353992e87.2;
        Tue, 08 Aug 2023 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691514602; x=1692119402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDyaLCkG9Gwg7DW4JRUummSbEo/7bXQ3Usvl8gTviOs=;
        b=AtDbmzdnGn7dyRGW9F343JoAWdkM6DRbid6MV1nwGXyzoCWRcj94OHz07KhU/FN+gi
         JpqPwrL7rnieULbj9eu//u2hJBdnClok9Bsqkanr/vlO2A9lWMlhgsbIMkVX1tWIbdxQ
         S/TkksaE3I5abgbBcY00Mo1mtTnKwwX0/BXfTmlP7l3kPDtWjBiMscz+KXEz/dFpvkz8
         NNChvdSGAU8mB06XOrkuCJS6S9wNhKHBZxJO2uKsHPCcJyAUm4Glvuh0q15lXZLWwCoV
         ge5KPlTCuq1jVrg0/JLkp9m6mLk79eC3X50FZLu6wf0+Rxf7rf8gBbHNisP6mD0DG3ei
         r12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514602; x=1692119402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDyaLCkG9Gwg7DW4JRUummSbEo/7bXQ3Usvl8gTviOs=;
        b=QqUJAfcriwgPV/EKVorg3sd9G8qDI/gpOQjUz0ISxnizqDYFSfzqxxyK7nHv7d/D+8
         iNXl5SpyqfCc9MHcWl/xF46GGLAyh4OjT2CTpTZ+c3GCm+Oeird+ZGH8Db1st7wvL+xg
         DaK+ASrtxC0Nqa4ozVNtdBFKYna8HQ5hI9ycBdaIayeVGDv6xyTP/Fk+VL8OmMLE8OdG
         4exE1oVlGqr4a9lta+ib6Jwp16TvLjLFKYm60NVnV3b2nCjBELrgZ3CbTCHKYbT4zJuI
         LhCV8rWZ48f+JFmO1s9DZ/mPX0Vc6FzekBXABTWR6N9yq02CJNFtQsTijDUVqygexsUB
         tJDA==
X-Gm-Message-State: AOJu0Yx4mPtTD2TC4OSiysbUf10cIghv6XufzTvz/Ww2eZb8XU3AI2cj
        PsRoNC4XFHKPyOxONZNJoql8dgXC378=
X-Google-Smtp-Source: AGHT+IGngRj3koc+G8bnqTzcS+/05+rLUdqPpBwdfyDQqjhLNRWeHlU8nfQEE0EYjdPBdEAVgf4UzQ==
X-Received: by 2002:a17:906:31c7:b0:99b:55e3:bbd with SMTP id f7-20020a17090631c700b0099b55e30bbdmr9437027ejf.34.1691476953939;
        Mon, 07 Aug 2023 23:42:33 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9102:d500:25c8:948:5db6:241c? (dynamic-2a02-3100-9102-d500-25c8-0948-5db6-241c.310.pool.telefonica.de. [2a02:3100:9102:d500:25c8:948:5db6:241c])
        by smtp.googlemail.com with ESMTPSA id fx15-20020a170906b74f00b0099c157cba46sm6142048ejb.119.2023.08.07.23.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:42:33 -0700 (PDT)
Message-ID: <b8931b6c-5b35-8477-d50f-b7a43b13615f@gmail.com>
Date:   Tue, 8 Aug 2023 08:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] net: phy: meson-gxl: implement meson_gxl_phy_resume()
To:     Da Xue <da@libre.computer>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Luke Lu <luke.lu@libre.computer>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230808050016.1911447-1-da@libre.computer>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230808050016.1911447-1-da@libre.computer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2023 07:00, Da Xue wrote:
> After suspend and resume, the meson GXL internal PHY config needs to

To avoid misunderstandings:
You mean suspend/resume just of the PHY, or of the system?

Description sounds like this patch is a fix and should go to stable.
So add a Fixes tag.

And a formal remark: Your patch misses the net / net-next annotation.

> be initialized again, otherwise the carrier cannot be found:
> 
> 	eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> 		DOWN group default qlen 1000
> 
> After the patch, resume:
> 
> 	eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
> 		group default qlen 1000
> 
> Signed-off-by: Luke Lu <luke.lu@libre.computer>
> Signed-off-by: Da Xue <da@libre.computer>
> ---
> Changes since v2:
>  - fix missing parameter of genphy_resume()
> 
> Changes since v1:
>  - call generic genphy_resume()
> ---
>  drivers/net/phy/meson-gxl.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
> index bb9b33b6bce2..bbad26b7c5a1 100644
> --- a/drivers/net/phy/meson-gxl.c
> +++ b/drivers/net/phy/meson-gxl.c
> @@ -132,6 +132,18 @@ static int meson_gxl_config_init(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int meson_gxl_phy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	genphy_resume(phydev);

Return value of this function should be checked.

> +	ret = meson_gxl_config_init(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /* This function is provided to cope with the possible failures of this phy
>   * during aneg process. When aneg fails, the PHY reports that aneg is done
>   * but the value found in MII_LPA is wrong:
> @@ -196,7 +208,7 @@ static struct phy_driver meson_gxl_phy[] = {
>  		.config_intr	= smsc_phy_config_intr,
>  		.handle_interrupt = smsc_phy_handle_interrupt,
>  		.suspend        = genphy_suspend,
> -		.resume         = genphy_resume,
> +		.resume         = meson_gxl_phy_resume,
>  		.read_mmd	= genphy_read_mmd_unsupported,
>  		.write_mmd	= genphy_write_mmd_unsupported,
>  	}, {

