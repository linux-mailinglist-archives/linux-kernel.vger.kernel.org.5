Return-Path: <linux-kernel+bounces-36838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF483A791
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAC11C2260D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625A1B592;
	Wed, 24 Jan 2024 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="N7n4+Jjp"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6B61B285
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095011; cv=none; b=HRhcnfgY4eXyOWUlRlRNia/Es/RDw4vj7HZjuL9zjw4UecR3B2H+Ioxftm+OKM/ifrtb038tx4c/woeVmEvPJtyd6tbhm6/XEbEWZILDkRfGBh0l59rVseJBAMjIVGXSN6+8NeiaPlhmKGD7gT9v6KYbhoy6075VPXXshe2syto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095011; c=relaxed/simple;
	bh=IU0qppSiKQWbofHyQdWavLUMvIA0lyz9bZAHuNpLlMo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qlMw2XT0ZyFdOQQ/4+ms7h74Z7RFSlHZ+teN2dCn7spe8KnyAXlOUZFpXrTZmR9GMmJPJkYWgzZpxo9KkOjfmGLoeL9s6llhLz7YzDL6Gcg4sO3RFn55F6BEtiMJDmgRxRHKGp5dsYY0npOWObTW4luuBq70w0ks1axrtWr8N+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=N7n4+Jjp; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IU0qppSiKQWbofHyQdWavLUMvIA0lyz9bZAHuNpLlMo=; b=N7n4+JjpPv4Awx/kwUvKxuQduh
	agJIdgn5qb63xeGT9mj/S8cWxxLoWgK5VQEAp+QwqJaq4NgCwKxOv8Xln/cSVcchDZYpLKUlfiQWr
	pAta4NlLKFhpvC/5ItOSNSNEly9IvIFYFifZfJoOeFWTh2nLLqjKlcqaSM/oj3W1CEPuRhOw/mTVo
	g734yuUE6UBB5itTgmJouzCHuh4hQeuzRbRYGzeEYtfAAlk6yf/yUsR1PMDjP5qP9JgatynDm6+pe
	S2U3HbcVSS9eLeVYIGWSiZS9PoQE8LPLkjTiDYJweQ5OUqeYXPqjNF6Fs0Wx93YuCQsUM6p9akwN4
	QFuteJ9g==;
Received: from [84.215.119.50] (port=57534 helo=[192.168.0.2])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rSbFP-00BhpD-NZ
	for linux-kernel@vger.kernel.org;
	Wed, 24 Jan 2024 12:16:47 +0100
Message-ID: <57df438d-77fa-4bfd-9d43-51327b33011e@cu-phil.org>
Date: Wed, 24 Jan 2024 12:16:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: RS X (was earlier iterations, fair pay philosophy, etc)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

An even more popular driving force than games might be email.

So actually RS X, Recieve/Send System.

--

