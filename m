Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43144812023
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjLMUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:44:27 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40650AF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:44:33 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca02def690so94093051fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702500271; x=1703105071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=791SIM/Dhvb8Ir1xD+lGgMjeSCLDTpnAuXXKKBGGfXM=;
        b=scCp2sm0xN+fUSCUAmpef9JPEiqasoceuJBC7uuWbi13tXHIBN7jilKBOzujq/M2Ik
         RVBrZSdbEyPRfKPsA5e6kSXmepZAep5kyap9WPnY12ZXL2yDOGA1YHgNOcGG0+vAwdsC
         K0RGZmlimA5MoubfHqD5vttj56tzHYajYw7VKROp3RusDdw89aMvmEbB04BjOpoRcXFg
         yyGv8YmP2iW3EznlDw+xnB79N03hfSPcgPRycQ5+qCqWyrpTSywTD3v+0iDHII9cX1Sn
         MbpJcAmV9vdivonRb9Km3mKpJv9P4uR89LUrnEiYqXEVYJ6fLxVSnEFUwEMtqxiz3XD0
         CAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702500271; x=1703105071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=791SIM/Dhvb8Ir1xD+lGgMjeSCLDTpnAuXXKKBGGfXM=;
        b=jpVyAjruK5loPWUDAJGV4K9qaYSJf6gphhykTJXU5RxDL2PkOMlThHwlkA09EcENOj
         qJi9yfMHx+CBKmCkeAGFuAkaT4+htoL3E9Q/HE8uCs+nXafcMGKDu1uZEDNK66dhwmT5
         lcGyZQmn7vzeGeqAi+GU6RRRgQ4tLVMMzH2CNt96Wf6cxF75mnwd/JfiyufZYzfoHDjS
         9SFse6n/Hz7sCbedQ38KkboQlg8DC0Y2+rdhJMwaPp68xTwrTbSge8LCWUiGzeoVn2/1
         ShxB9sPwtdU+FgPgcDpQwDlXuUy912eix7GV5HV1Qpq/7xQoVfJEpxfqQ5RAwYL8LnYF
         lwIg==
X-Gm-Message-State: AOJu0YygEJULtaGEhFEgiu4VX9YZAOwTkQFITZHToYfuVSL/mvpqa5B/
        S6AOzjFasHjVRjHrzENfU7w3Mw==
X-Google-Smtp-Source: AGHT+IGBcCefJRle6Hyu6jtgfQoSzKaAQzBDmyPvdwsrfJHXq/qI3IxXTgfVdwGdurr8E0qLZIqlnw==
X-Received: by 2002:a05:651c:b07:b0:2cc:1c25:83e0 with SMTP id b7-20020a05651c0b0700b002cc1c2583e0mr3375130ljr.39.1702500271376;
        Wed, 13 Dec 2023 12:44:31 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z11-20020a2e964b000000b002cc41ec2576sm1946ljh.61.2023.12.13.12.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 12:44:30 -0800 (PST)
Message-ID: <e7f8e4bf-080d-4bb4-99ca-727d2d00f55d@linaro.org>
Date:   Wed, 13 Dec 2023 21:44:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 initial device tree
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 21:33, André Apitzsch wrote:
> This dts adds support for Motorola Moto G 4G released in 2013.
I have a similar one in my drawer.. not the 4g kind, titan IIRC?
Wasn't this one codenamed thea?

Konrad
