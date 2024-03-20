Return-Path: <linux-kernel+bounces-109181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3228815D0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C2C1F23435
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D161C33;
	Wed, 20 Mar 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="B0ezw9bv"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364A8C04;
	Wed, 20 Mar 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952891; cv=none; b=pSOuiBN6Lb4bZWtfz59hPbTF89dHXfg6ygURNDBqUSSsd2XQVfYMg3+jhP+cwbhSIX+HXG3I1O4LNYPaU6MfKrJzpln32pIciOrtxahEmGCJmpZb/fyS2Ybin2dQb/r4u7aKKqJJuKnMAnrk8Q6lroFjlUnXpET+lycCDP4QTcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952891; c=relaxed/simple;
	bh=4eXyfTSh1hlBtoNTh9K+O9ATcNhGrOxzbsVhV+YOXgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz7JmrXxFTRgt9LBahfK7koxTKrzY2T7an/M37wI4fIv8e2l5pJF+4Xz6Zf9WYEtsvJiIRPlvBi/QcXbPmnlVqJOkpS/Hxg7OWWqGZqaRvnpCGB/NudKmtCFilvy+gUU+LjFKNGAk3yWqBOPdkKBCrbTlcufXkFdQDKYPzS4bTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=B0ezw9bv; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 72FAD40003;
	Wed, 20 Mar 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710952886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SkUI3atsAwC66eCnaxlWEUl9HDE01QJD/p5zESgycU=;
	b=B0ezw9bv16NsZED+hjFQa0hdg5L42aMiRwhE/JjS/cm5AnzWRq7VV6wB6wrhwY27zJaPIh
	kgJuHurSN79pczX1ABqa8EuZ5Rr7yp1dFI39b0bjJIJhBTY3Zrc5RPnUmCtT6Fb61JwerT
	DYIfNN2ZK2P9lKi6cVQs3s15vbfICaRv47YXclIZ/cxDDToDMkZ7cCIMB1dYvAF8ER08yP
	ElKJnwLgqy78sIQVZ/VZyD3c1lzbyGGHiS+iS9Yef69BUH5iT5Y8TBB4298byJ6Mp0b0ry
	5tf3Yi1jB8l8hOMbZG9TXf+0M5X9u74qXZp+dkg9X/Q/yRl51NWOqDS8Ny7X1Q==
Message-ID: <f6f064b8-efb2-4ab0-94f1-468d5d273d6e@arinc9.com>
Date: Wed, 20 Mar 2024 19:41:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] MT7530 DSA subdriver fix VLAN egress and
 handling of all link-local frames
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240314-b4-for-net-mt7530-fix-link-local-vlan-v2-0-7dbcf6429ba0@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 14.03.2024 12:33, Arınç ÜNAL via B4 Relay wrote:
> Hi.
> 
> This patch series fixes the VLAN tag egress procedure for link-local
> frames, and fixes handling of all link-local frames.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
> Changes in v2:
> - Add Fixes: tag to both patches.
> - Link to v1: https://lore.kernel.org/r/20240311-b4-for-net-mt7530-fix-link-local-vlan-v1-0-d67e6cc31af2@arinc9.com
> 
> ---
> Arınç ÜNAL (2):
>        net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports
>        net: dsa: mt7530: fix handling of all link-local frames
> 
>   drivers/net/dsa/mt7530.c | 52 ++++++++++++++++++++++++++++++++++++++++--------
>   drivers/net/dsa/mt7530.h | 22 +++++++++++++++++++-
>   2 files changed, 65 insertions(+), 9 deletions(-)
> ---
> base-commit: d7d75124965aee23e5e4421d78376545cf070b0a
> change-id: 20240208-b4-for-net-mt7530-fix-link-local-vlan-af6e9928ad8d
> 
> Best regards,

Reminder this patch series is waiting to be applied.

Arınç

