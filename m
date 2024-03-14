Return-Path: <linux-kernel+bounces-102964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604587B928
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E31D284B40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9E5D732;
	Thu, 14 Mar 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="ysnGHONb"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6522A1D1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404174; cv=none; b=utB2jM9Pi73beE4VZ6MzMWIBS4lO5Jf616RW+hhxv7CR5ZHSqrPeJiIH6Ix4jmrmuUEmbls29I5LZoWkc226as/+TGFGzKvsPNXKoTx3W9qwdpQJp3GiPI5WaCGGjY64poLBvI1a284dRu5pZjAZEfuwKqL2hkj1fZyZXKpIwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404174; c=relaxed/simple;
	bh=xxpMvnncS0Ks0LeoSm5+ZS7zvmLjm246cyMzrZzKwGc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=A+sQGcAh3uMBv25wtt8u83tAtd9qYlJpcs6tYOK3Ia5xqbRuXisJgk9YTrgzgMjnnRQZPxOGNsySuKWtXq69NaQgi5PPL2PTqcu+gNXpJ+N1lFvcMkPg+wVgbX+oE+8/m1Gt3xgm6evS3gkEJgS5T1bdOfmTbLVogzE9Q+8I8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=ysnGHONb; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wtb//Zl7OgBR2nXJDl9XNqOUIg7zUWgJbFFDodAKpe8=; b=ysnGHONb/zPL3xIZPbZ1n4UkN7
	lm+1hC0a7f2mBkKpjmuNydde0ifmEXcjUakXddOmdi9nMafCTiIcaqnYANlqY8Z0SV7ggSC6gSQ8p
	5jcqfDcs3esmeNlPbIgarCjJEd6njWGMTBDw7shvmeaXSb3CnL5riIcXs0pVXSOGuAmrXYvskAnCl
	nik6wZMiqcdSLIBoo0BGBvRBfP6uSpVuKGVUi/tlHvweDH58qHApGw9RHF99F3mv7DrkEdDM0Tf0p
	1zjKCVh2l20qB11aS3URROvlcCYVmUTtdPd6znyxuqju2bvqPbdEax8WRBqIkRg+Qdl4AalswqlTs
	tMWI8V5g==;
Received: from [2a02:fe1:7001:f100:a896:4c0f:6dfd:2834] (port=64000)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rkgFw-00F7Lo-Ky
	for linux-kernel@vger.kernel.org;
	Thu, 14 Mar 2024 09:16:04 +0100
Message-ID: <bfaf3044-adf7-4619-b3b2-909b22bc9f79@cu-phil.org>
Date: Thu, 14 Mar 2024 09:16:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Experimental AI Correlation for Psychiatry (A followup to We X, Fair
 Stream Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have done most of the work with fair stream philosophy now. I will 
look over the development of it.

I have a follow up coming if you are interested:

- Experimental AI Correlation for Psychiatry

AI's best use is for symbol correlation or Archetype correlation 
grouping similar symbols, into "archetypes", and distinguishable 
features. This way one can read scizophrenic symbol communication, and 
even include the arabic ALLA into this, getting the divine opinion.

This may be a next big thing in psychiatry, and will do all the work of 
subconscious symbol analysis automatically.

For an example, see https://www.youtube.com/@Nehchen

Concept released in the best Fair Source spirit.

Serenity,
Ywe Cærlyn.





