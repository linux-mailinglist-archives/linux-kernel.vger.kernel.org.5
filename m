Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C8766C25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjG1Ly6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjG1Lyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:54:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C4FC3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:54:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-991da766865so288205566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690545293; x=1691150093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVf6A5Nx/q2EKildiIxmLxp4cNtMGz7mdoFctSivjyI=;
        b=LR31EufuoXoa7rKRSNSLbrJqbocfirFDNEtrn/c0yCJgcSRTuSTd/Jf9rWoxoHXg7w
         jm3S5Bq8x5XDvAiKJM0j5lX+Bubbf5vs5E+tgGYPyJFkcAw6VJx1LCRWTlaP7gTTgUGI
         ygex/DHLX3aPhna09kJ3YogvasS9Y70LHA4hVPwThSI5GhIoFgz1Z9KWnAoynFJotCvr
         EZekZIAI+w7a55VQLw+CvOgK1lDCMsWdqxR47Zs7UpMpWmzUu4leOeB5NhalpJmpfk8B
         sXj2sdFih0OLDjwUXjOEbUzQ3uSmhitGN0b3xZfvOUkEIVchnRdS713eIjlWQAJg+Sle
         vD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545293; x=1691150093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVf6A5Nx/q2EKildiIxmLxp4cNtMGz7mdoFctSivjyI=;
        b=c7wKmQ7OoM4glgn0TcMmRYmrlBzRVTc5j9sEudQ/7Nxl6Qr4Z+pPvJC97Zg8oO1H6E
         fK9u+aNGC8QD96ZilPF0LmDjZoQe9xi+NMXYzmUIlKZzMIz/Jva4mxBpGziEMveYlTD7
         m99MGI6rkBAQwiSRYkzTkZbKxJBsW1MgpBxwjPX8fQ1yHiuvVpCtgX9BI+D22k2E8jcD
         VcuhVZsD8s/rveSrj+2OugJyM/enDq7FbBDYvyDcNsHjNkBXqbaJTMwxH6wkIS07odPL
         zxS19Ie7jr8+YPLbvc831f0z6SVjUFKzALFdbl7jlvyZpnNPPFJ6jA/f8m+/1JmyxcKg
         H5BQ==
X-Gm-Message-State: ABy/qLbntQzxABHLlMXQcRH5WMt6nhTwIHPa18kGuVPZF8cbnP+JDUPx
        ujfI3OHXZ0g8+F7pw2yEij94uQ==
X-Google-Smtp-Source: APBJJlF+TDV989GeRya5ntP90XQlmOC2pH2oR2BwNAwssUBTcz0yINP/cvwEbcwWvUbd+oceXt1npg==
X-Received: by 2002:a17:906:7a4e:b0:99b:ca24:ce42 with SMTP id i14-20020a1709067a4e00b0099bca24ce42mr1688763ejo.44.1690545292912;
        Fri, 28 Jul 2023 04:54:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u27-20020a1709063b9b00b0098e42bef732sm1932762ejf.183.2023.07.28.04.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:54:52 -0700 (PDT)
Message-ID: <db2703c0-b7f0-bc73-aa08-bfe4489bd999@linaro.org>
Date:   Fri, 28 Jul 2023 13:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 20/50] dt-bindings: atmel-nand: add
 microchip,sam9x7-pmecc
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Varshini Rajendran <varshini.rajendran@microchip.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102636.266309-1-varshini.rajendran@microchip.com>
 <b5c44fc5-005d-6268-af68-85eda9c330ba@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b5c44fc5-005d-6268-af68-85eda9c330ba@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 13:06, Tudor Ambarus wrote:
> 
> 
> On 7/28/23 11:26, Varshini Rajendran wrote:
>> Add microchip,sam9x7-pmecc to DT bindings documentation.
>>
> 
> Why? What's the underlying problem that motivated you do this patch?

Isn't the problem already described in commit msg, although shortly:
There is a new SoC sam9x7, where the model name is sam9x7 and it is not
a wild-card nor family name of SoCs, and we add compatible for it, as
expected by writing-bindings guideline.

Best regards,
Krzysztof

