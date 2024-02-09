Return-Path: <linux-kernel+bounces-60120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EDE850037
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DAB24765
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62639538A;
	Fri,  9 Feb 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JemgcEXY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62475667;
	Fri,  9 Feb 2024 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518281; cv=none; b=sNFuAAiXlFnS256e4oRyA5y3BcdIKOHhl5LpexW+Vv+3HCFJGAiJbb5LPifWeaAWjihbAwonN/i8/IsV568AsTwy2hjJwXbnGgO7m0FYMkL6IhiVdX1kZKW2ktOiGHtv8466JZbk/nVMxATm/A0k3QAytbPZiOEKEV+NyCHSuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518281; c=relaxed/simple;
	bh=Bd4OMZm1UeSfsk8w3Q5GxbdSxQxTV/q6uVgcc/Esg/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTGAIdf9aO6EkY4mVhRrnfySJN3sbEqtrkD+1qNrpisfU7lZ7YRXqdIwNPetesJh6j6jdgeG8738XxZp4wIgOEaUYwUhr/zVVjXON8v6t737swutnIQXXR1XU4lsB3doYT1/pSLHFAQnu2ab8oicbzaQ/5rsHKIFcxzHNMms34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JemgcEXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E377C433B2;
	Fri,  9 Feb 2024 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707518281;
	bh=Bd4OMZm1UeSfsk8w3Q5GxbdSxQxTV/q6uVgcc/Esg/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JemgcEXYbwF1/q9byP9kjMg+bXZ+bod4eWqcnl9yN9jfqw/k9J93it4EiJFelDXFy
	 w97GhMZEd4748AE3DIh19q5Db7Gcb6DJwdd/mPvEAbRC8vIpyqWjRZn/Xzu1scX6IW
	 gVF0/eMUHJVpZVd/i6CfxpoOIExwpljmPKDGby0CBba/EVOBZBHs0ZTpoV88gyAXxT
	 Y5+N7UHfjjRH4WpN8LJ7rpohBfXPMX2of+AaQcnrg9FCG1kuyxqkfS8b3b1Lr6pAkd
	 zv1p5PNntsV3wreBgORlz6UKovI3H6wLDNI+GSWlKSSB5T3ElfEbIxt17gxuPIZ8Sv
	 sjh1sxBi/gVpg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso2693530e87.0;
        Fri, 09 Feb 2024 14:38:01 -0800 (PST)
X-Gm-Message-State: AOJu0YxvKIqndOLBLk9oT+0v7gut3LU596UZHOS2NEIX+5DqP9itFn78
	OLO5psbVm2K636ZaekcQroFXuhVaRahSbOyF4jV9ghBRKcUF+HvkRycFwWhpE3Fw8syZkiGaeEa
	1G+OFXo0MDEALxuIfJOSfjrdcBOk=
X-Google-Smtp-Source: AGHT+IFpBf3XAC3iKUmfLUywJXROd17ydosHtuM8Th3bDywl8iK5xlHPus50UyvME8O6+Kp9KLw7Sweru+s9C6d+9J4=
X-Received: by 2002:a05:6512:2088:b0:511:7259:3729 with SMTP id
 t8-20020a056512208800b0051172593729mr802144lfr.0.1707518279186; Fri, 09 Feb
 2024 14:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <Zb2wxIpf7uYV6Vya@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <528ce926-6f17-c1ea-8e77-c7d5d7f56022@huaweicloud.com> <ZcE4mGXCDwjqBXgf@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <1fdbfcf8-1ee9-4079-e84e-6e2c1121491b@huaweicloud.com> <ZcGuRIrZJaEtXjPh@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
 <CAPhsuW6arbEmRUK3xG1XVjra3BtSx9_wFe+QKDBbTgb3DgYXig@mail.gmail.com> <ZcVhA_IqXH2Pg79t@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
In-Reply-To: <ZcVhA_IqXH2Pg79t@bmarzins-01.fast.eng.rdu2.dc.redhat.com>
From: Song Liu <song@kernel.org>
Date: Fri, 9 Feb 2024 14:37:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6VqSRUsB2oQ+Hmf-0+2gfKHgN1skvvUwDmqDOxJvEKtA@mail.gmail.com>
Message-ID: <CAPhsuW6VqSRUsB2oQ+Hmf-0+2gfKHgN1skvvUwDmqDOxJvEKtA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] dm-raid/md/raid: fix v6.7 regressions
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, mpatocka@redhat.com, heinzm@redhat.com, 
	xni@redhat.com, blazej.kucman@linux.intel.com, agk@redhat.com, 
	snitzer@kernel.org, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 3:17=E2=80=AFPM Benjamin Marzinski <bmarzins@redhat.=
com> wrote:
>
[...]
> >
> > I am not able to get reliable results from shell/lvconvert-repair-raid.=
sh
> > either. For 6.6.0 kernel, the test fails. On 6.8-rc1 kernel, the test f=
ails
> > sometimes.
> >
> > Could you please share more information about your test setup?
> > Specifically:
> > 1. Which tree/branch/tag are you testing?
> > 2. What's the .config used in the tests?
> > 3. How do you run the test suite? One test at a time, or all of them
> > together?
> > 4. How do you handle "test passes sometimes" cases?
>
> So, I have been able to recreate the case where lvconvert-repair-raid.sh
> keeps failing. It happens when I tried running the reproducer on a virtua=
l
> machine made using a cloud image, instead of one that I manually
> installed. I'm not sure why there is a difference. But I can show you
> how I can reliably recreate the errors I'm seeing.
>
>
> Create a new Fedora 39 virtual machine with the following commands (I'm
> not sure if it is possible to reproduce this on a machine using less
> memory and cpus, but I can try that if you need me to. You probably also
> want to pick a faster Fedora Mirror for the image location):
> # virt-install --name repair-test --memory 8192 --vcpus 8 --disk size=3D4=
0 --graphics none --extra-args "console=3DttyS0" --osinfo detect=3Don,name=
=3Dfedora-unknown --location https://download.fedoraproject.org/pub/fedora/=
linux/releases/39/Server/x86_64/os/
>

virt-install doesn't work well in the my daily dev server. I will try on a
different machine.

> Install to the whole virtual drive, using the default LVM partitioning.
> Then ssh into the VM and run the following commands to setup the
> lvm2-testsuite and 6.6.0 kernel:
>
[...]

>
> Rerun the lvm2-testsuite with the same commands as before:
>
> # mount -o remount,dev /tmp

This mount trick helped me run tests without a full image (use
CONFIG_9P_FS to reuse host file systems instead). Thanks!

> # cd ~/lvm2
> # make check T=3Dlvconvert-repair-raid.sh
>
> This fails about 20% of the time, usually at either line 146 or 164. You
> can check by running the following command when the test fails.

However, I am seeing lvconvert-repair-raid.sh passes all the time
with both 6.6 kernel and 6.8+v5 patchset. My host system is
CentOS 8.

I guess we will have to run more tests.

DM folks, please also review the set. We won't be able to ship the
dm changes without your thorough reviews.

Thanks,
Song

