Return-Path: <linux-kernel+bounces-153159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F98ACA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A334281CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5B13E40D;
	Mon, 22 Apr 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iSHRSSuN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C221653814;
	Mon, 22 Apr 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781190; cv=none; b=RhXqzbvrsDzj6aBBWfd1hh618xAOps7kUI94PiLW4O/T7FoYochsgqr+2rM0grXcFDqn/3O83hhrYNn5ojVeBIr4Qgv1MyQuuk2lTQPer2wIxwJTsRWPtY9w14fayMo34nHTZdTKpZeamhJp0WvHnPdRAJbygJ6v+j3vWSrPyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781190; c=relaxed/simple;
	bh=2be7ddOYKWR8xs1YeIaNBfdWx9fkiLTHGB9jAzYsguI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPOoSjraSpOXQTKnZYrUsmyzpLJAMQ+fr9VLVL7yFaRUK+CRDHzYf/svoPbknUh+Hsp4SNYNzlPHCnPCrcdvpwoWnk0SUI7UawzD9me+5dlcSPFwuf31mzeAXjZWuRuvKUSJpPhXGHsFA/qXD70e5qWKa/bm6wlPy/n+aa3tFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iSHRSSuN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713781186;
	bh=2be7ddOYKWR8xs1YeIaNBfdWx9fkiLTHGB9jAzYsguI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iSHRSSuNm4NDYQp300eygwILxcfazcpyBUpeCh3Szo641XH9kz2+9gSrY/wqEfNdY
	 e9D3F9j+J99thS5c58zJEqGm48rJeKqOFMVacHqbEW9yRZsa1TOVHrwSUKj+OGexWv
	 DFtDrxmsI/QFDPO5ru7SX4g/0Nk3YthxnA+GCvZbdfqg5q/y69qqbzrRovOd9kFaec
	 +uhdAz9De7DNltnyLgJYJgh0Y/6WT5Sr3kcj4ASnx31+VPNxseWgZthgIRbmV+FJDn
	 qo5X4PRwJ0QxtxcWFzZeTjt6MgAKt0kjSEYfeLIuOZFMXZpD4w2f7795fD9pNqXjSy
	 6/o6Tbqs0RZWA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEB4337813C0;
	Mon, 22 Apr 2024 10:19:45 +0000 (UTC)
Message-ID: <8de67c04-6f5c-4c0c-9162-e5c4dfdc7374@collabora.com>
Date: Mon, 22 Apr 2024 12:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
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
References: <20240419084211.31901-1-olivia.wen@mediatek.com>
 <20240419084211.31901-2-olivia.wen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id4
Fcc: imap://kholk11@mail.collabora.com/Sent
In-Reply-To: <20240419084211.31901-2-olivia.wen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/04/24 10:42, Olivia Wen ha scritto:
> From: "olivia.wen" <olivia.wen@mediatek.com>
> 
> Under different applications, the MT8188 SCP can be used as single-core
> or dual-core.
> 
> Signed-off-by: olivia.wen <olivia.wen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



