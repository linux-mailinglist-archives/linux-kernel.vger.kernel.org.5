Return-Path: <linux-kernel+bounces-30286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1E831C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE68C281E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ABC28DA4;
	Thu, 18 Jan 2024 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmp1uWa1"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C51DDC6;
	Thu, 18 Jan 2024 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591869; cv=none; b=TGQRdajfSEklpld05RcSDhEynvvnz26hznAWIrk4QhR5PEaXYYqgHFMqPaYNIBHJp1ONUzbVmuMGWUaoxXaPEdQOY7BECRS0hU5jGN3GwRwD8JYhiIYrEqq8suXzQVzxy1Gz2Rz34mLJgPG2lgflmk4dltdC+L2Xo/sYb5UAnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591869; c=relaxed/simple;
	bh=l79NY2dKBoF9XTkQ1wdRVseM0jwGQtTbZVF6sXmEHUg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=q2qSJMRE5NlRR53JEtuPLbVcWEK03vn7iTpKmwGeT9VRvP6P7Z+UzNc04Yj7dsTgZ104UM0Tn73l4OI2NiRzqLRfhbRt/EfbfO3gqrXVYMrXCf+8L/JW/191EfbWJNUjbcgvl9y/ovZKMI+9XTPv+I141JLvapSBfEpUseYRwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmp1uWa1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cddb0ee311so38235121fa.0;
        Thu, 18 Jan 2024 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705591865; x=1706196665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClAFFQl72AYBcbeJb8sfymN7hdNir4YEOmgS30D5baQ=;
        b=Gmp1uWa1C/YZ/Zbt2WvqJtKhJQLxijsxmx8hYfHqPYvsvjBmIcqOMOF/71MEz0YHNp
         EPucKN0HtwS5oLowmGEuuljlBlo1P3YIk/TWktm8khco6IfSQl/NQp6O39ctP4a6+75I
         rHAzr3/I09TMExRbKrc1E0kbcHvS4Ofh+QZBKJAEbvk9ZOeGvgOp7QAeST5PBhAS/IJt
         uZdcme7E8NhUTRvUkkNxuceF6i+lHDIR/G4+n5WWzIq0ziPugpnoYNfmg6kQEz/bFYAi
         cFNSZNqY7Q/BzsoobOoLYz6UzsBnZC/H7vj/JQeBdwbsKplEOGeHcWZLhmco3TPQs1Bd
         Q23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705591865; x=1706196665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClAFFQl72AYBcbeJb8sfymN7hdNir4YEOmgS30D5baQ=;
        b=LtYU/pNS611HcZCGvj+kkeAwwSbv7jPAH3bJ1YxVHu2eLE/FdZ4I4/GXqFn5FPW/Xz
         16xtVUN3oxNgMiiK0Z11dNR5qQlErQlLV9c2sNFtP1mmxTOzw6FDoeThoFtc2PPLdvv/
         yo/EXe94ct85i0hNyPNraznT6SD8ODSPi5TLF7jxPlVI8Zw/o0jIgnOqO5bnlBoD14Cz
         SRpqIqmxT+sM9EfEHZDdz9AZl8sYF9b3s6JCUVmcp06ee6W1VOloP4usO9cHHnCFLW88
         X9Je9N/hP0PvkmJuQMbo2kmzVKuqKLh/e0IvLK8L7JntK4eKcZ1nH3aaPF9oIf05cJXd
         SBrA==
X-Gm-Message-State: AOJu0YzWUNhdA70iporOcYaE+UGUQF6tdSwLinPLWDZzRYS8xH3aD+kS
	33w8Lj9EjGu+6xl0ucAsGCf0q2cu3vMFjAIC2OryDqw5C8Zo7G5zIJrZwpaszADotPdDs4buv74
	Z01qVjnFeEVZWNZ/Mi50AI005Z238ctWrAbM=
