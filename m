Return-Path: <linux-kernel+bounces-44210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B5841ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82191F213D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D7F59165;
	Tue, 30 Jan 2024 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElsHSCtB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F41758210;
	Tue, 30 Jan 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605720; cv=none; b=gqKLdFWp6fiQ731O7oNB7r+Jquiwupu0tX6YvivD957cksea3Gj3SrjG7gYpUIX/KY10LUaw9SbUUOdCO7iHlSJIX4o4Rj2rRYpBm99CzJVeVzAHrvgKDF/AdIgX8IzvccpVIxb1adhnnyayfWrEg9qLCIH/vv1LK2mZg0ht9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605720; c=relaxed/simple;
	bh=x3YsoKl3lyXJsq4HIoyY0PO1z6clLK9C7c17IKM8sLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6SYCqv/vZkJMgmlQsP4s1iTrnvvN34n1b5y+Fg3Ki/DATwrRcHy4mRUyEFMUWdgQJh/0L+9ZcxSTg/7GdvedOSItp+xrww0JDXILk6yHQnwtB1NhbALUjHGPVzVXmLIjL4h2igAJGuzxp9UoBr3/XaXLyKCX17p+34lf7XaNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElsHSCtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C0AC43399;
	Tue, 30 Jan 2024 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706605719;
	bh=x3YsoKl3lyXJsq4HIoyY0PO1z6clLK9C7c17IKM8sLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ElsHSCtBKq4sD1VLTqnxe3Rl0cHG7Pa9M+R8o+bDcjWfVYI99Cx+gHOwxeUx2F/s8
	 j5bmFgeTTuF2s4nxFeznnJE2sgWOoGV6nLGZS9XSIa3rrsVQnOSh3tYqOYKjcDUb7g
	 kwwMKNPRRTkZApxHiLdowC1oF4Atf5jD3NxSGV7TzOMsrI4TlyVXeSUPJGv3BIRxsx
	 wRk1g0zRjNMxdwo9OrMIo8bDFeTZPmnklLZ1FIfKDPWp4QE2WXgqdxsFlbtpSKFil6
	 7u6tiUrdsY89TvOL/rIs38U2Tm7H0hvKYDfNRye+d34+sQYQbM1DGOJ+oinEXZM/rg
	 g66exC1ZOR23A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511203459adso48747e87.1;
        Tue, 30 Jan 2024 01:08:39 -0800 (PST)
X-Gm-Message-State: AOJu0YxmgWbKLj8a3ZmnHuTPX40YC1IcK6Ewr6beCdzsED4Z+0hckbf3
	dM7Le3W8tmVYQZUFGO3dOrX2BAdIwWGJvQoQWv8GSl8Pl7ogKlCfgyrISWfBREKQ9L9f/Kqv2MI
	xd1U59ufMooVUdoxiSHjo5wFTiA0=
X-Google-Smtp-Source: AGHT+IFAADGl+dYJ3uYhd2b0X/8W7l84yce3XV0bpQdzSNHiMfJ0hpQ2FTyhy+Ky+G4alo8Vck66smIUmnt1u18K18I=
X-Received: by 2002:a05:6512:398f:b0:511:19af:f84 with SMTP id
 j15-20020a056512398f00b0051119af0f84mr1130652lfu.25.1706605717863; Tue, 30
 Jan 2024 01:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 30 Jan 2024 01:08:26 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6qkDyG_-ziDcHwbVNoWon8Gzg1vaPy=qFF6DC7QTY7Eg@mail.gmail.com>
Message-ID: <CAPhsuW6qkDyG_-ziDcHwbVNoWon8Gzg1vaPy=qFF6DC7QTY7Eg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] dm-raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>, Mikulas Patocka <mpatocka@redhat.com>, 
	Zdenek Kabelac <zkabelac@redhat.com>
Cc: heinzm@redhat.com, xni@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, yukuai3@huawei.com, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:23=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
[...]

>
> Test result:
>
> I apply this patchset on top of v6.8-rc1, and run lvm2 tests suite with
> folling cmd for 24 round(for about 2 days):
>
> for t in `ls test/shell`; do
>         if cat test/shell/$t | grep raid &> /dev/null; then
>                 make check T=3Dshell/$t
>         fi
> done
>
> failed count                             failed test
>       1 ###       failed: [ndev-vanilla] shell/dmsecuretest.sh
>       1 ###       failed: [ndev-vanilla] shell/dmsetup-integrity-keys.sh
>       1 ###       failed: [ndev-vanilla] shell/dmsetup-keyring.sh
>       5 ###       failed: [ndev-vanilla] shell/duplicate-pvs-md0.sh
>       1 ###       failed: [ndev-vanilla] shell/duplicate-vgid.sh
>       2 ###       failed: [ndev-vanilla] shell/duplicate-vgnames.sh
>       1 ###       failed: [ndev-vanilla] shell/fsadm-crypt.sh
>       1 ###       failed: [ndev-vanilla] shell/integrity.sh
>       6 ###       failed: [ndev-vanilla] shell/lvchange-raid1-writemostly=
sh
>       2 ###       failed: [ndev-vanilla] shell/lvchange-rebuild-raid.sh
>       5 ###       failed: [ndev-vanilla] shell/lvconvert-raid-reshape-str=
ipes-load-reload.sh
>       4 ###       failed: [ndev-vanilla] shell/lvconvert-raid-restripe-li=
near.sh
>       1 ###       failed: [ndev-vanilla] shell/lvconvert-raid1-split-trac=
kchanges.sh
>      20 ###       failed: [ndev-vanilla] shell/lvconvert-repair-raid.sh
>      20 ###       failed: [ndev-vanilla] shell/lvcreate-large-raid.sh
>      24 ###       failed: [ndev-vanilla] shell/lvextend-raid.sh
>
> And I ramdomly pick some tests verified by hand that these test will
> fail in v6.6 as well(not all tests, I don't have the time do do this yet)=
:
>
> shell/lvextend-raid.sh
> shell/lvcreate-large-raid.sh
> shell/lvconvert-repair-raid.sh
> shell/lvchange-rebuild-raid.sh
> shell/lvchange-raid1-writemostly.sh

Hi Mikulas,

Could you please advise the proper way to run the tests and to interpret
the results? Are these failures on 6.6 expected?

We hope to run lvm2 tests regularly for all md patches. However, Yu Kuai
has spent days on this, and it seems really hard to run it properly once.

Thanks,
Song

