Return-Path: <linux-kernel+bounces-94132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA746873A61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEB11C23C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC8C13664D;
	Wed,  6 Mar 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldW3/d+X"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08B8134724;
	Wed,  6 Mar 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737796; cv=none; b=joaB+apIFWULtiZzurOjbXw+rdNv0zRgUMSRL/iE/SvneMJyNZ71f8x0QnppepLoMLnygLUQ6Ds9jWLP98/Qo81EzeBugoJcllvWjNqpreCb/mRLHd/HWvRv/hFH473DoGY6hSwuG9hExGLrbQuBereBk4oDA3vDxqvNjWLLemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737796; c=relaxed/simple;
	bh=qBVex3xnygMUKs/9MpPs3xSIv7C42UXA+0WO0Hejv+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7k/wrIm9/8S1XHqT5YZHeqLfGfMyG83lM3Hkch7D34qXxZ4YoRltAcw9WsZ3Z09srVmMHrv1Qnf8WhSYoB/4tijjUS7JcSk2q1vek1wAkC3izgGLBjxjO6LE0E+O4DQCRBX0OYHt8eejvFMMgjhRUwuEIBvr4e6S+w+fS/9J9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldW3/d+X; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4499ef8b5aso565291066b.0;
        Wed, 06 Mar 2024 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709737793; x=1710342593; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qBVex3xnygMUKs/9MpPs3xSIv7C42UXA+0WO0Hejv+E=;
        b=ldW3/d+XPL49loQCHsgIeiDLoMygl7gifDNNybXoL2yXQbw8qABTMp4nVBU98HIWQ5
         xL83ptUtnGb1nH797Ij4hDVwuzuJfzqNJaMvAgVwT4/8cC/HJWjorXHa7nSCyT5dIFEO
         fMrg8df+XN2XF183Kh4/gGUM2ENNKeaDVVBPq8Cf/ALHCctHhvFt9xW/+zjixrcaYBsi
         QrxoN8NxQ8uSktPgxqIwqKcXd+4fbR9NigMPnEI1Ho+lVpnfDVHUJ6MDhQ12Kit0BI9t
         kERbRqzTI58vUt/W7FIfFuj5UXed5GGt0XdlFVRtjwe9YV3nUdBeochiKSjyRNThz/Ra
         dQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709737793; x=1710342593;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBVex3xnygMUKs/9MpPs3xSIv7C42UXA+0WO0Hejv+E=;
        b=TYk5igY9qUJ68T0noSN4Gozcf+i1dNvgz4iuPG+BqGGc3n/waKmfGyjkyTMskYDo1/
         huksDiv8CoEOy3VO3YsIklpMy2PctV9Hw+Cc/t3GaUmRqMBQPKKJRwBCdoR1WPJGyofn
         ouIS8P1xXBrDLLJj5sg61a7Ufz36M343Nh48EikTU9pdzLTtINMJ6RGaKFNM3b4Y7vLu
         eAWdWzltlibbfZH74yBwZ8q91CeLrL/LZmHfnUkgvmmPJvREQHW44DA435EJQ7oBje8B
         dKprvSe9eAiL5sZqBaJA30XMRYaBnVynT3iPTLz0qWvTsvKR+rKx3rUYYdUvU7t5bkGO
         cTqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNKmM1GoXmLudIvtXe5K4ZP1XW8AKVyG7Iy/Me49XzRM5KTb1SP9AsR7+H94WLdV9o3guGxDIo/YqTBH8JF2oEEhxv1PPApWVraYBYT9d3mZvEF/2dKy7+4fUhJi7/2XW1D4sjCiFKLoEOzblCEnsShNfkg7J27JvBt0YizEmWEA==
X-Gm-Message-State: AOJu0YzlZ9BXjnq2FVHR/OrTYfyIJHIwEyUNL/thpPHtOH5jJQKJoCtS
	9yPPaTYH5uTc/3XKYBUBpPEUlCNgUpt12l/Ndg98dCCpC9AIrVB0
X-Google-Smtp-Source: AGHT+IHIzvdxGlBv9QyWnuOL+U+llhm3Q5ESAssmDaQ1Ta8U9GagCoxWqbGDB/Xeq+DxAHHqUD2V1Q==
X-Received: by 2002:a17:906:6813:b0:a43:49ca:2473 with SMTP id k19-20020a170906681300b00a4349ca2473mr10710219ejr.0.1709737790430;
        Wed, 06 Mar 2024 07:09:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906669800b00a44ce07ad77sm5227476ejo.166.2024.03.06.07.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:09:50 -0800 (PST)
