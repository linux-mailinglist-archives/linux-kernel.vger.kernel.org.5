Return-Path: <linux-kernel+bounces-6371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7665D8197C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155B11F261EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6CC153;
	Wed, 20 Dec 2023 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk4nIgB2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC51210E4;
	Wed, 20 Dec 2023 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42788536cddso1801151cf.2;
        Tue, 19 Dec 2023 20:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046312; x=1703651112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmdtaBqyL+TTKmGt9TVdr/9Xg5s2fXpiGZdJ9KSKVKk=;
        b=Rk4nIgB2tAHCzK1R+U5dTjL8BP+X/ZRiMaRWxc8w6RWGI3/w3NGb7QYcU56KmB0jhT
         uqcuLJ+Is7Ej36eadzzSeIrZN7w3OEHnj9IdegRLIBTBfX/156Ix58Z36KTiqvjBnKeV
         ccheOuz1p3Z7VxD6M42zGq+6cho/zK9RLjM/+8jYI5QE33h3SuxWGNbNwPzs70CpcNqQ
         6xu+5eDBbd5Xsz9BQv7dNnw7I1jwgO1yMHHMVpRbxWEGzK44GMmf10HqK/OpSgS9qM75
         LOEVyl3K+SCqBMijbIg2/3ZW0qoJeSeGFyqoVqIEFvM8KbhMGmv75B7HVR9ljpOvlaFh
         QALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046312; x=1703651112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rmdtaBqyL+TTKmGt9TVdr/9Xg5s2fXpiGZdJ9KSKVKk=;
        b=FHQNsGyA6CJSMVFzjdw9aMNorY+MqSxAp5eHBy8liXJHUWNcMe27tdjTJcHxVJlfQg
         lIEaoOYSCXLaBaIBu3HGWpJO8KgVWRyUNQzhQ/76DznWXkUXApNMGTgzb4xIOurhsG5H
         fzj1nVkckyilEOMoAAX+iWDdLqUSXF179Wh+EBxkhvsn+/rgfXIfCecizssg17xLly/y
         r02LBFYdL10zCLqDXC0bm1v4Y4QQk0HwYXq2GxCbqPPS9df9T8RNOQXiKXYmKIPtfC+A
         rKuzbrQaWKW8yPha5JUvL9+awAU6g/z1AoccBOSlO4KfEI01ZxocMxpDYQpnYGfzMOHX
         TKGg==
X-Gm-Message-State: AOJu0YwezCJsFpPgb79DCBgOHFZ3O+JVw+Irl7FhtOXFkLAw4h5qcsIA
	whD4vuNS1StpgtCdcFOuYds=
X-Google-Smtp-Source: AGHT+IGLTvjYynOwjVav8Ui6s6MVyyOYM4txTbrMGOvYl1pHF8IRUtOQeOVHuof1hW+tO6p06z9uCw==
X-Received: by 2002:a05:622a:188e:b0:427:86ad:47dd with SMTP id v14-20020a05622a188e00b0042786ad47ddmr864739qtc.16.1703046312174;
        Tue, 19 Dec 2023 20:25:12 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id hh12-20020a05622a618c00b00425f0ab0393sm6253689qtb.17.2023.12.19.20.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:25:11 -0800 (PST)
Date: Tue, 19 Dec 2023 23:25:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Wang <jasowang@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <65826ca77a39e_190a43294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <CACGkMEuuz3R5CgBpKrnBwtFP3ZxWULDMm47LhtxYYHSSUy_2fQ@mail.gmail.com>
References: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
 <65807512bc20b_805482941e@willemb.c.googlers.com.notmuch>
 <CACGkMEuuz3R5CgBpKrnBwtFP3ZxWULDMm47LhtxYYHSSUy_2fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp and
 tx-time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Wang wrote:
> On Tue, Dec 19, 2023 at 12:36=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Steffen Trumtrar wrote:
> > > This series tries to pick up the work on the virtio-net timestampin=
g
> > > feature from Willem de Bruijn.
> > >
> > > Original series
> > >     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail=
.com
> > >     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,=

> > >     tx-tstamp and tx-time
> > >     From: Willem de Bruijn <willemb@google.com>
> > >
> > >     RFC for four new features to the virtio network device:
> > >
> > >     1. pass tx flow state to host, for routing + telemetry
> > >     2. pass rx tstamp to guest, for better RTT estimation
> > >     3. pass tx tstamp to guest, idem
> > >     3. pass tx delivery time to host, for accurate pacing
> > >
> > >     All would introduce an extension to the virtio spec.
> > >
> > > The original series consisted of a hack around the DMA API, which s=
hould
> > > be fixed in this series.
> > >
> > > The changes in this series are to the driver side. For the changes =
to qemu see:
> > >     https://github.com/strumtrar/qemu/tree/v8.1.1/virtio-net-ptp
> > >
> > > Currently only virtio-net is supported. The original series used
> > > vhost-net as backend. However, the path through tun via sendmsg doe=
sn't
> > > allow us to write data back to the driver side without any hacks.
> > > Therefore use the way via plain virtio-net without vhost albeit bet=
ter
> > > performance.
> > >
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> > Thanks for picking this back up, Steffen. Nice to see that the code s=
till
> > applies mostly cleanly.
> >
> > For context: I dropped the work only because I had no real device
> > implementation. The referenced patch series to qemu changes that.
> >
> > I suppose the main issue is the virtio API changes that this introduc=
es,
> > which will have to be accepted to the spec.
> >
> > One small comment to patch 4: there I just assumed the virtual device=

> > time is CLOCK_TAI. There is a concurrent feature under review for HW
> > pacing offload with AF_XDP sockets. The clock issue comes up a bit. I=
n
> > general, for hardware we cannot assume a clock.
> =

> Any reason for this? E.g some modern NIC have PTP support.

I meant that we cannot assume a specific clock, if aiming to offload
existing pacing (or "launch time") methods.

The issue discussed in the AF_XDP thread is whether to use CLOCK_TAI
or CLOCK_MONOTONIC. Both of which are already in use in software
pacing offload, in the ETF and FQ qdiscs, respectively.

But for virtio it may be acceptable to restrict to one clock, such as
CLOCK_REALTIME or CLOCK_TAI.

CLOCK_MONOTONIC being boottime is almost certain to have an offset.
Even if the clocks' rates are synchronized with phc2sys.

> > For virtio, perhaps
> > assuming the same monotonic hardware clock in guest and host can be
> > assumed.
> =

> Note that virtio can be implemented in hardware now. So we can assume
> things like the kvm ptp clock.
> =

> > But this clock alignment needs some thought.
> >
> =

> Thanks
> =




