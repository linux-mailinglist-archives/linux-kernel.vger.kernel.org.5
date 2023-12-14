Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673B88139D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjLNSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:21:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F57310E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:21:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50be10acaf9so942430e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702578077; x=1703182877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tafX2xO3xAurBh49KG+2mvpDK4q6+JAcQjqSwoaxrcE=;
        b=zn8E1Llk7e16Y2Ks60uDFwB7lFGJG6HFJbO+9bXwNt6mQTr0KIFkxNnRsQvTMmS1+F
         ppKne+Ghdj2Hcj6vsK3HppfJ6DUowUFZQZ9mT3xmJdxAD86+zmb7y9xtpI4I0BuVHsHJ
         zB5KuYebQr6p9dig46St7KGucp2fQPnKZAuwE++smd+GH6V7C81WQLPL4BV9bxsuRNwI
         etEbZt+daZ2vmFVBZJHi+RKQYgTLKqTlP2IEYQXIdtsbELgZiXd/PefFNHGJjT8EB90A
         c8uLoh3FxvDH2BeaW33WPyCqC+VpBAvMinr1AH0kCADyv56uNfYiBV1dN4NjGapVi8Qb
         TfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578077; x=1703182877;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tafX2xO3xAurBh49KG+2mvpDK4q6+JAcQjqSwoaxrcE=;
        b=MINgyV50/0ftFq07FfGDwdzbKpvY6Z4hTEf23E8RmEnCLqCNFObq7ZlrPNHzo+zzks
         HtCGwpWoHqiraAC7iY+5HxAzrxusSTU3uq7eKK2im/YB85VC/R0NMkopOXs1xSGkKpP7
         b+scUajxSVfDQ2TQrA6R7duCdefshZ07Osh4X36MOjklZN3WTPSb3aFdaK6NA8MwiGXv
         54LHdHzsG/xC/rZLjwJBr3ou9USLTzUdprDLX3aHWauUuxhBn2TrZBm7bCHMDrCWHens
         UQu/73BckRgczndT+Juc4UNGLdnLo/SQU2PduAxlqx5TYhdi1VaOIQuODY2NIndck90y
         mYAw==
X-Gm-Message-State: AOJu0Yx3j4roWwHEcKZ9QOuUlg3VI5SyGyXhtpnF8OPIPhFwGn59KRyE
        btCkIZ5Jz/f5W7HDS23KGwSvwA==
X-Google-Smtp-Source: AGHT+IE1OD2xsxB9RWQXbOqrcXcuu2XkumezDuYt6qOI7ak3ltyNiq6bYWnvuZG3s3zDZDMzhCMgbA==
X-Received: by 2002:ac2:46ce:0:b0:50d:1842:551d with SMTP id p14-20020ac246ce000000b0050d1842551dmr5027987lfo.13.1702578077527;
        Thu, 14 Dec 2023 10:21:17 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512340a00b0050be8d89aefsm1929877lfr.309.2023.12.14.10.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:21:17 -0800 (PST)
Message-ID: <37f704fa-b5e5-4c2e-9576-0bd37c9ad624@linaro.org>
Date:   Thu, 14 Dec 2023 19:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sm8550-mtp: Add pm8010
 regulators
Content-Language: en-US
To:     quic_fenglinw@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
References: <20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com>
 <20231214-pm8010-regulator-v2-4-82131df6b97b@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214-pm8010-regulator-v2-4-82131df6b97b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 12/14/23 03:59, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> 
> Add PM8010 regulator device nodes for sm8550-mtp board.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
