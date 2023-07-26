Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52599763BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGZQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGZQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:06:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504CE69
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:06:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcd6c0282so84843566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690387586; x=1690992386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CckCMVKjZtn73XX/vGnQfTQ1nmreAGHjbMwMQmDTxGU=;
        b=kqJyRA2lp8IC8e9gMZ6tOLzH5l0AWw7aW8S1vNCCo6CLMzYRNZqA/H84/Rxe18LRfi
         xgzei+t1qVCu/+ntDtNND2BqDs1Xog1Spwy6D7Tzl5frx9eqJOQIVIHvjigqGB+vhuQI
         26cbg32Xct1MabQ391lQlEs4DXjaEn/GvgNaraFG82mdbrCM9mdbADsFmHhxAgIQtazZ
         xhuWZ6YAAeseT5qc0feu+s3JV7+BJG6PxeXON+aq7vAB/wJaWw2j6nW1l1xaA6ECoZ4+
         BWgrNniVIp51EKvI99C6pgZ66YSDkOT6oDrcTyyli4uTLccwwgsnxlZtwDA4icefZ9TS
         hZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387586; x=1690992386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CckCMVKjZtn73XX/vGnQfTQ1nmreAGHjbMwMQmDTxGU=;
        b=CoEl2bNlaNEQQjxTp71z8HkWkAKnJN57tjRmx+noBH2oX77cNbj9JArtRROfqKUeTA
         vKSnwQrZkluTRxVLdQ7l95BNYlBBcmI5WsIVawqRWabXslbNkVUAUVGjt4be/svcbCjG
         LXN5q78xTxZ3Vtx+3PmR9wCHdavnWQjbURvz0r6gFppvSNLV8gbiy377g2mWyuZ5KcFB
         MX5d5Pv18EFUGMgsw5Fx5d0tbUJjCC6lwlfqi4onYYTl5caS8gr2pWxH9UUJcpFIeZ1L
         aMdl/UBGbyF2GgKO38z8P+TdHdwBw924xTKsGWDoVZdoshu2I8AJlQfpjwhvjVDe851g
         50FA==
X-Gm-Message-State: ABy/qLbL3DB2Sgj3WgFE7SmYQIOfYz+NjptSdvwhH76Ze7PxoDyC0KdM
        zPN+Utyl3HmyUebsiQu0WYjSqg==
X-Google-Smtp-Source: APBJJlEtkywycgl/q6V+qC4E7blxzJwpc/X+9+4tWcX8bKQr/5GQq60ouHzd8zXSCEyn5IHGR28H7g==
X-Received: by 2002:a17:907:2c59:b0:979:dad9:4e9 with SMTP id hf25-20020a1709072c5900b00979dad904e9mr2210669ejc.50.1690387586235;
        Wed, 26 Jul 2023 09:06:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b00997cce73cc7sm9659059ejz.29.2023.07.26.09.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:06:25 -0700 (PDT)
Message-ID: <52c60fe9-fff0-29a7-1e7a-12ebd207ca58@linaro.org>
Date:   Wed, 26 Jul 2023 18:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
 <d33e5dbc-ca38-4702-903a-b36f9a824391@sirena.org.uk>
 <1c3684e3-b88a-0476-9376-19d07956e261@linaro.org>
 <4859d289-f4e2-4676-9be4-182f7dbda8b6@sirena.org.uk>
 <2df8d695-62aa-329f-f355-d6081d970ec2@linaro.org>
 <34edabd6-8dd1-42f8-8309-07dfbf157dff@sirena.org.uk>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <34edabd6-8dd1-42f8-8309-07dfbf157dff@sirena.org.uk>
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

On 26/07/2023 14:30, Mark Brown wrote:
> On Wed, Jul 26, 2023 at 02:18:43PM +0200, Krzysztof Kozlowski wrote:
>> On 26/07/2023 13:55, Mark Brown wrote:
> 
>>> Oh, you mean if the regulator is in use in the system rather than if
>>> it's enabled!
> 
>> Enabled as "always-on" or "boot-on" could be encoded in the schema with
>> multiple if::then:. But it is not enough, because regulators can be
>> enabled on demand by drivers. So that's what I meant by "used".
> 
> Right, you said "enabled" in the changelog bit though.

Regulator can be enabled in different ways, including by drivers. The
text in description was accurate.

Best regards,
Krzysztof

