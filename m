Return-Path: <linux-kernel+bounces-50220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09E8475E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8872428B242
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7F14A4C7;
	Fri,  2 Feb 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="cQO+IZT+"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ECE1487FB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893956; cv=none; b=YMxWYn+sv0azx9XqWljqvZ+DGCPZTUOfcw1sWbTiW5qxeCeMSdIVK7kWOURxruuapbBVuQdnBwOwYOjFvbehkkUMNVdnrWDCV4q0wOHKjPnorIWqvoJSDCSYEZQ588tYiHUs7gv30a+yn4VboMbBzDpxy5guXPjGtlOoZCZnJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893956; c=relaxed/simple;
	bh=italr+SPawfjTR9Kzu1fU0O9AOe8rOlLdvqPtCEB3W4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=rhNmhA/QE5Cs2vlwoxqDlMmyHZu3XavqdNbansxOT62G/a0kSR66lrsQDWsbFhUXnK5e/4HqJo13C5gWeydDc+5OcJUgcmC6VhmRmkgrIK/r7J0Xahki0hpstZzmfaXERtZqAbK01csAlPprNLd8Sj2/iQpbbj0WN1skY2W+g7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=cQO+IZT+; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sa/F+vA1wPWFcGm0g7LUE74t83pN8PpIzvx2IsWSXsg=; b=cQO+IZT+5PbnyowYAn2b9lZKXK
	U0mhNtVWRd1yXE/NO47plfSJDGaCf2bHFynoofbgclHLQJh+rLk4evwbd9Vfxsc6H8MYVZ37zlX3s
	HDQcYAGbkyZKtrgbWwjtl6sIkzcKMO9WHKgrmo46104Z7D3nrRMK+/dRJAKWZQTdosN9Y/bHLYv4O
	/9E8ELihoiWD9LeE1ljaR8uyDHDAsyw4noWUk63MZ1QzvhCrkyZq7HT5vh2xmS656F2ijGmlkXBQt
	QGrAB+n4f77NHFno40EFPjPjT5V+r2mI9j/yuxddK1ZRA0XgBWHJAi2zV5D8uWhnCXNOcLBevX1rg
	dmO43Ucw==;
Received: from [84.215.119.50] (port=59371 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rVx5W-002zdV-VX
	for linux-kernel@vger.kernel.org;
	Fri, 02 Feb 2024 18:12:27 +0100
Message-ID: <9ed58add-61ae-4819-bd6c-2e14285b2b22@cu-phil.org>
Date: Fri, 2 Feb 2024 18:12:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X, Negating The Tux Mascot as Pro-Bukhari (was Fair source, Low
 Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I found a correlation with the Tux mascot to Pro-Bukhari material. This 
is known to be terrorist material, and is banned in Russia.

I made a little video on this.

https://youtu.be/jpyrxj7IVqQ

This channel will now be Ban Bukhari!, which is a very relevant angle on 
this.

-Peace.

