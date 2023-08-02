Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E8C76C5D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjHBGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjHBGxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:53:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561C83C13;
        Tue,  1 Aug 2023 23:53:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so724373e87.0;
        Tue, 01 Aug 2023 23:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959200; x=1691564000;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4Pl5BdSH4byRA35L85xc6zgO1CbzCWnR5yIepndUv4=;
        b=dG3UvMXulrUfNJ6jRi002t7IMTXDRFa3EkIjXo4YZNoRRElB8ESgvKp655SVVhEW+s
         WqK3tMXaREEjwHcNlgWUiIW0S755S+bbP8MgPvVzansTiM5Hmk2/h9X1qWkaFBdcJIzp
         FuEAbmNQ5pA6Z2CG1aIyNb+NXuSXUGp8bXNvPOdFfOqB5mPK2BtWbjXM9+sSmTKtnyUX
         mqbEkv3XqPyAgUo3WsrCJzZN7FLg2y8DnK04LOupId8sDYi2FB3zwc6vXZUjnCTkeljY
         l9Sd7WNg/lnIDfHesFVLvn9Lnnov8idFVo0cjv0+YENOWnrDv1H+1JKBYXP0uV28DWf6
         QFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959200; x=1691564000;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Pl5BdSH4byRA35L85xc6zgO1CbzCWnR5yIepndUv4=;
        b=ZPKHHyJbL/1Y6fL9xO98qiXkB9bgK/pjkisXuaacxBcy9G6u4M9+JFgSUa3aQhm2mu
         +g2YCTyVve52s4J5SjBKj04eXSGFrjF9uhpXE7Dha+oOIp82BXGXsB5BHUlODUIroHt9
         klHTiTNeyT6E6YJ5oNjZy/ok0XV0mwV3YpwGC2aSFyIj/KmKvIGtdqLAbS0ueVg5kp9A
         tEo9yETGqHmauOp+rdWxvn2rYuC2PMvnQh1CEecVmltAsBuhffl5zVs7KrcN5qTq/00O
         WF2TJhc+rBox0Xdjr08PcDNoajkL36bDfMuXfIDHycumtRr20cFiHYd8Y/sO9CEhjsgV
         3Ofg==
X-Gm-Message-State: ABy/qLZbtSJ7KzYg6KWZD3SOR2n+Xuofz/g3f4tmxr3X1iua4cLoyrBy
        kEKd7+Kf9fWCAZbTVf5GWTU=
X-Google-Smtp-Source: APBJJlE+MsFBV416mdrDP4Oa0sGHVarFSvTi8K1fbAzufL0Uiiw35c+ZN+Sy5dLJWmGJzMM6O7lp8w==
X-Received: by 2002:ac2:4301:0:b0:4fe:32cd:481f with SMTP id l1-20020ac24301000000b004fe32cd481fmr1833475lfh.1.1690959200258;
        Tue, 01 Aug 2023 23:53:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id j29-20020ac2551d000000b004fe09920fe5sm2867897lfk.47.2023.08.01.23.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 23:53:19 -0700 (PDT)
Message-ID: <f28f74f9-e88b-55a3-28e5-5997474a8238@gmail.com>
Date:   Wed, 2 Aug 2023 09:53:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: leds: rohm,bd71828: Drop select:false
Content-Language: en-US, en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230728171123.110489-1-krzysztof.kozlowski@linaro.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230728171123.110489-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 20:11, Krzysztof Kozlowski wrote:
> select:false makes the schema basically ignored (not selected for given
> compatible), unless some other binding references it.  It's not really
> useful nor needed for device bindings, even if they are part of other
> binding (like MFD).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Yours,
	Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

