Return-Path: <linux-kernel+bounces-59806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3D184FBEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA81B1C2381C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F384D57871;
	Fri,  9 Feb 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Rd8fuOGV"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC253398
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503794; cv=none; b=Mdng62njhWwt0+bIlYw+6SanrOeYA057kN9ChIPjAHVQSniSx/RN/mBI4YujBHIxfKXc7xqnxjkO/Z/SezPiRbQiQYprBKBLw7izw2usYrTL/XtvB8Gi97aquYeoccfvsiIhffg+kPPuTSEpax5ohHPET7zrBPrEkZmL+bUT2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503794; c=relaxed/simple;
	bh=t8bOJjsrTV3c53vuDIoRTflTs14aE2ecfe21agJBgU0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KUqs/0iwr664pbTfTB7YuuCcErY9USkEcyud4E5k8iM20WUfgxn8igc5I4fNMePMUtkTxkI38dC/vB/ps8MZK7xBqjXTWDg3AoqfP8xGrtfgY41KpovbXA3elGEu+gTBwTDmayJ1pILRsC8iai35iBAjVORNsiNlStj/OLTGV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Rd8fuOGV; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Aaii0bJOwhbKEDsa1KMfKQswrv/MVfTUj+VK8a614Zg=; b=Rd8fuOGVIjpWAYPGcnsUamUhLv
	KrMofb/Tvt8FtWday7OJ0xcJO4ZDo9wI7QzmDc6qv8mud7ZBB3PQBvjMaf5wbdn4mWh9r6+eA42WS
	w4DgqFI45C9rkhYbtUrnIHCSmve0pRx8Aol4S1XkX25TZKu59uV2/t+qNFhEEGW5hQe1tVoNLTh9M
	+2JUt5pWUB85DSFGCiPwbaEsLMszD4/vDmxJnJMO3MTF7+w5FSbSmM2OP2p1BT3bWPop451XD17Ww
	gaN4XwMFXhKY76dvLey0a+dzKvNtMI3LxuImB4Z6M1JBNuiTBFDnHM8leKwppeLQWcR0OFlOdyYR9
	CHRwlF4w==;
Received: from [2a02:fe1:7001:f100:912f:d243:885:7dd5] (port=60387)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rYVjh-00By7R-Sl
	for linux-kernel@vger.kernel.org;
	Fri, 09 Feb 2024 19:36:29 +0100
Message-ID: <19d3f6cb-7ffe-43cc-a6e8-cf9aeafe6bce@cu-phil.org>
Date: Fri, 9 Feb 2024 19:36:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X, Fair Source Philosophy (Was Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ok, I just went ahead and translated all the quranic initals. This all 
for italic script.

Translated Quranic Initials and Prayer examples:
Ylif Lam Mim Or    		YJp9	
Gu Hu Yoi Ein Cid		2oSHC	
Udu Hu Cin Heh 			tOF<	
Ku Nun				TU	

English:
For Cin, The Grand, The Good
Hail Cin, Don Of The Cosmos, The Grand, The Good
Guard of The Day of Doom
You only we worship, and You only we ask for help
Guide us in the right path,
The path of those you have favoured, not of those,
who have earned your wrath, and not of those who have strayed.

Norwegian:
For Udu, Den Gjeve, Den Gode
Pris Udu, Herre Over Cosmos, Den Gjeve, Den Gode
Vokter av Dommedag
Deg kun tilber vi, og deg kun spør vi om hjelp
Led oss på den rette vei,
Veien til de som du har velsignet, ikke til de,
som har fortjent din vrede, og ikke til de avsporede.

Etc.

This supports a comprehensive translation effort, for fair source 
politics in all countries.

PEACE.
Ywe.



