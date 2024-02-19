Return-Path: <linux-kernel+bounces-71050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD77F85A002
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB4E280C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E724B4A;
	Mon, 19 Feb 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1APkzwv"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8F23741;
	Mon, 19 Feb 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335724; cv=none; b=G9toGc3iUm8ueRuDvAc1l2mJyrCK2MxQFCtYY6d9C4cK6BiB5l+pwZ6x04sQoKZcpBPMWmRatduNyAVD2FyREv5lxKgnMq5r0m+eqssLk7HhM6nFH8d0V/RVOJKZtnVeSMsC6nULBSBOnLKvXwUK7ajN3fzJzOlWYBPsmqze/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335724; c=relaxed/simple;
	bh=spE386tCgWhvgTdYGVNL2rT5soI42ISiMPpiiaW6FPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwl7AbDu9e2Csj9bTcAOTavZ3WJfsaSpWXEi3ZOoka6loHDMC/Gs8EFsAR4K6bw/IAlaF+vI5er0k2dMXIUnex3wjptot5wwsUf4I6Do0TGvaLjdhHeD6bv3q13eOT8N81SFoh6VKKPHtt8bhjkWa8xtLuMqTW4/UTGMxJWgH/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1APkzwv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4280f3ec702so15198281cf.0;
        Mon, 19 Feb 2024 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708335721; x=1708940521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=spE386tCgWhvgTdYGVNL2rT5soI42ISiMPpiiaW6FPA=;
        b=C1APkzwvSbtgkU49/9VCUyBC98R17T1q51GoqezgPUYxhxFwSe16Kb2v1ZXC3EgTt1
         V8XLwrzZR5+E2LOF9XHgQz0m/GFHpzKI4EVJ9MLxzwClzVd3Az0Ss4QwWZzJ3b8F/AlP
         AA67cucPz0n90MnsNDrpEF3CfjmKv9Od4bHdVtn4If/KBYWCcOMTXZ55RIsl8sv6DlXa
         Y4OKMqido6nJ38pl9UuUOBYw3SPmYMz9PpbOaqKio3G772dlFwx2jotvnE68L+4QHAuM
         cDGcbvv6om/IZ7eLqsxCAatVsvPnG38T+HstE1rOVk/xlxXouwtMse21ltGl+zHtDyxS
         po8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708335721; x=1708940521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spE386tCgWhvgTdYGVNL2rT5soI42ISiMPpiiaW6FPA=;
        b=S0OZzxO2gsP2IC7lx1XG7Sacr8dg3mT09jTm5ECbpSGEQDD67SiVojNhKikibj7upf
         6FwI95ciklk1O99Af8Go+ZonB8BUnWteUZ9hYjwoOvWzVb/Guw5U3yIBiT1EYLNgzuXn
         4VOU9VrE5Q2VXnyeHFqHhquOLPN/0GC5FZMmus7boVSVpZUfrt/BK9aBXPIFwY61DCSu
         LgXJs+aNMKMoj/5kRj8sjDplkHxgiBV29QebHNW0V15Y/EwGLX3U6KBdCFMYNJ3Dwd2B
         RXfZrBzFOSszm1CEy5tEOgD5870nclcj0yvLW6EcwXUGm0WjrpFUe1ZZvwMaz7ivwz8T
         I8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgAvTZpDxpuPErtYjWowbjPHz/FoBEnnPD1MKZ9PZNg6x3eqEfxSMnBli3CuWmavsm+jGYRdHrtXu62Xw9dIWiOLUfRwqQEMG4Xzel+8DXoKHeDwrCZ7XRk9qx1Bns2aUAhM2yajVo
X-Gm-Message-State: AOJu0YwqBklmPA2Py3f99X//j5xQ8pj4UzXg6DwBWxqYww8Z49HXS+2A
	SQy9u0bB9mrgDDXiL5SR+BhX9O5fCG64+SAfzpktebk09/I6IqTPLtANjL115aQNjCcb6YEZb57
	AmLiJW8HRGbTssfSMKYL8v7pjcY1Kt8YVwFLNh/ei80U=
X-Google-Smtp-Source: AGHT+IGfXodldzainrkR4+f4nu8asp/vu8X13BCODwMeGf1LNvy2gBqmgH8OGTFP8YhYN53wL8aV0VtCEIkI1GGCz7U=
X-Received: by 2002:a05:6214:3002:b0:68e:ecdc:1123 with SMTP id
 ke2-20020a056214300200b0068eecdc1123mr13478570qvb.2.1708335721301; Mon, 19
 Feb 2024 01:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com> <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com> <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com> <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
In-Reply-To: <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 19 Feb 2024 14:41:49 +0500
Message-ID: <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_wha?=
	=?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_t?=
	=?UTF-8?Q?ime_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c7?=
	=?UTF-8?Q?5849406c?=
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d3795f0611b8e785"

