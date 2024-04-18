Return-Path: <linux-kernel+bounces-149924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D88A97EB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D02F1C20DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96515F316;
	Thu, 18 Apr 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kR+ja2UM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F415E7EA;
	Thu, 18 Apr 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437605; cv=none; b=TWmtHMTxLMBA2ox5NpSfV2mWVDGdXBkBJ+734AF6GLGnpWpafiDHGk3DT5kci/Re8LGtFcnWfupXjRGW4778X5JipHUpYqHaj3xMYAv/xbbwaSCfLp9L92rxzlPBqHgE3yHR4uCEkm+HExQUfjusa1147PczxMPf1Txhb3UlCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437605; c=relaxed/simple;
	bh=SDDFhbUiNOwHfeB4Vw/OZxgE2arSxDacnYuS9csQZRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZBXuJBMU2xjf/2pRRtJ1f9SvbDgOf9ursx6k1JiCiU2QYi9/6Tt8M0e1zu7rYGhWV7waSc/UUbvwMl6UA3H6BO7Pce46Y3dWsPxW+qKFWeNxxCxawXa4HHfHgXivpjD5VpV601b4smxMl1uQUF13KrEPuS+ltsrC2nEinYuM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kR+ja2UM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713437601;
	bh=SDDFhbUiNOwHfeB4Vw/OZxgE2arSxDacnYuS9csQZRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kR+ja2UMsEgj0JRYQpxSDG7coPupOpBYOaLnNRByXmaQn3wgUqA6Bb02s+UX0Hsbk
	 +0YeVKxn+uPnO7zWvz8f1nhFKoLOpHo3pkgJd7UM1fvaYAfPLqO9SUNQnxTB1E4YS7
	 9aX31mD04D7PXwVXBtd3pgbbyntchqXNhLnEJEYbA5inq41D9VmqVX5vwPPSGRfvmo
	 rqSfIPrf3bwH1xWykPcvFrdEY7fNsawkCIQ1Fk4YUS86StCtxUq7W6GWshpxfN/plx
	 eiwDiR+KdEn3bDBfslA5EMajyk2uOHkqTUCtpi6rPRrY0//XiJNNff0lZpYO7RioeO
	 /D+YhDal8E4Dw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F1A3C3780C22;
	Thu, 18 Apr 2024 10:53:20 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Walle <mwalle@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
Date: Thu, 18 Apr 2024 12:53:15 +0200
Message-ID: <171343758902.247007.7489492694009874618.b4-ty@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408080816.4134370-1-mwalle@kernel.org>
References: <20240408080816.4134370-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Apr 2024 10:08:15 +0200, Michael Walle wrote:
> Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
> computer.
> 
> 

Applied to v6.9-next/dts64, thanks!

[1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
      commit: 465fd1517d9fda695f8105867cb8547272e9963c
[2/2] arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200
      commit: 7d35c006a52661fd4d17a9f1ab627336cb215b97

Cheers,
Angelo


