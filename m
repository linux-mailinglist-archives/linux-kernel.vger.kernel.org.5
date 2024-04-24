Return-Path: <linux-kernel+bounces-156682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A38B06C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906681F2462A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3EE159566;
	Wed, 24 Apr 2024 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q4Zf0lrK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA893158DC9;
	Wed, 24 Apr 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952837; cv=none; b=mDlF9DNNMufvqfn+uK8u4Z2fZ6xb9crofZe9BPbaDnPMnH6OiJ3srbixrZnAIxvNq7igGQ1AwvAePIq9bWjeKDD9cIlnbvpbQ3mu/wRcyE5BoliCATOKCYgsRLWLQs0wqjpo9yHZfXZQ0FEhgvcUTiakmFCardCFWr9swqoH7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952837; c=relaxed/simple;
	bh=R5WVkYvVKBubh/Xkg9FSD0bHakUX4sVUce8nhIJGf38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7/ArakThYDzw7uBcdBhTFrG7aZbNlcG+WX0AbQXDT+gR5oNHIhZpwu/SjkURKIu1OHdPl4S99Wa0bqhW6Ucq3SAKCV1ru51+yfX85fuxkCZgsqdQoK1N1LRhXeEEJqStqifbTW9e10fwWH9SiJE8V9TwDvjr0YryoHpVqJL3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q4Zf0lrK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713952834;
	bh=R5WVkYvVKBubh/Xkg9FSD0bHakUX4sVUce8nhIJGf38=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q4Zf0lrKCA7W8EN2N7sw+LSgsWV+fEjN5FjnUoUlr5Bm2oZK5zbA1dyLrS28gOzhH
	 03d29FMJF3sJj88C82lOEb/Tg87p5CWzza8UfVArg0QwtxMDoeqayLgfpYaYFXqoUv
	 G44oIoNTbAfmBWQ/zp9wKTncSHbmAH7GQT+6D9aO+cAvluJ7mTXc9Ni9ZdGoV7zb26
	 oHKtFijfTPBZvypdJbX09+QjDBZ5pJENZzV86G0UjdaR+yFTDBczB8xMu+IDVDmqGM
	 qPFu2/qirSDIfZYgDpW9b9GudYTcSzDdjr89RE7xhHNPtCHu/lH6yHFDyOVis9Xf/v
	 SEK/ldElGYuzg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B4E937820F9;
	Wed, 24 Apr 2024 10:00:33 +0000 (UTC)
Message-ID: <186a2208-c2b0-4a57-9a2d-53a651ccd408@collabora.com>
Date: Wed, 24 Apr 2024 12:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] remoteproc: mediatek: Support setting DRAM and IPI
 shared buffer sizes
To: Olivia Wen <olivia.wen@mediatek.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Tinghan Shen <tinghan.shen@mediatek.com>,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 jason-ch.chen@mediatek.com, yaya.chang@mediatek.com, teddy.chen@mediatek.com
References: <20240424030351.5294-1-olivia.wen@mediatek.com>
 <20240424030351.5294-4-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240424030351.5294-4-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/04/24 05:03, Olivia Wen ha scritto:
> The SCP on different chips will require different DRAM sizes and IPI
> shared buffer sizes based on varying requirements.
> 
> Signed-off-by: Olivia Wen <olivia.wen@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



