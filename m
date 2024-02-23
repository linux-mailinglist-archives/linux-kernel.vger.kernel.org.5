Return-Path: <linux-kernel+bounces-79229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A4861F44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415C41F2645D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5841814CAA0;
	Fri, 23 Feb 2024 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="q5MbD4G6"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897CA143C63;
	Fri, 23 Feb 2024 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724949; cv=none; b=dEKyHQOBqXMv+LB8JomRjceC8cnYdP/A2mlZh499kQqNE/qxGPFhzJU8pJeCNsLjuTcBpS2gQI6yt30nWpzC4BLO8c6fsrrqfpMhJmnZyzxHVLdrf1N0YfPcYQpxqwarEmD7vUPy2DJLr+SUPl9q/vXnvspfQ4q2gTY4bhymFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724949; c=relaxed/simple;
	bh=6SBVEVhGe14XSlEdjUuk3BF9ZIWoWFHmX0bNpDG5K8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=opJIj51Ea+Grr1hjnugiLWbiP7hHExZaWg6T6ap7smlg9mEfV0mHFby9G5KZxYVhm06ywXCZRu4Q7KGD+8p8c9369F2Uz+zjB4XYv6637xvAafmkys3WjPYEuVUfsN8S8x9/GO5FZjnP3+9hG6PvbT53iy4PaTaq5MLVqicARB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=q5MbD4G6; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9EDAB120004;
	Sat, 24 Feb 2024 00:49:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9EDAB120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708724940;
	bh=LuXzDQesO0b7s03KMrS/BJMWiJPrhOHKPc+5IUUDRMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=q5MbD4G6MeOiwWzMZjjrknD5OdzsMSPM8jkxEd1eYvknvAwt7zbOitmzbmTyuuobq
	 pQUnqOd1X9JOhOejFGHWc6NsIurcnBwYMdclTjD4zeE/RVuTbQjVxi8moI2AsD59Bu
	 U279J5LFTw0rna//7/xIe4jl0FLoD1TpSN/JXUG/reMdcfLXjHUh0j54I5fAUC5ZOY
	 pQp8PAIaj+/39UwnWZRXZ3nFHum7bKc+FFu8WAhs+oVHudhY7JdL7wlGK2697bOO1M
	 sTF+TT7XPX96Rxf1S7givW/nOuNMhJ6MyCDdDXnvqObhOONQvByIC00neVuHuo/bJG
	 LJj6RrzOIBHoQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sat, 24 Feb 2024 00:49:00 +0300 (MSK)
Received: from [172.28.226.86] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 24 Feb 2024 00:49:00 +0300
Message-ID: <9922942e-ea9e-4cdb-a091-5b8ea0a180d8@salutedevices.com>
Date: Sat, 24 Feb 2024 00:47:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
Content-Language: en-US
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>
References: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
 <c79909e4e55badc8f094d2ff8c4d34ca.sboyd@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <c79909e4e55badc8f094d2ff8c4d34ca.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183695 [Feb 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/23 20:04:00 #23774084
X-KSMG-AntiVirus-Status: Clean, skipped



On 2/23/24 02:20, Stephen Boyd wrote:
> Quoting Jan Dakinevich (2024-01-26 12:14:33)
>> Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
>> case of deep hierarchy with multiple dividers/parents. But if the clock
>> already has exactly the same rate as desired, there is no need to
>> determine how it could be rounded.
> 
> What exactly are you trying to avoid? Is this an optimization or a bug
> fix? TL;DR: I'm unlikely to apply this patch.
> 

It is an optimization, not a bug. The problem is that 
clk_core_req_round_rate_nolock() is quite expensive, and I faced with 
cases, where it takes tens and hundreds milliseconds (depending on SoC).

As I see, it is irremovable feature of clk_core_req_round_rate_nolock() 
design itself. Lets imagine, we have some clock, and its parent is a 
divider. When clk_core_req_round_rate_nolock() is being called the 
execution is walked through the following path:

clk_core_determine_round_nolock
  core->ops->determine_rate
    divider_determine_rate
     clk_divider_bestdiv

Inside clk_divider_bestdiv() for each possible divider 
clk_hw_round_rate() is called for parent of the clock, which in turn 
calls clk_core_determine_round_nolock().

So, each divider and multiplexer in clock path multiplies many times an 
amount of iteration required to execute 
clk_core_req_round_rate_nolock(). When there are a lot of them the time 
consumed by clk_core_req_round_rate_nolock() becomes sufficient.

> I could see some driver implementing round_rate()/determine_rate() in a
> way that rounds the rate passed in, so that even if the rate is what the
> clk is running at _right now_, it still wants to change it to something
> else, or at least call down into the driver to call the set_rate clk_op.
> Applying this patch will break that. The contract is that
> clk_set_rate(rate) == clk_set_rate(clk_round_rate(rate)). It doesn't
> look like anything needs to change.

If I am not mistaken, clocks's rate is either equal to its parent rate 
or calculated by ->recalc_rate(). I suppose, this callback should return 
valid rate value that is based on current clock parameters.

Now, suppose the clock has rate "rateA" and we called clk_set_rate() to 
set "rateA", but clk_core_req_round_rate_nolock() inside clk_set_rate() 
rounds it to "rateB". Thus, although the clock is able to run on desired 
rate (and actually run on it), ->determine_rate() and ->round_rate() are 
unable to choose clocks's parameters for that value. Is it correct 
behavior for clock driver?



-- 
Best regards
Jan Dakinevich

