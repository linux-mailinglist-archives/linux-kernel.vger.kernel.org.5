Return-Path: <linux-kernel+bounces-129556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB79896C85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8516D2886EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5A145FE1;
	Wed,  3 Apr 2024 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZFkQnSQz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB5144D28;
	Wed,  3 Apr 2024 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140282; cv=none; b=sYx39ove2E4duiOzAtWcGjrcPzUQgYaOUYzWnyKs7mcCm9Puy7DDPZ+nMo+ykGktGH2u4+i4e5qLFOt49m6ZKhIeFHeGv/RkSshSf61DfoTRTZV+mKlr77ARIc9n508/xWm7noSw6S2E7T1G0lox25pQ2xwqVdodj0Lo2YbGdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140282; c=relaxed/simple;
	bh=etU0Fj2iZdIff3gebOm2cSSWKbsxCIRWcO8xXg0dock=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAY8zNJt1gCFWvicWbH/q5U+ju8mWsNkC0aZH3yt+wCtK06nZ32sEqNmfl2BosL1T+5EpGmK+Z0gVDhSgOvaCQK0SBmzD4gI1EIe1A8W6t4p2A1UBOzh2BP6z0pTYMupsKbRxrvA0QLbYjYHiEPRC6KnyAfNndBEQj3FMwD8Eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZFkQnSQz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712140278;
	bh=etU0Fj2iZdIff3gebOm2cSSWKbsxCIRWcO8xXg0dock=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFkQnSQz5Qh2ySG1S7JtHOmJ561+j+A92qPRyCSztA3w8ZfhQRv0ASmmJvEJoP9Nz
	 kcPJ17CUuClzRp8ZfxyufvRvYNR9cYv2z6MhLQr6Kya8sa2PekDKS8EdSKf+DPhae3
	 ApQ85hx42I+YkmItiy5Q3syOT74ijQGHAC1VQPEI2jmR3aHe9hRvWEhdcqjIofu3Zi
	 mNlpcLY5lX4OWjulIH3xql6G4N1dnSd4ldwFc+EhK7yHeSPCOQ/t3+Qt5slbnFxVlO
	 irbngHphEHkdSHf42d6/PD2aQnxs3FRkfY9+jWVeEStCIjOqBbzCufSq8OeGQE75QV
	 qOoeYBTV7dk1w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C039B3780624;
	Wed,  3 Apr 2024 10:31:17 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
	Tinghan Shen <tinghan.shen@mediatek.com>,
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	"Nancy.Lin" <nancy.lin@mediatek.com>,
	kernel@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/4] arm64: dts: mediatek: Add missing gce-client-reg properties to mt8192 and mt8195
Date: Wed,  3 Apr 2024 12:30:55 +0200
Message-ID: <171213179799.60933.17952427266637004148.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
References: <20240229-gce-client-reg-add-missing-mt8192-95-v1-0-b12c233a8a33@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 14:44:27 -0500, Nícolas F. R. A. Prado wrote:
> This series adds the gce-client-reg properties to the nodes where it was
> missing in order to avoid "error -2 can't parse gce-client-reg property"
> errors and possibly improve the performance. The separation of the
> commits was done in order for each one to have a single Fixes tag and
> therefore be more easily backported.
> 
> 
> [...]

Applied to v6.9-fixes/dts64, thanks!

[1/4] arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      commit: 00bcc8810d9dd69d3899a4189e2f3964f263a600
[2/4] arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys
      commit: 96b0c1528ef41fe754f5d1378b1db6c098a2e33f
[3/4] arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
      commit: 3b129949184a1251e6a42db714f6d68b75fabedd
[4/4] arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1
      commit: 58f126296c3c52d02bf3fad1f68c331d718c4a9b

Cheers,
Angelo


