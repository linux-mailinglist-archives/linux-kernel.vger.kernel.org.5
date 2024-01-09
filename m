Return-Path: <linux-kernel+bounces-21290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A04A828D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500971C24EC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AB3D547;
	Tue,  9 Jan 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3lGgSTZ"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6033D540
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-680b1956ca4so24065576d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704827228; x=1705432028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZWj0c0jaCsyimh25w1gCdR+brwMSXqABqwsZR/XLJU=;
        b=D3lGgSTZs8TFAynZNVJiGg1jSG5UHtO8YBCcxZTpCe4tOoK0KRgr+NFGH4D4yfQfMW
         FRDNUQjmeIAh9WG5ZN8AbawEM1yg5FlXYfNNc5rIxLpwU1f5SXKJPiElKI2vhxQxU/+2
         qoiZztTkzyk6afDOpUsB6UCN0Jn8u+MrokurMpy40JFw3nkU7aupo2G5+SqCmvp09AmM
         md/AoEL1v+1mANlpMUj1fiVX5TPSpz3MbA/7kGxx4HUvleMudmhtYkJRh2PqePZfHwlr
         F/ilcnUtqIn9ymYhiqpAuy9kOWpL4fCPQ/tvJeswY8myyyHPh75vAa7vjIPKK+n/U2sf
         qmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827228; x=1705432028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZWj0c0jaCsyimh25w1gCdR+brwMSXqABqwsZR/XLJU=;
        b=k6BYvU7GK/wvr3GIBd1qhETNuAnxxyVu9SvE7pZpVzo5AuMRpTMWVSDDc9NVw+eDks
         hbmBcTO8FyClzp55x4UZquA7P7+58RmehvD1i6PU/2qduVxPwJbo21a/AHsavzihPLbm
         zCbIyyN/wpqRVDxCJxiLaqR8j2sgYisyqgRTCvTzQtiUBhkRSaF12ub3DMllr9Mn1g/r
         DJCLCQVajJ8D7yMEI85ho7UI3AjUkZxRLi58+H1rLkL1F8kP944TcEUI8o8GJNggGTNt
         +ZmJBLyaf+X5UaiWS0RHzMiRtjnqUnRtKDjcPKCPeK9JptqcljOkrFdYILQofS7Q94E6
         nrcg==
X-Gm-Message-State: AOJu0Yz/mOHhybpPPZ7Td2S24eSgw97tVFF8n1ULzRy3EJubsnxwPxhR
	YZcg1dvQPwQyFOpBfppQsAk378c79wh/u7k7Bd1wH2J4JZNu
X-Google-Smtp-Source: AGHT+IEDkWh5d4jaJoD9wYDQIYJi4sfejD6VqQVpuOO7LI2Yu7a4R7ck8NJoxpQPlDzx+u0MWAM1PTPaOgDOvDfs/ag=
X-Received: by 2002:a05:6214:2b08:b0:67a:b99e:4228 with SMTP id
 jx8-20020a0562142b0800b0067ab99e4228mr7301604qvb.52.1704827228444; Tue, 09
 Jan 2024 11:07:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105000632.2484182-1-aahila@google.com> <11317.1704418732@famine>
 <ZZtwKFu4GQLQ5AXM@Laptop-X1>
In-Reply-To: <ZZtwKFu4GQLQ5AXM@Laptop-X1>
From: Aahil Awatramani <aahila@google.com>
Date: Tue, 9 Jan 2024 11:06:56 -0800
Message-ID: <CAGfWUPyHJ-R98jvqEyJ5KMkv=NyxvOFYLN+wxCoshu7mKXpuVQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 net-next v2] bonding: Extending LACP MUX State Machine
 to include a Collecting State.
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, David Dillow <dave@thedillows.org>, 
	Mahesh Bandewar <maheshb@google.com>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you folk for your feedback.

Currently due to travelling reasons there will be a slight delay in my upda=
tes
but this should be resolved soon and I should be able to provide quicker
iterative feedback.

Thank you again for your reviews,
Aahil

On Sun, Jan 7, 2024 at 7:46=E2=80=AFPM Hangbin Liu <liuhangbin@gmail.com> w=
rote:
>
> On Thu, Jan 04, 2024 at 05:38:52PM -0800, Jay Vosburgh wrote:
> > >+coupled_control
> > >+
> > >+    Specifies whether the LACP state machine's MUX in the 802.3ad mod=
e
> > >+    should have separate Collecting and Distributing states.
> > >+
> > >+    The default value is 1. This setting does not separate the Collec=
ting
> > >+    and Distributing states, maintaining the bond in coupled control.
> > >+
> >
> >       Please reference the standard in the description; this is
> > implementing the independent control state machine per IEEE 802.1AX-200=
8
> > 5.4.15 in addition to the existing coupled control state machine.
>
> The status of IEEE 802.1AX-2008[1] is "Superseded Standard". Maybe we sho=
uld
> use IEEE 802.1AX-2020[2].
>
> [1] https://standards.ieee.org/ieee/802.1AX/4176/
> [2] https://standards.ieee.org/ieee/802.1AX/6768/
>
> Thanks
> Hangbin

