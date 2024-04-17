Return-Path: <linux-kernel+bounces-148809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A58A87AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C965B1C219EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB40148308;
	Wed, 17 Apr 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2Nw0ur49"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2213EFEC;
	Wed, 17 Apr 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367984; cv=none; b=WBamnpM/JWzeC51CR7A2wzDSKSHUApsYI6hrkCUHQXtuosLa6qen+osDPwb7H6bPsNxMRIBQ2S8bm+vi+k2B9OaO69STk9m3CXDJBSKnICfJ4qCN4f7xI2lIK47RvuieV0qgXZko3ZkpCtRg188MJUhYYIUo6dzqS2JhSEA9JSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367984; c=relaxed/simple;
	bh=2xn4oP5qSf+gAMTht/g7tss9ReK+HcgndLYujyEm8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1jkrR7o2MGGm3yQJ+hB2h3SBeIl5GcOA59rtmva4MkGQV74zDSUv5ujHZVmgTIIcNtWVKCQQiKSfOQva0CXavsqSWkn1M9yppXtdZg6wgtxCaE+3VRp33YFK59fCKJ1RbnKHXrMC8/DxaKHZaWKtxjaKNTiNOCL6/C8c+Y9WNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2Nw0ur49; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713367979;
	bh=2xn4oP5qSf+gAMTht/g7tss9ReK+HcgndLYujyEm8Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2Nw0ur492Zb/y4Fr0BxzxP5YKMPjw99hkTQ/6oQaqB3+TKVKQgGYBrzJ5jJjUK5C+
	 rqnfaLCAzZS6Y4lwooVAe3tkIF4Y/j+3RFx0r/OkjAxhnAjoLyHcQKycQoRGZrfvtn
	 gBV2oZMyRtPJa4Z+YL8ANtXiuZOG4m/dsN7DoTDSKiPLVdmd06Kpq5kjkMa2of9vWJ
	 YJxdniLjhP02rYUR5TRcTzi0GUJ36xaHfNGAuhi5HEXi7Pi15z13hmap5zqT4ThXlV
	 8obhAOg9xFFA0U3O+BI6GWy2CQ1Dyn2vvv4E0tkNotlFeikZaXdEvGRL7dcHhPlQpl
	 AdHfXY7lei2/w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 329843782144;
	Wed, 17 Apr 2024 15:32:58 +0000 (UTC)
Message-ID: <59edbcc4-fcd2-4de7-a275-1d10e0c35155@collabora.com>
Date: Wed, 17 Apr 2024 17:32:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: regulator: Add bindings for MediaTek
 DVFSRC Regulators
To: Rob Herring <robh@kernel.org>
Cc: henryc.chen@mediatek.com, wenst@chromium.org, keescook@chromium.org,
 gustavoars@kernel.org, linux-mediatek@lists.infradead.org,
 amergnat@baylibre.com, broonie@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, djakov@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 kernel@collabora.com
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
 <20240417091442.170505-2-angelogioacchino.delregno@collabora.com>
 <171336511790.2347768.12360106374334104584.robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <171336511790.2347768.12360106374334104584.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/24 16:46, Rob Herring ha scritto:
> 
> On Wed, 17 Apr 2024 11:14:36 +0200, AngeloGioacchino Del Regno wrote:
>> The Dynamic Voltage and Frequency Scaling Resource Collector Regulators
>> are controlled with votes to the DVFSRC hardware.
>>
>> This adds support for the regulators found in MT6873, MT8183, MT8192
>> and MT8195 SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../mediatek,mt6873-dvfsrc-regulator.yaml     | 71 +++++++++++++++++++
>>   1 file changed, 71 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.example.dtb: /example-0/soc/system-controller@10012000: failed to match any schema with compatible: ['mediatek,mt8195-dvfsrc']
> 

This is a circular dependency with patch [3/7], so I think that the bot complaining
is expected?


> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417091442.170505-2-angelogioacchino.delregno@collabora.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 



