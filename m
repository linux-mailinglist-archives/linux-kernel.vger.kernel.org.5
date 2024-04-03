Return-Path: <linux-kernel+bounces-129562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D76896C97
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0DD1F2CABF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D41420A3;
	Wed,  3 Apr 2024 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fcOKvHeZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE207137777;
	Wed,  3 Apr 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140315; cv=none; b=efUZl064cAQpGD4RsCoAhyalV350tGC331eLmwozbyAoEh2Dq1xRJW8sS8yL3sxQbBgCgtbSu1LKuJySIMUU2MwVfJfQLU2zTg95W6vnnDphR/EuYUnhfOhqFzIBxrn3VVWFdpVBJDF8SfFIOtKsPbCKkG+G1O+gKcN5i7N+doo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140315; c=relaxed/simple;
	bh=bKmDSIDkCEXhaz2uF+QbMZ0GeW+xwltWAAyCQPnHrsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJkzhXBDD5pyzLeKmypD3G4tCn7VBGlXZNwDUfaRrjfekbXdcPdegExsLG8OXHv/wxaZ6yiraUR2Z6gE2pde8ZWjdBwHykmxpGXu6Y4i5rLOzE4ipasdkklAQXAX+hDSzwew1wnng7PRLauMZ9O8SLT4yM8T+q+/5ldjAZyIlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fcOKvHeZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140312;
	bh=bKmDSIDkCEXhaz2uF+QbMZ0GeW+xwltWAAyCQPnHrsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcOKvHeZ4iWpHRfxSuyrNsWLaqd0HmGeQy95YGjLOp/I7wVH+kBZSnB/6qJHevjpO
	 iBYwjU0GA/A46YUUoCyNcrDFD8KVxGZhhPgwWiIWCFn1ZrSq3vlRKTzrkKSPULW8UK
	 5q36mLKNLcHE1XWYhRGNmKmPU5FSJECCoapJ32tMshBSWBpnC3wualBqNpin0b1Jy+
	 zrbfCRF3abIDHaxxQo8JSSVP++ecaWF7w3n9cgCjZaASLqm4e1v4i8RVKBb58221dZ
	 qDIRAMpEUvFQah2UOt635+rQLYPMogbRaBGtuh1WgOHcDhfgtTWdIMD2LSa8vaGC7T
	 CbK1JyivpJi9w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA82C37820F3;
	Wed,  3 Apr 2024 10:31:50 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	robh+dt@kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [PATCH v4 0/4] arm64: Add support for Airoha EN7581 Soc
Date: Wed,  3 Apr 2024 12:31:44 +0200
Message-ID: <171213798076.111748.1656778458419095721.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709975956.git.lorenzo@kernel.org>
References: <cover.1709975956.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 10:32:13 +0100, Lorenzo Bianconi wrote:
> Introduce basic support for Airoha EN7581 Soc and EN7581 Evaluation Board.
> 
> Changes since v3:
> - remove unnecessary entries in Kconfig ARCH_AIROHA section
> - cosmetics
> 
> Changes since v2:
> - fix cpu-map definition
> - add more cache info
> - add missing soc node
> - remove unnecessary definitions
> 
> [...]

Applied to v6.9-next/dts64, thanks!

[1/4] dt-bindings: arm64: dts: airoha: Add en7581 entry
      commit: 82aefd8f1f1e73f95523a8eebf3d52719a946120
[2/4] arm64: dts: Add Airoha EN7581 SoC and EN7581 Evaluation Board
      commit: a8ffe7cfce40c20a2508c474e49bfd9f29d0e253
[3/4] arm64: add Airoha EN7581 platform
      commit: 91ed3fc5e3a3b33ce73374715f3be97367caf402
[4/4] arm64: defconfig: enable Airoha platform
      commit: e9340b4423db78a31ed156a92af9eb2fd7df9456

Cheers,
Angelo


