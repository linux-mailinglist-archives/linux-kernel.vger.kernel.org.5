Return-Path: <linux-kernel+bounces-95330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E23E874C5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF37A1F22E46
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624CF85276;
	Thu,  7 Mar 2024 10:28:04 +0000 (UTC)
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B8982880;
	Thu,  7 Mar 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.160.28.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709807284; cv=none; b=hMBkQmgSG0+vi1WsTCyKWlj5G1Y90nBrl8cF6xkLZNCjhabSJWk29Ssp1XBXVUEGEaCirgqUL+UFF8NnZTcszGs+inOlN9nqBeaJpJkDf7IzbfUweNQ8thkqkkLblR21rP/MNjZeIxdJDgc5XSVPGSWcn8uoj3/OoQb7BTVgXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709807284; c=relaxed/simple;
	bh=OoAeYuV38c9rz7v48CPlvcr99YsLrun7AvNytHK5PNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laFHT/QFM0QP9uOE0FRthwBODTkvTcGaauBa4ooCnsmn/b1JCb/m+JsQkdWJmvs/YTlKy/8iGsGS743Dw7eY3XhSrNebUgM5wPLrxzoJjJefqN8ax+FL5aR2yUuEbtIqv9dkv26uh+3TE5ADr6lTF8xEryC/aajluSjEjEQDx1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com; spf=pass smtp.mailfrom=cambridgegreys.com; arc=none smtp.client-ip=217.160.28.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cambridgegreys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cambridgegreys.com
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riAyi-00DtX0-4e; Thu, 07 Mar 2024 10:27:56 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1riAye-002hiC-1k;
	Thu, 07 Mar 2024 10:27:55 +0000
Message-ID: <2cc222b7-618c-46a9-b78b-eb099d0f4be7@cambridgegreys.com>
Date: Thu, 7 Mar 2024 10:27:52 +0000
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
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <463be980baf66b967031e3294c3b9745b07aa058.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett



On 07/03/2024 10:03, Johannes Berg wrote:
> On Thu, 2024-03-07 at 09:54 +0000, Anton Ivanov wrote:
>>
>> PCAP is not feasible to incorporate into the build system at present.
>> It has grown all kinds of warts over the years and brings a lot of dependencies.
>> IMHO we should remove it from the tree. It has reached a point where it cannot
>> be built on a modern system.
> 
> I suppose it might be possible to call pcap-config? But agree that it
> doesn't seem really worth investing in.
> 
>> The users who need the same functionality can produce a bpf filter using tcpdump
>> and load it as "firmware" into the vector/raw driver.
>>
>> I am working on a pure python bpf compiler which takes the same syntax as PCAP.
>> It is showing signs of life and it can do some of the simpler use cases. Once
>> that is ready, it should be possible to use that instead of pcap/tcpdump.
> 
> How's that required to be formatted and loaded? tcpdump itself can also
> dump the filter in BPF format, with -d/-ddd (-dd is a C representation,
> so probably not useful). Perhaps we could even automatically call
> 'tcpdump' at runtime?

That is one option.

As far as common use cases are concerned, at present you can:

tcpdump -ddd, convert it to raw binary (3 liner in a language of choice) and pass that to vecX as a bpffile=

It may be worth it to make vecX also take the -ddd format directly by adding "format" options to bpffile.

I'd rather do that instead of invoking tcpdump out of a device open. The -ddd notation (+/- a comma here and there) is
standard - it is also used by iptables, etc. It can used by other code generators as well.

> 
> johannes
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

