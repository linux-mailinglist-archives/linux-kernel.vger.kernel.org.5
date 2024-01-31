Return-Path: <linux-kernel+bounces-46011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAABD843934
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE90D1C21238
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8C5DF24;
	Wed, 31 Jan 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqI3eTcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3275DF14;
	Wed, 31 Jan 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690334; cv=none; b=t+2NL0d70myBP009+/ZDseg6uVXpmJXa9nnT8A7sbrJX9EEvoUJlTphsn43lcGL8sa6Nz0pBr4pO/z4JYnJj/PWb0uv+Q2CcerzvY6BaPmC9oJT1LqkKG0z5X9YcnCClELhtmNwlqDWodr/G+OCEX946KS3Vcb4ldQCHR+dxXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690334; c=relaxed/simple;
	bh=x0tRelhk7NT8O3HekjXxZew7WO8DsjClDug4eSypwg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPj1a+u/A/TPDi/IcwgoWhpkfHiyCVDzol0VlB0mgR5RvRgH9zL2AytX+HZg25hVcQRUom/E4wjR8BTGV8bi1iRCDcwd+mZk1KAL5S/kLvaSdTHpmgKGgOT9ea9WlP1iNZt3Akw25fnzyO6oJjte3pFLJffThb1plB6CVT9OT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqI3eTcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7930C433F1;
	Wed, 31 Jan 2024 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690333;
	bh=x0tRelhk7NT8O3HekjXxZew7WO8DsjClDug4eSypwg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IqI3eTcSS3u8krmwIFMQifrLSop0nr3gnpfsa7xh9ibKgcbslk7GFvWvQuF9k7O1s
	 MmzuH1IZ7sVwVcVS9UG/HAoL7w4UGou5jqhO2idvOK5BrjzK78kM/LKoodzn2NUhGw
	 8EoNWhHbhbzhfPr1/nax0whRRJYlnk4PccUkHYk6IryIlmV/L7qth9r6qCiSlQ0z+T
	 JXx/uABnox/9BeRC7RFxFRspvQD7eDFyuPUfK3Nxhc+sVJcbNC8tzMnj3KPZING1Xl
	 sSx4whYGpALtb8FlfLHK9MuWaszoIxMSTKbuMOR19Z4OPczjzxUXvX7IAFxQ21mwko
	 sXaJcpXRcylJw==
Message-ID: <a331e135-857a-49d2-8644-e8dd0255f372@kernel.org>
Date: Wed, 31 Jan 2024 09:38:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Add MTU3 nodes and
 correctly describe USB
Content-Language: en-US
To: matthias.bgg@gmail.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, wenst@chromium.org, kernel@collabora.com
References: <20240115084336.938426-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
In-Reply-To: <20240115084336.938426-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 09:43:36 +0100, AngeloGioacchino Del Regno wrote:
 > The MT8195 SoC has four USB controllers: only one is a direct path to
 > a XHCI controller, while the other three (0, 2 and 3) are behind the
 > MTU3 DRD controller instead!
 >
 > Add the missing MTU3 nodes, default disabled, for controllers 0, 2 and
 > 3 and move the related XHCI nodes to be children of their MTU3 DRD to
 > correctly describe the SoC.
 >
 > [...]

Applied, thanks!

[1/1] arm64: dts: mediatek: mt8195: Add MTU3 nodes and correctly describe USB
       commit: d464e09e60f024aea0de7adb680a8e8582ab8df8


