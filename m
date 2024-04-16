Return-Path: <linux-kernel+bounces-146974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC328A6DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A1B1F21BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F612FF64;
	Tue, 16 Apr 2024 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="PidpUtUk"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E76012CDB0;
	Tue, 16 Apr 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276726; cv=none; b=HKyaC29oEn/hSv5317/8jjxlf8/vu7i+Osnedub1KdrbWghrzcEhojX8zNW3jjAK2bAqVA+2a0kmIn3jj+PpTwMyLrZV+yBMnc85JfWwOPdhghVN4nWDXifYnmHPWsIIs0HcbtiempOpAKM/ryGzR9TZRjM8JhqwvSDPFR3B+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276726; c=relaxed/simple;
	bh=9lb0vxA4WQBvo8bA+3SRiWJn3KQMYj0rb9tY1M90M2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnhV0+tbmEmdATFB8G4iwvh5Ez575AYVNg3mVByyBj8QJZelk5RY7BtBKJScQlDSO4NM0CgGQjCo7bRcdOXoPMP+mPNDSI7npK6xV5oh9S4GfxX7z81JSEsLiXCnSkrJKavgXMdexLVRNewwfTbMHzpSTljzk9GlDmJtECbn25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=PidpUtUk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id BE625600A2;
	Tue, 16 Apr 2024 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713276718;
	bh=9lb0vxA4WQBvo8bA+3SRiWJn3KQMYj0rb9tY1M90M2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PidpUtUkGQyHqrq4m2n5FU4Gl18JgJySU1rvtQcHbKWXUS+S7ajBps43ud2ma1jQi
	 9/wwyNTFc8qRRZRKW+X+T5kFAsMxtD0TL6H4FunB1GkZX71ELOeixpWTAZH0ecanAF
	 lyOhLxgWlqs9RaVPGu9A0QhzNFlDElRQoZ2r/eM84kMC2eSpHKJIno/OLC4BBGaYY9
	 qP8rKwLZS4pe5eceQvIeAj2W6gKa/S/cq6j9yJDdTzPL8DnRZLYgDtqZb8fQWxOPR3
	 7FLMcyuKaE60fEy5dsOWtU0Ek72MCvamFC0v4f9QOHKKqg5HJiGRopHBKN7jEVFpEW
	 YUOfSNR4IE3AA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id A657820025D;
	Tue, 16 Apr 2024 14:11:52 +0000 (UTC)
Message-ID: <ce0a08e2-a74a-4059-97c4-a38cae788a0a@fiberby.net>
Date: Tue, 16 Apr 2024 14:11:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: use flow_rule_no_unsupp_control_flags()
To: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 linux-net-drivers@amd.com
References: <20240416134432.9527-1-ast@fiberby.net>
 <496dba36-1d40-e7d1-1250-a350bc590902@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <496dba36-1d40-e7d1-1250-a350bc590902@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ed,

On 4/16/24 1:57 PM, Edward Cree wrote:
> On 16/04/2024 14:44, Asbjørn Sloth Tønnesen wrote:
>> Adopt nfp-style *_FLOWER_SUPPORTED_CTLFLAGS define.
>>
>> Change the check for unsupported control flags, to use the new helper
>> flow_rule_is_supp_control_flags().
>>
>> Since the helper was based on sfc, then nothing really changes.
>>
>> Compile-tested, and compiled objects are identical.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> 
> Subject line doesn't match the patch (I guess because the helper
>   got renamed).

Correct, through I had fixed it everywhere. Apparently I missed one.


>> ---
>>   drivers/net/ethernet/sfc/tc.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
>> index 82e8891a619a..5f73f1dea524 100644
>> --- a/drivers/net/ethernet/sfc/tc.c
>> +++ b/drivers/net/ethernet/sfc/tc.c
>> @@ -21,6 +21,10 @@
>>   #include "ef100_rep.h"
>>   #include "efx.h"
>>   
>> +#define SFC_FLOWER_SUPPORTED_CTLFLAGS \
>> +	(FLOW_DIS_IS_FRAGMENT | \
>> +	 FLOW_DIS_FIRST_FRAG)
> 
> I'd rather keep the flags in-line, next to where they're actually
>   used.  I.e. we have
>      if (flags & FRAGMENT)
>          blah;
>      if (flags & FIRST_FRAG)
>          foo;
>      if (!blah_supported(FRAGMENT | FIRST_FRAG))
>          return -EEK;
>   and it's very clear that anyone changing one of those parts also
>   needs to change the other.  Whereas with your #define it's not
>   immediately obvious to someone reading the code where that set
>   of supported flags comes from conceptually.

Ok, I liked the NFP-style #define, but will drop trying to expand that.

pw-bot: changes-requested

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

