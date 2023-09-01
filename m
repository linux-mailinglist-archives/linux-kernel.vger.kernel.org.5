Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BE78F7B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 06:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbjIAE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjIAE4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 00:56:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4412F;
        Thu, 31 Aug 2023 21:56:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso12483865ad.1;
        Thu, 31 Aug 2023 21:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693544207; x=1694149007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxMAdQ9JHhbY/6XOYXhohZX4W0hkhsENsmdXA3joCPY=;
        b=C6+nZqaaqsQRSPdbqP8L9VhVfHF5lwRQqVz+2KlIFc+UicH7DCHsfU0z/KAwH6iGjE
         yquPphJKmh9YO6hgaidYwSeyqQNY9/MZbiiPywqo/KYxHvP1LQw79lXJpdRCAvrMViOy
         0RaA7iU20sF5ybiPJVo7R0/Vu5RUZG1aKC6wk31m31oPzi4775c/CWn3s1Ee09Ri5zm2
         igHl/rqmR3QFHGzbpviAUAD7c1EtOdq+bxEe2UorPI3W2GtfadCDrsDU6oIHdgNT7kR7
         zX08A8f0YUmUV/QrEZ6BcopK7L5bPxXMhgyalOPP90lYc1wznxksRFDlUgLn33wL5Egg
         sa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693544207; x=1694149007;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxMAdQ9JHhbY/6XOYXhohZX4W0hkhsENsmdXA3joCPY=;
        b=QR6+sGb3QSorLYFfd3P4Vw3F1ImaESOCNs48oYGPr18gHxVRKehfyWgLM5TS170GHl
         9ZuToQMwLiNbh5N11ZHkdf/dU6LHbTkR5O1iZMMmcVsXXIIn0JZEIVVsD3oKQWbInE/L
         PTF1rk/JKAImC/EO1LPyjIS3B1/ok4r/LffTRxWot230UPIEr3pauc4SnkiZ6Q2Yf8/G
         RpD8vkZYGdStpi35AoYcIcNQfokAYjyJmPg5Z8ois8fDdOTQ5hlFpGU6OjSw11+z6I+J
         yYr3IleuBH2iWGCWZkLhJzXQ/agRchQwehZ4PB4EKGIW4spc9e6hHrE+sXqO7SMK8eEc
         fuWA==
X-Gm-Message-State: AOJu0YwyFTUF4XJcm2D10XmlhHphmmFNcM8sPJ2mepm+OT27/TNESKtO
        tH4r1aJ3mrYJ+iEhNWQHqg8=
X-Google-Smtp-Source: AGHT+IF6QDy3CuYUe+uak82ob23I21g9dB49A8IeXHA8TbCz/H5rYUS4VaHBNmXQXV04PA1Rwb8IDw==
X-Received: by 2002:a17:902:c40b:b0:1b9:de75:d5bb with SMTP id k11-20020a170902c40b00b001b9de75d5bbmr2191573plk.7.1693544207479;
        Thu, 31 Aug 2023 21:56:47 -0700 (PDT)
Received: from [10.10.4.41] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001adf6b21c77sm2036354pld.107.2023.08.31.21.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 21:56:46 -0700 (PDT)
Message-ID: <99ffd1fb-14ae-1c83-bc32-2d0aead4d696@gmail.com>
Date:   Fri, 1 Sep 2023 12:54:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 3/3] hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED
 g6 PWM/Fan tach
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>
References: <20230830123202.3408318-1-billy_tsai@aspeedtech.com>
 <20230830123202.3408318-4-billy_tsai@aspeedtech.com>
From:   Potin Lai <potin.lai.pt@gmail.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        corbet@lwn.net, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, p.zabel@pengutronix.de,
        naresh.solanki@9elements.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        BMC-SW@aspeedtech.com, patrick@stwcx.xyz
In-Reply-To: <20230830123202.3408318-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/23 20:32, Billy Tsai wrote:
> +static int aspeed_tach_hwmon_write(struct device *dev,
> +				   enum hwmon_sensor_types type, u32 attr,
> +				   int channel, long val)
> +{
> +	struct aspeed_pwm_tach_data *priv = dev_get_drvdata(dev);
> +	u32 reg_val;
> +
> +	switch (attr) {
> +	case hwmon_fan_div:
> +		if (!is_power_of_2(val) || (ilog2(val) % 2) ||
> +		    DIV_TO_REG(val) > 0xb)
> +			return -EINVAL;
> +		priv->tach_divisor = val;
> +		reg_val = readl(priv->base + TACH_ASPEED_CTRL(channel));
> +		reg_val &= ~TACH_ASPEED_CLK_DIV_T_MASK;
> +		reg_val |= FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,
> +				     DIV_TO_REG(priv->tach_divisor));
Hi Billy,
I notice the fanX_div is always shows 1 after I set 1024.
I think FIELD_GET() needs to replaced with FIELD_PREP().

> +		writel(reg_val, priv->base + TACH_ASPEED_CTRL(channel));
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}


> +static void aspeed_present_fan_tach(struct aspeed_pwm_tach_data *priv, u32 tach_ch)
> +{
> +	u32 val;
> +
> +	priv->tach_present[tach_ch] = true;
> +	priv->tach_divisor = DEFAULT_TACH_DIV;
> +
> +	val = readl(priv->base + TACH_ASPEED_CTRL(tach_ch));
> +	val &= ~(TACH_ASPEED_INVERS_LIMIT | TACH_ASPEED_DEBOUNCE_MASK |
> +		 TACH_ASPEED_IO_EDGE_MASK | TACH_ASPEED_CLK_DIV_T_MASK |
> +		 TACH_ASPEED_THRESHOLD_MASK);
> +	val |= (DEBOUNCE_3_CLK << TACH_ASPEED_DEBOUNCE_BIT) | F2F_EDGES |
> +	       FIELD_GET(TACH_ASPEED_CLK_DIV_T_MASK,
> +			 DIV_TO_REG(priv->tach_divisor));
And here as well.

> +	writel(val, priv->base + TACH_ASPEED_CTRL(tach_ch));
> +
> +	aspeed_tach_ch_enable(priv, tach_ch, true);
> +}
> +
>

