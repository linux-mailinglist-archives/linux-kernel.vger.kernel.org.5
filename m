Return-Path: <linux-kernel+bounces-59080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7831A84F0EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64BA1C21185
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DF065BA4;
	Fri,  9 Feb 2024 07:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="tsW8emX6"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89819657CA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464540; cv=none; b=WiE9KQxKQgPwc83kBi6+tpmGN2LFOx/RbYNqszBk4UPHM2MAd89pqplSyN2VrcJVGYXNAPRq734YtIDC0JSuwI01cs39X9awzCudwMmoABtSMJN10MxyKdbFi4+JQRlKm3vAJ/aFA8j1n5y60lbqkkGRAmMKlLCOj7L5uV2XRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464540; c=relaxed/simple;
	bh=Lz1+uflya0+XBIwawiCswZ4+qjDAsrTF0Co7i7JIknk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dRx9onwd1T5wJ0lffODGBe1PSKVs91KiSbBo47i4dLw8k65v9JVH0PBvQddtdFrK82LPU7a1vvTa0LHkYvm+TXK1GuDod3pHMQ9Xab4BSIXtf7xT0iNLZ3ENCKj1h+ykqGZxAFy+L86BtKUXmaAK6vTAo9NL5OLh9zJteRPjTVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=tsW8emX6; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RgcorGkekXbjNVTILiG3myVHCqVPkFaoDWufFjSU4yU=; b=tsW8emX6iA4tTrg0MG5X8kRudj
	0Mg96a1KOR64Z3Xgy9vlcjiroByQolB2bf2Kr1TAOJxBkDmtx149pXd4dYeGEHoOZGnMjJ8MONlNt
	xGLRm2LaGP0b+VG4uDMWZ2SoLK/zgyLMkZZkkMwsssr35Sch3WiV6qZl1nVlvGKpy66KPd3ccuP2j
	ygoXTQKvSPQoACf3JaDYcempbVtURTKfNw1tAEMGzVqH6/2tVN9rlol/lc67ErzkfnWpA5mXxb/CF
	u1Z7dnXavyychrI96a40hYUl8Obn6SCRFBQFJVHSaaUwKp7f+M4shcVddv3OvID+Dk9tm1Xgsbj85
	IW60H85Q==;
Received: from [2a02:fe1:7001:f100:5d14:f6ee:82d2:ddae] (port=64350)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rYLWa-007eWr-8R
	for linux-kernel@vger.kernel.org;
	Fri, 09 Feb 2024 08:42:16 +0100
Message-ID: <df441dbc-2e0a-4fdc-9086-eae498c5fd60@cu-phil.org>
Date: Fri, 9 Feb 2024 08:42:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: @ X Fair Source Philosophy, TaSin Mazda (Was Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I also coupled TaSin that I talked about earlier, to Mazda. Then it is 
correctly interpreted, if you want to use this for OS and computer design.

It unifies Sin and Sid efforts, into TaSin Mazda, which many seem to 
want. And could be seen as a canon concept for this.

-Peace.

