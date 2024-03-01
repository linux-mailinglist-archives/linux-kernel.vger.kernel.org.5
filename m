Return-Path: <linux-kernel+bounces-88120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE786DD8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30716B29428
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E51B6A8D2;
	Fri,  1 Mar 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uo/WGCtA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D76A03E;
	Fri,  1 Mar 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283036; cv=none; b=KSH16QW8AsBz/lW8fW0IWlWR+0u+Ay+/BJuQfdMF3g/yRg8f8zLU5kmKqX0xDRXa9rO8uqe7OhBZjoAt/PviepJqKk3UHkMPFm+vS5rbnBpUxCyi96cKVK+b0pu0eNiePBhwpd8KNjAnBKTznIoqXE0fSo1dqd2pYO3FLPe+kSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283036; c=relaxed/simple;
	bh=p0+gL2pGtqtFlpqt0S3w2xlnVMGKK7Z0m4Og3mVvC2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYLaXAErUH3pAMqkOX+KlCoB935gN6PjX/RbY6AQWSaVmSx3l8ghU2i6gg3SIDEDNwkvu5KSzm9LREi8ouFo88ASheGnGd0bpURZO1lnl2+S3WvnIDAMEphi3ism8ithBfIFjWkx0Z7iW08Kq3ymZnhel5SQsppKzpuS/d4guWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uo/WGCtA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709283033;
	bh=p0+gL2pGtqtFlpqt0S3w2xlnVMGKK7Z0m4Og3mVvC2M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uo/WGCtA6Dqs1bk7v68YrMs+VoVpdYlx5GyjyYpIoL6TALzcXa9P5nppoKgA2l9L4
	 ChPQ+9u1IWbw0s/aIJUIrkuLSD8peA7zPMMp9kz+iTVtO94i4PBppkXQSlvYFDPJ3/
	 UBh//ttvR5FMLF+RuMFyBO5aFR/7so6atM5lhlaRe1AQTSHLlOnCVd8M67pM72jqLe
	 7aGNRg8p7tC3XD3Y2DxOqSqf+AykymBmRy8wl70w7Vn4oJtASLzHMRb7taee6yuj2Q
	 oCvnflAu+hvSt/AoWX/fU+GY69bhUIJv4I6bLBeUJti1odttt1BdC2F39YvHDEsCTE
	 XTSym6OW6jL+w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9AC9837814A4;
	Fri,  1 Mar 2024 08:50:32 +0000 (UTC)
Message-ID: <22e2cf1b-9560-4f4b-b08b-a112e8e272a8@collabora.com>
Date: Fri, 1 Mar 2024 09:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8195: Add missing
 gce-client-reg to vpp/vdosys
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
 Tinghan Shen <tinghan.shen@mediatek.com>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
 "Nancy.Lin" <nancy.lin@mediatek.com>, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
 <20240229-gce-client-reg-add-missing-mt8192-95-v1-2-b12c233a8a33@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240229-gce-client-reg-add-missing-mt8192-95-v1-2-b12c233a8a33@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 29/02/24 20:44, Nícolas F. R. A. Prado ha scritto:
> Add the missing mediatek,gce-client-reg property to the vppsys and
> vdosys nodes to allow them to use the GCE. This prevents the "can't
> parse gce-client-reg property" error from being printed and should
> result in better performance.
> 
> Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Can you please squash patches 2,3,4 in a single one?

It doesn't make a lot of sense to have them separated in this case, only
generates commit noise for no practical reason imo.

arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdo/mutex

Thanks,
Angelo

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index ea6dc220e1cc..f2912e1a0e49 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2028,6 +2028,7 @@ vppsys0: syscon@14000000 {
>   			compatible = "mediatek,mt8195-vppsys0", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0 0x1000>;
>   		};
>   
>   		dma-controller@14001000 {
> @@ -2251,6 +2252,7 @@ vppsys1: syscon@14f00000 {
>   			compatible = "mediatek,mt8195-vppsys1", "syscon";
>   			reg = <0 0x14f00000 0 0x1000>;
>   			#clock-cells = <1>;
> +			mediatek,gce-client-reg = <&gce1 SUBSYS_14f0XXXX 0 0x1000>;
>   		};
>   
>   		mutex@14f01000 {
> @@ -3080,6 +3082,7 @@ vdosys0: syscon@1c01a000 {
>   			reg = <0 0x1c01a000 0 0x1000>;
>   			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>   			#clock-cells = <1>;
> +			mediatek,gce-client-reg = <&gce0 SUBSYS_1c01XXXX 0xa000 0x1000>;
>   		};
>   
>   
> 



