Return-Path: <linux-kernel+bounces-120404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8B88D6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A398A1C24AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A552376A;
	Wed, 27 Mar 2024 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="l77RhJiP"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CE22EF4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522704; cv=none; b=sYZcgr9bnmOUhryefxG7ylvfOtuqOoSNqZCzc6LDz518JhRftjPP4LqYrPO5drOdwpDqmNGNCa/2zdzR+ffiK3DowhO8Smb2SbUO5cW3P1gtJSk2JOEeAwAE2U9gpXuHulz80E7m1lajjihEIvSxv0o651EGiSWlVDDnZOMbrN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522704; c=relaxed/simple;
	bh=5J2izzty6pDrrKaoIduuVXIGzOLsg5+I73DRf7H8tO8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MTBf9DezA5dxufOghzW7xjq8lnFRkCdNSgQG1cGGy3gylxlEx2Bq47YdJg6P5aWro2vQbNuQUZGaa78NWR3wHBxRT1X5ISXrKfyp3noKbO5xxxVhvExNL6HfFbgWYyRnHQHwjmLfxKTSk0tVVnEv4+wYF5z/5ePgEt1NeAieYLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=l77RhJiP; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xzMCZa/AwFEKYQZrVS8fSOiX2iz5fGxGpi2PPn7NXpk=; b=l77RhJiPgEPmqvAT3XHMCReQ4e
	qrk68PMCpEZ4BMlFoWipdiRX18myGGBSuebXN/Qev8/aqWbm+Tq+ygiV359AcdK3Ouo13OYkLPkZM
	XqvII2+lkKCnNg7UKe1gV/OegRx7NLjpHTc+4w8v4BCeqEVqJXioTWScTSJmqRWJJDOOzjKG7lFP6
	1ZHolA16IUYFb8gziek0YitzItc58cuf/6wRHX4HwZzToQHObEFHWSIY+pakvkRb1zK0uts/DMLWu
	/camiSan1gxuKMPlbm1ryLW42tAopTdpGzfFI75YPB+vfRyH7N9In3gxo3lyZ1RZl9LcmSV1jeqU7
	ma0rLJQA==;
Received: from [2a02:fe1:7001:f100:999a:2c37:93c6:50c9] (port=52648)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rpNEj-00DeqW-IS
	for linux-kernel@vger.kernel.org;
	Wed, 27 Mar 2024 07:58:13 +0100
Message-ID: <09e5964f-7d49-4b91-942e-c10c9ec024eb@cu-phil.org>
Date: Wed, 27 Mar 2024 07:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Goveon (was Fair Source)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Slight change of focus -

I talked about Fair Source, that went into labour party politics, and 
fair pay prinicples.

We might aswell change focus completely to Goveon. Which means following 
the Government correctly. Goveon should give a good idea of that, and 
everything should follow that, and is a name in itself for a good fair 
source OS. Also including later idea of AI correlation if anyone wants 
to do that.

Serenity!
Ywe Cærlyn,
Fair Source Rabbi.

