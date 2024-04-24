Return-Path: <linux-kernel+bounces-157076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA6E8B0C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94520288B84
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528D1E52C;
	Wed, 24 Apr 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/juaEK6"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4F1E536;
	Wed, 24 Apr 2024 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969026; cv=none; b=jiqvSI0KNoe87aaYP4XjuHnyOJqyTaeRuJtsavxY1J7toOw0kYLWhCU0zskeiYDvnTL4CEpZ4123S/ezZ6/iao3RGuqtV2KLBHJNWbT96dSeGYdyKX6L0kg8JuLy9ElKe+xab1ekRtVSmPDcLYzByAsB8rflMRTOAnok2qR3fIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969026; c=relaxed/simple;
	bh=I7g1GEThsmk5aqInc5zQLzj8WAnvS4+ZZw2tZoY6rKE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YcdyeGoOCQwEcZtPnQ5q+c/aoPOjUC8806F8NV3HcNsnG8bcHY+BnJUtJHaDkFxmLfCVoxBJexdWby8WVsFxJVR5PwzcHlHjiW2eX/rzCe9BwhkjNHmB76wRsR9VJTBnRVuP2Yyr1/qnpwUr5ZHL7kl1UgyutlsBfwUYvGecC6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/juaEK6; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4396b83b10dso25502381cf.1;
        Wed, 24 Apr 2024 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713969024; x=1714573824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7g1GEThsmk5aqInc5zQLzj8WAnvS4+ZZw2tZoY6rKE=;
        b=b/juaEK6DnUBx0AZNxzjfgXx4CV0d3KjoLDPY8N85gZQCO0+0pzi9IfXIllejggGOq
         YEVsbafFZkMnndPH9PKYJlg6j/SqPNN40YUUMumka4TkmNlpgRcWxeRrrjmJ8/QPB4Tw
         kdvfTbqCY7ZMPXNC0p8Z5BEv8PhztLtBfrDRSwwP3KLSxLkG/2OYrMOs27pn6TgoPiSv
         VVXDR/VnrYxc5fmENiAO+4gpYQo8m+1u31aYBbpY60iCjm1v/jIuZ77fia8ohpfjJFOo
         GztNFpMuv2Cg1lDWWI9vQRqk8WL+C7R6K47oqO+a+kpHBMAFBgH2o2GVnIlFlEhhlSxr
         /xQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969024; x=1714573824;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I7g1GEThsmk5aqInc5zQLzj8WAnvS4+ZZw2tZoY6rKE=;
        b=tOU2pttJAhsU7yqazYyGarVgRk3g9EwqApTfzi7IJ0GBZBiFtaJy+sz/ez4PZKgrqO
         j4Z5qu4xL3yR3fHryQQHLhKZrRB+tdZ1B1Z4QGJhueS2agsqNEiNkkz7D9g/wv3ShgB+
         ufvpOEPoX4RW/1Ecr49PF/l+8rCHY6INM3PSG3yCN70AtNM56Rr8way2SlD3T/+cPRkW
         5ONIRxatjpMq+OiJ+F56ch9n86SLTgUW0+t5CvCix/fTVGKKCbeZuOoO2xuExsVXDf4X
         lesNSZpTVGoQN1MEfq5scvCqspXspK/JFKTWnPStBa5YCwEWh2vcqaIEx+6vDDiFWy3z
         cdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWZW/c0dYUlTVvEK69jXuXHIVFrLGMzQMrqxN8CKl9uTi71zZ8eoyCrGmUNpuCPy/f1l8uUjI/7HvNQz4Giw6nJm2hhx2xBrerY2HKK
X-Gm-Message-State: AOJu0YzDGvrehVdlmVQ8UPjLknscanhUrLK5JiI1k6Qo+joPxP6rhvlh
	SMW+5PEhXXrZ6helF8yPgu/UTuYftsKtcLsq9ZGbd0FIQ70nICaC
X-Google-Smtp-Source: AGHT+IHUiuFHB2+cDn5b3Y7bGYzFVvH4V68Fj1xnu5TWDyCa+vk5bebbv9x+JhxnMkhMyD5R0Cpb1g==
X-Received: by 2002:ac8:59c9:0:b0:437:c7c3:661b with SMTP id f9-20020ac859c9000000b00437c7c3661bmr2447086qtf.68.1713969024077;
        Wed, 24 Apr 2024 07:30:24 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id t4-20020a05622a180400b004371724f711sm6091409qtc.80.2024.04.24.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:30:23 -0700 (PDT)
