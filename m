Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7E77C705
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjHOFWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjHOFUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:20:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8F19A8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:19:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso8332866e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1692076786; x=1692681586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FknlwclC7+OtWq5SNlcgj5uStWt+3ALYnSPMd2n2Tj8=;
        b=OFenEgmn2gqLfy3FCtzBF6PbA3ekm8oN/NXz+34WiXac1iIs6490/cNKIkC756bvoW
         4kFl1TL0/EvE8h8CV64HIswTfy3iUb4LuFi5mp9OeYDo6uCLAUMlKnDtftdNcNhBK6sj
         XVdtI/ny7HAkBaxLhH4HR4RElX9ck20xBCOyHCFQGcEGX1og5gR+t+OJXsOvk1wqrVmI
         TgXp6sor3sRsw2L3pkyaYpewwm509MCUjdrZMq5Ck2Uw3DJhKcV8DSO1DoM83xjvgzYB
         O6wpXzJvkDIv7O+wYvIdopw7FgQeHx73mezepZ2Jjk+FtXIGIFbWFVBVsPgyn5DKrDR6
         4AuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076786; x=1692681586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FknlwclC7+OtWq5SNlcgj5uStWt+3ALYnSPMd2n2Tj8=;
        b=AWBZbX97B98kNviqmndTJCRf+ux9ouyL1L+XY99IJV5QwzCk/CeBx0kp2fhauMd2sv
         mkClYsBSX+48dyI+coVVCX7cWqiUlSuJ2apjY+bxuIhOJzXsEtpc4L3r83u8p0PmBU0u
         1jV6lEERG0S1R+yZiM92L61Vomtdwt37tq/YdpnlKn6KmcYXl6Eg1AB/TuNI/V9J3vul
         o3TcxpZKOjddKMNExtas4KiP2AtTMIV19UUWBl970EvV67y7zyUCjCXgx59azVPEgsW+
         QzsKxV65X0TL1vIPsnLHcwmCrYmsDJchQJrXlOODQm2EEdfOqbtWXTl6HCX2HqHO7KIG
         xpug==
X-Gm-Message-State: AOJu0YxTxY0bpMVrRKydI0FiR35dnJfea1DZ83Ct28NdPBOFXI8Z3/DO
        CuV4etLFzZ3Z0FBiajTWJukokWef6ICp+Ptt3jrULQ==
X-Google-Smtp-Source: AGHT+IGW5H0+167JcPGa8HUXwV/Dhz1hWaMMSuRLDmovtMrs9htYPt5VAYHJaK3rVPEBWTHcv7vunw==
X-Received: by 2002:a05:6512:703:b0:4f8:49a7:2deb with SMTP id b3-20020a056512070300b004f849a72debmr5860026lfs.8.1692076786192;
        Mon, 14 Aug 2023 22:19:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.75])
        by smtp.gmail.com with ESMTPSA id qc1-20020a170906d8a100b0099d9bc9bfd9sm3176573ejb.48.2023.08.14.22.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:19:45 -0700 (PDT)
Message-ID: <98d01db3-3eba-0731-0dd9-4310ed293bd6@tuxon.dev>
Date:   Tue, 15 Aug 2023 08:19:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91: sama5d29_curiosity: Add device tree for
 sama5d29_curiosity board
Content-Language: en-US
To:     Mihai.Sain@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com,
        alexandre.belloni@bootlin.com, andre.przywara@arm.com,
        Jerry.Ray@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andrei.Simion@microchip.com
References: <20230804101043.4063-1-mihai.sain@microchip.com>
 <127fc712-d924-f27f-5449-33385e89d6c3@tuxon.dev>
 <PH8PR11MB6804E49B5946F4A9D60837E18213A@PH8PR11MB6804.namprd11.prod.outlook.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <PH8PR11MB6804E49B5946F4A9D60837E18213A@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mihai,

On 8/10/23 09:47, Mihai.Sain@microchip.com wrote:
>> +&i2s0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&pinctrl_i2s0_default>;
>> +     status = "okay";
> I see no sound bindings on DT. Is there any reason for having this here?
> # i2s0 bus is wired to RPi 40-pin connector. I want to have this node and its pinctrl here.
> # i2c1, flx4-spi, pwm0, uart1 are also wired to Rpi connector, and are defined here.
> # The same logic we apply also for mikroBUS sockets: i2c, pwm, spi and uart nodes are defined here.
> 

Can you use it (either with user space tools or other kernel consumers) w/o
additional device tree bindings?

