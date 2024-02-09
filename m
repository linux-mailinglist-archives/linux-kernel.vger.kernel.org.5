Return-Path: <linux-kernel+bounces-59026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7284F00C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC711F27A72
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400ED5732C;
	Fri,  9 Feb 2024 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Xd+4dsuB"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692457307
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458099; cv=none; b=PZmb6s7Hn3Z4uLyDb1cWhxzdAUxCeEAgm1B6+aYHGcNusMHo8pI58fdAB5CpKAQcFadJdyC3Px26mMY89Riz8QuosFEDNJcL3K0hVAXUoD1BQYBffBYLA53vne4ljdiL650ZSQ1UvgjSp6wfxHZqIJ60g+knHlMufc0ENZ4EEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458099; c=relaxed/simple;
	bh=t2eFwQLubw7QkLe/6zlPBcVRA1bY6BtAeS1FFqJPork=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=s2k/C6mtLLHIkxmfmzPN4GVCZaL2LD9CbEAjnd/vmeZRlhFh3+zlckQJ2s6t+7cHwpYzLDyYUm9w8NlplSlM79ADuAob4aa/YYugMMMXiKt1gEOkB8Rju17uJFmCoS7ASxXk3EqOsPc0SLQNF2Az0lrk71V16+GniwNJWC5Q1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Xd+4dsuB; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4r+wNqSQNA5QAKUmH8C1pUW8ydL3JkdZL/s6j3fxWNI=; b=Xd+4dsuBOvdu5rZ1r2V5KSW7x8
	jCXXrI1x0VJ5qJKuuQ7kVc7QOheYUkgJhU5NR5c6V4zXIkl7wgAr0pdcdEx4Zs33y2A7LlZKmCATr
	h60elYpOcieTtyTtPaJi55NomW+JrCuMM58bEAK+dU3INygyxxZJ9fTa3DR49P7A9cTfZU3xZKOHo
	k6EbH5yq4W0oHb0a1B9227Vd5cFHFO8BvlFjOeuAISYxUJGb9Zp2QNKCZ/oKvevYsIhbSss1hSH2L
	uWjv6GVbDNdgO5AEWLbM7Jze2TNXcCgmPgZY9Pu5zsYt7dgmn0xpxgx4FgWwynsPP0FR4hrvUZLON
	6jdY7iQg==;
Received: from [2a02:fe1:7001:f100:5d14:f6ee:82d2:ddae] (port=58130)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rYJqc-007CfL-9N
	for linux-kernel@vger.kernel.org;
	Fri, 09 Feb 2024 06:54:50 +0100
Message-ID: <4f00a1e0-d175-4529-8c43-15e526af8946@cu-phil.org>
Date: Fri, 9 Feb 2024 06:54:49 +0100
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
Content-Transfer-Encoding: 7bit

Yes, I did a translation of The Kuranic Prayer, as a example of the 
fluency of it.

--
For Ge, The Grand, The Good
Hail Ge, Don Of The Cosmos, The Grand, The Good
Guard of The Day of Doom
You only we worship, and You only we ask for help
Guide us in the right path,
The path of those you have favoured, not of those,
who have earned your wrath, and not of those who have strayed.
--

This should be no problem to adapt for the faith side of things.
Wellknown expressions, clear english.

Again, I am on that side of things: 
https://www.youtube.com/@Ywe_Caerlyn_Norway

And I have also done research on the other side, based in the 90s 
Satellite/Rave/Cracking culture: https://www.youtube.com/@Labour_Party_Elw

Where the correct angle here is labour party politics, and a sentiment 
of Ban Bukhari, the sectarian book of extremism. Which really is the 
only sane angle on this, which was the maddest period in world history 
ever? Breivik also "just a raver" from here, claimed christian.

-Peace.



