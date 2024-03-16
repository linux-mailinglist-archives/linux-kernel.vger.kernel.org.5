Return-Path: <linux-kernel+bounces-105026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB50D87D7CA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0FE1F226AC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628C1847;
	Sat, 16 Mar 2024 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b="oMV6JViM"
Received: from outgoing6.flk.host-h.net (outgoing6.flk.host-h.net [188.40.0.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343563C7;
	Sat, 16 Mar 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.0.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710551750; cv=none; b=cWy5I4zP0SmawsVZbePmY8HzlTi+k7YndjsUcouS9pIDNeZY80Q2Tn1FdtSXOljG/pk0ztx6ld3FR0NqJAiifGlwP3AYB7bgF983OR8e15cgwRruNwZTeDdEmZKpL+/j9R5cwaQqpa6uLw9JoEgjW1CpjQRRO/tgoTEh2AROJOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710551750; c=relaxed/simple;
	bh=z6MoTcp+Us2LNCmXauSH6zP1k7mgFwFrdvZIkl9eXhU=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Pb6vh2/SKJvFyZSr0FoUPuqc8uxDigPUjIHgaU5wRW6FFkBcFgAYZ5bhDgmKqLVAK+3ZtSuA2WgQswIcoFejdhBDhFweTZ7dhr/ftyhWa7lxQnL5gXnWm0f6eg3P8LX+0tlm/IC4nAa/sXDXv/FdM0UyIaYM/M/Wv5C8wn039Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za; spf=pass smtp.mailfrom=risingedge.co.za; dkim=pass (2048-bit key) header.d=risingedge.co.za header.i=@risingedge.co.za header.b=oMV6JViM; arc=none smtp.client-ip=188.40.0.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=risingedge.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=risingedge.co.za
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=risingedge.co.za; s=xneelo; h=Message-ID:References:In-Reply-To:Subject:Cc:
	To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:reply-to:
	sender:bcc; bh=MX6jkiVUp4pmiMnqNAYESEmxzkbjgUGsT0t3EwwIUvY=; b=oMV6JViMO73NXv
	JL90xOJZpSs8aj4O60Iiqwh4l8719SBHzLJnfSUzVxW5e0znxJPIgQPmNgttXfvzgF+FXgonQIFue
	WcR4LSyQ6o8jUPjNBDIZAAai4jwO5+rvzsORduF/3H5lNIBKHleUzuBxrBeoDCoJ0tBa6WlmuI69M
	OvOcu4vv/ClGRBPXkGaLN/Vxvbs1udsioNXTeEKJjAv/8rnC6Sw4vYLbby3fyL6lYyDslbSX1Ea4w
	eovqjB6iS1VBsqru50GTmTM9ZUeD5rowfaaRRlG0jmxbab8rAJpDIBCgbT7EmawuQjPOAqG0LNx6a
	ybU6dU3gbi1caa6t7m8w==;
Received: from www31.flk1.host-h.net ([188.40.1.173])
	by antispam2-flk1.host-h.net with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlIeD-00Dbhe-8i; Sat, 16 Mar 2024 03:15:42 +0200
Received: from roundcubeweb1.flk1.host-h.net ([138.201.244.33] helo=webmail9.konsoleh.co.za)
	by www31.flk1.host-h.net with esmtpa (Exim 4.92)
	(envelope-from <justin.swartz@risingedge.co.za>)
	id 1rlIeC-0004UJ-N5; Sat, 16 Mar 2024 03:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 16 Mar 2024 03:15:40 +0200
From: Justin Swartz <justin.swartz@risingedge.co.za>
To: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mt7621: allow GPIO chip select lines
In-Reply-To: <81c2c997-52f8-48a6-ace5-1bf503462f25@sirena.org.uk>
References: <20240316005917.20526-1-justin.swartz@risingedge.co.za>
 <182aa3a1fcd05a2e25b55442f58ced5b@risingedge.co.za>
 <81c2c997-52f8-48a6-ace5-1bf503462f25@sirena.org.uk>
Message-ID: <92944d93690f8dbd1ad1008e5ceda854@risingedge.co.za>
X-Sender: justin.swartz@risingedge.co.za
User-Agent: Roundcube Webmail/1.3.17
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT8pt9o77kKUASdyj4YHcnP4PUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5wCPRB8bAzJcv2cv+UqiTTc2+CpNcmBnO4XM3Sck4bwNogU
 WCl1nkLBzZX0KuJ9bXiS85Z42w/+2OBolTNFbPomXFWCX8oNdggW7HE9XDTdSejrkEpbuUvwMvHx
 3T+KSG//gbuP7hnUK8NQdLwsVWKIss2oH4Yjh6Q4paNNh70vrmKlRYN8+ZW0XX0AH/7tz8lOUWMR
 3Oz/N19DDfqg//ykQCB4rUl3suKct8rEwEjtlBjGf82vsPPH4Z6bBeyJ2ioKLll7c1zqbZ0Shnfk
 f76m6WzjgyOQ30CX3jGye0AgO43dPg2t4siixN3H6ipUQps3xP/3XyJyMBxDHFVRLVjhWmuNA8WT
 ybi1JN85FSnfKaZl5e9CnNR0t//S8nh6vX9JR7tTkgtGxbJXMnaWeORi/IOL8hFK8UwSRsjj826v
 xIvoo9siXVea4yN8+JzC4p2qtoJeAaAIM5zNlwLSz7WsotxMDYRAzuCR0I/uZN17IfdXFZsEUcDk
 8TfE1VxuxGc2M4JzCc//R6Wyn0xEa4/gbKRUuwP9TxU53J++//mag2wVXO50BuTihrUiUr+Ne0YD
 3ddZG295JphtZpms9X0aBNANCxNWMmHXUTEMGGbKThOghFKJuzFdJ78lk25pCKnYrhUnk1aI/tYo
 PYfrgLItviC2z3vIzjh1mXBwO7cA3LYE//971/IPrjStHq+sLtv6f48W6vJ1YXzwg/yHdBoe6D9l
 C5HcnR5sMHCtNqaTmXQ4BkBE3IhMX1f/+suluw5k87r8vepAOoS2eUqUWS3rIOs6OFebJBWcGqKs
 Jc1xjt6Txl9yx/3BhqO3m5yd2tj74O4hBSz/kkmPgL+fgIguflsMx6vatUpjecZPSp26CgsDSXR1
 fPypOcxCjKydCyzGsjrtOLqk4YX4CyQ85xnc4q/WKvSWBPzknbkTJiNN9rwBJkpKiGGp8ai4iv7H
 Q04RFZ4oobg8BBg3Jq+ntzj0FowsI0DXck/yx+ZVYiqsOvAPPsA1Nn6T/CCq0ZTp7nGtmEMS1aoV
 PcFuJe5x+tG/EkefTeqmRpyDccXu5OsjwFFfEoXm0/FPF8PR0w363llwyMFXKarlqLFqhfrB0GFR
 NCI72pnwdS+UMZgGNjw2gmyaDtrWPzIOQpV3d9KAZvFEy4yZs8FnQMzvojpIo6wEKULl9qYjJqeC
 CacQRjWWfmKrLjRFuOfsv9pIlKVsvXNK4117w0+Iu7iq/3ilwajFT6Qh9VybPYnXpWlnmHX0yg==
X-Report-Abuse-To: spam@antispamquarantine.host-h.net

On 2024-03-16 03:11, Mark Brown wrote:
> On Sat, Mar 16, 2024 at 03:01:02AM +0200, Justin Swartz wrote:
> 
>> Please ignore this patch. It was accidentally sent without
>> "v2" nor --in-reply-to=...
> 
> The --in-reply-to should be avoided:
> 
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep 
> track
> of what current patches are, both for the new patches and the old ones.

Thanks, I'll do that next time - already sent v2 in the wrong manner.

