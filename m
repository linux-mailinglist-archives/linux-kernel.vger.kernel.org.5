Return-Path: <linux-kernel+bounces-24033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A382B5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C641F2481B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3C56B67;
	Thu, 11 Jan 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="FpRJcWwu"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7E26AC7;
	Thu, 11 Jan 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 0CF2D1657AF;
	Thu, 11 Jan 2024 21:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1705003682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GvjUcYLLXKLbNwRxSSCVydB/RFhpiJ6mm/XGX66hcSY=;
	b=FpRJcWwuQTPar2Eai5aH4jQj/07Z2WhTgHa/405+UzJUOVS57CrlyTqfDSBahucZexEPTx
	lf1+UMns5MoGVtfNDUWqNzfHcM/ZOHrcVfm2um3wncHvo8axQjY1RetJk/xUpv+nqspKJE
	H9JcEH1QV9ug1ECXeRT0EDp5jF3l4UA=
Message-ID: <9696e2e9-db02-4ea7-b955-785ff5d19f3f@ixit.cz>
Date: Thu, 11 Jan 2024 21:08:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable PSTORE_RAM
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Kees Cook <keescook@chromium.org>
Cc: kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <quic_bjorande@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tony Luck <tony.luck@intel.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110210600.787703-1-nfraprado@collabora.com>
 <20240110210600.787703-3-nfraprado@collabora.com>
Content-Language: en-US
From: David <david@ixit.cz>
In-Reply-To: <20240110210600.787703-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Useful stuff!

Reviewed-by: David Heidelberg <david@ixit.cz>

On 10/01/2024 22:05, Nícolas F. R. A. Prado wrote:
> Enable PSTORE_RAM, that is the ramoops driver, in the defconfig, to
> allow logging and retrieving panics and oopses to/from RAM automatically
> for platforms that have a ramoops reserved memory node in DT.
>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>
> ---
>
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d48659217bb4..0b0ef6877a12 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1589,6 +1589,7 @@ CONFIG_HUGETLBFS=y
>   CONFIG_CONFIGFS_FS=y
>   CONFIG_EFIVAR_FS=y
>   CONFIG_SQUASHFS=y
> +CONFIG_PSTORE_RAM=m
>   CONFIG_NFS_FS=y
>   CONFIG_NFS_V4=y
>   CONFIG_NFS_V4_1=y

