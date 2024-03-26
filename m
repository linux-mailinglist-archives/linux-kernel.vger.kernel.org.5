Return-Path: <linux-kernel+bounces-118444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A291A88BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DA81C2D058
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FD6130485;
	Tue, 26 Mar 2024 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpkQwHub"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863C129E99;
	Tue, 26 Mar 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711436744; cv=none; b=EVJlkRQfxP1Y21V19l7hmVoR4PCIwNgjwsMkoeqxmVhKl+IwxpagfX41b2bXyDupcAHR7GWCNa9ag2q+2pXhh75qwuNgRmeb+8Fni+fS4JFm1O7U80nJSWNpvmBguMX9goywNsv+wBbT7OdhDxt/tW9O1Fz7lphiePahv17SQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711436744; c=relaxed/simple;
	bh=v4v27zf/Du3GEjUn8WMGe0XsAPchh5ctG1u/pFL8EZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5nTDjflU5ygcj3gh1iUwZRtQPjYWMMBSqlElWs3eUfAL/deYSOZQF4M0fESoypEalKA6cmICyNsOEqhs8LgPiefG1Tu/M4N/JqcAKKJC7ZSD4d/Ri/Svde8OzlgULM+t0TAeuyeq97a708Ow5OhwQmjqO8YobKD3WDHlKOoAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpkQwHub; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c2df28f15so47168a12.0;
        Tue, 26 Mar 2024 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711436740; x=1712041540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4v27zf/Du3GEjUn8WMGe0XsAPchh5ctG1u/pFL8EZw=;
        b=bpkQwHubTFTAyXreDY5UoRcMYCzwm1aL/aF4oQY6/C7qL3xOeOtB3saViOHd2olpPu
         YWwsNGpX1qsYLdQT8sZhiVb5ugTiPO6E7uQp5JHVZLRR8rQUgCkDiGs1+ILJU18oLUw+
         GYxrDGlJZOHYGXi5SeVzSRvtGwrV8/8T/xCRLBEaSrw9eObHVnr7rWDEu8loRBmavFro
         I/9RNEHaAIPbhLkOC1WlEIIvqTX108djgrhvD2/ZJQ1xyy7QseSjfqK/eJFsf+VhnPx4
         HIZ5s0S+VNjXTXYP/En1GFGT3q6fIwW52MQRk6y+8DMRyc5PGUKGyhfE4223R0FxKWkU
         7AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711436740; x=1712041540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4v27zf/Du3GEjUn8WMGe0XsAPchh5ctG1u/pFL8EZw=;
        b=P4aLcZWig7R7M9UWbdEan99jgAQb3wLIZYSPnp5rh2asbVTZmQu2p7tcmVur7ou4L0
         yUHRCJp2u9y9ztQHnvRrqKcw5krDe/pQgdKj3JHLEEAbUvVHdsFx9Vc2BQhldVZ3z439
         1kveM91VBU+d4dlrsg7S3GNjuO/40SLmeaouRD/g6z8tTKtsP8IeBEUma1zSJrJ6Ut+u
         +sOdhWU15WWOwamFnMCs1FJz+PdQ9OqK5YpeWTZ2Bi6i9N5L5Zgx43D6OOOtrpEdyV+5
         +HqeHvssUxHkWrbmQFoMTmrf0EoK+N6IXFYnGdWYNz+WmbAYyBh1Un4aQxfd2Rv2Tn5e
         FUkA==
X-Forwarded-Encrypted: i=1; AJvYcCXd/SiJxYX1Y6tw4J2nm/GnfCEs77F2+IVIKlfV//W+C4ib5pGhZCPxnqOzGMheJXUh6bjP/nUbWnaqzItZ2N178DPF9LXiDe8zTkIOO7bbb5iwNLRLPKcgYdKFjRejVr0SNCJmiepBsiHD3EyrzK0Dwra65zBR/0UAjAYAdzLP/Q==
X-Gm-Message-State: AOJu0YzLYJgoAz16mfJ/GjGxNURGLZzuxgnAV/itHyPLnkzbtBSyjWmF
	6ADsL8GifyYNHzB4YIX0dItMMWD2P7BljLKjrVJ8IbG8a7r8IsHu
X-Google-Smtp-Source: AGHT+IFfsXz9OY1v3x4os4etHL3YdPMza3/jQ97c5ftyRW4nz+jwiYu1E4UIniKF2tm1OWuqRPJv9g==
X-Received: by 2002:a17:906:b0cd:b0:a47:48d7:d393 with SMTP id bk13-20020a170906b0cd00b00a4748d7d393mr437692ejb.33.1711436739835;
        Tue, 26 Mar 2024 00:05:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id oq25-20020a170906cc9900b00a46c8dbd5e4sm3858326ejb.7.2024.03.26.00.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:05:39 -0700 (PDT)
Message-ID: <ea13bc4f8a8aaf5b91ab3ca403533475000d5d87.camel@gmail.com>
Subject: Re: [PATCH v6 1/2] driver core: Introduce device_link_wait_removal()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina
	 <herve.codina@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring
 <robh+dt@kernel.org>,  Frank Rowand <frowand.list@gmail.com>, Saravana
 Kannan <saravanak@google.com>, Lizhi Hou <lizhi.hou@amd.com>,  Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Tue, 26 Mar 2024 08:05:37 +0100
In-Reply-To: <2024032554-tipoff-extrude-a631@gregkh>
References: <20240325152140.198219-1-herve.codina@bootlin.com>
	 <20240325152140.198219-2-herve.codina@bootlin.com>
	 <2024032554-tipoff-extrude-a631@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 19:38 +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 25, 2024 at 04:21:25PM +0100, Herve Codina wrote:
> > The commit 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > introduces a workqueue to release the consumer and supplier devices use=
d
> > in the devlink.
> > In the job queued, devices are release and in turn, when all the
> > references to these devices are dropped, the release function of the
> > device itself is called.
> >=20
> > Nothing is present to provide some synchronisation with this workqueue
> > in order to ensure that all ongoing releasing operations are done and
> > so, some other operations can be started safely.
> >=20
> > For instance, in the following sequence:
> > =C2=A0 1) of_platform_depopulate()
> > =C2=A0 2) of_overlay_remove()
>=20
> So this is only an issue for overlays?=C2=A0 Why has no one noticed this =
in
> the years since 80dd33cf72d1 was added?=C2=A0 Why is this an issue now
> suddenly?
>=20

Not sure either... Note this is only an issue if device links are in place.=
 So the
overlay needs to have nodes creating those links. You need to have regulato=
rs, pwm,
eth phy (at least these ones I'm aware they create links) to trigger this. =
We would
have to dig through git to understand when would this be noticeable. But no=
te this is
very straight to trigger.

May also very well be that most people don't really "play" with overlay rem=
oval...
For example, I have been dealing with overlays on rpi's for the last 5 year=
s and only
noticed this last year when we had an usecase that involved overlay removal=
.

- Nuno S=C3=A1