Message-ID: <f42ceee61ddb8b50c347589649d4131476ab5d81.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Frank
 Rowand <frowand.list@gmail.com>, Saravana Kannan <saravanak@google.com>,
 Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Wed, 06 Mar 2024 16:13:15 +0100
In-Reply-To: <20240306160101.25b45335@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-2-herve.codina@bootlin.com>
	 <1fff8742a13c28dd7e1dda47ad2d6fa8e21e421e.camel@gmail.com>
	 <CAJZ5v0gWCo9nDAHkzeD08tTKoE0DE0ocht-Qq4zA7P59y9KeuQ@mail.gmail.com>
	 <ed442b6916016b3a40782dc32538fc517715db6c.camel@gmail.com>
	 <CAJZ5v0iQNEj6e_L1=uBTPaWn7BqV4pnoWxUq7LRPe5iVWsaifw@mail.gmail.com>
	 <ec7705f410bc848e79b8ab878b5fbf7618d9456d.camel@gmail.com>
	 <CAJZ5v0iMUOJmm99H6SgfP9179hBsLdyC+1ixJwBxSP0b18V6XA@mail.gmail.com>
	 <86a0f91675197a00bbd921d6e57d2f3c57796e68.camel@gmail.com>
	 <20240306160101.25b45335@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 16:01 +0100, Herve Codina wrote:
> Hi Nuno,
>=20
> On Wed, 06 Mar 2024 15:50:44 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> ...
> > > > > >=20
> > > > > > That makes sense but then the only thing I still don't fully ge=
t is
> > > > > > why
> > > > > > we
> > > > > > have
> > > > > > a separate devlink_class_init() initcall for registering the de=
vlink
> > > > > > class
> > > > > > (which can also fail)...=C2=A0=20
> > > > >=20
> > > > > Well, I haven't added it. :-)
> > > > > =C2=A0=20
> > > > > > What I take from the above is that we should fail the
> > > > > > driver model if one of it's fundamental components fails so I w=
ould
> > > > > > say
> > > > > > we
> > > > > > should merge devlink_class_init() with device_init() otherwise =
it's
> > > > > > a
> > > > > > bit
> > > > > > confusing (at least to me) and gives the idea that it's ok for =
the
> > > > > > driver
> > > > > > model
> > > > > > to exist without the links (unless I'm missing some other reaso=
n for
> > > > > > the
> > > > > > devlink
> > > > > > init function).=C2=A0=20
> > > > >=20
> > > > > +1
> > > > >=20
> > > > > Feel free to send a patch along these lines, chances are that it =
will
> > > > > be popular. ;-)=C2=A0=20
> > > >=20
> > > > I was actually thinking about that but I think I encountered the re=
ason
> > > > why
> > > > we
> > > > have it like this... devices_init() is called from driver_init() an=
d
> > > > there
> > > > we
> > > > have:
> > > >=20
> > > > ...
> > > >=20
> > > > devices_init();
> > > > buses_init();
> > > > classes_init();
> > > >=20
> > > > ...
> > > >=20
> > > > So classes are initialized after devices which means we can't reall=
y do
> > > > class_register(&devlink_class) from devices_init(). Unless, of cour=
se,
> > > > we
> > > > re-
> > > > order things in driver_init() but that would be a questionable chan=
ge at
> > > > the
> > > > very least.
> > > >=20
> > > > So, while I agree with what you've said, I'm still not sure if mixi=
ng
> > > > devlink
> > > > stuff between devices_init() and devlink_class_init() is the best t=
hing
> > > > to
> > > > do
> > > > given that we already have the case where devlink_class_init() can =
fail
> > > > while
> > > > the driver model is up.=C2=A0=20
> > >=20
> > > So why don't you make devlink_class_init() do a BUG() on failure
> > > instead of returning an error?=C2=A0 IMO crashing early is better tha=
n
> > > crashing later or otherwise failing in a subtle way due to a missed
> > > dependency.=C2=A0=20
> >=20
> > Well, I do agree with that... Maybe that's something that Herve can sne=
ak in
> > this patch? Otherwise, I can later (after this one is applied) send a p=
atch
> > for
> > it.
>=20
> Well, I don't thing that this have to be part of this current series.
> It is an other topic and should be handled out of this current series.
>=20

Yeah, fair enough... IMHO, then I would say that we should still have the
workqueue moved to devlink_class_init() and I can then follow up with a pat=
ch to
do BUG_ON(ret) in it.

Alternatively I can also just move it in the follow up patch but I don't th=
ink
it makes much sense.

- Nuno S=C3=A1


