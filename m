Return-Path: <linux-kernel+bounces-163788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F58B703A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1084AB21AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E791E560;
	Tue, 30 Apr 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaI0xzY9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA212C49E;
	Tue, 30 Apr 2024 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473843; cv=none; b=r5RRCpGQqfNpk4+muUklVFq6XXshO5zP6nfqyUowEwW0G09cfLMWkUtuoYOCw+A0id0/XIQRqKLkH6umCv/3EvWkIA5o+2bjBd63FxESMSVD+igG+M6yDTwEGMK16gw3HTn/OOk7LIH1LBtUev6u7TE9Cluh0dtFNQ0wFuzDG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473843; c=relaxed/simple;
	bh=31wBKTJ4JT9mmJchsGpHh0X2DixmXplN7JVxWeiEljQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp8KiZ2zlpnObF64JnXbZbH5QXXCn+5r1aRteD30WXVr4DXg9DxUQv7hEzvAznYYuYOWcJpX21tehY2vA0NArIYuNUomYOEilASVrg1qsBKp99EtKkQcU3yN4in6C6ydmLZOWEhqydUeyHbu4Sy4dJTo53YLC9vnSQcaMfjHzcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaI0xzY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F5FC4AF1C;
	Tue, 30 Apr 2024 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714473842;
	bh=31wBKTJ4JT9mmJchsGpHh0X2DixmXplN7JVxWeiEljQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AaI0xzY9Z3IQNuhJFKx4lBotVbt3gALNxKpQErcol1SFcHqtAkxY+WB+zHtVsUnds
	 ffdQaGaOqkmbj47SFC7s4Q9YVM8XsD/6yHDRYYJdvKdj55gdrFuoAKiwC89FdoGXFl
	 UYriQqVNzrOmMsfiG4Xc2O8xxbQGQbTupzsAfk7A45gxQ+XOvVXJm16W5JchgHuJ3y
	 pYDz3c53CBiJVEkrK1d48P0R8cGGzYXn/HVJ3cEEc/cwqvlPCkfBhcg3YoqArocqGw
	 wLluZZuEphpCpXmUUi5g+RQSobEztzqcEAgycW7ZnkjbKOuhSTBlZy7iQjHsbaoEza
	 tXTgU3eih9BsA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ebddef73b5so725736a34.3;
        Tue, 30 Apr 2024 03:44:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWy0tP0N18ZYyDMnW2192sNQvLN7e4qkBGnSk+zuUf+b6fpKm3oHPAulWj7VufT5QaNXTWDiui0og47CMRAFuryvd/kzy3XQtfGUR/dMS+UmZwyqZAxuxrVn9toDCwnAdxvFkSoUEQ=
X-Gm-Message-State: AOJu0Yz6rdA0P58lt5gqI6RD+Hk7nSgbXChRT+nz6o74UANlwbdzEHzn
	8IG1EP8Tmk+fqTCbpYc2Q+6ePpJsyBh36dn/YoqvfhH0/wFehVEoAFnSUAzFsZ+0nVaU3qYDvQz
	O//Kgclpgtr0zisqIJMWUMKWDEgU=
X-Google-Smtp-Source: AGHT+IHXc5ixS3yw2zA6kQyqlqd7MY7x9Q0gfDuxuWB+CcozzVPski3SefuzvhVZqXc7ySiE+ikrsJzAzlJdL98UE80=
X-Received: by 2002:a4a:9287:0:b0:5af:be60:ccdc with SMTP id
 i7-20020a4a9287000000b005afbe60ccdcmr3594185ooh.0.1714473841687; Tue, 30 Apr
 2024 03:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5e2dfd0e-d647-4106-9921-a78ca4b55403@linaro.org>
In-Reply-To: <5e2dfd0e-d647-4106-9921-a78ca4b55403@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 12:43:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g063TE0Yj3VRbSRC=4YFaZoh4CL9CpXNMFu+M6yGV5LA@mail.gmail.com>
Message-ID: <CAJZ5v0g063TE0Yj3VRbSRC=4YFaZoh4CL9CpXNMFu+M6yGV5LA@mail.gmail.com>
Subject: Re: [GIT PULL] cpuidle for ARM for v6.10
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, Yangtao Li <frank.li@vivo.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Apr 30, 2024 at 12:30=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> please consider pulling this single patch PR.
>
> The following changes since commit ed30a4a51bb196781c8058073ea720133a6559=
6f:
>
>    Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)
>
> are available in the Git repository at:
>
>    https://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/next
>
> for you to fetch changes up to f9059eb5d73e65c88b88465abed4364dfc7b20b4:
>
>    cpuidle: kirkwood: Convert to platform remove callback returning void
> (2024-04-23 09:21:48 +0200)
>
> Thanks
>
> ----------------------------------------------------------------
> Yangtao Li (1):
>        cpuidle: kirkwood: Convert to platform remove callback returning v=
oid
>
>   drivers/cpuidle/cpuidle-kirkwood.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> --

Pulled, thanks!

