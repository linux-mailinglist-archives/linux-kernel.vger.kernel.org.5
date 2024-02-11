Return-Path: <linux-kernel+bounces-61021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5F850C56
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEADD1F21D5E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332D171D8;
	Sun, 11 Feb 2024 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="eNhH+tzi"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D9154B1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707694120; cv=none; b=cJRhYz4ud9c1w0ow9MAdhVyBl1HzOS/xAih6vd7uWVV0B+3VkOVVLHwafxHtHACVQmU9+unULPRMG4/2bkckyH1io+iWikPhg7iVNSm/WfRG/CzfxZWQpugal/T5lMUnMcWkfl3o4hy2xmL8BWplYZbS4sKIlww1WptlbipsUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707694120; c=relaxed/simple;
	bh=6wkJ90hJRyjyxzzwamo4+aLabRjK05mqebLXsqkM2Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Km3czQBnKabjQghRjHv1oFyxzHpcfC5pPudVOc6LM+DNI0gUr6vbYAfJdLrUn2XdaPOxnG32v+jzvo7sFPYm7PmN1XwAFjRJ4FWtpFkvBEooUpYcJB/nQkcd9JJ3Rik+otb0t9K7ojLoyOsW+o1yPfwTbIemXzi6C3WSWKGflU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=eNhH+tzi; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 50737100008;
	Mon, 12 Feb 2024 02:28:28 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 50737100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1707694108;
	bh=q0jymPh9QJK+AI28qCcKpMknnpoU1qk2qsIpp8W1RlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=eNhH+tzi7iExPI8unRR0Pnj1iar/WVWzu6a9/f6AwEy3HSCO4LNni4/iDN7USiHos
	 MwGUXBbLbuQ2rhLTZumP2wR0dw3BEVX3hjsj7tPajp42TVuQw5zowFY6VGb3bCFLYQ
	 FTtPGpjLjWSJxyVdaVgq3qxmxj5qJ+hgXmYiupSK5bjMhDlw2Sj2cmz/XcekQeJCDO
	 fV23q6JXPrsjuUndGcAWmJXMTGn5McedElt68lluNX6+P/0utt2sqlFZ2tun25HCCw
	 pEfO1xgm9aOkqgyj6wpj+KHGYM1fxX6o8T8wrALShbQmbakGP3zGI/eYa3qSwA102n
	 qvsSLwSW7K9Yg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 02:28:28 +0300 (MSK)
Received: from [172.28.160.241] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 02:28:27 +0300
Message-ID: <22c625f9-1750-4ade-b9c7-27b608c7f653@salutedevices.com>
Date: Mon, 12 Feb 2024 02:28:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] locking/mutex: Clean up mutex.h
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@salutedevices.com"
	<kernel@salutedevices.com>
References: <20231216013656.1382213-1-longman@redhat.com>
 <8be5bc9d-9505-41c6-b2ca-654bfe1d809f@salutedevices.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <8be5bc9d-9505-41c6-b2ca-654bfe1d809f@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183351 [Feb 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/02/11 22:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/02/11 22:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/11 20:38:00 #23539253
X-KSMG-AntiVirus-Status: Clean, skipped

Hello

Excuse me, this is my 4th letter here since December 2023 and there's no 
response unfortunately.


Just to recall that we had the discussion in December 2023 about 
implementing devm_mutex_init. We came to conclusion that the only 
effective way to do it in include/linux/mutex.h but mutex.h requires
some cleanups to simplify the devm_mutex_init patch.
mutex.h owners proposed such a cleanup patch themselves and there's no 
progress since that. How can we move forward on those patches?

Cleanup patch:
https://lore.kernel.org/lkml/20231216013656.1382213-1-longman@redhat.com/

Original problem that requires devm_mutex_init and discussion:
https://lore.kernel.org/lkml/ZcZeRmVjEPhVPW9-@smile.fi.intel.com/T/#m0f514f8f96e18db9568f84b2df37aaf648874a4a

-- 
Best regards
George

