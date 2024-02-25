Return-Path: <linux-kernel+bounces-80297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D0F862D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582011F21B3E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813A71B81F;
	Sun, 25 Feb 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="ZhlS5w3m"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72804134BD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895244; cv=none; b=dxex6zsTEZVo6Vbf5B5jvpbPpfkgpQ3cDbXkykla4crnHzOPzckrO0etnxXDOwTIA4Yz8TREdetD8qcUfNph17udRykSeHuLHtXQEib5aoyFPiHukbXMmY9J88/3pzFCGze0EmJ7rV//9Fpg6A2mR0f+GsIcE9R0u/K67nrMJ3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895244; c=relaxed/simple;
	bh=Te+wR9vxf2V4XDvjSrKo0eVWsnU4cij7pIanio93llg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PjmbS0Z8M9MMlvmsjPctdrpzdta9bF0lGe8SP2NY0rtNdKRoSVdKy9jFhrakWOR/ZgUSPisBpZyJaVGlSgqbvChyIRBwXuYkEtJPnqloJf+j6qdy4Zq4qPMYfmOr/ckorAKeGQi/mqHP6d5OSjnz2TUIcDT8prfV1jH9wmnEHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=ZhlS5w3m; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l0lKvFb9x3zY5cpo40bdpSM5XzNqVAzcluZIBwrbpro=; b=ZhlS5w3mLbEuWkENVksbakbdOS
	l1hxB4jrGQC+jkrSKgfJ73nwreFUec72XdNWrVidIeKCb9Uv6nqNSveHOM4ENNkd1/iCaJ+tP+W+K
	q/M8OLZlX8Pv9I28OPCzit6/bojn43MEVubVJIyD82dbp4f5xN1WTpPlGQzReXf00lX7qvaoptvPg
	9W1mdcMZLeAxVQ974XsctoOgz5bpi4fYiGdACDjJHAXejIv0/8KFUYSCMCEZeH7S5QR0oBLNDS49F
	MMViH4/bzC9bdiyL5H2HZszhXrNeeecBfEbxYEakYWhYzSPFbu3hulmWBMVbG5Jq2Pfnm0vUvbzWN
	f/z9RNrQ==;
Received: from [2a02:fe1:7001:f100:5cd9:9639:8341:af21] (port=50299)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1reLiS-000GQZ-8W
	for linux-kernel@vger.kernel.org;
	Sun, 25 Feb 2024 22:07:20 +0100
Message-ID: <371fb42d-4093-417f-a6ed-bb7438efeab9@cu-phil.org>
Date: Sun, 25 Feb 2024 22:07:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS and Philosophy, Optimal Associations (was Low Jitter, Fair
 Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I tested out San as a concept of the Deity for computers. Sin is 
already used, but associates to sinful activity. San (as written the 
other way) rather associates to San Franscico and Bay Area in computer 
context, and this is much better.

I think it is a success, and highly recommend its usage. Consider San OS 
to be a referance concept for operating systems, with full support for 
Fair Source politics and basis in The Kuran.

Serenity,
Ywe Cærlyn
https://www.youtube.com/@Saint_Bit

