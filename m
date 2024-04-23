Return-Path: <linux-kernel+bounces-155570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED7E8AF40E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734BC1F22BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCCD142E69;
	Tue, 23 Apr 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Wy1Y85zC"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DE142916;
	Tue, 23 Apr 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889567; cv=none; b=bKWiX5yQ7Ow+2cr9O2vBE2TwLTHopIWgxxpHuouKOoKJjzDrlcVjRytOYmGuBcDAe7P8em3moHAlmEZUJgf4UE4u1J0C4IyT38NkOrSqR+HQ548uaxyFr5xT5ar/5uQrFoOyko55TLd2DuyaMw1qBmv/SXoOJ1C3z5G1Yph589Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889567; c=relaxed/simple;
	bh=nx7ksgUQaGN0EY1GfAjq1Qx4E1C02KxqvhGIJ2PtKp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9MlS1R1QaoM4PV9vyF65esWCvUQPbET1FX/Zco1rtjyiXF3RegeCJGNFI4VltbUnsU2nrI2Y25J4bgGIPZy6pdlONRpg1Ckqb+oBaL7ojz2pxQoW+kh0KKzQwPxLVPfwjX/LPQ3IpXplUqFyugbr7Pljdtvivmwz1hXoR+qabA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Wy1Y85zC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 78369600A7;
	Tue, 23 Apr 2024 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713889560;
	bh=nx7ksgUQaGN0EY1GfAjq1Qx4E1C02KxqvhGIJ2PtKp0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wy1Y85zCl8qjZwviFxUVjPwGHAzszgP07LuhfP0ILoq2zTbtXwMY8pUCeak4rheIZ
	 5SOWaA3EWeRE12awTASNBViXK2v201N83EGXFsjakP4SLpYdBJX0gdqedCpF91ycqt
	 ZfpZ91W1zB5mTVCDd4aEGqtnrB1NL/eSbi3PoJG5IO+IfsiO1vAAGJ2KTS0it6X4ZV
	 aBjeWoxzhl3vHnwFPhdjxRV7oVIzw7vs+bb8OBdoMkO6dg6Bc/0KDXFlxLt3lHuWMk
	 Cux21icq9SurCdgOjNlii+NFq2W24fIKkNzJZspIYTlXXYb3JygX4Kt/3XDsZKew9j
	 XABlU82rJUjQw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 9C6CD202787;
	Tue, 23 Apr 2024 16:25:53 +0000 (UTC)
Message-ID: <8e112b31-0168-4e82-a378-87211ea99cfa@fiberby.net>
Date: Tue, 23 Apr 2024 16:25:53 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: sparx5: flower: cleanup
 sparx5_tc_flower_handler_control_usage()
To: Daniel Machon <daniel.machon@microchip.com>
Cc: netdev@vger.kernel.org, Steen Hegelund <Steen.Hegelund@microchip.com>,
 Lars Povlsen <lars.povlsen@microchip.com>, UNGLinuxDriver@microchip.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
References: <20240423102728.228765-1-ast@fiberby.net>
 <20240423111515.wzvclnlxdwv77zy7@DEN-DL-M70577>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240423111515.wzvclnlxdwv77zy7@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

Thank you for the review.

On 4/23/24 11:15 AM, Daniel Machon wrote:
> Hi Asbjørn,
> 
> Thank you for your patch!
> 
>> Define extack locally, to reduce line lengths and future users.
>>
>> Only perform fragment handling, when at least one fragment flag is set.
>>
>> Remove goto, as it's only used once, and the error message is specific
>> to that context.
>>
>> Only compile tested.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
>>   .../ethernet/microchip/sparx5/sparx5_tc_flower.c    | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>> index 663571fe7b2d..d846edd77a01 100644
>> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
>> @@ -159,13 +159,14 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
>>   static int
>>   sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
>>   {
>> +       struct netlink_ext_ack *extack = st->fco->common.extack;
> 
> Could you please update the use of extack in all places inside this
> function. You are missing one place.

Good catch, sure. It must have got lost somewhere along the way. I deliberately kept it out
of the net patch, since it could wait for net-next.


>>          struct flow_match_control mt;
>>          u32 value, mask;
>>          int err = 0;
>>
>>          flow_rule_match_control(st->frule, &mt);
>>
>> -       if (mt.mask->flags) {
>> +       if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
> 
> Since these flags are used here and in the next patch, maybe assign them
> to a variable:
> 
> u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG
> 
> And update the use throughout.

In an earlier state this patch had a #define SPARX5_FLOWER_SUPPORTED_CTLFLAGS,
in the same style as nfp in drivers/net/ethernet/netronome/nfp/flower/offload.c

Right now, this driver supports all currently defined flags (which are used with mask),
so the point of using flow_rule_is_supp_control_flags() to this dirver, is to
make it possible to introduce new flags in the future, without having to update
all drivers to explicitly not support a new flag.

My problem with using supp_flags in both places is: What happens when support
for a new flag is introduced?

u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG | FLOW_DIS_NEW_FLAG;

if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG))
         /* handle fragment flags through lookup table */

if (mt.mask->flags & FLOW_DIS_NEW_FLAG)
         /* do something */

if (!flow_rule_is_supp_control_flags(supp_flags, mt.mask->flags, extack))
         return -EOPNOTSUPP;

The fragment lookup table code currently requires the above guarding,
as [0][0] in the lookup table is FRAG_INVAL, and not FRAG_SHRUG.

What do you think?

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

