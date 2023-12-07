Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C65808EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443335AbjLGRZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjLGRZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:25:13 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31219AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:24:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so158553966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701969892; x=1702574692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSaCKj49TdBQE/wW0nBbIlYjNisy5X/gJJF/8cHix4E=;
        b=LIraSdGECWO5t07MKS3BLatmmOjnaU/i9lSaejma3SuvcK292+cy6HZfwVlTMs2Ajk
         Y+gJwKny2rBCWoe3d/VCuueff38nvjeSD6o0QKl7N0Xm7O6ZCxHXKorPx5x30dWOnO8g
         rhN/KwmgeLTLJHZYpiFhboBk/kUIG8Rjetu8rKys8fMtuncgFlijUmzduv2JIjzBrZz4
         vIdZb2ndFYx2cmlSD2k9m+hlZ7yq6nyPowWnvJ2pCOU/j7CHTSTy8ZS66dzb8mdMo8iL
         eSl5LWwg76mxf/X/Yr60tw1Klo7QVULLD8Z9SxB+2mJ5YkzVwoI6y7kffEFq3MdwLT3T
         0elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969892; x=1702574692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSaCKj49TdBQE/wW0nBbIlYjNisy5X/gJJF/8cHix4E=;
        b=SWgEMioJ2uyW+oEP6yBar1QYGpSXzd1InG3NiFCBGkeXXlVJcZcR1nZ+i84PL7hO6p
         tCVFfJbwnL/CrIbj6DdkI9EHG2z+KJJs1J71Zb2RKa99/omunfnEhxVvwj3qJfvdmvdc
         EvheHlvtZ76SRh6f2TUZZsVkp6ul1w1bOJxdXMh36BbCAAzGH4rMw+gvNiOHimLM/7Cl
         XeM6uAGXbLlNGXkNddap/HtLcYT344rs6epXFnByWY5EzBRsSL0FFbrhfWPVDbQuLrfY
         xgtQKseZ7V+tnncKIZ+yjldlClgV/la8gaHSSEnwgCUQd/OqzA5FfGlwe7KAIpXoVco4
         qSzA==
X-Gm-Message-State: AOJu0Yx1M+/xuhpYbPpK8wArY+UVtvuZYHMQJVOVRwvzaYY5JoOh5a4s
        322grQVrD/6qEgqWOizpzqwPiHzFmaVoi3XecYE=
X-Google-Smtp-Source: AGHT+IEtTd+pA4mJobxUqdqM7SglT4EunogmAQ8lpbogM+tHlUMEk4Qwu5mWYwLQ9J+s2P4F/4V7+g==
X-Received: by 2002:a17:907:5020:b0:a19:9b79:8b5d with SMTP id fw32-20020a170907502000b00a199b798b5dmr1010958ejc.110.1701969892432;
        Thu, 07 Dec 2023 09:24:52 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906684e00b009fd0102f71asm1078898ejs.176.2023.12.07.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:24:50 -0800 (PST)
Message-ID: <797b9023-e56b-404b-bb4e-6e178b7ada88@linaro.org>
Date:   Thu, 7 Dec 2023 17:24:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        broonie@kernel.org, pratyush@kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, sbinding@opensource.cirrus.com,
        lee@kernel.org, james.schulman@cirrus.com, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, linux-mtd@lists.infradead.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@tuxon.dev, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        git@amd.com, amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
> The current implementation assumes that a maximum of two flashes are
> connected in stacked mode and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical.

Too much restrictions, isn't it? Have you thought about adding a layer
on top of SPI NOR managing the stacked/parallel flashes?
