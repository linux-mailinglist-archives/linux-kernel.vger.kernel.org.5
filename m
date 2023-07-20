Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F01275AE86
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGTMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjGTMgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:36:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA22126
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:36:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98de21518fbso137341966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689856601; x=1690461401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeWGw2gUiLPO/RS6979ifpmA5NC37xcO8V3RqV0p6sM=;
        b=UEICAlJLJDp+3I3EqRBjOrINwFRMYbI9+BKYwQcOQA7bCQVNhmAeCQR8nzfGdmgVkb
         Hx49390V+EBXAlE4CO0Tx0WpBbjHvqYICtv5F4KHyDxjwWgVHamv2WYNI+vzMmSC66gj
         Q0DjCb/yuDugLZunCw2fnqGwi+FCEQTYKQZt/561zhfw04rMEElFCJabPBLk4paFKakQ
         FHFcvWU8zENYfxWw1NcHl9FE8yaxLJBX6k88CifCRFoLYCDm/HzghVB9OsWg6DTkOA6x
         YmLvjmCI68JoaV1JDlHPh0YRCN+6oQbOU49Cj00sCaaY8DZwx8DB82CK0C03uU6k8op3
         QzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689856601; x=1690461401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeWGw2gUiLPO/RS6979ifpmA5NC37xcO8V3RqV0p6sM=;
        b=dBIDPma9nanP1RpkBR5g+PHL8Dp8qNEXZdJ75NZVCSDdcINdLfaznbT1MWFx3hlm8r
         wFU1p9YAFYH/xAZa93DDUUHXLiBaNdmNxMiOU2TAbJ3ytY+KknADcY6LM3QrjF5v5LIc
         sElo9hOteLyYf98E6fqfN6nXJXDZX8aWm8yiqOTgmJDhZ+oo14DPmqgTrvKA0rPlwnVe
         /vU8yuvoj/4YBFLBKmk5R6lpXcvIpHBtIGG+7tKIqQjAw0HmR/mp7GGVef1iu50w+/cQ
         8n/wmiEtNUkOHR/nyu5z/ysw1lh73EmMrFbxNR1HbWlkyFIAT1RFGHz4KmTlQHOs1vFJ
         Scfw==
X-Gm-Message-State: ABy/qLY+QCRh2i+GbaE/qlShlG8JfNczdMCdasRnLGKoNt0YHJwVqcFt
        Y1cNd7jOkypvTFpoWfaRGcBA+g==
X-Google-Smtp-Source: APBJJlFyWuz4RP3lpWwhWBFPBxHH+evG1aHzuSnSD11+X1U38hrobyh2hgqG/WfGnjR28zjpg4Omaw==
X-Received: by 2002:a17:906:7a07:b0:99b:4668:865f with SMTP id d7-20020a1709067a0700b0099b4668865fmr3407023ejo.10.1689856601393;
        Thu, 20 Jul 2023 05:36:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm636723ejd.218.2023.07.20.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 05:36:40 -0700 (PDT)
Message-ID: <f67d710c-bacc-8480-a918-db84b82885e1@linaro.org>
Date:   Thu, 20 Jul 2023 14:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230719224141.3716815-1-james.hilliard1@gmail.com>
 <20230719224141.3716815-2-james.hilliard1@gmail.com>
 <0ad5a223-d70f-deaa-6261-a2bd2b2af40d@linaro.org>
 <CADvTj4qvXvuV=ASg5h4hPr8QG-NR48j6G36AZC5xHDdhLyjT7w@mail.gmail.com>
 <c70e397e-dee8-2155-9f0b-538e95bda2eb@linaro.org>
 <CADvTj4p72nh5umeSRw2OhjA5NyyZY_BkMhzJBn4Y2AHZHA3+dw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADvTj4p72nh5umeSRw2OhjA5NyyZY_BkMhzJBn4Y2AHZHA3+dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 14:22, James Hilliard wrote:
>> Take a look at IMX8 Variscite SoMs.
> 
> Oh, I see what you mean now, so it looks like this is missing for the dart-mx6
> device tree.
> 
> imx8mm-var-som.dtsi:    compatible = "variscite,var-som-mx8mm", "fsl,imx8mm";
> imx8mm-var-som-symphony.dts:    compatible =
> "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm",
> "fsl,imx8mm";
> 
> imx6q-var-dt6customboard.dts:    compatible =
> "variscite,dt6customboard", "fsl,imx6q";
> 
> So the DART-MX6 is missing a compatible along the lines of
> "variscite,dart-imx6q"
> for the dart SoM I guess?

It's different topic whether it is worth to fix DART-MX6. In general it
misses its compatible, but it might be not worth to fix.

> 
> And for VAR-SOM-MX6 I guess I should use something like
> "variscite,var-som-imx6q"
> for the SoM right?

Yes.

Best regards,
Krzysztof

