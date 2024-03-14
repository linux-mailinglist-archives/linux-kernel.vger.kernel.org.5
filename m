Return-Path: <linux-kernel+bounces-103071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E471487BAA2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B051C21179
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC516CDD9;
	Thu, 14 Mar 2024 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fkUhM6GK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005EE692FC;
	Thu, 14 Mar 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409505; cv=none; b=GeKqylqnbXvr8N8AvfYOrwfXhDhQfRIZ9VVBIMKial6kDc5XuG+ST4j7KhfiB3Av0sJVsnJU18+G0OPpFXcr58wA6ybNupoDqkyX4jiKedgyLORtwSlS8Vhm4HtfH13IKcW8Hm9Wevbo4+qo2XQ4AOdOyXVS1sWcMrgBYMFpej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409505; c=relaxed/simple;
	bh=pVZnehC/cbZZicGajuwvH1Tlz6noVProoLGDfyrCVrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VLiqM93EwSeHFRDG/CBJNFKN8mep5PpEHAIRcSNzD3C9eV1K8ragqsh790JcLLIjNgn3A3BUL65NWBnHbef9G2n7k8vJF1NRXz9RbwAT1oiLCIDpmRFTJQlJSbQNs+p4BBugOB3JUHnZg4i1jrMMnf7kIylYUMAi/618ZJIAZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fkUhM6GK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710409501;
	bh=pVZnehC/cbZZicGajuwvH1Tlz6noVProoLGDfyrCVrw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fkUhM6GK0jvq0Q9XSZTW3dzp3W8UbHMTC7pIxcGG6MKPFbucGLAY3sMt7+1Wihfi5
	 RRQHko0vML9PtDPKRes+rMf0wXvmzqrQNYyHP40avy27aMP3alI4+hAEyLe/shtfx7
	 GJTqjmY75I08n/OrQgk7irkJ0tCGjTLsBi1OfR9EZtZM7PefrpdA8/mE5xWUJROLnQ
	 5TQDtOk9LCQCyIu3g2t6/qVhOmG0TBQmD1LGcd2ZnEpbnvdGX9w7LpLN6koSfCgtwO
	 EoWMy0xxgvuvO4VLfezr562BFlVcPLizsVeUSM/7/V0aoMbYabSPjCWZ1qhK9KTsmc
	 4yLHgrQDeKYAQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8516137820A3;
	Thu, 14 Mar 2024 09:45:00 +0000 (UTC)
Message-ID: <f0383126-99c4-4233-b222-597caacf43b9@collabora.com>
Date: Thu, 14 Mar 2024 10:44:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe
 port
To: Daniel Golle <daniel@makrotopia.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, Frank Wunderlich
 <frank-w@public-files.de>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <1da2506a51f970706bf4ec9509dd04e0471065e5.1710367453.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1da2506a51f970706bf4ec9509dd04e0471065e5.1710367453.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/03/24 23:05, Daniel Golle ha scritto:
> Due to what seems to be an undocumented oddity in MediaTek's MT7988
> SoC design the CLK_INFRA_PCIE_PERI_26M_CK_P2 clock requires
> CLK_INFRA_PCIE_PERI_26M_CK_P3 to be enabled.
> 
> This currently leads to PCIe port 2 not working in Linux.
> 
> Reflect the apparent relationship in the clk driver to make sure PCIe
> port 2 of the MT7988 SoC works.
> 
> Fixes: 4b4719437d85f ("clk: mediatek: add drivers for MT7988 SoC")
> Suggested-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

That's funny. Anyway:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/clk/mediatek/clk-mt7988-infracfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7988-infracfg.c b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> index 449041f8abbc9..c8c023afe3e5a 100644
> --- a/drivers/clk/mediatek/clk-mt7988-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7988-infracfg.c
> @@ -156,7 +156,7 @@ static const struct mtk_gate infra_clks[] = {
>   	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P1, "infra_pcie_peri_ck_26m_ck_p1",
>   		    "csw_infra_f26m_sel", 8),
>   	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P2, "infra_pcie_peri_ck_26m_ck_p2",
> -		    "csw_infra_f26m_sel", 9),
> +		    "infra_pcie_peri_ck_26m_ck_p3", 9),
>   	GATE_INFRA0(CLK_INFRA_PCIE_PERI_26M_CK_P3, "infra_pcie_peri_ck_26m_ck_p3",
>   		    "csw_infra_f26m_sel", 10),
>   	/* INFRA1 */


