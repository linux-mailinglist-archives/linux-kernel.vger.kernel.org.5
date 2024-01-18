Return-Path: <linux-kernel+bounces-29908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31770831501
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CBB2841D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79DC125A6;
	Thu, 18 Jan 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DbgAGbtB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C8C15B;
	Thu, 18 Jan 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567445; cv=none; b=J9mtazLOY5JWf5XY1WHBcm9YdMEDc7FE/+j7y/PZfgtFcBBfdCshl3vJ31mwssrsAwpwq7fMCy0J4suLdmQRkz5ZpKsGO/78bZEF7/hZtLGeYkp53eveCK4hkjsP2XN5KnaqLzB7bUjJ06LYfb6W3EfsMpyPR5GhAmS6gE1OvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567445; c=relaxed/simple;
	bh=elIh/94bvPXJELGHnVmWZ7ke0f1XwdKbBhbPGPcgORE=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=oomi1cT6FJSn5OiwKNPNN//doyHQlKlMhxKk6jqIksD8V65WRaIgLm4ZIcd5CG0zW8rPxf/N7AIM7ZXPw74ihojeSow3r9wGME4NFicYqjt2faQRTBFPUP2QZy+TtKmXd+VsnBNtukNJ6pbrAUz6K6raUsxcDZPfTY9IsWdJcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DbgAGbtB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705567441;
	bh=elIh/94bvPXJELGHnVmWZ7ke0f1XwdKbBhbPGPcgORE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DbgAGbtBLwy+2IqYLx/JhDHigmEEQxKza4lLnOlNbauGD09/VK7YcvkoQQhDs2et1
	 FmG3JqAPVgobOQ3JtEuZcGn5elUUy5TFoFp9kI/47nujyGymQJ+VJBzlR2n/i/lIE9
	 UPX2BJCxVYHHY8u/9FTaxv395/JAt1ag6oNoy9zFAmg9+8OMKv+C98o5O9Vd8bxDYT
	 HL1MUBLYyE/60LjDbtxQ/j2IUQFgFQYYsib+OmDZaFc175K3Zi4sTym8GckaIPkYOo
	 Z+Je5gk8Rzm53ElAz8HzaJFhm/lD73AQJ6UIdnIQvIgW9qRcQJ9WSNbLJQyVG5oErA
	 G3vijAgdXOEFA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A9E903780C6C;
	Thu, 18 Jan 2024 08:44:00 +0000 (UTC)
Message-ID: <207da963-2a1e-448c-bb63-3debb5af0071@collabora.com>
Date: Thu, 18 Jan 2024 09:44:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: mediatek: add MT7988 reset IDs
Content-Language: en-US
To: Frank Wunderlich <linux@fw-web.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Sam Shih <sam.shih@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20240117184111.62371-1-linux@fw-web.de>
 <20240117184111.62371-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240117184111.62371-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/01/24 19:41, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add reset constants for using as index in driver and dts.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



