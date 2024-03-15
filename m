Return-Path: <linux-kernel+bounces-104404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F44D87CD59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D4D2838DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBCD36AED;
	Fri, 15 Mar 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JPKBtvqk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E259124B26;
	Fri, 15 Mar 2024 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506176; cv=none; b=UZVnf9V6rLZxEcPsv0NyZhJfrdQAxHV02yL+LdnU2AdN7uET1XODGeN2J4slh79+S3A4vgxMTzStxVTuLpXWGCRt/iIikkfDYl4JxRSl3GZWzsQdEyMSOFMK7AjWeMRX2X9HUPwc7jZ4EyRzpw9FsuZf1CzRT0A5Gkeh8oJG9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506176; c=relaxed/simple;
	bh=sXn9cci0I3XE9mhMDSKLJPy3XLYVgxwVNOfzPtLZ40s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W17FrDM9nmvpUv2ZoxTsNuxnRn8pSQW0RNEZ2n4pMlLk+ikqr6tWGKbocLf6wBhrrjxOxqu3TCOdac2A2MalIDjydSv8nXNlTFZFXFCmJip4eN8ly+4uVxm+pfonQ02h6Chh4paYBvqOh7yq5vifPvFbt3aOMseIuK5Pb4/ripc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JPKBtvqk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710506173;
	bh=sXn9cci0I3XE9mhMDSKLJPy3XLYVgxwVNOfzPtLZ40s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JPKBtvqk5Arybk7fguYZcRKl4lYEBL3MWjC0s4UviIK22yLAs7PIxUiyuZ8pQKIdr
	 vM63+fz9RRJqV47y65Dnozt+TLXwlfNZWf/xfeVact55QokzcqauCDnDKnY4doS64R
	 ZGCQuLWOm0SvXU8TwrzP/gCkQGpfo6GeE8YLNFdm1V+1V4uX6fF1o7Sz0Rt5gsEVRp
	 90/wMjqeL6xQujavatRdpxO/gCF8TS4n+gEyaq8JR6KYFv2d0rquAmHAD1+h1DGAu/
	 c6MLCiaEw9kHKztbh98H/bAnjKihh+WQ0/2q1ovamV4ff6nvKEDMfABAwbpyfSvT42
	 My8sz8Jj4INvQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C2A2B3782112;
	Fri, 15 Mar 2024 12:36:12 +0000 (UTC)
Message-ID: <9fe9354e-e2ef-40a4-a86e-aaa590ccd4c1@collabora.com>
Date: Fri, 15 Mar 2024 13:36:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: mt8192-asurada: Update min
 voltage constraint for MT6315
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20240315111621.2263159-1-treapking@chromium.org>
 <20240315111621.2263159-2-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240315111621.2263159-2-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/03/24 12:16, Pin-yen Lin ha scritto:
> Update the minimum voltage from 300000 uV to 400000 uV so it matches
> the MT6315 datasheet.
> 
> Also update the minimum voltage for Vgpu regulator from 606250 uV to
> 400000 uV because the requested voltage could be lower than the minimum
> voltage on the GPU OPP table when the MTK Smart Voltage Scaling (SVS)
> driver is enabled.
> 
> Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



