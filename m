Return-Path: <linux-kernel+bounces-104403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386387CD56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCBE1F21CCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA2288D8;
	Fri, 15 Mar 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="v6v02svM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AFD241E0;
	Fri, 15 Mar 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506174; cv=none; b=nP/u1O177cVJphCkFjWLCTTciJU6faRAbQHE1pFTdHT5gFRoDdOXQgfVnLVkEVcFIBuPRfIh0567DoSHGZ6UGjGzB0Ko1XUronNJfEtsZGWojCmSb5kUxW2RQ5fAmC1c5LiWO4jcvRT3AI8V4MgzDkkKx7SzcOSX3M+sFEnu+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506174; c=relaxed/simple;
	bh=snxNVny3b5vWDdS22vpyzo7kUdKFFpuQnWuKvhCD5dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPAoqUceI82yG2HcIr88Vvn1RVB5B0W5otWWa9X9X1GrMdW5JNslreVdtP3UUn9V/AQtw19VZD1VTC3fjcuX4P6X0FU/J+Upvqpa9+8Sb0ufYvrxekrLRVRTELCWP9EsUnpZjD/RyrRapRwvsyg01aTE9u5/9x2dX4ROaK6n64Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=v6v02svM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710506171;
	bh=snxNVny3b5vWDdS22vpyzo7kUdKFFpuQnWuKvhCD5dI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v6v02svMU6nHv8G5f72MSLjj8eV+uDHl/+9DybGTO/rBYJD/1kG3udMNQEAwGM3Q4
	 IrayK0Ilj0Z9Erc71/W+z/fozg3A9OcVONXbyl6iUlvmQ7KiT/MFxs0jwxuEPVwGsF
	 /BCdNMJS9V4ad/2C7YDCMcsYzaNFb8eJJP7Eyh8ZO1lWkBRhv7J+njMs2LnF7jWlri
	 tHKKPIdw8ZWanN8ApKa7AjcU7Oct7YC2MqnBxXAek3oEx5Kss+IqU3ojAOMBOHorqs
	 wUxS2W7GEdxs3Z3z2pOswPQKY8is4e6kXaB80129NAp/cGTvGEkubwgkM+aYAtZZf3
	 77/385bq/PpKg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 539093782110;
	Fri, 15 Mar 2024 12:36:11 +0000 (UTC)
Message-ID: <c6188852-378a-4455-8120-024d463ee983@collabora.com>
Date: Fri, 15 Mar 2024 13:36:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8195-cherry: Update min
 voltage constraint for MT6315
Content-Language: en-US
To: Pin-yen Lin <treapking@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 linux-mediatek@lists.infradead.org
References: <20240315111621.2263159-1-treapking@chromium.org>
 <20240315111621.2263159-3-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240315111621.2263159-3-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/03/24 12:16, Pin-yen Lin ha scritto:
> Update the minimum voltage from 300000 uV to 400000 uV so it matches
> the MT6315 datasheet.
> 
> Also update the minimum voltage for Vgpu regulator from 625000 uV to
> 400000 uV because the requested voltage could be lower than the minimum
> voltage on the GPU OPP table when the MTK Smart Voltage Scaling (SVS)
> driver is enabled.
> 
> Fixes: 260c04d425eb ("arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



