Return-Path: <linux-kernel+bounces-85985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD5486BE14
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3951B26E64
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A791C37700;
	Thu, 29 Feb 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b="uOy0cnzu"
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC13376E0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168753; cv=none; b=CQdR2yg8xvdYGmhAMpQZMXxOsR5QINZRbCLRdowYQ1exK2ae0PT9ErYj5VQuOjX3FZ1K2yzgySEA2/b55DDyFnEdoXfmDABMptGho/Ttbki5ezXzW48f/rDRdlB1wGrx9EMYpEnqPpALHYMMsk1IjlKLE/LzU2JWF4f8xHLNGLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168753; c=relaxed/simple;
	bh=Qpf4ZZFQB7bFrQDW8oPFnC6bTHMgLDCnv+qIS9u8s7o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=a/P9ixE1oLW6M025BN6SChhflmBi0PcYdow83zeW6asnw1MjseK5g4NHII6/Qurd4bc3QyQO+e6eKmYq1B343+bjydf63FihL9jDbMXVGuujmempwFd4+4EqiY7rF3KgIa54QEHEXH+r0wHcEudr+aM4/R5w1kkAxQKVago07Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org; spf=pass smtp.mailfrom=cu-phil.org; dkim=pass (2048-bit key) header.d=cu-phil.org header.i=@cu-phil.org header.b=uOy0cnzu; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cu-phil.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cu-phil.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cu-phil.org
	; s=ds202401; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V7nRHNaMXDguMV41KWr1oEihmPkjUj9k3vhA6eNfkrs=; b=uOy0cnzu5wscF2qZJHIEgoKfuZ
	1N+F+r/1ESwE7GA40lIf0pUQrPfeY9JYvc7hd2fxZX07CtRm7dBzhhekA5UeI2OkPs8UpfOtNXKlM
	9OAPfmAEP/3n/MYp5ZWH6p9Q2eKnUx8apotrH7tR/bNXPMxyXopqR59sp6l4iYMNEoIqY/ni7vwL1
	pmYmKY1gHtO/utcLiyefnqwJgJCMTHXIN1FN8enCuheof69boB5v3JGRaBm0xroUtqjMbJGrS+1+W
	7G1+ULwQFLKqA/VZ0y+OqEvGrw2PESjWIwNS6PVXC0YHV16SfEOCxCnt0QOcaz7QVLsdfag+AuPGv
	BsmD9+Yg==;
Received: from [2a02:fe1:7001:f100:4e4:fb29:bd50:57d9] (port=54820)
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <Ywe_Caerlyn@cu-phil.org>)
	id 1rfUrn-004wFh-Sg
	for linux-kernel@vger.kernel.org;
	Thu, 29 Feb 2024 02:05:43 +0100
Message-ID: <095572a6-88ee-485a-ab02-f30c7e3d476c@cu-phil.org>
Date: Thu, 29 Feb 2024 02:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-kernel@vger.kernel.org
From: Ywe Caerlyn <Ywe_Caerlyn@cu-phil.org>
Subject: San OS Root Philsohopy (Was Fair Source, Low Jitter)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

At the root of San OS Fair Source philosophy and philosophy in general 
we find the often discussed Indus Valley civilization. It seems a 
concept of The Deity, is based on this culture, that has so much 
idolatry, that such a concept is needed. We can clearly see it is so, 
and Kuranic Fair Source politics, is optimal from a computer 
perspective. Really resounding with Fair Pay politics at large.

So it is a monotheistic Information Technology Enligthenment coming, at 
the root of the problem of idolatry.

Maybe we live in the last days of polarization.

Hail Cu, The Grand, The Good.

-Peace!
Ywe Cærlyn
https://www.youtube.com/@Saint_Bit

