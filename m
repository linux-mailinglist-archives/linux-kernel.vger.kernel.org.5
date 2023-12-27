Return-Path: <linux-kernel+bounces-11905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9881ED59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491941C21599
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2808163AB;
	Wed, 27 Dec 2023 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlLxrFF+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE8863A8;
	Wed, 27 Dec 2023 08:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECB7C433C8;
	Wed, 27 Dec 2023 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703666023;
	bh=cdLrFbEkFzwUHDx8JwRAgteZpWcz5ddl4PjRSMGdkaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlLxrFF+MpsHDrjSaSBlzvKGrVzO6E272l2S63XZnkIwLNspj5YkMzNWDHGqtTDpn
	 qzOhukca6aX21zGKipxolQBjw1QVAOt/TSAqYxMioDdzdIf9u8Vpzj7FAEGSG8XM0q
	 mleAHjRyj2WjkSRvhZode/I2El75z62HiMBLU0E33z5hOXakQmSYfkdkLH+qCNn9aT
	 n8lsV30BSUK3qV6xSorfWSU6bUfBOOeFz5P3HeuTQov9CRRmniXTN9g9yMfjwX2vb7
	 QM8RGHW9TZnONnKeYRv1MUycfJADLId9M3bsMHkhfpq+9pfNdqhFnWHKpa62EIuAdE
	 7iaGRJwvM2TEQ==
Date: Wed, 27 Dec 2023 10:33:39 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	Eric Dumazet <edumazet@google.com>
Cc: Shachar Kagan <skagan@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Ido Kalir <idok@nvidia.com>, Topaz Uliel <topazu@nvidia.com>,
	Shirly Ohnona <shirlyo@nvidia.com>,
	Ziyad Atiyyeh <ziyadat@nvidia.com>
Subject: Re: Bug report connect to VM with Vagrant
Message-ID: <20231227083339.GA6849@unreal>
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
 <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
 <cdf72778-a314-467d-8ac8-163d2007fd70@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdf72778-a314-467d-8ac8-163d2007fd70@leemhuis.info>

On Fri, Dec 15, 2023 at 10:55:05AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 08.12.23 11:49, Eric Dumazet wrote:
> > On Thu, Dec 7, 2023 at 2:03 PM Shachar Kagan <skagan@nvidia.com> wrote:
> >>>> On Thu, Nov 30, 2023 at 2:55 PM Shachar Kagan <skagan@nvidia.com> wrote:
> >>>>
> >>>> I have an issue that bisection pointed at this patch:
> >>>> commit 0a8de364ff7a14558e9676f424283148110384d6
> >>>> tcp: no longer abort SYN_SENT when receiving some ICMP
> >>>
> >>> Please provide tcpdump/pcap captures.
> >>>
> >>>  It is hard to say what is going on just by looking at some application logs.
> >>
> >> I managed to capture the tcpdump of ‘Vagrant up’ step over old kernel and new kernel where this step fails. Both captures are attached.
> >> The tcpdump is filtered by given IP of the nested VM.
> > 
> > I do not see any ICMP messages in these files, can you get them ?
> > 
> > Feel free to continue this exchange privately, no need to send MB
> > email to various lists.
> 
> Here this thread died, so I assume this turned out to be not a
> regression at all or something like that? If not please speak up!

No, it wasn't fixed and/or reverted. Right now, Vagrant is broken and
all our regressions around nested VM functionality doesn't run.

Eric, can you please revert the bisected patch while you are continuing
your offline discussion with Shachar?

Thanks

> 
> #regzbot inconclusive: radio silence
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 

