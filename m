Return-Path: <linux-kernel+bounces-60349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E385037F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94911B24B25
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296131582;
	Sat, 10 Feb 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="l1x43EOC"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734D10A16
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707553526; cv=none; b=os0vmfwNrOGdU2b/vemFrLdCu4pNVlHB4RAGa+Cw5UkEOOH1/RwnevdlfIkHbDSoiZci/84XNYVErJuwNZQg9pPyxRy9UE5syzb9VXAbWJTqShFqkqSEGnii2QpCTFom+4w586eNH3uq8qFptAyf1DvOOhCf+1aaj1JLYuQAOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707553526; c=relaxed/simple;
	bh=Rha3pOaDSkB7LQBaIzdhQcBSUbPQOyc/iV9XUvDft9s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PlxsiVqwLJAbQLbAGCbFu7OLZk/PiNkkAPvqimg7NAzO4opkXJmAGwTjhC5YQKLxZJxkKLEdT4w0QvC+pW5yULOesEMQo6H3iIoVyZNUeTkWC7FFolHYWmZRX/8gnuGkjiubNNsXkSgMQjD2CIezI9llYuhzdtP5Q0F8HNvUUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=l1x43EOC; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RCAfevwT9W1bPwJkr8wFW2gg7X7QtGdB/lcN9c19w2E=; b=l1x43EOC0NTwN2HgWy5RiAitRR
	KkSUUJobUIhb73U2MosQ59K4xFcH8B0URPfoAclrL7WfZ+y1JMh1SSbO+dHhVfsbMNr4nmywURp/1
	ZnwP7rygE83FKQZhjQ5GqjDcVf4LtzAFTey6u1TgO05gZrWJET5xlUvbi33gdCHcNYKEJcXx6nPsr
	G2h2zzXiq8ovQlaVFUTGQHxV+nz0D6pHrjD8UHe//xDkQAFXDYEVOH4v2kPHSQiznveE6Kdg4h+FQ
	nuHq2Dv8rH1at5mlYFyTvWNJwOhOCG6kcTNz+xJsxy/4K0vN8aD4RAeLXN6mpkHWpvSzV4eRL+QqH
	0BHx8LVg==;
Received: from [2a02:fe1:7001:f100:192e:efb5:8c1c:f8c8] (port=55205)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rYifl-00Dpz8-EM
	for linux-kernel@vger.kernel.org;
	Sat, 10 Feb 2024 09:25:17 +0100
Message-ID: <c30e7c91-a40f-4a78-91dd-2f0776fc02f3@cu-phil.org>
Date: Sat, 10 Feb 2024 09:25:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X: Fair Source Philosophy SUMMARY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

New Muclim Keywords and Phrases, writing to the right in italic script, 
which works well with variants of the deity, featured in the Quranic 
initials. Suitable for Fair Source Philosophy.

 From The Doctrine (Al Quran, from Al´a to Yibril to Muhammad)
Main teaching: No subdeity.
Gamers are doers of mindgames. (Arabic: Fasiqun)
Lucifer Shaytan (Iblis Ash Shaytan)
Trek to Oman (relieving Mekka)
Don of the Universes and The Earth.

Translated Quranic Initials and Prayer examples:
Ylif Lam Mim Or    		YJp9	
Gu Hu Yoi Evn Cid		2oSHC	
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

UduCin Mazda for related universal computer design.

@ X referance concept for OS.

Bitcoin recommended currency.

--Ywe!

