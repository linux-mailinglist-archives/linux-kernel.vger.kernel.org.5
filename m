Return-Path: <linux-kernel+bounces-108736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0AC880F58
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7622845E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB83C097;
	Wed, 20 Mar 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="QDQjbN6s"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B323BB55
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929424; cv=none; b=N60ld+zc/PEpS5nM+JNv7H11cWn91AEKR5DQ8NUf4aSvEtiNOzqVFE5Q2GPKfxlPdl51WdL2NOYhHfa9dy2mJmynNk26JS6jo2otlwSbbsQl8IxSVzBO0Fx20VBlNBarkfNOYek/QCa7gOt7dEygVLYdDgRNHS6E3j2PYy89RZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929424; c=relaxed/simple;
	bh=UDVGIGDRTakaHoCWKjlHQaQVWUmJhroAsn1PPdUZW88=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=NepbpYqeme1rm3dcbqzDA0yUlS13+9eCJbFXX53IWaGeCpNiFmHF2T/+20OiwoW94hbQMaa43C+c75Xx1bqqUjmJ39AM1PpjROGYcr/IqrwfM+0szsqFnwRxHxrUnpzB3h/f/Q/J7Bo7+wwOJxgE9gxIn/7KFikja60Lv8XZqUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=QDQjbN6s; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sYMBjV3IJLKlzsPGNAzdyBOPkfsOI4cepRaDdDEGYk8=; b=QDQjbN6sqzcZWnaw+xe6eWOYLs
	Vbp4LzUypWfpnclsP/QlJnbPcDNXF/vBkNkBhnff7BmZhgmkEiwk50zW/OEGhxfi07ZaZ5W36hd5x
	w0alb8MBPvmajSzmsf4QWl8IdJKnGBnh7wbLfOCHp577LEy6TuQyzRzCDohc778z9y3y6NjqZAJqX
	5+SZyG/h6IrgNUTtlDq4xmzmwWFMZ38C3iEkJg59rBacJc89r7UGbIMkFR84PHy6AHVBKjoGvoUxv
	Pf6klPTxTBMzy7D7yrWiWKB8MTVHULbt8uaBOAEgBaq9yU+hc+XaDmyHxMmySHWkCp0rW6PIcBlKl
	I/ulMbuA==;
Received: from [2a02:fe1:7001:f100:d4a5:6ca1:a72b:7c1b] (port=57022)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rmstj-0095pU-2E
	for linux-kernel@vger.kernel.org;
	Wed, 20 Mar 2024 11:10:15 +0100
Message-ID: <2db0d9fb-5925-4397-b249-bca74e496a14@cu-phil.org>
Date: Wed, 20 Mar 2024 11:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Lut Psychiatry and AI Archetype Correlation (A follow up to We X, and
 possible feature)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I have completed the design for Lut Psychiatry and suggestion for 
AI Archetype correlation now also. It is a follow up to We X, and 
possible feature.

You can get an idea at	https://www.youtube.com/@Nehchen

You can actually "talk" to the symbol which already is an optimal 
correlation, and see an example in videos of what AI Archetype 
Correlation will be about.

The latest video is Pac-Huri, which is the biggest idol (Pac Man).

https://youtu.be/V-AONmZURSg

Serenity!

