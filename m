Return-Path: <linux-kernel+bounces-30226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CA831BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1A21F27ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CFB1DDC6;
	Thu, 18 Jan 2024 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRzeQily"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12B1DA35;
	Thu, 18 Jan 2024 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589446; cv=none; b=NVJoEX6NroYkr7J07ys7SUleP7sScPJYWDrv1bzvWG5PzABE3Xl0D2N3ghgj5nVsLGRu6tO+pAZ8HMMSPzWAXW6/z1dv2zGQw5Tks5B0/itNMOVUiOxgdraSumZq1HyXDd5sNFSqfdmZmRTCVcKwSFQdyXQ/QZ5S+5lEFyKGEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589446; c=relaxed/simple;
	bh=alixWb0bJYipgWM4dK9Ifl3J5Shh4TIfqUE0rVVCStM=;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer; b=tCS5fx93lSCzVMEhbbrRRxfUZM/CwZdTvGleO+IhgztjfNfRg2v8gx/Yy/J/GR03Ke/Xqx7E607HGuUePnJnlPFi2K3p/pAUtd7cTZtpkAon6wJvv5UBVhnRrXLCZA5ayK8uQaoHjR5G1inEIdhxFIHR7MpymvlISDtTv8Cor84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRzeQily; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CA9C433F1;
	Thu, 18 Jan 2024 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705589445;
	bh=alixWb0bJYipgWM4dK9Ifl3J5Shh4TIfqUE0rVVCStM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LRzeQily1n58ZLq1jLHxIxwrt1ztIMdrAirrVCO9hV9n1qsAxlL8wgL2fAA8Q306O
	 WBLAKtHOc1CQyQcfzaw+idgUTJw0LKPSbGR6yMEivXWaP13qwMLX7ewnQqOSNtXcHb
	 D4ZGnEE8nNOHtwtkG8lmnnJAm7sD87+O5N+B4wc5oLJ3YP63v9aTMHYdaM2ermVqzU
	 VrBi8FfB4gTuQwdp/pX3gS+0rGPNYkBN7eAlyzDEPfyE55U9CiQ30XyEWiz/sf4ip6
	 oZwT6leH8fjMi+z5o/EDJRIj1UVooLlhmPSbjJwsn8LSGkzWiTY6KuoIks6lfXyyCg
	 mtc1vhifesVjw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff LaBundy <jeff@labundy.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
References: <20240115182042.1610134-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: iqs62x: Do not override
 firmware-name $ref
Message-Id: <170558944350.3311254.3312082650049337237.b4-ty@kernel.org>
Date: Thu, 18 Jan 2024 14:50:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 15 Jan 2024 19:20:42 +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: iqs62x: Do not override firmware-name $ref
      commit: da4326075cff7ee6416309a9c3641d7eca2a53c7

--
Lee Jones [李琼斯]


