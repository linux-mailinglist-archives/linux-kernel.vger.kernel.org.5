Return-Path: <linux-kernel+bounces-106719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C57F887F27E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD0A1F22738
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EFF5A784;
	Mon, 18 Mar 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BtT6BSCA"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1DC5A4C4;
	Mon, 18 Mar 2024 21:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710798452; cv=none; b=uRRd8JiSfGnjlu/64PfQluj1/wHCZQMfau7DQ9XFiBzsgqal28ZxhcXbMgXxyB2a0mM83NaOK3omHXb8CajKtBtteQ+0rYrxKPLaWmrnI8OTLaCB2LIIHPaFxo+MCJrYlDorhdufNY9+xPWyAY3qX6lfXmuCZ9lwQsUCYMzSNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710798452; c=relaxed/simple;
	bh=0KHLOX989patS77pGpcRZFTzkTlt4FFLOAPNDbE1sso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4HIZpse48Yf171OUKy/XABQ6+qPLPDQrOrnYsAOc/wPcWdY4CLaXT0g/3iCKndwD0pZjxoEwLx+uzD3Vv66vrRGsq4frQV5xmzflavJa9C8g7NZCO6oo13fct5QbF7sdTnh2tad5X5EHOIpNZ3UIZ5WLAWSKGeVWd8kpqNMkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BtT6BSCA; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id mKpDrVX3HykpTmKpDrlHk1; Mon, 18 Mar 2024 22:47:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1710798441;
	bh=Ki8LFuEpDeR2mCHJn1d/kGG14vmkqd8OY5uyzfzg9Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BtT6BSCAllOalo4Torsvp9ebPARr532K3yfpGu5YkFPtWUGFT/8yFUxQl8rrSGqk7
	 LJLXIPCFJcnIXv/hS+TrJeQ+0QxMKSYFHguTyrBjz6Ehsdwiksg6I1E98NAGRl7prY
	 Evnf6p4hrYbW/oUufarHq975ylA3gkz5NhoX3OoPsn61LVFZcduJloyvN/M4PPJ4Tl
	 1txPov/jEW1BdfZURM0okyyOYrpClTiF83clIDbJlhbk9qjz4GdTQAbAtvnb9sW0Hk
	 t1zLN7ddTI/g/5wsMKOq+ZpfA/pKA2wiAv92ysOtbLcmtU59/u3dDho5g+wAGTfwkl
	 OMpS+aL8j3UwQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Mar 2024 22:47:21 +0100
X-ME-IP: 92.140.202.140
Message-ID: <c4236382-d3c8-4560-9a95-f90effcf6d88@wanadoo.fr>
Date: Mon, 18 Mar 2024 22:47:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] caif: Use UTILITY_NAME_LENGTH instead of hard-coding 16
Content-Language: en-MW
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
References: <af10f5a3236d47fd183487c9dcba3b3b3c66b595.1710584144.git.christophe.jaillet@wanadoo.fr>
 <20240318032133.GA1312783@maili.marvell.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240318032133.GA1312783@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/03/2024 à 04:21, Ratheesh Kannoth a écrit :
> On 2024-03-16 at 15:46:10, Christophe JAILLET (christophe.jaillet@wanadoo.fr) wrote:
>> UTILITY_NAME_LENGTH is 16. So better use the former when defining the
>> 'utility_name' array. This makes the intent clearer when it is used around
>> line 260.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   net/caif/cfctrl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
>> index 8480684f2762..b6d9462f92b9 100644
>> --- a/net/caif/cfctrl.c
>> +++ b/net/caif/cfctrl.c
>> @@ -206,7 +206,7 @@ int cfctrl_linkup_request(struct cflayer *layer,
>>   	u8 tmp8;
>>   	struct cfctrl_request_info *req;
>>   	int ret;
>> -	char utility_name[16];
>> +	char utility_name[UTILITY_NAME_LENGTH];
> Reverse xmas tree.

Hi,

I'll update and repost when net-next is reopened, but honestly, looking 
at this file, changing this to reverse xmas style won't change that much 
for the overall coding style!

Moreover, as said by Dan, it is not really easy to understand the wishes 
of different maintainers. Should I have updated the lay-out, someone 
could have argued that patches should be 1 thing at a time.

CJ

> 
>>   	struct cfpkt *pkt;
>>   	struct cflayer *dn = cfctrl->serv.layer.dn;
>>
>> --
>> 2.44.0
>>
> 
> 


