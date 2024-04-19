Return-Path: <linux-kernel+bounces-151307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9499F8AACA8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5017C282037
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19A67E794;
	Fri, 19 Apr 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="GuuK84x5"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60927D408;
	Fri, 19 Apr 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521820; cv=none; b=F3gDajPEBBVsCNHtgCrPamMNT5dV6i3GIXaPzseGxpJA2bC80pHtwBpljiZLN4uYIAa/NUCbgP92lfj9PgpLNIZTd7RR127YTsdcAtORkdQHcbpcj0Jndcq46wGdmuhrop0WqD94qWKn6sE3xUscduMQWGbG/3tsFu4ylb+gWE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521820; c=relaxed/simple;
	bh=2sK9/hm5MbgYK20ADFonel+AGn+EPUfyWibnS6yXY20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGSc/aHWQ5uTM03xuXbb1UlFgg5GVbU6yAX8roOuHq7oro8J7dKLiWqLM+u0g583yfFntN3ElM8noFSWuMd0MGAj7zSXoU7yAa/RE5EpMNAi2aYbh6jK0Fs1ZMf0sr19IqV9eV8pX5lbar244lmAM5/kqFy0GMSHdFnv4xMrYY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=GuuK84x5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E20E240005;
	Fri, 19 Apr 2024 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713521816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHoB2/u0iQQD7Qs2J3/fAxz53BAIZJT4DssPOxGoyP0=;
	b=GuuK84x5dPkVEXdmw3BGvsscchReg5waiZd4jxUhkBYIlSlt6KBz2Na0Sk/lD1ASxOfn2o
	+5UX5fFj8IR/QSXF129J6es1YrrXomAomSIVUzm3TmTnZVBGigdCJ7gRJtMaH4RDeXSGP8
	j0eVMxZk0bYs/Yj0gnqDLMhjeDwfgbvOLdzFi6HMruHenkydK9AndHX+2WnVim28+VjuyK
	5fqECcwClbMuulgga7VnWQbb2YmJP7uNGtCZYtfAd3s7LVaHZiuyhbEOluKRfU7P43yejZ
	IHaNEZngc507/yi+tdutr7HpBI8sBg1rs0mCoWdK37Lux155PVn8y0I8CHVDgQ==
Message-ID: <8e85298c-aad4-4b05-94bc-f92e339e526c@arinc9.com>
Date: Fri, 19 Apr 2024 13:16:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/13] net: dsa: mt7530: use priv->ds->num_ports
 instead of MT7530_NUM_PORTS
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240419-for-netnext-mt7530-improvements-4-v1-0-6d852ca79b1d@arinc9.com>
 <20240419-for-netnext-mt7530-improvements-4-v1-13-6d852ca79b1d@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240419-for-netnext-mt7530-improvements-4-v1-13-6d852ca79b1d@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 19/04/2024 13:09, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

I forgot to write a patch log for this. I will submit v2 next week.

Arınç