--000000000000d3795f0611b8e785
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:42=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 8.2.2024 12.32, Mikhail Gavrilov wrote:
> > On Thu, Feb 8, 2024 at 2:23=E2=80=AFPM Mathias Nyman
> > <mathias.nyman@linux.intel.com> wrote:
> >>
> >> My guess is that CPU0 spends more time with interrupts disabled than o=
ther CPUs.
> >> Either because it's handling interrupts from some other hardware, or r=
unning
> >> code that disables interrupts (for example kernel code inside spin_loc=
k_irq),
> >> and thus not able to handle network adapter interrupts at the same rat=
e as CPU23
> >>
> >
> > Can this be fixed?
>
> Not sure, I'm not that familiar with this area.
> Maybe running irqbalance could help?

I installed irqbalance daemon and nothing changed.
So who is responsible for irq balancing?

--=20
Best Regards,
Mike Gavrilov.

--000000000000d3795f0611b8e785
Content-Type: application/zip; name="measuaments-irqbalance.zip"
Content-Disposition: attachment; filename="measuaments-irqbalance.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_lssqytc90>
X-Attachment-Id: f_lssqytc90

UEsDBBQACAAIAOB0U1gAAAAAAAAAAIAXAAAaACAAbWVhc3VhbWVudHMtaXJxYmFsYW5jZS50eHRV
VA0AB7Uh02W1IdNl9SHTZXV4CwABBOgDAAAE6AMAAO1Y3W7bNhS+51OctZebKJL6sS1gwBZnA4w1
g5F0w4AiGBjqxCEsUxpJJ3VR7HIPsEfckwyS5VJOk63uCqxN+vnCn4/P+Q7JQ4oUn4KSHuLG1irW
xqO168Y7eA0Liw1E38ETNA1PHXs9nf/EnhAYoLUEygMVgSaBpoFmgeaBjgIdBzoZpGCB8kBFoEmg
aaBZoHmgo0DHgU5CL0I2EbKJkE2EbCJkEyGbCNlEyCZCNhGyJSFb0mcjAOO06Ls/4rv2tPhMPyCd
nUbz6Sw6OZv9EjHGWMGwYIx2TizCcoFb134lEFvX/huHqjaltJvoxsHvT6E0l6CN87KqQNvfLmQl
jULyTDoPK/SylF4Cvmy0lV7XBtQVqmUBrOBJwSYgFzXUBk5qA3wC3+MFCCZSYKIQvBApzE/gS5ZR
cowNmhKN0ujAoquraywp+fpRgcBcqqXc1eUgfGvVlfao/NoeEP4zWtdW7X1xik3ttK/t5rC4M/0K
H1txZ9tVpM2iIIOldOiQvxznv+bpOzjuQRScTqiIUnqpUvYOAbdg5c2VLg+fmOkYloQ8t9I4qboH
xNl6tZJ280irD8B3i5yQ57WXFZT1jalqWYLTr7DYjljvjTvjuDM68FfaQb2EF5v4x/MCNuS4D9Zm
sdN1BQmzKxqWnW7nDrXN6vAZ8P9BZByWR3F7eutG56iztvtZN5FJ9KjQz5oHgyS/p7jb0yI5XRvT
zm4/eIZ0h4y9p0pnAbdWCrFsTw53hXl0fi+qNfxLEAGYW2ykbe09ivt78ymDx7w9m4d9qrcXg90q
2t9I6PvtRh8F+u7uau6U1Y2v0D/k7k4tSt/uKptVpc0SYvQqdhvncVX23/FqXXkdrR1a6qVdoKc3
0ngXh1GhDu21Vgh//fEnxGtn40pf3JZ5250SEja2gsDDHOd7QMi0XjUVevzi7hetz/cVn8J9BWcs
2Y3Ex/Om/zDoB7mv0A3aywQiBY3Vq62dVrWSFUQeMogayBhjEM2Bk2ltDCrfbfk1XNXOvxX1FTS1
9V0MeQGQncNWjE8E5fmYcsoT1vuMcp6C2mpi2UoGr0m+JzQ7PodZu86v985y3eHkEm3340h7K314
5zpFbwGmN6bsWwLAKGMRp91B2KFqr9NoBidHG48OAHLG4ORCexd3f/YDnowS+GHn0uKNXKsUiYFc
ntM8yGXZ5CC5VilKhnJjygZyo7tal3J+j1yrFKVDuRFNB3J5dpBcqxRl+3JiKJfeJZewW3IRHPj5
D9Xfr/uw7ZCkw7aPkjva/gauvWr7R7FkMhyIW1Xfh0WF+hotId3Sg+PaICV/A1BLBwhm+Kv62AMA
AIAXAABQSwECFAMUAAgACADgdFNYZvir+tgDAACAFwAAGgAgAAAAAAAAAAAApIEAAAAAbWVhc3Vh
bWVudHMtaXJxYmFsYW5jZS50eHRVVA0AB7Uh02W1IdNl9SHTZXV4CwABBOgDAAAE6AMAAFBLBQYA
AAAAAQABAGgAAABABAAAAAA=
--000000000000d3795f0611b8e785--

