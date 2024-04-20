Return-Path: <linux-kernel+bounces-152387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213048ABDB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A90C28150D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA44CB4A;
	Sat, 20 Apr 2024 23:05:54 +0000 (UTC)
Received: from out28-82.mail.aliyun.com (out28-82.mail.aliyun.com [115.124.28.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4E2747D;
	Sat, 20 Apr 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713654353; cv=none; b=s6D6zW5Ot6bnq6ql+yyvAQhgY3Z3bodv1e4Cmy8cj5ayaLk3poen0vFRvna0Be3iVe1VShV5C45h/DTTLqPxFF3ckuYFzGP67QpKO1KCFH8e4qwwUTJNLWzCOhMiCfggMd8qkp5q4hXtRSEH/Baes1F6rMl0EBXt16z3r7nwgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713654353; c=relaxed/simple;
	bh=OHtgtW8L4Duwwp/TCH/X7YkJd9k0LtJwHCy5dH/qFTQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=HgLi1ZguXG/8/IJVpGtsSQm4NYjhPnkhbn546UqC9msaGzypTQsVeHERKpNtZoraNHqwPDsMz/HYUyPsrDVy/lz9mrJnTQYm1JLU8O5/t0eHA1yBWW0yTzUpuhY6GssB+0ryAz9/jcdmE7GFoL+x+iDaK1GS6hbOFYUN26R5FKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1073318|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0311914-0.00265519-0.966153;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.XHDA.xl_1713654025;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.XHDA.xl_1713654025)
          by smtp.aliyun-inc.com;
          Sun, 21 Apr 2024 07:00:26 +0800
Date: Sun, 21 Apr 2024 07:00:26 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Shay Drori <shayd@nvidia.com>
Subject: Re: Linux 6.6.28
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <linux-kernel@vger.kernel.org>,
 <akpm@linux-foundation.org>,
 <torvalds@linux-foundation.org>,
 <stable@vger.kernel.org>,
 <lwn@lwn.net>,
 <jslaby@suse.cz>
In-Reply-To: <220e55df-a0a2-4272-b94f-c7c4c6fbf2b7@nvidia.com>
References: <20240420135914.2AD9.409509F4@e16-tech.com> <220e55df-a0a2-4272-b94f-c7c4c6fbf2b7@nvidia.com>
Message-Id: <20240421070025.C32F.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.06 [en]

Hi,

> 
> 
> On 20/04/2024 8:59, Wang Yugui wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Hi,
> >
> >> I'm announcing the release of the 6.6.28 kernel.
> >>
> >> All users of the 6.6 kernel series must upgrade.
> >>
> >> The updated 6.6.y git tree can be found at:
> >>        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> >> and can be browsed at the normal kernel.org git web browser:
> >>        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> >
> > Linux 6.6.28 failed to boot with the following panic *1 on a server with
> > mellonax CX-6 VPI NIC, but 6.6.27/6.1.87 boot well.
> >
> > After reverting 'net/mlx5: Restore mistakenly dropped parts in register devlink
> > flow', linux boot well.
> > 
> there is a similar discussion in net-dev ML[1].
> In short, it seems this patch is missing from stable, which is prerequisite for the bad patch:
> 0553e753ea9e
> "net/mlx5: E-switch, store eswitch pointer before registering devlink_param".
> 
> Wang, can you test it out please?

After apply "net/mlx5: E-switch, store eswitch pointer before registering devlink_param"
to 6.6.28, linux boot well here.

and  "net/mlx5: Restore mistakenly dropped parts in register devlink flow" is
NOT applied here.

Thanks a lot.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/04/21


