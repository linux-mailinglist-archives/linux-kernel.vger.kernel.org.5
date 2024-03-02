Return-Path: <linux-kernel+bounces-89245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488486ED34
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CB91F21FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B0110F1;
	Sat,  2 Mar 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvrMrRkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2932196;
	Sat,  2 Mar 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709337968; cv=none; b=rcWxH6Iys/QF6kE8Wq6rDDID4bnMGIWzCW4AJFfSmu1PFkRkZD7/3yIKkMyVolye4VVxPKiti2s83M5TTq9ideB7/UCdSw3ZhcPmmH/vuMSztAGACpTj5BDBxUzouNrtNGaIOcMsn+9qik2Agl2nZBUHexfYt7LLrLchM8IwfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709337968; c=relaxed/simple;
	bh=9jhxQYst6W/53/FNdtKeZCmGcKX2pz71OAXlAHZw2Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7fzm+TK5ieuS/fQFpIMdUnPLcXIQXDmmYBNkWVu/KNJv3Vjo7axlzs/zwNDPWgrh5D4ryfxGk1YZ/I5YowoY2RQUrjy2WSIXvZKOZa5/XIYXBb6D1SqhLBTb7wGdQWuaHs1IBBhkNsjSSokjmW25fGq6/l80tLjpbXDo3eoJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvrMrRkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B924C43399;
	Sat,  2 Mar 2024 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709337967;
	bh=9jhxQYst6W/53/FNdtKeZCmGcKX2pz71OAXlAHZw2Ho=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QvrMrRkXYK0EDmLE1WkV5Z4MLMH7B+MZXteBCW208Ko6B/1fmpOoA37PChuIKP/zc
	 9TVQCfhxDMvqngy0I+fneUNf+R/Mm36f93IuhHCsoPt/l2NUesjREEOlAw8NL9P8eH
	 hCZb4hhMueqQjzRww5omKMbRQQFDsdYr4ULxs+HUuIwVa9qTXm8zfrYQQ8lUOMici0
	 iV6CifP3sVK2ndHjoBvJKek8zQwOee3CG89ln+QL+IZN8nNYg0TwuUeKnCGXQsZ4jn
	 EJfQbDXabyDWXfkp7V2UxuphyDL5s10pIezp1RpjPEb5ra13zgwZL296ZsNjVV2AwC
	 bYMvLgStCnaoQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5101cd91017so3410273e87.2;
        Fri, 01 Mar 2024 16:06:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwSbTjfopd9ZYtum7ceS0PZxcHq1OY+39wgSbSETSn7A/WJQ5F1qKCi9oMKLZpaZmNr748C/NHp66oeNnksMoVpTv3/dR5bAVxZXnrEYKnlzj7vc+PWFeZHgDKj//4+ETE9Jr+mtN0DDoKUphtRFp58LNek1ND0vyYmJTywSq50A==
X-Gm-Message-State: AOJu0YyplBoMDXWGikGUd5YVBZq8jurqh8RerKVlTuUbA8+CIoo5qOht
	h2/DWTS8VE2JCRZBojlZJ05PIRjvRlLLTue6m7OCypszDIHUx+/DVR5k5JoldYQhxzvghpCyhpF
	vlJxZyR06Fwvr4utqYMc5f35f3G8=
X-Google-Smtp-Source: AGHT+IF4l59Ka3h13yYEnZDIZtj9l8dHsTXiwdtLOLinPJocCPkbKn8I2g9Y2wJzbcusgFDgCUlBLBSLuhBOcHPBqWU=
X-Received: by 2002:ac2:5929:0:b0:513:28c1:99fe with SMTP id
 v9-20020ac25929000000b0051328c199femr2183561lfi.37.1709337965753; Fri, 01 Mar
 2024 16:06:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com> <20240301231222.20120-1-dan@danm.net>
In-Reply-To: <20240301231222.20120-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Fri, 1 Mar 2024 16:05:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW73WZRekVSEFPgL7R-KNtd2DuhDo7oUNmjZN4Hr7w0dhg@mail.gmail.com>
Message-ID: <CAPhsuW73WZRekVSEFPgL7R-KNtd2DuhDo7oUNmjZN4Hr7w0dhg@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>
Cc: junxiao.bi@oracle.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan and Junxiao,

On Fri, Mar 1, 2024 at 3:12=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> > 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have
> > some issue which leading to the io request from md layer stayed in a
> > partial complete statue. I can't see how this can be related with the
> > commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING i=
n
> > raid5d"")
>
> There is no question that the above mentioned commit makes this
> problem appear. While it may be that ultimately the root cause lies
> outside the md/raid5 code (I'm not able to make such an assessment), I
> can tell you that change is what turned it into a runtime
> regression. Prior to that change, I cannot reproduce the problem. One
> of my RAID-5 arrays has been running on every kernel version since
> 4.8, without issue. Then kernel 6.7.1 the problem appeared within
> hours of running the new code and affected not just one but two
> different machines with RAID-5 arrays. With that change reverted, the
> problem is not reproducible. Then when I recently upgraded to 6.8-rc5
> I immediately hit the problem again (because it hadn't been reverted
> in the mainline yet). I'm now running 6.8.0-rc5 on one of my affected
> machines without issue after reverting that commit on top of it.
>
> It would seem a very unlikely coincidence that a careful bisection of
> all changes between 6.7.0 and 6.7.1 pointed at that commit as being
> the culprit, and that the change is to raid5.c, and that the hang
> happens in the raid5 kernel task, if there was no connection. :)
>
> > Are you able to reproduce using some regular scsi disk, would like to
> > rule out whether this is related with virtio-scsi?
>
> The first time I hit this problem was on two bare-metal machines, one
> server and one desktop with different hardware. I then set up this
> virtual machine just to reproduce the problem in a different
> environment (and to see if I could reproduce it with a distribution
> kernel since the other machines are running custom kernel
> configurations). So I'm able to reproduce it on:
>
> - A virtual machine
> - Bare metal machines
> - Custom kernel configuration with straight from stable and mainline code
> - Fedora 39 distribution kernel
>
> > And I see the kernel version is 6.8.0-rc5 from vmcore, is this the
> > official mainline v6.8-rc5 without any other patches?
>
> Yes this particular vmcore was from the Fedora 39 VM I used to
> reproduce the problem, but with the straight 6.8.0-rc5 mainline code
> (so that you wouldn't have to worry about any possible interference
> from distribution patches).

Thanks to both of your for looking into the issue and running various
tests.

I also tried again to reproduce the issue, but haven't got luck. While
I will continue try to repro the issue, I will also send the revert to 6.8
kernel. We have been fighting multiple issues recently, so we didn't
get much time into this issue. Fortunately, we have got proper fixes
for most of the other issues. We should have more time to look into
this.

Thanks again,
Song

