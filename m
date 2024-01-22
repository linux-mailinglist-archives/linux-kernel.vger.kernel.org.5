Return-Path: <linux-kernel+bounces-32761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10F835FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F7E1F21B59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595D238DDD;
	Mon, 22 Jan 2024 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="hJvJV0Rr"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E037144
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919653; cv=none; b=Mktro6XOxxPjwHSS9KVViqA7kSByI+z0XjSFzRkF2BzMlSjCaypYTUwKT7XH/crpVe/Oc1Tx2PdsfWdNQ3OmB8z01DqKjp3Q1eMOUwWM59+WWnZIzsmWvMX/tS0hwu4RVbjdBB41NvhoFvM0+XZI6Xlc09cbfiuk3M8dUI8yUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919653; c=relaxed/simple;
	bh=nGcB8t9xZ+mtTEdiu2aaOe6BEkHn2KJtyklNA5ZxmHU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=tsahmu89mN4J5ssUR2DdII+Ui2MF5ainMTZ3gWv9/XIo2YeqeBq9jbQUvqHrTRCPUbJ1MJOegsKpKj0UqctiU6ub3lu0yiA/8ajd7nIHdSFqnsJvzFGJefxmP3orTr2+Lv8rvlsVgsJ1Hgivj4SaX538yncwxzwh7cqyIY/wpak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=hJvJV0Rr; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xf33rN8iXI23fiTfczkjznDyPyeBT+sWLRkn4RCNveM=; b=hJvJV0Rrj6w/0VC82RWwCAuVzx
	+26M+1yd08BuUmnAxLDdWN/ByjpRxwc08ob1d4V28bxfZOj38RJtYk16q+wyANNCiJ+tu6wPfUO16
	zVtvfTEMaYWlqUq3W2KaKJGNL5UwCWYmOVhzxDDmocB6Ed5IfXGN9vwSl8WAbbPRUMXTayInMjQZs
	mSctkYf9m89LZP8x5VlsHeziWFNYCICcyjE3F3ub/QasL1nMR9AWBf2N4u+DH9dapxZpXh5UmKwNg
	0F40t4frGJvWN5GoDR2Mec7Wbtt/gFsGRpmNKN9RS/91dm6U1688a0ZPY4rkiVd7XoHrQZGLs1KTT
	9BLzH78A==;
Received: from [84.215.119.50] (port=59430 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rRrcy-00EuoM-Eh
	for linux-kernel@vger.kernel.org;
	Mon, 22 Jan 2024 11:34:04 +0100
Message-ID: <d7c66c3d-7c8f-4e9f-90b7-c013fca2d24b@cu-phil.org>
Date: Mon, 22 Jan 2024 11:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: Lo X, Bitcoin (was fair pay, low jitter, philosophy)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Iterating my last post to Lo X, and Bitcoin. The computerbit symbol 
really an optimal symbol for this aswell.

https://cu-phil.org/low-jitter-linux/

This really symbolizes the whole thing I have talked about.

-Peace.

