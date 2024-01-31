Return-Path: <linux-kernel+bounces-45749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 484D58434E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28B02898D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4B3D0BC;
	Wed, 31 Jan 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qifMW2hE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE73D0A1;
	Wed, 31 Jan 2024 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706676953; cv=none; b=Di8VDHwv6p7kJwy7imJvfVUwfTRABvD7L3njrXJrfeKXjjAu1Oovkx+ud25VE32VyW/WcaMuW3aLLQyuAiTeYbZaVJMOknTSjJ3ydThf7groSno5LM6X57dzCuYIA6Kat01U1w8cDAxHxhwzqcrAfBPgk6wS3yRwfgaarcvOi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706676953; c=relaxed/simple;
	bh=UAcaG1XK5qRhb1eEHIUDL8EenSrO063sixI2jRRZVqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr32f47V2FMit7Va1YfzXnIVN7BXb1WDUoxPj8ct+a32IoW9YCv5OMC0vkwFqHOJynrIGqR4Gys0flwsOkmCDlMf0LwowoTKg8uSD7mo/cHNMjEor+2dHHzaekzipx60hE9E3BejRdg1RfAEeiTOaUAjrYQ9W60TQh8ZKZ0kdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qifMW2hE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D7AC43390;
	Wed, 31 Jan 2024 04:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706676952;
	bh=UAcaG1XK5qRhb1eEHIUDL8EenSrO063sixI2jRRZVqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qifMW2hExigqDc9NNIfpRl3LgWBwoXismg+Zf4JIj0mWtWM6/4/jOi9m1y4LG0+IV
	 98+JGAytF44SDjGpfvQnk4f5AnjwqjAlugoWEzjwrqhuSyZa/FgHosLfTXp7QT5cmS
	 kbUwjDSsrpzZIjTmFYK1cgm4CGxbWrtoNsCHOI1R6gcX/GuWSkQICpabKwqBOAUs1m
	 D28cpiVZjJ1vTH9uaDhZh59tHLFl8IIeO2BPYFft5v/o+C+jnUOMseMvoikPXr+5eU
	 e+QZVT00u+FP1pQz4U3Hs3JUNyJaSEn65JPnQKDMZGpKK3D7e+ohO9IqZ4Jt7Ror+d
	 One20Hed4NEiA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5110fae7af5so3489629e87.0;
        Tue, 30 Jan 2024 20:55:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxtEjBT/b+a5V+/cdxpcaORYpQqqkDxrPVjQ+50/r8X4WAoo8qD
	0cGpk2ixacxLt7AtpZo4xJg8wauiGNzJ3g+Z5W0rrigceCI9U6FAvMGP+ts9nQbgE7kgNJO03vG
	UDCuXT1P/HxcpERVakOZsaCbtFRE=
X-Google-Smtp-Source: AGHT+IG2pk+OgJ/SA4zOiQYsteh2+uWiGgm5RzgPyiaXhKOriI6X38evAsmx1xw+J07cYAoMgGbF6x2vH5KfZbzfAKE=
X-Received: by 2002:a05:6512:3ec:b0:510:1a32:6298 with SMTP id
 n12-20020a05651203ec00b005101a326298mr398529lfq.56.1706676950941; Tue, 30 Jan
 2024 20:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbMnZnvyIyoWeIro@fisica.ufpr.br> <20240126154610.24755-1-dan@danm.net>
 <20240130172524.0000417b@linux.intel.com> <95f2e08e-2daf-e298-e696-42ebfa7b9bbf@huaweicloud.com>
In-Reply-To: <95f2e08e-2daf-e298-e696-42ebfa7b9bbf@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 30 Jan 2024 20:55:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7QHq4e+cHvZcw8c=ePpeSM69UKTEi8P40=-jOZn+YyyA@mail.gmail.com>
Message-ID: <CAPhsuW7QHq4e+cHvZcw8c=ePpeSM69UKTEi8P40=-jOZn+YyyA@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Blazej Kucman <blazej.kucman@linux.intel.com>, Dan Moulding <dan@danm.net>, carlos@fisica.ufpr.br, 
	gregkh@linuxfoundation.org, junxiao.bi@oracle.com, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 6:41=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi, Blazej!
>
> =E5=9C=A8 2024/01/31 0:26, Blazej Kucman =E5=86=99=E9=81=93:
> > Hi,
> >
> > On Fri, 26 Jan 2024 08:46:10 -0700
> > Dan Moulding <dan@danm.net> wrote:
> >>
> >> That's a good suggestion, so I switched it to use XFS. It can still
> >> reproduce the hang. Sounds like this is probably a different problem
> >> than the known ext4 one.
> >>
> >
> > Our daily tests directed at mdadm/md also detected a problem with
> > identical symptoms as described in the thread.
> >
> > Issue detected with IMSM metadata but it also reproduces with native
> > metadata.
> > NVMe disks under VMD controller were used.
> >
> > Scenario:
> > 1. Create raid10:
> > mdadm --create /dev/md/r10d4s128-15_A --level=3D10 --chunk=3D128
> > --raid-devices=3D4 /dev/nvme6n1 /dev/nvme2n1 /dev/nvme3n1 /dev/nvme0n1
> > --size=3D7864320 --run
> > 2. Create FS
> > mkfs.ext4 /dev/md/r10d4s128-15_A
> > 3. Set faulty one raid member:
> > mdadm --set-faulty /dev/md/r10d4s128-15_A /dev/nvme3n1
> > 4. Stop raid devies:
> > mdadm -Ss
> >
> > Expected result:
> > The raid stops without kernel hangs and errors.
> >
> > Actual result:
> > command "mdadm -Ss" hangs,
> > hung_task occurs in OS.
>
> Can you test the following patch?
>
> Thanks!
> Kuai
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e3a56a958b47..a8db84c200fe 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -578,8 +578,12 @@ static void submit_flushes(struct work_struct *ws)
>                          rcu_read_lock();
>                  }
>          rcu_read_unlock();
> -       if (atomic_dec_and_test(&mddev->flush_pending))
> +       if (atomic_dec_and_test(&mddev->flush_pending)) {
> +               /* The pair is percpu_ref_get() from md_flush_request() *=
/
> +               percpu_ref_put(&mddev->active_io);
> +
>                  queue_work(md_wq, &mddev->flush_work);
> +       }
>   }
>
>   static void md_submit_flush_data(struct work_struct *ws)

This fixes the issue in my tests. Please submit the official patch.
Also, we should add a test in mdadm/tests to cover this case.

Thanks,
Song

