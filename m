Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7530793AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbjIFLGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjIFLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:06:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111FE59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:05:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso519516966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693998357; x=1694603157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZF93plebKdvCmcv2sStolY9Gg96oDc/H3iFV6+vo6g=;
        b=KpqMBsuksmRpp04mdXXzrFSrFWKyy4ZPz27ToUZiI9stee5SbUGU9VeBKmJSe+CGGc
         0fHnogiXTzIsmE/ik9s4ZtySPTCaHzfiYppdmfM60on3gn9BqIDzDmvo3UENtEQIAue7
         B3GgHT2YydK4zJKLYeZ6IW+6MijrMQ6KR/Yo8avutIwnJv/XoSI7g1bR83hEVE49zq+/
         THWvGV5q+EqxmjYYZdkAOS8FSY2zgVeVsxoiLyVgEnPlnuODdMzCXEY98UeUnWf+RWLc
         2sC21M8XtVMyNlG+9Ii+C+cZf2EJ3jV+S/3WYdjQEpv5z0qI1gXL36fDcENzXIASNQSY
         A0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693998357; x=1694603157;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZF93plebKdvCmcv2sStolY9Gg96oDc/H3iFV6+vo6g=;
        b=SraN0CaEFn/oNit1QcrxhiJaKNd5LaPQh/ERPziHqv19GyDAPOs8Qf56Wrt+6gsnEk
         PcrCo7KGyXZKila3dHwgDeEVdAvy7gH8VgN2iNQGX8P4XfthFii+OThHmmt9FaWmihkK
         O7jF4pX0pJh+aLq8VutPG3Uu9837M4KNjIVLtIvOVePfTRKETNALrt0AQ9zmC0w9vhhy
         +bJLeTRlBeKcs2ZIc8dqwnwClomTa0nN5gPexkc3pcl0Me3uv8Pi7ggeXabYXim0hLzm
         MpzE3tY/1/s0Jk3oZCLVQNqJ8NwrGzXULRiou/Lh4oJVu+XIi8BJv1Bj2BM31YuqHTsg
         pS+g==
X-Gm-Message-State: AOJu0YxV0XXWtaG4PQjIUdSiTaa3kOb24iHjHS1yjtQuhnf7HczTXZf9
        EYAHfc7EH09++pDBmTlYQLkEnxQMkIXKJmtjOEE=
X-Google-Smtp-Source: AGHT+IG87GKTy7Cm3eTULvc0MLBOlYrDMG1y4DAY17lrDFmo71ieT/Hk6T/V9nZLD6eJRzhQGGav/w==
X-Received: by 2002:a17:906:32c8:b0:9a1:c659:7c56 with SMTP id k8-20020a17090632c800b009a1c6597c56mr1975050ejk.22.1693998357507;
        Wed, 06 Sep 2023 04:05:57 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0099bd5d28dc4sm8775909ejc.195.2023.09.06.04.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 04:05:57 -0700 (PDT)
Message-ID: <45357ff1-4fd2-45f2-bb3e-16f973e22497@linaro.org>
Date:   Wed, 6 Sep 2023 14:05:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: qrb2210-rb1: Fix regulators
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <20230906-topic-rb1_features_sans_icc-v1-0-e92ce6fbde16@linaro.org>
 <20230906-topic-rb1_features_sans_icc-v1-2-e92ce6fbde16@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230906-topic-rb1_features_sans_icc-v1-2-e92ce6fbde16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 12:24, Konrad Dybcio wrote:
> Commit b4fe47d12f1f ("arm64: dts: qcom: qrb2210-rb1: Add regulators")
> introduced regulator settings that were never put in place, as all of the
> properties ended 'microvolts' instead of 'microvolt' (which dt schema did
> not check for back then).
> 
> Fix the microvolts-microvolt typo and adjust voltage ranges where it's
> necessary to fit within the volt = base + n*step formula.
> 
> Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: b4fe47d12f1f ("arm64: dts: qcom: qrb2210-rb1: Add regulators")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++----------------
>   1 file changed, 43 insertions(+), 43 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

