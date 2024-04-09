Return-Path: <linux-kernel+bounces-136928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8489DA00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1843283482
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1C12F38C;
	Tue,  9 Apr 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="m/7BQlwH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697A78175E;
	Tue,  9 Apr 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668885; cv=none; b=eeHKuSVZFFf7pICPbAGADuWI3g3G6EJyutywAlGUFwLvWYhapuOCGxvWYWpIZ61ZbvgJWmied+yM7AnOL3uqeH1NLkHVrpkmaOh1/P41UkBQNib0t57gfku9DLPQjAisR6ubHgT2/p74FzLEQ7UFkJ58DkD2TqckSTL9n1D+Blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668885; c=relaxed/simple;
	bh=+d2BOCUd0ebFCs99YmQIURG9qs3Tl6AOpmQ6gm+Q00M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlfRPnPlLbXPTxvznA16va+QlEudi2blWaR0AHq/LwCJestU72ZCuFviPVeSZSzdoYIZMEnzGcdadYCYgTlZEV3i+yWJUyn47b1w3AvSu7iGA9CJgNWuNKbFOPJknj6mTaVnqThz9PVZQb/i9Y6W6zcahYlckADJSPxOmiVHO78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=m/7BQlwH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712668884; x=1744204884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+d2BOCUd0ebFCs99YmQIURG9qs3Tl6AOpmQ6gm+Q00M=;
  b=m/7BQlwHeXj8N03SKkW683M0xs4NQ+oEEu3ZikGsQVwnDEq4mNaKZ3JW
   pk/VeLVyuUnGLxiO2aAp+GJ0CtSb2qe18il09JazY7Pq3ohMEBVynt9+M
   iP2FIQgE5nndzdJAzqKugphERBFtCZwn8tfVUYohJte6AFnUcTYkKe9uW
   fTSazvB77rGSD10yf75r0KaFTWqOlPq3VYncvkelrrHUcmuHb9pFA+wXy
   A35E60Q/+wrePe2ZFhiS+I2aECUcXxBG4SpczZC/7JS+7MU6IAgV3WHDS
   /9Is7ollbqtjvoMHmUamKBihGzGXu4JlAC9u3/Ph61MwvTZdcNd3xXfRK
   Q==;
X-CSE-ConnectionGUID: 4u0sR9+kRH2p6uXBRTNgRQ==
X-CSE-MsgGUID: 4ejcv+uLRd6CbWIvbWcoaQ==
X-IronPort-AV: E=Sophos;i="6.07,189,1708412400"; 
   d="scan'208";a="20192869"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 06:21:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 06:20:48 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 9 Apr 2024 06:20:44 -0700
Date: Tue, 9 Apr 2024 13:20:43 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: Steen Hegelund <Steen.Hegelund@microchip.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: sparx5: flower: fix fragment flags handling
Message-ID: <20240409132043.gaf5heor5vx42j3j@DEN-DL-M70577>
References: <20240408172738.96447-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240408172738.96447-1-ast@fiberby.net>

> I noticed that only 3 out of the 4 input bits were used,
> mt.key->flags & FLOW_DIS_IS_FRAGMENT was never checked.
> 
> In order to avoid a complicated maze, I converted it to
> use a 16 byte mapping table.
> 
> As shown in the table below the old heuristics doesn't
> always do the right thing, ie. when FLOW_DIS_IS_FRAGMENT=1/1
> then it used to only match follow-up fragment packets.
> 
> Here are all the combinations, and their resulting new/old
> VCAP key/mask filter:
> 
>   /- FLOW_DIS_IS_FRAGMENT (key/mask)
>   |    /- FLOW_DIS_FIRST_FRAG (key/mask)
>   |    |    /-- new VCAP fragment (key/mask)
>   v    v    v    v- old VCAP fragment (key/mask)
> 
>  0/0  0/0  -/-  -/-     impossible (due to entry cond. on mask)
>  0/0  0/1  -/-  0/3 !!  invalid (can't match non-fragment + follow-up frag)
>  0/0  1/0  -/-  -/-     impossible (key > mask)
>  0/0  1/1  1/3  1/3     first fragment
> 
>  0/1  0/0  0/3  3/3 !!  not fragmented
>  0/1  0/1  0/3  3/3 !!  not fragmented (+ not first fragment)
>  0/1  1/0  -/-  -/-     impossible (key > mask)
>  0/1  1/1  -/-  1/3 !!  invalid (non-fragment and first frag)
> 
>  1/0  0/0  -/-  -/-     impossible (key > mask)
>  1/0  0/1  -/-  -/-     impossible (key > mask)
>  1/0  1/0  -/-  -/-     impossible (key > mask)
>  1/0  1/1  -/-  -/-     impossible (key > mask)
> 
>  1/1  0/0  1/1  3/3 !!  some fragment
>  1/1  0/1  3/3  3/3     follow-up fragment
>  1/1  1/0  -/-  -/-     impossible (key > mask)
>  1/1  1/1  1/3  1/3     first fragment
> 
> In the datasheet the VCAP fragment values are documented as:
>  0 = no fragment
>  1 = initial fragment
>  2 = suspicious fragment
>  3 = valid follow-up fragment
> 
> Result: 3 combinations match the old behavior,
>         3 combinations have been corrected,
>         2 combinations are now invalid, and fail,
>         8 combinations are impossible.
> 
> It should now be aligned with how FLOW_DIS_IS_FRAGMENT
> and FLOW_DIS_FIRST_FRAG is set in __skb_flow_dissect() in
> net/core/flow_dissector.c
> 
> Since the VCAP fragment values are not a bitfield, we have
> to ignore the suspicious fragment value, eg. when matching
> on any kind of fragment with FLOW_DIS_IS_FRAGMENT=1/1.
> 
> Only compile tested, and logic tested in userspace, as I
> unfortunately don't have access to this switch chip (yet).

Ran VCAP test-suites - seems good. Thanks!

Tested-by: Daniel Machon <daniel.machon@microchip.com> 

 

