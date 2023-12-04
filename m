Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71180334E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjLDMpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjLDMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:45:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28FC3;
        Mon,  4 Dec 2023 04:45:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f751663bso17517941fa.1;
        Mon, 04 Dec 2023 04:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701693912; x=1702298712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HBLZybjftIGabZbm0Ye/1bPR801qDd5qZ9HTYuLRbI=;
        b=KCX9Yv1neKGUGZ3grAMbQ+2S9xtJAxzGeWAdO65NZOgT2nLIl7GdUMTtHI4Incv35G
         MLaM2pxSZkylSnX/rFeaDO6Jlk5NVZixdr41RDuQAZn3sLshDYmH+2OLKB6x/OsODvQp
         Atm88xrPjs2QzZb8+Kbvg1qXQwrhCvWvPvWMzw1bPejIzbS663H1owqgEq1s5ObTEWnN
         yItPMkEgtTrkThBZ/OwZAYySXYrUS66/cMdiKUbMsixAHfgVZBHg4sqG8xAVwEfGuutn
         p5eKvG6IZRsn2ZLv07Sx0r4BN7JC8+j2Iuk9qMwWXhV2E2uL5xQVC9kERGl62fc0DDaj
         QoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693912; x=1702298712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HBLZybjftIGabZbm0Ye/1bPR801qDd5qZ9HTYuLRbI=;
        b=C9MbaalWMKRF4iEfw/4apwqEKc7PbxljU+H/vxoTCcXczAo+6ULMDK+/4pT4JqPlCH
         KJuvIe3RMSuXertJqyd1tBmYZ+JUd1dJ3fp6NMbIslh/HNRNSSPKmRh9Wl0Q02Xpnkxl
         y9mpZ0QQkNHxIUrygnhYc7kCtG4w566iIzArWOtoQegqz5PqtUjqiJoFxmAsjplpyn+A
         U4P0mCKbAB3dh6EewVgfeHgnxDz0PSyvOUxM6TGqqAuNgmnst4oE1m0jhlBzMoWdujQk
         XK1+EVPHaGsO6lBzhHnFAiyw+vgoLuee4eLzRpN0LbkvhZpCq9ehuKuH7QK8ind9t2gi
         fSQA==
X-Gm-Message-State: AOJu0Ywb8+1n0cY67pD1E0xGiOc+xxGQ/WnEyb7HXZNdsGIqZTeZx9sC
        3Jhy3egsUelhHmFp/2ezVeY=
X-Google-Smtp-Source: AGHT+IEOliBtuZ1V9WfGZ9329l3YbMsOVqiATXrwGqkJXoUyZ86vXHpk7NJg96l9OcTU4BJ1YYDxUQ==
X-Received: by 2002:a2e:2c1a:0:b0:2c9:e982:2761 with SMTP id s26-20020a2e2c1a000000b002c9e9822761mr949246ljs.211.1701693911705;
        Mon, 04 Dec 2023 04:45:11 -0800 (PST)
Received: from ?IPV6:2a02:2378:120d:1a46:8f76:bf32:c739:eb6e? ([2a02:2378:120d:1a46:8f76:bf32:c739:eb6e])
        by smtp.gmail.com with ESMTPSA id o17-20020a2e90d1000000b002c993c5d4c6sm1235669ljg.105.2023.12.04.04.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:45:11 -0800 (PST)
Message-ID: <89f7e7de-c574-49ab-885d-c6d4427fe64f@gmail.com>
Date:   Mon, 4 Dec 2023 14:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] input/touchscreen: imagis: add support for
 IST3032C
Content-Language: en-US
To:     Karel Balej <karelb@gimli.ms.mff.cuni.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>
References: <20231202125948.10345-1-karelb@gimli.ms.mff.cuni.cz>
 <20231202125948.10345-6-karelb@gimli.ms.mff.cuni.cz>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <20231202125948.10345-6-karelb@gimli.ms.mff.cuni.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karel,

On 12/2/23 14:48, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
>
> IST3032C is a touchscreen chip used for instance in the
> samsung,coreprimevelte smartphone, with which this was tested. Add the
> chip specific information to the driver.
>
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>   drivers/input/touchscreen/imagis.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
> index 84a02672ac47..41f28e6e9cb1 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
> @@ -35,6 +35,8 @@
>   #define IST3038B_REG_CHIPID		0x30
>   #define IST3038B_WHOAMI			0x30380b
>   
> +#define IST3032C_WHOAMI			0x32c
> +
Perhaps it should be ordered in alphabetic/alphanumeric order, 
alternatively, the chip ID values could be grouped.
>   struct imagis_properties {
>   	unsigned int interrupt_msg_cmd;
>   	unsigned int touch_coord_cmd;
> @@ -363,6 +365,13 @@ static int imagis_resume(struct device *dev)
>   
>   static DEFINE_SIMPLE_DEV_PM_OPS(imagis_pm_ops, imagis_suspend, imagis_resume);
>   
> +static const struct imagis_properties imagis_3032c_data = {
> +	.interrupt_msg_cmd = IST3038C_REG_INTR_MESSAGE,
> +	.touch_coord_cmd = IST3038C_REG_TOUCH_COORD,
> +	.whoami_cmd = IST3038C_REG_CHIPID,
> +	.whoami_val = IST3032C_WHOAMI,
> +};
> +
>   static const struct imagis_properties imagis_3038b_data = {
>   	.interrupt_msg_cmd = IST3038B_REG_STATUS,
>   	.touch_coord_cmd = IST3038B_REG_STATUS,
> @@ -380,6 +389,7 @@ static const struct imagis_properties imagis_3038c_data = {
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id imagis_of_match[] = {
> +	{ .compatible = "imagis,ist3032c", .data = &imagis_3032c_data },
>   	{ .compatible = "imagis,ist3038b", .data = &imagis_3038b_data },
>   	{ .compatible = "imagis,ist3038c", .data = &imagis_3038c_data },
>   	{ },

Other than that,

Reviewed-by: Markuss Broks <markuss.broks@gmail.com>

- Markuss

