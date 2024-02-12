Return-Path: <linux-kernel+bounces-61821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC778516F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1F61F24242
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C793A8FE;
	Mon, 12 Feb 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="Z/g3q2t+"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6C3A8EA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747722; cv=none; b=swl2GciRy7SHXrUMQQAO+wnTRj3aKWmO+A5uy0D6XeR6dzux4PpKU3fY0VjhQ87LjSQ+LI/q27uL5g6nHrx9hMKLKi0EcbBEb0CDNZf2G2cMrcawZMaC8gmJ33ts6giUCCvpkIgcREaWfwGcIrbLQUjUlBvxT9mICbGURAToUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747722; c=relaxed/simple;
	bh=qG5Zh0vCS+1lHqBacD5osS/+iKFc9yi/KEMHKIHUoNI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gEIxfW0a7cvH9cvKd9lB9XqcymykwUI8V9a2n+O3Ye1avpvdqrBBOPkIE09V0ZxYfO0QdRbl2Ebe1/voV8DsU7qWsqI8R9o/s1SoGli9HhiujrQdGV+z3c9AIYh7KAsCJkPaTReorFEncnYSDsrUoxuiXn3w/yE0Rc/ch70lJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=Z/g3q2t+; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bZF60wJbdhDqXYkRFb4vOWZne9xjcM4fj8vHloKmQL4=; b=Z/g3q2t+SYfDkD8fRmcyecevlh
	tpu6FrUDRENMLJmZILWyfiD/wglJTZjn2j3baB6daKuWLROuekRUec0viSnloSwPSB6p6aCbyKQbH
	ubvEGEeZmO57V0yNeHQJxHQK0shuM5nF6X+K8xO6szKOR8siJ8OH6jEWDUMkdqoJI1mNl00KEHn+k
	ry+Rdq9Ie9/2Y+PNqf6DgngF6a8lSX6/SpHbU8tnntX3+en2FvVpPoZGx9ol4DfOJNJPiwad3kFLL
	pPa0YpA18Rft3YR4yL73mUAuaGZa38KMXh4SfZ/ZDZZa0ugC6rOiO/j1X+wavAKD8MPbcT+Lj9Rbs
	biBeQOLA==;
Received: from [2a02:fe1:7001:f100:99e1:7a8b:3518:d355] (port=63178)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rZXBw-008Bh4-TF
	for linux-kernel@vger.kernel.org;
	Mon, 12 Feb 2024 15:21:52 +0100
Message-ID: <e043e8dd-6370-4d9e-8aab-5d64bc8a78f8@cu-phil.org>
Date: Mon, 12 Feb 2024 15:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X, Fair Source Philosophy - more detail (was Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Updated translation a bit, separating out "the mest", of the deity 
concept, and translating the allegory symbol (the other part) accordingly.

Very Suitable for Fair Source Philosophy.

Translated Quranic Initials and Prayer examples then:
Ol Le Mi Or    			YJp9	
Go Hu Yo Dy Cy			2oSHC	
Ud Cu He 			tF<	
Qo Nu				TU	

English:
For Nu, The Grand, The Good
Hail Nu, Don Of The Cosmos, The Grand, The Good
Guard of The Day of Doom
You only we worship, and You only we ask for help
Guide us in the right path,
The path of those you have favoured, not of those,
who have earned your wrath, and not of those who have strayed.

Norwegian:
For Nu, Den Gjeve, Den Gode
Pris Nu, Herre Over Cosmos, Den Gjeve, Den Gode
Vokter av Dommedag
Deg kun tilber vi, og deg kun spør vi om hjelp
Led oss på den rette vei,
Veien til de som du har velsignet, ikke til de,
som har fortjent din vrede, og ikke til de avsporede.

u y Mest for related universal computer design, for combined what was 
"Sid" and "Sin" designs.

@ X referance concept for OS.

Bitcoin recommended currency.

PEACE.

