Return-Path: <linux-kernel+bounces-14188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADF8218EB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E761F2215E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3027B79E3;
	Tue,  2 Jan 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jf8esK5A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF546AAB;
	Tue,  2 Jan 2024 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704187772;
	bh=X3V/FUP7jB7imPZc6a3/phfo3h5eler6vQthFA3zLC0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jf8esK5AKxIa/brudcCHU0UiYvO2pmC29TKXKFazyHwe51nl7mJ9rTLT6TMri+DXW
	 CR1f5LycZXNqGF5vdL7dggD0rhKyTw7suSPKQWOcGD86dLIre936kfJXIYwAtGSLzz
	 0vXMs3/xqgKiY67o/avkHRZa3qO+/58d9xIvLa/jOiF4EFvBMS/j2NBHHwObWqgWzk
	 TDkLXzFwAuNuEJ8BfP+t3uCKw9lx4XzUz+j69TXSjETy24mwcHv2AkMhOO/JcVTE4s
	 3TUjuQyH3gLYM3Vsbqj6D7lS1CIl0KNca9i/VY2dNaM+RQ1R2v9dye3bNRIp93Xdhm
	 KF2TPYpN8PuWQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DBD53781433;
	Tue,  2 Jan 2024 09:29:31 +0000 (UTC)
Message-ID: <5ad9e27b-761f-47a9-8d7d-f182dac5d2cd@collabora.com>
Date: Tue, 2 Jan 2024 10:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: media: mediatek-jpeg-encoder: change max
 ioomus count
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, bin.liu@mediatek.com,
 matthias.bgg@gmail.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231227130812.148914-1-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231227130812.148914-1-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/12/23 14:08, Eugen Hristev ha scritto:
> MT8186 has 4 iommus in the list, to cope with this situation, adjust
> the maxItems to 4 (instead of previous 2).
> Add also minItems as 1 since iommus are mandatory, to avoid warning
> on the example.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
>   .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml       | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> index 37800e1908cc..60c75b9312e8 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -38,7 +38,8 @@ properties:
>       maxItems: 1
>   
>     iommus:
> -    maxItems: 2
> +    minItems: 1
> +    maxItems: 4
>       description: |
>         Points to the respective IOMMU block with master port as argument, see
>         Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for details.

(commit title) `ioomus` is something I've never heard of before... :-P

Please fix the typo, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


