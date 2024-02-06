Return-Path: <linux-kernel+bounces-54354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED284AE15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3292846D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E096EB7F;
	Tue,  6 Feb 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="YIdXpIMG"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC1173196
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707197373; cv=none; b=e54/3g+FvTd/uxWWBtE3Z8cK/dpUr/srSmY1VSkL4xP6piWPdq3msfWoTQRy6nUoxWkU4NVwTAuGFcjkiVrGM5PL1RBLiRiF5Y8S7LvGcSpbeMqQ+/mrmjHyxwwsS1wPY/B9aTwWMEwcjCN6cs6co9xeuErqPA5BxoayVdJY+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707197373; c=relaxed/simple;
	bh=9w7H8mM+gKuCSfl2yDfhtRNMAC0zyD+hOUbISG35PTg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZyDyfO//StWdIQlkSaJaAsRV1Ymw6KnsTzhKmJyAnovclo0MQOb6UzOwpvkzO6NIM9+vvNa/LzBduUBO8q9meLh4v1pokaomIYrz8xnzREcD82sYT8Gto68/bepmkTxsaK/LPfvp42hcw5prQeAMecWYvG1NiFjRMWVtDNisaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=YIdXpIMG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TwJlZjA3TQQh6F3K72NlxQoK7b3gDgD2gIkb+1/6Jn4=; b=YIdXpIMGCzMhz8iUYMjKVduHYZ
	6e+IECuq0q4Jaux0bo9GW5n8h7yCXcjnvH9+HiehBNLohxqlTmT6f31z2URTrO3HMVkHyK4TU/oKf
	RYVzWLxpdpjw/r8xlnZDszfSiBHZdIZ7mfXMYUXcLRef5a3SIlItwKprZKDHXq5qxqnQWB5pD8RjU
	PDpUMZCQWalSFaGlrmddGl2GpW1ndQgP7vAZJnjU2czeP6v+hWdFQJAsOVqMoGm9W+f8L6rsD4TgI
	BA+FBN1mKoP5O0TLFBGfCJed+YQwoX5NjJGTy4BU9WZ5eN3aozLxYCE3vwMMenY4tt///mAoiX30m
	UMAWJjog==;
Received: from [2a02:fe1:7001:f100:3915:c788:53df:7b7] (port=49729)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rXE1L-003Sx7-Vh
	for linux-kernel@vger.kernel.org;
	Tue, 06 Feb 2024 06:29:24 +0100
Message-ID: <8b2a018f-729c-432e-8e80-f8578aede004@cu-phil.org>
Date: Tue, 6 Feb 2024 06:29:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X Philosophy, some further improvements (was Fair Source, Low
 Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I have done some further improvements to the philosophy background 
of @ X, which can be considered to be a referance concept for a Fair 
Source (mostly post to the general man) system. Also I would like to say 
that I support the development of Rust use in the kernel and system 
generally.

I did separate out the concept of deity used in this alphabet, Ku, for 
italic script (cursive), and Gu (Гу) for russian script (regular).

"Bor" is a much criticised concept, however taking Shaytan out of it, it 
becomes Гу, and Russia has banned Bukhari, stating it is terrorist 
material. And that is the truth aswell.

PEACE.
Ywe Cærlyn.
"St. Bit"
https://www.youtube.com/channel/UCS62KrskrKNLLtryqB6F-nw




