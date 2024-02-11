Return-Path: <linux-kernel+bounces-60721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A48508E2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D0DB22DE8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C55A798;
	Sun, 11 Feb 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Ol1te3wM"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC45A785
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707652372; cv=none; b=hgMqiCfpggM2ykB0KBwXRKQ7VgNkQ/doSpKbHbdqoQihZoOjKeQK5qVDtjD3OU7SW6fKLMBudbgwzGhgjKMy1S1UUOr6sflf4Ewrd9u7x6yi5YM+j8+DoA4MWktxfKjtzQBkUNOXh8vfESGhKi5RUbgYKxlnu6C/EwzizbuED90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707652372; c=relaxed/simple;
	bh=R8+zsPWDeJMuUKfxi7NPv42gWYaB4eqnU3v7qW7APdU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=XYuMeksEwQEE0CWjswL0aEZQRkOTbk1FaJ6XfxDpJTweB9KV0pC+KvKDGEDCJqWTPccfoX4Fe6NOUSmvho6Jy+7AoyIKyDcUcQz6ie5WBTe/Nr1HwX46gGmeWc5gG6iPrubzyTOpSG2Epz5AqLzd134X4eULkZwnGJkMDv6/yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Ol1te3wM; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L5957gIhwRJtf+q6lCJbiq1CJAQnKqYUwCtxH3U+S/Y=; b=Ol1te3wMApkmax3IVkcJpQi9lV
	DC9+Ch8trfXVw1ITkp5e1si723Re7L6hxuwhFabIumSos2bSHw/kP9g/Grcn55gcpq5AUgN/Nf0nn
	L+3o+kFyNV0zS1fgKZw5RcrbiDdrBCDnpbXn6WTvfpf8SW1Lucrx0ubhUkAVRzt6TGB6OwvmiiIIQ
	FJ87t9FlVMuyJt8ovRGFVFC518QUT12arvTwjjRily61LkYVBQd+KLJM2qlz1xEGYMXu1k9Wq5pIO
	lobqo79p67lOSTHbYI1iUYijmthm6FSeaDes4pVdT/NqhdDSyYlmK371T4au621h88qSEfiw4RaUi
	e0swFFew==;
Received: from [2a02:fe1:7001:f100:65c4:d7b0:f03a:d0f6] (port=54557)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rZ8O2-0010Vv-H7
	for linux-kernel@vger.kernel.org;
	Sun, 11 Feb 2024 12:52:42 +0100
Message-ID: <a1c3b68e-b2f5-4dea-85e3-5015184970b6@cu-phil.org>
Date: Sun, 11 Feb 2024 12:52:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X Fair Source Philosophy: Cyr (Was Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Many deities in European related societies and alphabets really are 
about Cyr. So I am using this now. It is a very popular deity also, with 
potential for correctness as in The Kuran.

Prayer then goes: (Italic recommended)

For Cyr, The Grand, The Good
Hail Cyr, Don Of The Cosmos, The Grand, The Good
Guard of The Day of Doom
You only we worship, and You only we ask for help
Guide us in the right path,
The path of those you have favoured, not of those,
who have earned your wrath, and not of those who have strayed.

  -

@ X referance concept describes design aswell, and like MOS once was, 
with modes of operati for typical things.

