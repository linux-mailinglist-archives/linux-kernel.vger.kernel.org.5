Return-Path: <linux-kernel+bounces-36589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038383A37E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285D7281BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CD18042;
	Wed, 24 Jan 2024 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="V/IENVTF"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CBD18030
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082353; cv=none; b=Nq8Ch0G5xujgYkWdfWhG03uV3+XAEPR128oJkvvc6yD+ITAxDagpJVxONPlP0dND1/gZ4xtjwTV90WvMENbDqBHjUv3rBfGgLORQBdDhUZEIxZYsUinHyMBF2ySnqqJV3Dnl3cU7cDfP2NWa2EbwM0vfuvbDe5S0zC1C3FVHC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082353; c=relaxed/simple;
	bh=5Dh5m0T/sME00LerzXR3pUFl475FOQa1Uu+0an5wSVA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=VHYHtklm0s1ihMtd8qV6UI9wND+T9OyLJ8bOjaApYsAx76nD4Cfru2iyHWf6HGYV99YMehd51JDb7sgxF0Ge1GvvFBbItVv4ZSCMw1DCPsjX64ZKIi6NV6FjxYo3RivQVd/WSglRKKOZHbES2CgmD4/ohUc6WdRyd80Cihssr4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=V/IENVTF; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NG1AscD6yjWAKyTbxEpmhdwOaD7ID3OALa1b8dxEAcM=; b=V/IENVTF1pj0yWt9b24hGDFgoN
	IwkRWzzb3lazw7Ui65uxKbdpy9atJoQRY0GUldmkSOhtZq9hSpF16TFMFsh/9Q/ySTlzNVfhDxYd7
	dFgeKWv275KueeKiYzLOjIEh/Ew99EZde/jc8cblpAr3YsipfxfZYMHurwoWxQ/gwkhn2/vVbh32b
	dNZ5V2oWmV+nWzkZAOVfUhF6CCGYeDlugrLw+nLM5LzjLOBnL9arRvkguRkXXu4zsEmFwAwOccKhL
	w9IS55R1c/coG5hNdRaVxm2rXcWaOXRqCi84nnGoiTLWScuzL2G4KzrefZBQZ7fFt/fyC31/uvj2q
	Rbk6e62A==;
Received: from [84.215.119.50] (port=63619 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rSXxA-00A0V9-03
	for linux-kernel@vger.kernel.org;
	Wed, 24 Jan 2024 08:45:44 +0100
Message-ID: <4b117503-0133-4267-99da-daccbe1010f2@cu-phil.org>
Date: Wed, 24 Jan 2024 08:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Vec OS (Fair Source, Low Jitter, Islamic Background Philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I reiterated further to Vec OS, vector games really the driving force 
here, something to reconcile with.

This should be perfect.

PEACE!

Ywe Cærlyn.
https://cu-phil.org/

