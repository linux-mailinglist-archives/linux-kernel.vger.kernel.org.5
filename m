Return-Path: <linux-kernel+bounces-64810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51C854317
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FE52885F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9011119E;
	Wed, 14 Feb 2024 06:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="oT2oNT10"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A54010A2C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893597; cv=none; b=jz8mBinzd6zMpo95ZK2OCpytOPPnkvOzOsyZ5z16vMzYyAC1YZ3KYw8HqYZS3etJMiKpgGCFJ7/joTxWrhKID3+FMHMOYWYa5+PcTZ+bNR9OSyyI5OxbmHbIJ7UxhEJT/ylnRSxyYabyw4mkCZ8OuDLCfv5pu5xGJnsaGkMGunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893597; c=relaxed/simple;
	bh=VQNUX+iO/fDqPzjbs0M6i4ZPlLekSAXn4f84rqCnrGI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Y/6YsujeXe99mF88vXhHXG6UfdEYoN5wF7cb86AXz03tnH1QiTqlwmXIcA9WGagz7e6BvIfcU+2NJpNuoH7lWp+8BpvucXCnV9fEPNDyL6JWq76O9motYZwjE5mWfgVbizCIZXQr/k0+QB24RzavbzsWHsfb6Jf4KvxbipfCGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=oT2oNT10; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ukmoLS7hlY4mfbLsYdem9kiJx+IR+NfjeI5wWjMW9Co=; b=oT2oNT10d6/B9z5vWK4qvfRlKD
	JkBgzAWcaj3QMCbvkCKqPqVuAoVrVVlSZjfep8cObSiin1E3C5icR1nLR3riaGzVNBVqDyMMQ3BXM
	dpbpU9p8ZKB80zX4QqMDuiEf1UL68UbbZBw8mepIpV1ZvngOOcp+qCbQ2XnoCjYS6b+TABhUusVJb
	roVYuAhAWyLvwMXsNDIr0ovL1isyeX4LTvr8fw7ZYfutZKcPodr1qIObQdQp86lPNfDYInpzxhXkP
	jjtAhulUslu12HmuFXH8k1h/8Dm8AQyDdAG26Sh8pnd+ENpJv9s0rsPduI7QS8By5VqTDiroa3uR7
	IrVxByWQ==;
Received: from [2a02:fe1:7001:f100:5fc:6946:e928:a7cd] (port=57425)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1ra98r-001LyB-Kl
	for linux-kernel@vger.kernel.org;
	Wed, 14 Feb 2024 07:53:13 +0100
Message-ID: <ec36e6b6-eb81-4a15-b78a-0142b0b8e7f0@cu-phil.org>
Date: Wed, 14 Feb 2024 07:53:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS (was Fair Source Philosophy, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Or that sounded a bit close to an already existing name.

Reverting to a Sin related design, Sin written the other way is called 
San, and really represents the canon of Sin I talked about earlier.

So San OS it is then.

PEACE.

