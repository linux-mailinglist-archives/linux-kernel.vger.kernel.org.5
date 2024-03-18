Return-Path: <linux-kernel+bounces-105990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96687E72E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CEBF1F21B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A13BBFA;
	Mon, 18 Mar 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lMvnkFqS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C033BB4F;
	Mon, 18 Mar 2024 10:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757229; cv=none; b=Oo5PUyblfvjOQjRVdYpFbZRM4FJuFdGHw6lx7HoexJBbitaDZy1hLaAM+Me5U9yuIsbFfa9VOlNt7Rae7OcXoqQrYPJYQfqE4vH65wbWSOURy77mcIRGP8zRx20H1Ggb8FW1UI9+bpgGEJjZwNnz+nhm6TQsq4Mlbvpxs/mySTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757229; c=relaxed/simple;
	bh=x//SFnXAA+iv08g59F+aAIxM0D0meKGYLNErlalqk2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIFGl7m7fC+d8p3oFvUfwon/qX0GGh+zsQqERrNGJfdVAtoc8qhW8rS0jT8eqkULH4tXoQS8M0f0IsaqgH6NCLA4Lwqmjo8u4bmHYI5l+NYFwhItl6kx1I8whvfdq3gcepKrmdLwMjvspv9/ykj1lwUxH48zbI4KLHdsTjZkY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lMvnkFqS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757226;
	bh=x//SFnXAA+iv08g59F+aAIxM0D0meKGYLNErlalqk2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lMvnkFqSztXnsc1kXJpvrP4snV8yFbiQYtvV4TkRVND7yUYL2dudYjxWw9FjOH7An
	 NGRNWepI+GrrYn/nSbOEZWE4ncWsaWLc+Y4euK3nh7fM1UeptdK1zrfcW8w4NrbSQz
	 n+bPwE/lchiQsMPZsRDlpJluwSTligecMFC+n8bdKXcGThsEO3hCYIMQ3u0WfXNmyo
	 aY4LTYBs/8taExAHwdsXHVYS6gsM8lFiyH56C9bUt7beX3Qrtx1g4bK5KeJFUra7Dj
	 IE546Pd4nQHEoS4A3vfZPQO+qCIAQ5f9kb4Nr8DNFQdC/O3el5h1UcVi2L6bG6+epq
	 3LY6TOnZjTBuQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BF43F378107C;
	Mon, 18 Mar 2024 10:20:25 +0000 (UTC)
Message-ID: <ee50ba70-8393-42be-a82d-f4f6094a43bf@collabora.com>
Date: Mon, 18 Mar 2024 11:20:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] mips: dts: ralink: mt7621: move pinctrl and sort
 its children
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-9-justin.swartz@risingedge.co.za>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240316045442.31469-9-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/03/24 05:54, Justin Swartz ha scritto:
> Move the pinctrl node prior to the nodes that feature unit
> addresses.
> 
> Sort pinctrl's child nodes into alphabetical order.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



