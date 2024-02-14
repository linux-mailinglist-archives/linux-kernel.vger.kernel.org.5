Return-Path: <linux-kernel+bounces-64779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA81C8542B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF5CB216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AD510A2A;
	Wed, 14 Feb 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="uRc4wKR3"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC0610958
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891600; cv=none; b=taeMYzjvkFLTO/u/jaIHp8oDAb1eyFLvCY2elifWwzY5Na64xYqdFtu3xy0Gzh2nSpKAMueCjNoBMGZvTlVhN+aZ5bhkAxbliv00mDWKMksTHS8L3IvnasdJPpbW8Z7A8dfy5lBGYY7Wxm5RdzXW6wljF7Ty6bKiWON6nfmYpU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891600; c=relaxed/simple;
	bh=O6E6Xl0L1lQSlw9jYy011uAAqNPlGJ2DlHYm7FQ52uQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Gab7jI6JwsXjXmR75ENhWbZ7AKDcHMJMPQrwabr+mzkXABFlBayBqEHstVC4oQVMoful+vDR4nqWbbiDHPUccUOGWy8P2QXmS/axHoz4s4/Mqb7EZQiNhAciuMrpXLR4pRFE71SCtFBlIaxY3fQEooxzd9qoltnv1EDcob9SRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=uRc4wKR3; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6jT4jFDIrZwBb73C2U3JFIU0+blghCQzXHfSb2L1YjU=; b=uRc4wKR3ok8C3LYUFQwgcLr3o8
	dvZ5b0xPjygBqW9RuUzDksV7x0r+VDch3uoKl02/2bIVkbCMA4/4qntZZFdDC6aUJTOTWYXUzL2GG
	LYq1wJgSFziKIt03yDpdWzgzgQ7T4gJ9UNJoIvndHx9M/jaSaGKfkgrYzeYawOIn7H+TsaiYgP/k4
	BhgcXJg6dgJ0joiPhuhvezfI8XQPfGpy7OjrscuUXxJYGnv0dE7fy0MeQHSfJYo3MdZ19M/ciRJtx
	LRnX9qFzQog1P/U4mN8b4BUe1AQa1GoYxtJfgAczG/9EOQ5V3Z5SGwUU/SsaEi3HCZYTSiQ2uQ6Fr
	qWCVJ4rw==;
Received: from [2a02:fe1:7001:f100:5fc:6946:e928:a7cd] (port=61669)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1ra8ce-001EJV-Jf
	for linux-kernel@vger.kernel.org;
	Wed, 14 Feb 2024 07:19:56 +0100
Message-ID: <e44b5512-3fc6-4fb0-b3da-bca34bde5ed9@cu-phil.org>
Date: Wed, 14 Feb 2024 07:19:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: X S (Was @ X, Fair Source Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

More developments on the philosophy side.

It can simply be named X S, X being the part remaining of unix, unix 
derivatives, linux and fair source, denoting Network. S System.

And the concept used for translation of The Quran (for Fair Souce 
background), is Am now.

Hail Am, The Grand, The Good.

-





