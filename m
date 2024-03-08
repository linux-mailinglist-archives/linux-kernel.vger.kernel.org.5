Return-Path: <linux-kernel+bounces-96437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09665875C16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE51C2152D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A2E23741;
	Fri,  8 Mar 2024 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM/8XK+E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395222134A;
	Fri,  8 Mar 2024 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709862513; cv=none; b=KS0ozCJshmCQmTu9oefgUoLlHE7/FJMIo7hX1FMpP+sYE9V/kT3Nsw7xOMu/kc7HJtQEHOiYkWXtln9Kx3S/HGR9g+zGzxN7RAbMY3Ox+UR78OdZyEE+/nUcprp2vm+/a+t/WzG8ntbXT+H049GDs2Rmms2DpTBgTtq5Z80gFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709862513; c=relaxed/simple;
	bh=kZ5SHKDJ8Skr/N7XxcifcmmAO0LJXEYjTOAY6vdiggs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnT2j9WSpuaNEwL5kVraq8tvn9wxKZZBJlWgqtHnNfNagNR+WrJSIb00uRw5Yw1EpLqlbHGeTCbziXnQr6KLjd+J2GFN51c/EtaCrimeyUHAzyc4EzrQ8EYOzbSLxZVwoGicfU/rJiX3Ct44OuqV6tSX8J7WDMJo7ppHwzYXIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM/8XK+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B46C433C7;
	Fri,  8 Mar 2024 01:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709862513;
	bh=kZ5SHKDJ8Skr/N7XxcifcmmAO0LJXEYjTOAY6vdiggs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QM/8XK+E9TR9WeXmOjIg73Ojis85ecaIVjttRIzp4JfgbTgsdSUJeIETrh9surixT
	 lg4juEIB4OCdkC4hQ45FbQBwGP8eQ7c+IsJoFl4YaCW3MeKPwKUr79lkn0RF+wsdEj
	 hdAb2ltaW7cT2U/cKUu1uTun9DXFt8YK63eIUGq+EmLNRxK6QW5k+I6+JbFQhrsy/o
	 aSxFikWEoBNgBRyGB476K8s7ZCfuXerwM/zQglv6BuyUfyldDbcMOD7Rr3tmQcitxl
	 PRmPmrVFtRkPPSBZ52ya7M8YC4NZ0urD77x6FT1q2ldx2Dt/fwFE5SMw8bz9hw/6UC
	 fKYoTQ4DSWaVQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d208be133bso3644581fa.2;
        Thu, 07 Mar 2024 17:48:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5EDN5WbQvAepGT/0j92xM1rJcyeU6z/uYESslkl5VCBd8PuQ+Zio79qgEBWoK7X8mu6l/8njSgQhyLE6FB7lj0x+Npf05OAaJgZvjPrhL6uL1aY94xodlUR/g8vcN4K5QqSNLuRFs5EZJa6NMf3XVbCVhg+/ZH9kUsKijf6bPcpObTnlU
X-Gm-Message-State: AOJu0YzKXuhgiTQcW2dfW7VfZXlleDxngdtiz8vGURjOEUAscySrxDZJ
	C5q3gkJhe1+t/tOnqTDCQqstCgVivp+2rTr9EIU0ExO7PI2Lv8sXZB5EGhmHqt8pygGkDnqUcIg
	XLQObzjanI6+2mwsw5TzHfywpuds=
X-Google-Smtp-Source: AGHT+IHVXAjkM9sta9OiKBdvLifC7AinwKanBZx08/VEzYkb61ZLfoxNF6qOes4GMWiCSbDnzeTOgz2gB9Leq+qrp5Y=
X-Received: by 2002:a2e:7815:0:b0:2d2:6d19:75ff with SMTP id
 t21-20020a2e7815000000b002d26d1975ffmr2372320ljc.50.1709862511109; Thu, 07
 Mar 2024 17:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031946.2324519-1-linan666@huaweicloud.com> <1dec5d5d-fb4b-8203-82ca-dc1ee92132bb@huaweicloud.com>
In-Reply-To: <1dec5d5d-fb4b-8203-82ca-dc1ee92132bb@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Mar 2024 17:48:19 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7HJD28Q9GUqQ_eP4SZETzfFeRPm8Mo5jhTJOzivuEE0w@mail.gmail.com>
Message-ID: <CAPhsuW7HJD28Q9GUqQ_eP4SZETzfFeRPm8Mo5jhTJOzivuEE0w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] md: fix is_mddev_idle()
To: Li Nan <linan666@huaweicloud.com>
Cc: axboe@kernel.dk, linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:12=E2=80=AFPM Li Nan <linan666@huaweicloud.com> wr=
ote:
>
> friendly ping ...

I am sorry that I somehow missed this (or archived it in patchwork). I thin=
k
we gonna ship this to 6.10 kernel. I will work on it later.

Thanks,
Song

