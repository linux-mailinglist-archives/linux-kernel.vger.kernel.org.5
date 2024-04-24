Return-Path: <linux-kernel+bounces-156088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7105C8AFDC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E7DB243FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CAF748A;
	Wed, 24 Apr 2024 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R18UYbfH"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E75695;
	Wed, 24 Apr 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921894; cv=none; b=NJpjG2sOFXznpg/RkhslPKC8J1P0Lnhw/Zqen9PxEHiv/C/30M/Ah5IZWpfn1cSw1wARx1peahjpgAaFxuOzTp61onH2CMfW6hyEAtaLZQwvl+KAG4hVAHFtDhPIPmbHUJgk53BbhUZuNuwonOrLcGapOznSL7lSJT4650gdJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921894; c=relaxed/simple;
	bh=g2euHgv+u1HrhsRlYkjqccKAEn+4TDFzMWh6/w2TmZ0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AMxeE+OKO2JxFjAE0QT5Uixa1p4GheMfeURL73jk7J7/MdHLPP52YVezveCBcEWB9rA+Rh3cEL/oA4NEI8XQvgZOxEXnWYSP0bD3w6k2Vkwbq1EuAwfXMc+9MYEhxru211uo8RmA30I9924UroXjbJUemfksUdwLebUQFB9ZasQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R18UYbfH; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-615019cd427so50865907b3.3;
        Tue, 23 Apr 2024 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713921892; x=1714526692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2euHgv+u1HrhsRlYkjqccKAEn+4TDFzMWh6/w2TmZ0=;
        b=R18UYbfHTNPvvZ6dVkuMofYdzTljjrrcP3O+todHqthzNhvKmgZnhz90NRDKW0mL0x
         h3d77joaYfr7ie4ZBpynvp+4VM2ZM/ugboOfEkc9BoCYGP4SFAWKMdWh1yUdp1wDBku+
         vkNJuZrBe0TgAMb87GIjvuILhw6aLEyPHrIyT1AxeDja5H6/OjnxflsgpeBBHYo+4h8T
         SOFCKYZYy95uKmvEnKR4rlEC3bMtYpD0gkZ7H0iH/XLga8Z0Olb18sWq2Gfh9qLMnfhl
         CkmpXymmLPzJF5z5FccKg+WluI41qikNca2xdjKz77Vg4r49TQvrgC1q+iex8F57VBUN
         Liog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713921892; x=1714526692;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g2euHgv+u1HrhsRlYkjqccKAEn+4TDFzMWh6/w2TmZ0=;
        b=oV9k4LXQnLcj9+DCOXtO1SyDIyjVupyknlk+tULCvRr+fUida5Lb9JThCdqQuSbBkd
         WL5GaNcbqdczCCiFrk6m6yvlvowICSzlH0Dw09Wb7ESRaLBDA9Nl8suIBQCw8Ky67fF3
         Pv+qc67KOWWo1AjBHr/DATNDn1pfiimiQJ/qAgvec1t3aH0mBvwpEP+armsxYdScTKke
         NbkVkcBh30pQYu5WMgErcw9eaMiziEBpy4YjDBW9vWlk7+jwWm7BXI0gfQiE4wXEeFf0
         amAyGMyNgaOhx1bIO11U8ft+MhA7MCESADaVD+1tNHjZOKd0TZyWqOWCucfnt9HPQL2a
         Ba4g==
X-Forwarded-Encrypted: i=1; AJvYcCW7Z14Ebe2sfWBwJ2di/iudug6lKXcJmNqeF9NJuWxh9jBjyBWcEMB4ZY7B4Qyd/O7ZD5K8nSlgHL8CgMP+LcqHMVuh6Am5ytQVgIlS
X-Gm-Message-State: AOJu0YzpRoINHHgRqBGy1eDXdDgobGHzw0dLdlwCjI40a9YN2Xy9EEx6
	OzjO9GlYJaoYrDcM9I208j1R7C8JGZ5Yvg7J2CHY/wYFJxO7+FiU
X-Google-Smtp-Source: AGHT+IFlOTIokBwIIGQQn7gMAI89XHKSgpOr9CpuGazblPnQR5r3xgr40lSSWK3gZaSorqqSdupmmw==
X-Received: by 2002:a05:690c:6f0f:b0:61b:12:a587 with SMTP id jd15-20020a05690c6f0f00b0061b0012a587mr1294230ywb.3.1713921892021;
        Tue, 23 Apr 2024 18:24:52 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id f12-20020ac8498c000000b0043496744c5dsm5662122qtq.52.2024.04.23.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 18:24:51 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:24:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <66285f637bdec_1924cc2941b@willemb.c.googlers.com.notmuch>
In-Reply-To: <328ab7b3-4890-4e0d-8b9a-fed7700f1a6a@nbd.name>
References: <20240423094117.93206-1-nbd@nbd.name>
 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
 <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
 <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
 <97f10c8b5b615eac8f65d67ef10928d97b6b760d.camel@redhat.com>
 <328ab7b3-4890-4e0d-8b9a-fed7700f1a6a@nbd.name>
Subject: Re: [RFC] net: add TCP fraglist GRO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Felix Fietkau wrote:
> On 23.04.24 16:34, Paolo Abeni wrote:
> > On Tue, 2024-04-23 at 14:23 +0200, Felix Fietkau wrote:
> >> On 23.04.24 14:11, Eric Dumazet wrote:
> >> > On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.nam=
e> wrote:
> >> > > =

> >> > > In the world of consumer-grade WiFi devices, there are a lot of =
chipsets
> >> > > with limited or nonexistent SG support, and very limited checksu=
m
> >> > > offload capabilities on Ethernet. The WiFi side of these devices=
 is
> >> > > often even worse. I think fraglist GRO is a decent fallback for =
the
> >> > > inevitable corner cases.
> >> > =

> >> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST=
_GRO already ?
> >> > =

> >> > Many of these devices are probably using NAT.
> >> =

> >> In my tests, nftables NAT works just fine, both with and without =

> >> flowtable offloading. I didn't see anything in netfilter that would =
have =

> >> a problem with this.
> > =

> > I see you handle explicitly NAT changes in __tcpv4_gso_segment_csum()=
,
> > like the current UDP code.
> > =

> > The TCP header has many other fields that could be updated affecting
> > the TCP csum.
> > Handling every possible mutation looks cumbersome and will likely
> > reduce the performance benefits.
> > =

> > What is your plan WRT other TCP header fields update?
> =

> I think that should be easy enough to handle. My patch already only =

> combines packets where tcp_flag_word(th) is identical. So when =

> segmenting, I could handle all flags changes with a single =

> inet_proto_csum_replace4 call.
> =

> > Strictly WRT the patch, I guess it deserves to be split in series,
> > moving UDP helpers in common code and possibly factoring out more
> > helpers with separate patches.
> Will do.

A significant chunk of the complexity is in the
tcp[46]_check_fraglist_gro sk match. Is this heuristic worth the
complexity?

It seems that the platforms that will enable NETIF_F_FRAGLIST will
be mainly forwarding planes.

If keeping, this refinement can probably a separate follow-on patch in
the series too:

- refactor existing udp code
- add segmentation support to handle such packets on tx
- add coalescing support that starts building such packets on rx
- refine coalescing choice

> > e.g. in __tcpv4_gso_segment_csum() is quite similar
> > __udpv4_gso_segment_csum() - even too much, as the tcp csum should be=

> > always be updated when the ports or addresses change ;)
> =

> Will fix that.
> =

> Thanks,
> =

> - Felix



