Return-Path: <linux-kernel+bounces-105127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D12A87D96E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18426282247
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34EE125BA;
	Sat, 16 Mar 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="dZgDMy6Y"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E38134BD;
	Sat, 16 Mar 2024 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580877; cv=none; b=vA0kpkYEXJwKjnCY8dqyWzNRs2sKyS9gprkP1IFzrhN5CVFEEVSMGTOPPkIyOQnPQTbKaDKvHYMnEOjPdLXN96adgoq/dg324idJAcdHEjtml7I2yQdftqAbQEpqJQzrgzViX/0ilgNwedrKJC53SLgr5sCn06xbwfgkioXaoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580877; c=relaxed/simple;
	bh=CAL4+BrQQT1n6weI0sQEfLaXkaVls9mCTPngEXvs/yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKPt0EV+6Cqklm673PQqzLuxXP5SGGQKcOg0gNPdD13Hj0J9X+dTkqONkMo0BjvK74I08Aw8GujbUL57oLlXLyXwx/cxYUzQuL/0Z0VNKS8b4mEgTNP4g3Wq/6pK0EtJKGFJLl7RdjUolZRSu3EQi66PXtcPFlPPDqurg9Fk/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=dZgDMy6Y; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D00A120002;
	Sat, 16 Mar 2024 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sLsztMZ8AnZVIz4bQcF9FyUQ2mwfMm1gz36aKSiWLpU=;
	b=dZgDMy6Y0euTQFlpRUqSK+TtXgaTRVBcKf/pfh3FBIWvkncQNqVz/YAGEGLESVyJ9KvsoI
	/xzPopjNm7qJcE1j2/A2ttu60nQpQyXeHWPZnBnf9rIct8a0onLVOJGo1+zA3LxIM6w+WJ
	dgetEfvwrCXyN6WIdSo8mJ5khhS802kq+Y4p+siY98cBsS7g9FRkesTOcCOV7h1wHWALdv
	iUjJoVnk1JV95F6Ww4VTX66h3EU0mcGzHXrvl+PvM+J3+2UoKZHy4E53cug/jLMo8nuuWa
	EaunDnI9Re6RYfaGBaYTCFnE8EOgEhzzreP5/8wjbrOmuQqnl6SztqG4dGNaow==
Message-ID: <e61a4dfd-df2d-41c1-b2b9-80476863213b@arinc9.com>
Date: Sat, 16 Mar 2024 12:20:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] mips: dts: ralink: mt7621: reorder mmc regulator
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-4-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-4-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Reorder the attributes of MMC fixed voltage regulator nodes
> for the sake of compliance with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

