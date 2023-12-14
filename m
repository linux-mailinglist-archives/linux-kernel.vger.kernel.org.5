Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E48B8139D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjLNSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:22:11 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F2410E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:22:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf69afa99so10883127e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702578134; x=1703182934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zt6+gWy3AYMGQQWK/VYCZJ/8Ak/jHvaEgVD9s7jZJE=;
        b=NaNr0mz1qAc3gO7fJQL2VF0XNWaGagG1TgvrUlQoV1aLBDol6j7KEehPFNeB64gThz
         3kG/OEyyBEyxnwlu55AuZKgDbDXDXGzYlft1DQmbxiurB0BwFxFAjjoddlbCjx0qTzwZ
         GB9udkEMKsJCHxhA/JNHP8obwYXI1dJV/oEiDH9LYXclYqy1SKApT62vlj3etT9I6ztE
         qeop4/RcSywKAf2yDyqHqwsg8aubHeDTuNLoCaRen89GMtbQcFhuiRmHxeeAZNnvEIvA
         Yjb2tW6VZKxSigbfuhoggSjvdixTGH7d/M2X4FJKYo7l3i70XpBlp69Xfmp99eL7NCJX
         /FQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578134; x=1703182934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zt6+gWy3AYMGQQWK/VYCZJ/8Ak/jHvaEgVD9s7jZJE=;
        b=kU+cJpQ2tk4YxB1NiUlEanvoX658cFUTFOREplwPkEVE3m3lPzPBk92I8x1QTvm9mz
         vde1GBTZPXfNyDEOXdsHHV7/JRkAYaGO+P/QvqHMSaZidou6wzHhxGYDDzKrXyJgZX0o
         gPzrVAeDM+W75S8hm83QzkmJWk8oHqblRRSr83GzKUKeXUOJPdPfpZ4mFtceVE6rfz1t
         ArCYT7ASgHcNBCkzV6Y1+NVXldEhzc5szDjHPqRAscv+87KudA3e1/igjIoA+iznmiDl
         Jqk4BmhBXHu87ILy202XoWIOg2mFNOtlurmpsjsCaIPCqWnBr2omQuLb9CFMkMewUlYW
         65Wg==
X-Gm-Message-State: AOJu0YyHt0vJLFJH1pLXzHvlWbWCdnuxLoIwUh0s1oiz5rT2RF/SKbYL
        xMH2xGF8mVC/atYcIHLDdxjV9A==
X-Google-Smtp-Source: AGHT+IG+XbVz7FwSzjj/gwHLGVwqaJROV9CW96oHkXLky1gS42N0U1lqDEU4h7qlZAmOkAmt1r4s7w==
X-Received: by 2002:a05:6512:92a:b0:50b:e9ec:4e2c with SMTP id f10-20020a056512092a00b0050be9ec4e2cmr4474729lft.104.1702578134417;
        Thu, 14 Dec 2023 10:22:14 -0800 (PST)
Received: from [172.30.205.72] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512340a00b0050be8d89aefsm1929877lfr.309.2023.12.14.10.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 10:22:14 -0800 (PST)
Message-ID: <d9a80642-dd8d-4b3a-bf59-2852b5a5146e@linaro.org>
Date:   Thu, 14 Dec 2023 19:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm8550-qrd: add PM8010
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
 <20231214-pm8010-regulator-v2-5-82131df6b97b@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231214-pm8010-regulator-v2-5-82131df6b97b@quicinc.com>
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
> Add PM8010 regulator device nodes for sm8550-qrd board.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
Weird to have "pm8010" in p4 and "PM8010" in p5 commit title,
but it's fine, just remember to be consistent the next time
around

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