X-Google-Smtp-Source: AGHT+IGsbx3wnyrWjOXm3YY25A2iEm2aIDxpxx8+OisUG8gtw4CKBY18wsSvaREIQJhkNkfjUX4WeruJYPCN39awfzE=
X-Received: by 2002:a2e:6e06:0:b0:2cd:df43:9539 with SMTP id
 j6-20020a2e6e06000000b002cddf439539mr247922ljc.193.1705591865219; Thu, 18 Jan
 2024 07:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com> <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com> <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
 <CABBYNZJ_EAuGEdeW+vZzXu20nVqLkLwiQbYQ9XzoABxQ5rAzdQ@mail.gmail.com> <ZajkA6oxtMcxKY4X@hovoldconsulting.com>
In-Reply-To: <ZajkA6oxtMcxKY4X@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jan 2024 10:30:50 -0500
Message-ID: <CABBYNZLV9o9hsYGVTGA7dPby-j1P_a35yNrDy4d9PMJq=TaRsQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Doug Anderson <dianders@google.com>, 
	Stephen Boyd <swboyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Thu, Jan 18, 2024 at 3:40=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Jan 17, 2024 at 05:49:07PM -0500, Luiz Augusto von Dentz wrote:
> > On Wed, Jan 10, 2024 at 3:12=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
> > > On Tue, Jan 09, 2024 at 05:54:01PM +0000, Matthias Kaehlcke wrote:
>
> > > > hciconfig
> > > > hci0:   Type: Primary  Bus: UART
> > > >         BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 24=
0:8
> > > >         UP RUNNING
> > > >         RX bytes:1700 acl:0 sco:0 events:95 errors:0
> > > >         TX bytes:128949 acl:0 sco:0 commands:578 errors:0
> > >
> > > And any user space tool overriding the address would currently need t=
o
> > > provide the address in reverse order on Qualcomm platforms like this
> > > one (e.g. if generating the address for privacy reasons).
> >
> > Perhaps we could attempt to resolve the address byteorder, in
> > userspace we use hwdb_get_company to resolve the company but since
> > this shall only really care about Qualcomm range(s) perhaps we can
> > hardcode them check in which order the address is, that said if the
> > device is configured with a Static Random Address then that would not
> > work, but that is only really possible for BLE only devices.
>
> It's not just Qualcomm ranges; The Lenovo ThinkPad X13s that I noticed
> this on has been assigned a Wistron OUI, for example.

Well we could still attempt to check if it has a valid OUI and then it
fail swap and check again.

> We're still hoping to learn how to retrieve this address (from the
> secure world firmware) so that we can set it directly from the driver,
> but for now it needs to be set using btmgmt (or the local-bd-address
> devicetree property).
>
> As was discussed here:
>
>         https://github.com/bluez/bluez/issues/107
>
> it would be useful to teach bluetoothd to (generate and) set an address
> for devices that lack (accessible) persistent storage. And any such
> generic tool would need to work using the standard interfaces and the
> address endianness that those interfaces expect.

Yep, patches are welcome in this regard, note that we do something like thi=
s:

https://github.com/bluez/bluez/blob/master/src/adapter.c#L9847

But the first thing it checks is if the controller supports BR/EDR, so
if you want to extend that we need at least the OUI portion to be able
to allocate a valid public address, we could perhaps attempt to fetch
the manufacturer somehow or use the controller manufacturer
(adapter->manufacturer) in case there is nothing else to use.

> And from skimming the Bluetooth spec, I was under the impression that
> random addresses applied also to non-BLE devices (e.g. requiring the two
> most-significants bits to be 1).

Not really, BR/EDR/classic addresses are always considered public
addresses, the HCI interface doesn't even have an address type to be
able to handle something like a random address or privacy for the same
reason.

> But to summarise, I don't really see any way around fixing the Qualcomm
> driver.
>
> Johan



--=20
Luiz Augusto von Dentz

