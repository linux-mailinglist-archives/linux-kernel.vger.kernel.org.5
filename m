Return-Path: <linux-kernel+bounces-71097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F485A094
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D81C21805
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569AD28DC8;
	Mon, 19 Feb 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="r6c/Z9IP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859428DA0;
	Mon, 19 Feb 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337374; cv=none; b=UzGFUssaLeu97NIcycawVUvbwkD+pyMU2/mCa6U7EQL61AcHnbWmM1rR+7p1c+jbDSuXwsjuZSiG4Doda6htacJTRZlCYTzV4CkmhVpCu/YP+vKwiKnP2o3MUOQoCXoR0cI2xPvyeVdjg4c2k1o8R7s0SFFYuj+baSMQQCPVGt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337374; c=relaxed/simple;
	bh=ZzvLHqzbOzNqgDJELQJkkjJLEqLzCR/eZD/cAnNXkH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPeUvRv3/KF+1HOhFXS+58WXcaVJWt+5BKVdgrzlEKICTMRecXm5yTJNixrdR/iMYQ1B+cEoiXgQIQVD8+VJMZTsRV/TnSpAeZfWD4O5+3hKxNXGp81RC55FySNu4Nih1G1pd4D+JSfb7LfO/AIqeaRGraPRXOEkgUxQTWhUnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=r6c/Z9IP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708337371;
	bh=ZzvLHqzbOzNqgDJELQJkkjJLEqLzCR/eZD/cAnNXkH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r6c/Z9IP1/y6EccSA3Cxc1flHaLxKndVJnkO75I1X/sbu1OjORcs0/81F88zlEdAR
	 uRFANdb7fNU3mruOeEnktSB8zXZnr3LWjPggn/r/dYc+E76lTZ9r1x3Qw/MjK7pg51
	 jN+j5N0ndQ2EopJJyeOqO177V7WXfMuHs6Bxgl9wr0anFrtSgVnFkrkErSRgxPMX+x
	 ECaO04ddI0GctmreaQvTrrz5f7cSZIjBBfOGzeVFZDKkJ29j5eeZUqJJ+/vfal4frA
	 v56/CjTyqXXDhi1yp85FWZTC9RmU6Kr5VihvsUui2Rq0SWoue82qn3PHjByHAfs2nk
	 K6Tfrmqxdq48g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 402D13781FD9;
	Mon, 19 Feb 2024 10:09:30 +0000 (UTC)
Message-ID: <3d98486e-f0cd-4930-8e97-4a09f1ad0aa2@collabora.com>
Date: Mon, 19 Feb 2024 11:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ata: convert MediaTek controller to the
 json-schema
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213074747.26151-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213074747.26151-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 08:47, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



