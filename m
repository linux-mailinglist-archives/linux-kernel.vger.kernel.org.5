Return-Path: <linux-kernel+bounces-46055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BDC8439CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107C6284392
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC66994F;
	Wed, 31 Jan 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHl11occ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026AB651B6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690645; cv=none; b=bp7O6OIgFsdecJRmtFfS7s4cfcmRCC7uPv5OuuGDxU57qZl2fQfUum1IdezwZlXpMn+Ojq1xlfi2q9PmfU/SSfMnyrQFQNWXq6/X+lO6bgHVDrXlKjQJ75iNM3TTJt7HD+4WWCUKjKnEv34OlOlgjnS2vllzw9SCvwryzgzbzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690645; c=relaxed/simple;
	bh=d31luWYsuQdq6x9sI290GYoxyL+owfx4MYBc1lDFsLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDG9Erq6uzvMmStZB3xnYCmKcNP6Au4hmoTRt3Ydaw0B/wcfuLzZTjUzpyQ/vxqXTmqXMQy8UyO6vQPmTx/LG/gbuh7dL3rCFlKLCD0h30RZo3Und35sPeJsUeS2zzfO1OTrJq+BzUNGk8U/uqNsxWfcaUIksgZEMUU83FHsaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHl11occ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB37EC433F1;
	Wed, 31 Jan 2024 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690644;
	bh=d31luWYsuQdq6x9sI290GYoxyL+owfx4MYBc1lDFsLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qHl11occenh/ZVYFwfCIjM+3JZ6q3MPpatzFQmlli0t11Gb9OgpJphqVURbu5U2VJ
	 OIZZUaRuKh0/OiZvZWf8MouxKYQ49Vmv+Tgfe73F7WYtJu8+W19NiMuwY7ejedOnLA
	 xdloSbMLj7qhEskyFXprMaD7k+lchonf+FGcrlc0p0nTl0bGB4dYXA711e3xS/gTRb
	 tNOFPmL4yfdehh2Rkogvd0PpBE94/hPzGA1DAQo7Jjw7UCQrRVUa3ZJxFIHj5o3K/g
	 NG2XQqxdUJyG0TLmmkgyIqnL7cyATNsEwya/gLRrTjSyS+yaQGJVuA6qOjWWwa8uNO
	 gobBRtnRTVpKg==
Message-ID: <b954441a-5dff-46b5-910a-2396d0be2d69@kernel.org>
Date: Wed, 31 Jan 2024 09:44:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] soc: mediatek: mtk-socinfo: Fixes and cleanup
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 William-tw Lin <william-tw.lin@mediatek.com>
References: <20240130095656.3712469-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
In-Reply-To: <20240130095656.3712469-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 17:56:50 +0800, Chen-Yu Tsai wrote:
 > The new mtk-socinfo driver has a double put of the nvmem device used to
 > read the socinfo data. While fixing it, I rewrote the read function to
 > make better use of the device node and device relationship.
 >
 > Patch 1 rewrites the cell read function in the mtk-socinfo so that no
 > resource leaks happen, and device lookup is more efficient.
 >
 > [...]

Applied to v6.8-next/soc, thanks!

[1/3] soc: mediatek: mtk-socinfo: Clean up NVMEM cell read
       commit: 82e5d7d793e8aef1275dae266427cf048a7459d6
[2/3] soc: mediatek: mtk-socinfo: Add extra entry for MT8183
       commit: 54d21dea6a6c117f3cab4caa1f9c3ffafb515dd6

Cheers,
Angelo

