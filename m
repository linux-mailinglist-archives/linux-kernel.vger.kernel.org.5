Return-Path: <linux-kernel+bounces-95358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AA7874CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D101C22B56
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DA8565A;
	Thu,  7 Mar 2024 10:50:09 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797283CAF;
	Thu,  7 Mar 2024 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808608; cv=none; b=jhmHr0RFTo7UQt8Fhbqj/vswTLhPiSGGFJzL5awNJUWOSdLxg3JQUYBR6/lKol0WY5mrIOsAKvw9OgywlFS73I44l3N4VKRWNGNcTFzcxdakKuTV9Ow06NSUeIQ+C2fcI5ryTtiPIsIuvMUabmbT4pWaeJ9Nvw98g5b4jhcUfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808608; c=relaxed/simple;
	bh=ZzG+eAiAVIliAT/8yyBZr4RKhrPLz83uIS/Odi/W98A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3doLSWKkU3yRlwtiCq0YQE1jwI7AeiDpMJUEOeq5DQPN+OK+qoFEg0KPzlMj2rZiIzGpAytQDS+SlTfu58BbH15deehxYPyysIWd1g/iT9ReoOInEYpaXuyWvyu8Y/LZ264HQyUUd/HuXv3iDqjhP7dfbYSaQ46rKC7dmSSB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riBK5-00DtdZ-EY; Thu, 07 Mar 2024 10:50:01 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riBK0-002kf3-2N;
	Thu, 07 Mar 2024 10:50:01 +0000
Message-ID: <4ee83195-99f5-4823-b4d0-339ef4127013@cambridgegreys.com>
Date: Thu, 7 Mar 2024 10:49:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pcap-dbus.o:undefined reference to `dbus_message_demarshal'
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Waqar Hameed <waqar.hameed@axis.com>, Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel@axis.com, Richard Weinberger <richard@nod.at>,
 linux-um@lists.infradead.org
References: <202403052336.y6DkUd8a-lkp@intel.com> <pndzfvbibgm.fsf@axis.com>
 <87cfca1e-3f53-4935-a274-0920bce86373@cambridgegreys.com>
 <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
 <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
 <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <a485fbdea26e19afe00f603bd65c83e2be20abe6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 07/03/2024 10:29, Johannes Berg wrote:
> On Thu, 2024-03-07 at 10:27 +0000, Anton Ivanov wrote:
>>>
>>> How's that required to be formatted and loaded? tcpdump itself can also
>>> dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
>>> so probably not useful). Perhaps we could even automatically call
>>> 'tcpdump' at runtime?
>>
>> That is one option.
>>
>> As far as common use cases are concerned, at present you can:
>>
>> tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) and pass that to vecX as a bpffile=
>>
>> It may be worth it to make vecX also take the -ddd format directly by adding "format" options to bpffile.
>>
>> I'd rather do that instead of invoking tcpdump out of a device open. The -ddd notation (+/- a comma here and there) is
>> standard - it is also used by iptables, etc. It can used by other code generators as well.
> 
> Yeah, that makes sense, this is all kind of special configuration
> anyway, and given that it's been broken forever ...
> 
> I actually doubt anyone would scream if we just removed it, so maybe
> just remove it and if they do scream, point to the above, including said
> 3-liner in the response?

Let's make it so.

> 
> johannes
> 
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

