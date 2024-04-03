Return-Path: <linux-kernel+bounces-129561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20861896C95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD981F2CA98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CB31411F8;
	Wed,  3 Apr 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dpePdvJ6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE513775D;
	Wed,  3 Apr 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140313; cv=none; b=FTOA/ne8m8NzeeMlzhSLVZd+/UQdyfkQ10/QAgXYv12pRMBH71c3Hqak6pbNNdiLAB5foy9rgM/bjMl8ICr60NPfuljhPjhgQPm8mocU86zSYvwnXVVBT49OmRuR4dsoCECpvz4Bn4m8A8P3UWNMmHhjKchaNLVQyG/z5xYPVfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140313; c=relaxed/simple;
	bh=4iqKGJY4kBJIBlK531YR7UlzsD9hKc27WlTKaBE2L6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCjDVR5NS2xDMoXhyK1uMMca2w/aRj+YCIfXhO37DHCnMU3ooz45LkPIq0x4Pm44kDhraC+HgIgBt/seQFRzROiPRJaKAC/6+XudY5SucR8uHHXNRnBbBl1FKDRR0dgexaST3sF1+ePK71fTzGAFGytDB/UH73RigpZDsUpGr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dpePdvJ6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140310;
	bh=4iqKGJY4kBJIBlK531YR7UlzsD9hKc27WlTKaBE2L6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpePdvJ6o64/y+hWsMvSio6BoiFXgnbSY5fnWWl/C+4y3eIaZpyxqvPa4FVP1RFcq
	 7xogpdAg7vsQDv48sdKvVhKdRW/tLXNBjVi9fEVn1fJuvnLw64JoKCZDi1d4B0WcM9
	 Onaf33Cvu7AGbILGVCU4C/XhtKWrnxpMJnV4FWUeqZDrjIBmToS92MR15NekJPinaA
	 uUvc9S4k+r7enXSTg9fNJztATKbkRK/dCFVB8ylUMTIOlB1J/ENesGVD8i+WdLGPEw
	 So1nD4D2OZtYoxKwDKWLFia6omPmRlWFtlsXFAy7et2h1VRzjccNhsjtUms3o28xEu
	 /buh9A9/dZPsw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 105AB3780624;
	Wed,  3 Apr 2024 10:31:50 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH 0/2] Add missing chassis-type to MTK Chromebooks DTs
Date: Wed,  3 Apr 2024 12:31:43 +0200
Message-ID: <171213798076.111748.12884095737828369172.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
References: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Mar 2024 15:15:36 +0100, AngeloGioacchino Del Regno wrote:
> Even though the chassis-type property is optional, it is useful to
> identify a convertible vs a laptop (etc).
> 
> Some of the MediaTek Chromebook devicetrees were lacking their chassis
> type declaration: this series adds it where missing.
> 
> AngeloGioacchino Del Regno (2):
>   arm64: dts: mediatek: Complete chassis-type for MT8183 Chromebooks
>   arm64: dts: mediatek: Add missing chassis-type to MT8192 Chromebooks
> 
> [...]

Applied to v6.9-next/dts64, thanks!

[1/2] arm64: dts: mediatek: Complete chassis-type for MT8183 Chromebooks
      commit: c7df5fa3d1bd4c71d3a2d452c9da70e5e78f03e2
[2/2] arm64: dts: mediatek: Add missing chassis-type to MT8192 Chromebooks
      commit: 9b8c00596e30bb27a1f25a0d9766d6c767f4b355

Cheers,
Angelo


