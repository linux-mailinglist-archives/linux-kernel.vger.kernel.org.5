Return-Path: <linux-kernel+bounces-163220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BF8B675B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1425CB2191B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C7524C;
	Tue, 30 Apr 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl9UnBCS"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D4F1843;
	Tue, 30 Apr 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440126; cv=none; b=MBAZtWdqBPpDpAR5CLMujF80YDG5NXNjWv3WN13ymupSLjP7+87aJwYe/61TsAG5HyNU3jVsDpCcKPrQhQhkVXeANucHqcAaEgcN31tIK/D3tke9owIl8fC4Fub/9XlMYlgSdfr+GryLp10+1Zr5/P2yie0Jmj35o2RPhS2AANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440126; c=relaxed/simple;
	bh=UMqhj0rTdZLGeNTxC8kWhGYjzAOidG4Koh9u9oR661A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg/Zz1gf7ZqGz337zzaoedFD+CwMrbb1BB8zPNm7DKrOwXRGoI33tPB47ybeNRrlfwsaf77XHdNl7WFVW5sN5m+PrPjQGMzrvbbAQ6i2LXMgu/UfAmF4lK9rYKP8OA6A+cVnRse2IGw6QWUdEbimqNdIjJEJ7WdmhMGE7PVkRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl9UnBCS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5544fd07easo675402866b.0;
        Mon, 29 Apr 2024 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714440123; x=1715044923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mRqa2ovWjws7B2sIgD6E2HvQPUnrNYKW4I30w74FzA=;
        b=dl9UnBCSyO2d9lmlIVz8lGo13FUjeu8hwJAs+NPb/7EP8ZnENY/zBJaabhcvMpW4vF
         EnOQiYOlXm1r91KomcPytUbbYP0gcvKY8iQcKCVL+DHRxsqa9msoYIj/+Pdwuv3TbOBt
         yV5A/DtKo2I+EJ1Pf39SGWTkGEO3ur2WUh8j/BKoLqvz2A/BV+mNv3qQVqgPBogwTxT/
         r72eYuD53N7oNZ4CKT661h93vfrufUXVd89+XA3StIuk5txouVegK4eSzSzxDE1wwlcy
         G/eqMmjuZBy6VezxZFdgkBTW/6qw8mR4o27COyZm85TjZImVBXkixJGyC5MHMJ6tax1A
         WIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714440123; x=1715044923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mRqa2ovWjws7B2sIgD6E2HvQPUnrNYKW4I30w74FzA=;
        b=cupgNOJ603WWju97MChP+M9dluhTvoDYImjR4wDL+jM8YcPDPvX6rrMLfKaasUutxZ
         PSK/Z2KkGQKEl7fKeP8YpXbCuMdG2ol1j44p6FUPxPmfIa1d7KbPbgsYDFtJyuDLNc6p
         s3cS38pAR2s6CfSY7EGOraQSW2UVwPJEy+XEturJeqO5w3gWv4Q9DSs9t3OA7iN0Tscg
         rY5U7XntpiIggrkMRKD0iutshL8doEVGcB6G1x/dzXuWBgmcidGbo3uZRpc5gypdl9CL
         4UVeWakvPo1HcCNUmAPD/MWBqKXyBFENVg+5Z3LAWFYuyVd1dpNfv/yDw5B4b/Ia+4gl
         HDGg==
X-Forwarded-Encrypted: i=1; AJvYcCVh0JBZh1MT2w5U0PXPoODgYmf09VDQapWgFC6lmhkZ4lDMPJBg4W1T+h03zaMdffLCegUs7y3zD7+dGnt9OTta5Y3gMvq8KHtOt+Jm2alrFp/kLjwp2iP6l7S5ZTRA9pMHEEmw
X-Gm-Message-State: AOJu0YwgIC0W330GlgZnj1UqbgQqdsYbAZ3dr8HH6iTa/mOqKKpC/b/P
	OGCvScdaacmyi1rywafO/7lL17NSnW0vcxJQRrQMSGxkMrkrrRUq
X-Google-Smtp-Source: AGHT+IFsFi0wMgKpgdlzgdLNfkp5iSSMe8elCVig3meaXHcygogd/Vsp/vWvDxyBkmV3BaICI9gqfw==
X-Received: by 2002:a17:906:c252:b0:a52:6fcb:564a with SMTP id bl18-20020a170906c25200b00a526fcb564amr788676ejb.9.1714440123077;
        Mon, 29 Apr 2024 18:22:03 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d70a:9c00::b2c])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm14388210ejm.23.2024.04.29.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:22:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 04:21:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Message-ID: <20240430012159.rmllu5s5gcdepjnc@skbuf>
References: <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
 <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
 <651c87fc-1f21-4153-bade-2dad048eecbd@gmail.com>
 <20240405211502.q5gfwcwyhkm6w7xy@skbuf>
 <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f385946-84d0-499c-9bf6-90ef65918356@gmail.com>

On Mon, Apr 29, 2024 at 04:14:03PM -0400, Joseph Huang wrote:
> How about the following syntax? I think it satisfies all the "not breaking
> existing behavior" requirements (new option defaults to off, and missing
> user space netlink attributes does not change the existing behavior):
> 
> mcast_flood off
>   all off
> mcast_flood off mcast_flood_rfc4541 off
>   all off
> mcast_flood off mcast_flood_rfc4541 on
>   224.0.0.X and ff02::1 on, the rest off
> mcast_flood on
>   all on
> mcast_flood on mcast_flood_rfc4541 off
>   all on (mcast_flood on overrides mcast_flood_rfc4541)
> mcast_flood on mcast_flood_rfc4541 on
>   all on
> mcast_flood_rfc4541 off
>   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
> specified first)
> mcast_flood_rfc4541 on
>   invalid (mcast_flood_rfc4541 is only valid if mcast_flood [on | off] is
> specified first)

A bridge port defaults to having BR_MCAST_FLOOD set - see new_nbp().
Netlink attributes are only there to _change_ the state of properties in
the kernel. They don't need to be specified by user space if there's
nothing to be changed. "Only valid if another netlink attribute comes
first" makes no sense. You can alter 2 bridge port flags as part of the
same netlink message, or as part of different netlink messages (sent
over sockets of other processes).

> 
> Think of mcast_flood_rfc4541 like a pet door if you will.

Ultimately, as far as I see it, both the OR-based and the AND-based UAPI
addition could be made to work in a way that's perhaps similarly backwards
compatible. It needs to be worked out with the bridge maintainers. Given
that I'm not doing great with my spare time, I will take a back seat on
that.

However, what I don't quite understand in your proposal is how many IPv4
addresses lie beyond the "224.0.0.X" notation? 256? Explain why there is
such a large discrepancy in the number of IPv4 addresses you are in
control of (256), vs only 1 IPv6 address with the new rfc4541 flag?

