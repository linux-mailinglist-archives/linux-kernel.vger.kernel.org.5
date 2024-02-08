Return-Path: <linux-kernel+bounces-57493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360EE84D9C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA85DB20D23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C367C76;
	Thu,  8 Feb 2024 06:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Ln/L/3GZ"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4288A67C6D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372559; cv=none; b=Tv+5VoA9qtjOYQ4Mygg6kRIe9hqeB1172lQ/aHaWndI135y1LJViVm9j9PQA4KYZZy8sEdNpGPG8i5kZmxOLQEgzihDXTX3ZqGrAHLgZ/rZjcgdwV8EWGjVjvMQyaY+k0lnuYb86+cg3NY6VCM0VhJjDyfiCtkm3RDul9/hdVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372559; c=relaxed/simple;
	bh=0WaGRdQieP8qPB7+5tY1vVKpStuQmtRJ+UA4eW449ew=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=U8PamgCdCMBh8fCLGQfGOdYyoBVrGBFq7TSlRZgB+iskqFAmNKrBUtbp7nbBLIoSZG6Pad5c1PzEm6f99HKsduJgWrjWTyBjw/lDkWlX7Gp8Sh/cbSuwDK1LHYVFj8qyOH/dn7Q9FsiqAFYeMq9ad0D1iQdsHqbmCXizpnctCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Ln/L/3GZ; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JyvnIF9FYHi9SWlvwYfcXiPQ2MgiofrtBswlBFpdQy0=; b=Ln/L/3GZFT3b5QIfIG7FewI8Ip
	L6Aplddp7+AqDOjJTZ3Zl8xcW8PjdAwfCl+imm79u09jvOU5mxBzOAL5uh7iiFiQ5hAEtQjIFXR1y
	1ac926SNe4EZ/6wW5LTUwJ+EZLzPLbli2BAJk8Paz79pfnJP3ibmf6xRhyjFECGtkumNgDxBIyekx
	WQSh21EAIL4/umaTNG4yTqeHhedxrMqXYbZkJ4FD4TCpsdJZGDSD8x+SwQX/6kF0CIWZpAQtrqzgJ
	fii5zlY06wz0NRPhQ+GfYlmulOO/RXRfxjFQDKtCNdJHq77vC4AekASVwMfJgGF/YV8sfbJvskKm7
	2a3O9F+w==;
Received: from [2a02:fe1:7001:f100:ed4f:49c3:4264:fc12] (port=57001)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rXxb0-000AH2-9a
	for linux-kernel@vger.kernel.org;
	Thu, 08 Feb 2024 07:09:14 +0100
Message-ID: <88f10ec3-0cfc-40db-99f4-06916c0ac7d0@cu-phil.org>
Date: Thu, 8 Feb 2024 07:09:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X Referance Concept (Was Fair Source Philosophy, Low Jitter
 Configuration)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I found a common concept for both russian script and italic, Geo (The 
Grand The Good). This also factions the popular "God", which is 
desirable aswell.

This is max Fair Source Philosophy, keeps what is of it, of established 
religion in both russia and the west, compatible with the east.

Mistranslation of Allah is also now Ale on the Ban Bukhari channel.
I grew up with Ale, and anyone recognizing this, will probably recognize 
the humour aswell. (Only possible in a "christian" society).

https://www.youtube.com/channel/UCR6KAPt98kGaXbfa7enQ_KA

This was the result of "Al Ghazali" "finalizing interpretation" for the 
related sects. (The Kuran was already finalized, so this is nonsense 
aswell).

- Did you know Git seems to be based on St. Bit aswell?

https://www.youtube.com/channel/UCS62KrskrKNLLtryqB6F-nw

Serenity.
Ywe.


