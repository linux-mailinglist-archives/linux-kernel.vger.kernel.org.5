Return-Path: <linux-kernel+bounces-88067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E85B86DCF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FE86B2514C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15969D28;
	Fri,  1 Mar 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="rtN255oA"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C873D482E5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281389; cv=none; b=N+kxoIloWIGlMiXjp3xWoPaPfyLBPxqTT2VTXGX3XnQKWzPv+99t6iRw9ySRJBo2ff8g9gttE4Rild3DlWGIXl0ARfMLvov2ATwmQuwEvvbLqTiT2fr4V2dBoY6rJYNPbJklLCHB3WaemTWlQp6dd/Gf7K0bQY3j4ymw6qFMk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281389; c=relaxed/simple;
	bh=2o5MGJBZw029P7UO7atYu1SLfVDDs6kTc58FZ61gsFw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qgLXf1/O/AO1ZHfbLPCrVwZkmlYrAPoFNu0CTCfc1Jx3RUfKzwdYDWRwXum7jMHJZNSGdPDiquJTFr1vqUJ9UCRkJW4aJSSA/5IlZsJ207FIFbbWKLoE692RBxUScpNVXuI730dReELToMVisg1QWyZFa/9CW6QTynQCJvkr8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=rtN255oA; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7Z2samfE5e277rhzgEAusEduWelCD1tpoWQQeCAo+Cc=; b=rtN255oAuwJMrzuPL4CAI/NsFG
	D4whYP2ydpHAX4WpsBHTQGFSDXTiSdJOdX9muB1tCCj8Cjwhi4e47TfkOjTMX7qb+565oqyDyUYwt
	8o9qxqoSjQM6iETLYV/zzYiRhpiPNe2gX6SkeMt1Nx6PYqDXfNh/8VVTelr8pvvRb3JJBfU/Q9oFG
	Y6U4WVqs12fkkSzD4IwhtIHFYDfnQZ8tmRam6j77kD2V9YTl5VKmetSveFD7l3CypQpebuwzTbFEu
	BylCIr2e0BI4huYK+1gQtwHXOSJTlW0UZrqnQFNKOBhnFR4+wQMVkOeDM9QpB9bKPO95SUROwsh5E
	tS3rpt7g==;
Received: from [2a02:fe1:7001:f100:34a4:85ed:697:262f] (port=58647)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfyAV-00DZVA-0G
	for linux-kernel@vger.kernel.org;
	Fri, 01 Mar 2024 09:22:59 +0100
Message-ID: <4c99dab3-69e2-49d6-9620-61211a4b5a30@cu-phil.org>
Date: Fri, 1 Mar 2024 09:22:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: We X Symbolworld
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Yes, I talked about symbolworlds earlier.

We have a symbolworld going back to the beginning of computers, and 
particlary tapedrives. C64 Datasette is this in miniature, and 
particulary with the C64 this type of culture gains popularity, and 
reached height between C64 and Amiga.

This symbolworld will be updated as follows for the serious:

Saint Ignatius will be replaced with Saint Bit.
Linux etc will be replaced by We X.
Christianity will be replaced by Iclam.
"God" will be replaced by "Charity-God".

If you are on the wrong side, it will be the same for yourself. And it 
might aswell be Fathers OS, a fork of Terry Davis TempleOS you have 
worked with.

-Peace!
https://www.youtube.com/@Saint_Bit


