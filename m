Return-Path: <linux-kernel+bounces-2246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E334B815A22
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BC61F237D5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69630357;
	Sat, 16 Dec 2023 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkQebdUA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6A30645
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc3f5e7451so19105111fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 08:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702743406; x=1703348206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8PgQLqOXkUClynES2HJSw99Nb05GOLlDrX6V7TYSFs=;
        b=PkQebdUA4hKm/Of5n25PR0ee/m7EiUGm3E0Pachz46oc9SU1MKTb447Vy2EuwRtQQ3
         nuJvm3uJWTbj4nrEfKJSmPLyv2tWjCFbfgpSN3tf4S2EwSNrB6ihcsRMWJ1VTuYCcJt5
         Pr9zoRw7gXId5TNViwZ8yk9Z5iXTOm1HwEserpQYO8ay6x4xgEaUuJBJPXU8muLZQu+s
         +zyih/wOkkd3wOEDK06GSCtZBogAjxmmGofEixuUFdinJ75VfCWh5tyQ0D4xdirCdvXx
         A+USkt76SZU/4LhuBdw5hLO0kbCthVFS5jG780rN9J8IAkQc/uOG3+q9wi0UshQmQ8By
         IZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702743406; x=1703348206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8PgQLqOXkUClynES2HJSw99Nb05GOLlDrX6V7TYSFs=;
        b=DwcB5nXp1Uv7Jj4E9ZtwOn/oMY2Wi2Tt3tC2bovRVIpf2UTWTDKibFrt+1AfCXzN1F
         D7DXanr8+Xzuw0xcaDexM/Pt9KvyqYea1PTQnLJxsdr/ZkVq06jMzAR68FEKOXd2t75z
         g/HE7n3yKgPgAS4cIoGH2wHcOK2oZ3oGh7tkLhmXxJ5eg7tb/PPO5nxpIiiFXVe3DztR
         GaT0yaSCFHBQv8PsL2oidnr/VYcgem27KUKH97KwrBTKVuo9u/emwTKLP0EBjbtLY252
         /FfHlpVatuM6SrMYnFEwhYfquFx25EsM/xarM173F2wuPOtiCNZNX9zt8ImtRyqegBdc
         5b/g==
X-Gm-Message-State: AOJu0Yx4RQFvsL+5qAiBzaT+i+LkF1uHjG8Qj7FhqNFEzjO1+44bEDE2
	GVs39GAEJplqdYszBvXVhlrdrg==
X-Google-Smtp-Source: AGHT+IHQCH/vfA1cj1fNNhtfvMyAjR3ImzfuDYOWm2UJUWey604HepThbTmHm7OIrwHm9H8eTIrCgg==
X-Received: by 2002:ac2:598d:0:b0:50c:525:abda with SMTP id w13-20020ac2598d000000b0050c0525abdamr6034373lfn.135.1702743406412;
        Sat, 16 Dec 2023 08:16:46 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id m2-20020a0565120a8200b0050e17621ea4sm712657lfu.23.2023.12.16.08.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 08:16:45 -0800 (PST)
Message-ID: <4fba10fa-2f46-4d64-aba3-67afe2ddd680@linaro.org>
Date: Sat, 16 Dec 2023 18:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, jsnitsel@redhat.com,
 quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com,
 robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org,
 vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
 quic_molvera@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 qipl.kernel.upstream@quicinc.com
References: <20231215101827.30549-1-quic_bibekkum@quicinc.com>
 <20231215101827.30549-4-quic_bibekkum@quicinc.com>
 <e4329952-34ac-4458-a63c-1f64e288614c@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <e4329952-34ac-4458-a63c-1f64e288614c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/12/2023 01:35, Konrad Dybcio wrote:
> On 15.12.2023 11:18, Bibek Kumar Patro wrote:
>> Add ACTLR data table for SM8550 along with support for
>> same including SM8550 specific implementation operations.
>>
>> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
>> ---
> [...]
> 
>> +static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
>> +	.impl = &qcom_smmu_500_impl,
>> +	.adreno_impl = &qcom_adreno_smmu_500_impl,
>> +	.cfg = &qcom_smmu_impl0_cfg,
>> +	.actlrcfg = sm8550_apps_actlr_cfg,
>> +	.actlrcfg_gfx = sm8550_gfx_actlr_cfg,
> There are platforms that feature more than just APPS and Adreno SMMUs,
> this implementation seems to assume there's only these two :/
> 
> I suppose the only way to solve this would be to introduce new compatibles
> for each one of them.. Krzysztof, do you think that's reasonable? E.g.
> MSM8996 has at least 5 instances, 8998 has at least 4 etc.

Ugh. I don't think compatibles will make sense here. I think we have to 
resolve to the hated solution of putting identifying the instance via 
the IO address.

-- 
With best wishes
Dmitry


