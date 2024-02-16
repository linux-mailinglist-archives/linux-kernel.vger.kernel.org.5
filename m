Return-Path: <linux-kernel+bounces-68295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D752E857850
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733D41F27C68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587581B951;
	Fri, 16 Feb 2024 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="rT21pGFH"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66761B949
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074067; cv=none; b=mDEI45MGlJXH4ZilpQqHDPQaJUCYvpq23vfiqz9bSxr0DfT9urR6OFs4ECSqJYLIsydUr+cotlNNwS6pEtbL4mSecfG8/fkirBz/vZHZTlLR3HQIafnODUh0K97NlQ62D3ib8TSx2JphtK8BBHSbmnL1X8tOabv8wQ42iBL9f1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074067; c=relaxed/simple;
	bh=33VWwgJslzzZqowmTOZ5ZkpKvGeTwihR9dbb/Y1sgwk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KvX/FVHlH0u9Nf+GYyRveIiJUwP2Ad1WygzsY3hP0NCl+M99haIFIv5RLhP5El11Q9GeIC4RBKnucsKZKaQETIbnCGGuWeY9bo+45wcTY2l1YaEQQdkFa8MRmtIk52L3n3EzkwOAf3+w0ls9ZrlfYI95DoNkpN2G0TzZTOv7nBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=rT21pGFH; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lk9sG+orzWt5XzZkVawsi3pqfrrJvR8V8MSrhf8Oos4=; b=rT21pGFHzb6bB9/93zQFcMR8xm
	gKcpb6Yxd4NtPYLcED3GxikrV91b43Vbcb6jGBuzAf1brYb7nIf2hrYXFwQ5/AiC1Tipnkh+7dotk
	Y00KZDI8i3DIWMOeObvuvHtQ0g+y0sJjOm+ZuBkTbaPm7eewb4WO2emn+OZft/K63Wa911893lss3
	HlXI9lAjb+/btfmeZ5OLEVLD709j+5I0ogyCbnHPK6aQ0EzsUiBPyyP5restbVN40hhw2s8+xmUUW
	9GEaSeJty1viWwgvKJa0aZwFJ+Hb5DBab5ViluV0Rw5QKgodnoeXvVFwl7UPx3VqyX0f8J9EMG46E
	nPB5FqKg==;
Received: from [2a02:fe1:7001:f100:7448:4f36:80a3:5ac8] (port=62167)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rau5c-00GSnC-P4
	for linux-kernel@vger.kernel.org;
	Fri, 16 Feb 2024 10:01:00 +0100
Message-ID: <caa2586e-6869-4c6d-9e5f-5cb9ef1fd17c@cu-phil.org>
Date: Fri, 16 Feb 2024 10:00:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Fair Source Philosophy (for the low-jitter San OS)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some more updates on philosophy.

I made a big cultural fusion on the Ban Bukhari channel that now is 
about Yah-Allah. This is a correct angle on what became the modern LSD 
culture, and overwrites it, and deprecates the teachings of Dennis 
Leary, and his "God". Everything there will have its run, and what was 
overtaken by the fair source movement will be given back, now that we 
are mostly done. ("Fair Source" keeps the revelant there).

https://www.youtube.com/@Martian_Elw

On the Saint Bit channel, the standard concept now is Yos, for standard 
Iclam and cursive script translation (for Fair Source background).

https://www.youtube.com/@Ywe_Caerlyn_Norway

Serenity!
Ywe.


