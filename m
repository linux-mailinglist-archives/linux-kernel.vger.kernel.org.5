Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19878199B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjHSMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjHSMwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:52:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C3255E1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:51:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso2665599e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692449515; x=1693054315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nauYnXDm92Wk/8xh+HfUpmV7pJLWSptdaV1nMXTUtM=;
        b=ZxdWyNY1ioE6olKzzf0xknirLXka0bMJNbcMnUJCrje3X2+oK4RPLWUSNY/+Km6I3F
         v2Q1CnK/Nv2Kbdm/Ob5DhRh5m4RTtWJp4E+suS/qEkldeZUffmsaYbRFPbUIqbKMjGge
         kS/8ofLI7bi5hcNtgTXBlOjiWjE0ml4rE7JfFyvp6wMK2o4DYd1pACgZf9Z72wV/HOtf
         K7Kg4Ih1YlpIiNseWplRPLzvOuDzZ4/v38RZgWppc1+bb8q1qvsZ9mv1xXYBJCJWMSQn
         CP/kKjUxOJxr3OOTl5AbOAdMWp3cY8ecdhZDCSovhSDHJX2knRGaoH+IQCnp586BfUMh
         Juig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692449515; x=1693054315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nauYnXDm92Wk/8xh+HfUpmV7pJLWSptdaV1nMXTUtM=;
        b=QfsOpEXstfkvZLzKJme+dY69A5mLLYQkBlFZI4WkFtRYcSkt5uupE6ycp8Ar3/gBP5
         8SvaHThqi+QTqwsY4pYOLFUl7TtRr+xOwodTqowHAEwjoImvD+ZPMVJHOYGtXBm1CCI6
         mQ9GTetVBeNP/BBeOz8lWIIsPxzEPI7scSvBBqLXUMIC+73a0HyamELD3qqPvbCqKddT
         gPBmb8J+xVIfbmNesjEUemxgQLJAcP8PgYynAVO7BDveLUU0KQzf577X4B732FKQ+81V
         Gmt5bSPPye9KQhiFxMkeKYPkJGQtokx8Rb2X3dCt4pFKzzyFqJDJMGDGm60jxv9QIgGy
         FWVA==
X-Gm-Message-State: AOJu0YyKFQroEPra+ZYElLFXeMluaYx9fyUWZRo0tROIs+Cwej+Ygr0y
        IEKyEV//9ue/JWImDAEMqW4nfw==
X-Google-Smtp-Source: AGHT+IHGYkGAGQbuidgr8BddnCfOf+7iMfBc4p8yzRZw8ipG1/9UYUiG8Cbsm+iCJqVulZBcHQn8+g==
X-Received: by 2002:a05:6512:3d1a:b0:4fe:18be:ef37 with SMTP id d26-20020a0565123d1a00b004fe18beef37mr1710065lfv.61.1692449515336;
        Sat, 19 Aug 2023 05:51:55 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id d17-20020a50fe91000000b0052228721f84sm2464003edt.77.2023.08.19.05.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 05:51:54 -0700 (PDT)
Message-ID: <ba07e9b6-ca69-8837-896b-26982facd510@linaro.org>
Date:   Sat, 19 Aug 2023 14:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display: ti: Add support for am62a7
 dss
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
References: <20230818142124.8561-1-a-bhatia1@ti.com>
 <20230818142124.8561-2-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818142124.8561-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 16:21, Aradhya Bhatia wrote:
> The DSS controller on TI's AM62A7 SoC is an update from that on TI's
> AM625 SoC. Like the DSS in AM625, the DSS in this SoC has 2 video
> pipelines, but unlike the former, the latter only has one output port on
> VP2 to service DPI display sinks.
> 
> Add the new controller's compatible.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

