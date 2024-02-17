Return-Path: <linux-kernel+bounces-69701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D70F858D72
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95403284221
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 06:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B031CAA4;
	Sat, 17 Feb 2024 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="DUVd+SZN"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657A1CA86
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708150441; cv=none; b=Mc26nL7+qcI1ifQU/D4VcORl3q2dwUpvkB6w+O6+ELDBuYY7u8skRQEtzOxKEEbulBUIGdih+uTDtcADIGaK3ct21/oUkGXLU1VGcUHitEcb2215r/MpjRpHkiqS6+kJbgRrq5AU1vGhNP/coG4cUFGhcvvRqwLvSZpXWW3K4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708150441; c=relaxed/simple;
	bh=tf+GqnPVooVwgnPnzOXyNN5zHVtRdXAoEwSd5radnWQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hoFcFc5WXuQUdw7NGE45FpkmcGz3REZdSj++lieLM184dMltiV/kTncUkxY9pM9H/AXi9PgxVDSYTDGqkRqAHjBJ+8oPdGIpQZ4rhr4l5r+pksS+EgtLNeyCiBWth5xhjRGsRt+8KjgYlDUJZ9E1h/hKYM+kWTXOKG55DY2Kdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=DUVd+SZN; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6K4mLitdGNJtnRRfIMFi1ylxVF8/kcSYoS90XJCp1OM=; b=DUVd+SZNGK0xKfOIxd/Zknw/Am
	Khwzyrc5cykv/4B4yeLfwwz1pi3kXpX6sZXQJn9mCjIUCwVdKHN8iFOdby6/Dcxq94FT3T4EgZwmz
	bcGrEJRYlbkIamxuHSVHSvXu3PNQ4RcHSjl8il8HtpmuUgm2v1WA5eHdq3FrHwoX6dMWGkVtySXSi
	+omeJqNrsVsdlQjDCmS9Ri3za5kLVjVPlXznH9KeD/G5b+SNPYndxEeNWxwI80Tkq0uZOPF9cWxUY
	+r027J3311eKki8615c2fi0M04zAy2SstU/3TgJuxDS4EQOJLZlyitcjp5DT1Dkh1v8JSPUosA8b/
	Kedntgcg==;
Received: from [2a02:fe1:7001:f100:49df:ade:2528:aa2a] (port=50289)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rbDxQ-004G52-5E
	for linux-kernel@vger.kernel.org;
	Sat, 17 Feb 2024 07:13:52 +0100
Message-ID: <f0669840-b3aa-4829-8e52-849e053df5cd@cu-phil.org>
Date: Sat, 17 Feb 2024 07:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS, Philosophy, Low Jitter, Fair Source
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Improved some typings:

For the Ban Bukhari channel we use Ya-ila. Which also represents a 
cultural fusion, and non-schismatic and correct view on "God" culture. 
Tested and works. Sympathetic to "make love not war", on the middle east 
conflict.


For the Saint Bit channel, Ios, is the standard concept for translation 
of The Quran, for italic script, for Fair Source background. Tested and 
works.

https://www.youtube.com/@Martian_Elw/
https://www.youtube.com/@Ywe_Caerlyn_Norway/

This also represents much a sample of what culture will be in the OS.

So, some final polish there.

I am am very pleased to say it represents finalized work on the 
philosophcal background for Fair Source, for San OS.

And a happy ending indeed.

PEACE.
Ywe.


