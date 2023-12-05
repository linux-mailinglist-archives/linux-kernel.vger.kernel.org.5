Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E837805668
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442224AbjLENtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjLENtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:49:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10F199;
        Tue,  5 Dec 2023 05:49:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1b6b65923eso312440066b.3;
        Tue, 05 Dec 2023 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701784183; x=1702388983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=su3JiBRDwbVj1xAUvi7p9QvTL0dh/tmm8/DJGL4OtkI=;
        b=Clfg2T2XoNq+uHO/lT/hGWO3rgIC6DrRyfHmw2XMVkhq8OmGnLYXAPbMPcecZob5nY
         qG7DxjrKHz2HxTkFlRvNQZegCAH3nWdokWppn8aryHa5k2C92Lh7pkzsXOrJT4Evt3Qa
         dTVGEJFiqY95vF9my3IdV4/8sJsmI5ZGK1N7TsTcWE1owYnhm5GxRYzaWpMBUR8A4ohx
         40jPvQX1FfZSnv/4y5mR98uARx39MokwezRWtFO2llKYtFkqD6EPjD8JH1Fj8yjvVgK+
         0ey/6IBRthzkJ6z7BLHbpwJXlgVQ81byqgHTqD5/Dwuoddur4GgREy40uX7ujF6x1Neq
         /M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784183; x=1702388983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=su3JiBRDwbVj1xAUvi7p9QvTL0dh/tmm8/DJGL4OtkI=;
        b=kf2onVefKvfk4kMigdLW0vDol41MAWBBGTG4VrVQc2kP2fiGkSr2X/nZlpXqNsaHJg
         /at+2gruwQob2KT4bg5r8EqG9MGmmso4Un8pWh0aMBBLv8rLOaUBmxGBk2hV2KhmA64X
         FNjXXSQjXHgDOJA7Qqv3l/VjisL4m9cOczwIHVkXUoN8n942v5x7Y354cWcfnVC9s9UR
         ivHqLqnoS6kw0pEzLeEGBBbXQ4O+J9wbMF2Dt/WXy/18YQZWT3nMjuZfWFbIL8ZVie1Z
         QmmMi+kfMiI8vb7bl0YGU/uYxDn99kY9RRE2EmelT1kqQughWCF61NbNZbrEHqFGdZjx
         aMJg==
X-Gm-Message-State: AOJu0YxNxoNclv4WLj8xVnA412st6HDv0npMybnkOcHwmJSE69jG4H2K
        tbbCmX0GtLxKZHyXwsBWteQ=
X-Google-Smtp-Source: AGHT+IERoivcMLsR85BC/oYIWQsZBhUjILXepkJNOvS8aSSqS25ruiNCxTIE/GTh5RYNtCROtTqLEg==
X-Received: by 2002:a17:906:4e91:b0:a0d:39c6:1f67 with SMTP id v17-20020a1709064e9100b00a0d39c61f67mr337137eju.76.1701784183397;
        Tue, 05 Dec 2023 05:49:43 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090637c900b00a1cdf29af64sm424678ejc.45.2023.12.05.05.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 05:49:42 -0800 (PST)
Message-ID: <11eda58b-579c-4f50-85ea-fe3ac111d096@gmail.com>
Date:   Tue, 5 Dec 2023 15:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
 <20231205134223.17335-2-mitrutzceclan@gmail.com>
Content-Language: en-US
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231205134223.17335-2-mitrutzceclan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        MALFORMED_FREEMAIL,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 15:42, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel
> applications or higher speed multiplexed applications. The Sigma-Delta
> ADC is intended primarily for measurement of signals close to DC but also
> delivers outstanding performance with input bandwidths out to ~10kHz.
> 


V6 -> V7

 - format Kconfig supported models using '-'

 - include types.h instead of stddef.h

 - change device_info->num_gpios type to u8

 - reorder fields in ad7173_state, place ad_sigma_delta

 - reorder fields in ad7173_device_info, group by type

 - add default case in read_raw()

 - rename ad7173_debug() to ad7173_debug_reg_access()

 - remove explicit u8 cast

 - remove return 0; for offset in read_raw()

 - add '\n' to error messages

 - reorder probe variables -> reversed xmas tree

 - remove redundant inner commas in of_match and id_table

 - simplify selected reference code by setting default value and
ignoring fwnode_property_read_string() error

 - use match_string() for finding selected reference

 - err on no channels specified

 - add missing fwnode_handle_put(child) on err return branches

 - remove spi_set_drvdata() from probe

 - remove offset variable from find_live_config(), not used

 - add comment showing a generic LRU implementation might be used if one
will exist



 - MISC:  add blank line to chanel_config struct, trailing comma
ref_sel_str[],
 remove blank line in update_scan_mode(), add spaces around '/'
