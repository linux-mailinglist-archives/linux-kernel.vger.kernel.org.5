Return-Path: <linux-kernel+bounces-87416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF086D421
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A338AB24729
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13740142913;
	Thu, 29 Feb 2024 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Caz0h/CL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DF13F444;
	Thu, 29 Feb 2024 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238198; cv=none; b=u+gkDZ+11q0iTdQyuaSfe0aM+Nu0fm1i+HYfebUk0iO/x2k0tdVkXVr+dE7PBkWut3LV4/FeDDF6pVl3KPBVUHQjH3a51qwDVMgYY9+MXHRb2JeefQwve8YGsxYXLp2+M5+hcdNpGg0xQOzcQLF6RqTvPbVxvN+imUgdMxXJGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238198; c=relaxed/simple;
	bh=eypfRWduOTtxVcXy1CeP9vCXIlJPyx+8mSFU5oBXO/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRjjfL/TcWUYpeMJbzzs2gP+GUKqPVuQFOk9EtCcWE1OQYkWkaqLz1aCpnoUdAHzaPq4fn0HO/3msi/vMD8d3bgV+nC7JZnAbJmwSDM1eyqupjATmyIS9snFmuyCurIh/4ucPe61Y0VRh+Aogdzv4OETIYRu6c/oZuThXVjHSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Caz0h/CL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709238195;
	bh=eypfRWduOTtxVcXy1CeP9vCXIlJPyx+8mSFU5oBXO/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Caz0h/CLWd1f0XuHIlATCpzDZQEDROu3iAqJPbZ/Bm3Zal5kqJIikrrCn/kgFWaLX
	 R5o7GDzqLG7Ec5TZkZgMdkVxoFNyUPSNq/TRjXjB7d8IcZw6V85PCu8uhtW1EALC0j
	 rP2BYIZFgPihSOd2AbuLKoc34DnoUN2Ppd6QdjS+Iun67N9R9/gx3UBBGkGN4pkFp4
	 hce4IgmCsFQ9K0HhYqygEfZF4NKUVjejOPmjTkQJjN8bXEkMTlBZi9ZyIFKbkacjGd
	 B3wa78mo2zvkbDownlHap21AYbvmNR7RKO0y9R2FZEW5sGNrEESL+HQBFBfV/uGiQS
	 rpuMK96Cj+TDg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4153137820E4;
	Thu, 29 Feb 2024 20:23:12 +0000 (UTC)
Date: Thu, 29 Feb 2024 15:23:09 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: cherry: Describe CPU
 supplies
Message-ID: <8a45151a-1d51-4001-b0f9-9cfb0027232a@notapiano>
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-2-nfraprado@collabora.com>
 <e325a4d4-0df7-499c-9d55-7da093b744ea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e325a4d4-0df7-499c-9d55-7da093b744ea@collabora.com>

On Wed, Jan 10, 2024 at 03:32:02PM +0100, AngeloGioacchino Del Regno wrote:
> Il 10/01/24 15:23, Nícolas F. R. A. Prado ha scritto:
> > Describe in each CPU node the regulator supplying it.
> > 
> > Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello,

looks like this patch was never picked up, while the cpufreq part has been
merged for a while, so I'm still getting the mentioned hangs on linux-next.
Could this be queued? :)

Thanks,
Nícolas