Date: Wed, 24 Apr 2024 10:30:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 linux-kernel@vger.kernel.org
Message-ID: <6629177f6b4c7_1a76072949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <eb0e1eb6-306c-4cf7-922d-203db09d8d29@nbd.name>
References: <20240423094117.93206-1-nbd@nbd.name>
 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name>
 <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
 <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
 <ebe85dca-e0e9-4c55-a15d-20d340f66848@nbd.name>
 <97f10c8b5b615eac8f65d67ef10928d97b6b760d.camel@redhat.com>
 <328ab7b3-4890-4e0d-8b9a-fed7700f1a6a@nbd.name>
 <66285f637bdec_1924cc2941b@willemb.c.googlers.com.notmuch>
 <eb0e1eb6-306c-4cf7-922d-203db09d8d29@nbd.name>
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
> On 24.04.24 03:24, Willem de Bruijn wrote:
> > Felix Fietkau wrote:
> >> On 23.04.24 16:34, Paolo Abeni wrote:
> >> > On Tue, 2024-04-23 at 14:23 +0200, Felix Fietkau wrote:
> >> >> On 23.04.24 14:11, Eric Dumazet wrote:
> >> >> > On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.=
name> wrote:
> >> >> > > =

> >> >> > > In the world of consumer-grade WiFi devices, there are a lot =
of chipsets
> >> >> > > with limited or nonexistent SG support, and very limited chec=
ksum
> >> >> > > offload capabilities on Ethernet. The WiFi side of these devi=
ces is
> >> >> > > often even worse. I think fraglist GRO is a decent fallback f=
or the
> >> >> > > inevitable corner cases.
> >> >> > =

> >> >> > What about netfilter and NAT ? Are they okay with NETIF_F_FRAGL=
IST_GRO already ?
> >> >> > =

> >> >> > Many of these devices are probably using NAT.
> >> >> =

> >> >> In my tests, nftables NAT works just fine, both with and without =

> >> >> flowtable offloading. I didn't see anything in netfilter that wou=
ld have =

> >> >> a problem with this.
> >> > =

> >> > I see you handle explicitly NAT changes in __tcpv4_gso_segment_csu=
m(),
> >> > like the current UDP code.
> >> > =

> >> > The TCP header has many other fields that could be updated affecti=
ng
> >> > the TCP csum.
> >> > Handling every possible mutation looks cumbersome and will likely
> >> > reduce the performance benefits.
> >> > =

> >> > What is your plan WRT other TCP header fields update?
> >> =

> >> I think that should be easy enough to handle. My patch already only =

> >> combines packets where tcp_flag_word(th) is identical. So when =

> >> segmenting, I could handle all flags changes with a single =

> >> inet_proto_csum_replace4 call.
> >> =

> >> > Strictly WRT the patch, I guess it deserves to be split in series,=

> >> > moving UDP helpers in common code and possibly factoring out more
> >> > helpers with separate patches.
> >> Will do.
> > =

> > A significant chunk of the complexity is in the
> > tcp[46]_check_fraglist_gro sk match. Is this heuristic worth the
> > complexity?
> > =

> > It seems that the platforms that will enable NETIF_F_FRAGLIST will
> > be mainly forwarding planes.
> =

> There are people using their devices as file servers and routers at the=
 =

> same time. The heuristic helps for those cases.

Ok.

> > If keeping, this refinement can probably a separate follow-on patch i=
n
> > the series too:
> > =

> > - refactor existing udp code
> > - add segmentation support to handle such packets on tx
> > - add coalescing support that starts building such packets on rx
> > - refine coalescing choice
> I don't really understand what you're suggesting. With my patch, the GR=
O =

> code handles coalescing of packets. Segmentation on output is also =

> supported. The next version of my patch will fix the cases that were to=
o =

> similar to the UDP code, so I guess refactoring to share code doesn't =

> really make sense there.
> Am I missing something?

I mean if breaking up into a series. First have the refactoring patch
which should be easy to review to be a noop. Then add the segmentation
code, which needs to exist before packets may arrive that depend on
it. Then add the code that produces such packets. To break up into
manageable chunks.


