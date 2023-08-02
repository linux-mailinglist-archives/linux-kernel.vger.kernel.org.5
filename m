Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8076D771
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjHBTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjHBTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:08:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9830EA;
        Wed,  2 Aug 2023 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biqu3d.com;
        s=tfld2305; t=1691003270;
        bh=HoxRKzN6dAhfwwtqhM8XAOAJnIPkI9mQ1RwsscMStQc=;
        h=Message-ID:Date:MIME-Version:Subject:To:From;
        b=P9JTBM4005YPYtn2mezPx1FrYmlqKSHzWDsvojmdAm23u2Jr6vreawN7LoXaK7J5y
         RoCw6M3YYRxQH02ppslBXZKH30ilvFDJ2oyOAPjmDjT5SvPvveTbGIExKMyk8Hlq5R
         UD3mmjs9OPfLNG/K1CP33enjtEyTH00Yv1cccoo4=
X-QQ-mid: bizesmtp84t1691003267tplhw4ez
Received: from [192.168.2.144] ( [178.41.211.221])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 03:07:41 +0800 (CST)
X-QQ-SSF: 01400000000000102000000A0000000
X-QQ-FEAT: lO87fmWkX3GVdw/k/UlTbtjPPHsrrlE3SwOsxekRlaHeO9mYXbQiWgJuXbCeV
        W148F0t6BZBHv7ngtFXpBDO8GeKI4kOU9cy1YpPxTFC3pf72hJYqhsLhgx5WrBnTMOibf24
        WERMuxkT98RIuGEyJI6xkx3fR+EzuONROXXw28dFNoBOBi/X3W7W2OQyfwb8FEhuMfhGiAG
        JLA1XcQLEmu3foKgGxwhESpolxROZ861LCQnhPOfoq0pEjwBAef5AuAhfbvUSvXlstYHeCp
        N2wpT0qDPr0vQXTYKME6Ejv8pUd/sWftyr4x8n5EtPOOtPQp9fODNul1vK7YAQlq5P+yBHB
        dqr0Q5B3d2TPXmi87LwFGL9VXiEqQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6762482929374395796
Message-ID: <C49F6BB03C78B6A4+5d083b09-4366-6d5e-7464-ad3bc68a2d41@biqu3d.com>
Date:   Wed, 2 Aug 2023 21:07:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
To:     Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Mark Brown <broonie@kernel.org>
References: <20230802141829.522595-1-andre.przywara@arm.com>
Content-Language: en-US
From:   Martin Botka <martin@biqu3d.com>
In-Reply-To: <20230802141829.522595-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:biqu3d.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Martin Botka <martin@biqu3d.com>

On 8/2/23 4:18 PM, Andre Przywara wrote:
> All X-Powers PMICs described by this binding have an IRQ pin, and so
> far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> they are connected to.
> However we start to see boards that omit this connection, and technically
> the IRQ pin is not essential to the basic PMIC operation.
> The existing Linux driver allows skipping an IRQ pin setup for some
> chips already, so update the binding to also make the DT property
> optional for these chips, so that we can actually have DTs describing
> boards with the PMIC interrupt not wired up.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>
> arguably the IRQ functionality is optional for many more PMICs,
> especially if a board doesn't use GPIOs or a power key.
> So I wonder if the interrupts property should become optional for all?
> After all it's more a board designer's decision to wire up the IRQ pin
> or not, and nothing that's really related to a particular PMIC.
>
> Cheers,
> Andre
>
>   Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index 9ad55746133b5..06f1779835a1e 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -67,7 +67,10 @@ allOf:
>           properties:
>             compatible:
>               contains:
> -              const: x-powers,axp305
> +              enum:
> +                - x-powers,axp15060
> +                - x-powers,axp305
> +                - x-powers,axp313a
>   
>       then:
>         required:

