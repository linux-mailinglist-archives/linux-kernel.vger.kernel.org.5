Return-Path: <linux-kernel+bounces-143811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9F98A3DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F01F215DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911461D6A5;
	Sat, 13 Apr 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwfgDzBE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C725EC7;
	Sat, 13 Apr 2024 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026204; cv=none; b=IgzvWZw8O/zWiuf6RRKEf9U9dyZEoQzZilhYJSEzot0X9omg/PJzn3UcB8Ggkzvw+gCFH9JDxFfAdNdbhgf2Q+VAJnMI64my3Us7RkCljox2fAooTc1aktqUWfvsGmRPGjwo/ACqjbwxgQFgdzvdHN5n3P7kZjRDjgmR9GPBaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026204; c=relaxed/simple;
	bh=UQGy6WJYcpSkvjwL5jcGwx5Vo/JwWOk0wdfTJVrGk8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0wKIeeGE1Ai1N5iZbm/oQMCziAeCr5fPQ97cGgYmUCRFdxh8jaIqIKn10REB/6aSH8nzPFzyMjWmaat6MPUB2gdl4EYccisWRet6+y/lOCPyEa7qkfOpORL4Meqli3ZDeekaqh2HiHmYU/rPalfbAxS2l0C1pl3Y2EctidLZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwfgDzBE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso1738732a12.3;
        Sat, 13 Apr 2024 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713026202; x=1713631002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNj+6DrfOiQjFKWAX1mlfx0zYPpOzh9UWFldVp7iAn4=;
        b=CwfgDzBE5D3ZPZtTEpwV0tRV1XuQ5r2WWsE3d1B/QjCd6NUqf7M5PQgtmGEb0vLwif
         rYSLfQKury13eLXle+bMDJpch9UOtDUuZPCWWrudtzoGAKJqUAM73cOV9vhS4/sB5MEy
         3IBTQWvJf4Y1P0rNgs06qEwp71Ts3sAHInmXBLQqyiH/stCTSq3K/2qV6NnOuhOdhm8S
         42qXoB+xREr5o1hPxUtPqbMCdCg9/uu88iPA/LkLZFUkovhb1pKMpLHraIyV0SNM5Voa
         0OzsweR2QaMTQGMyQfH1R4OMuyxW5XYhgQ+1GgpAIR0B9gFbRfZ5oaKJsSXhBmiytoRZ
         D8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713026202; x=1713631002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNj+6DrfOiQjFKWAX1mlfx0zYPpOzh9UWFldVp7iAn4=;
        b=n7OoznrSfmgEiAyqagYwi1SIDPmMA9kctUE/tsozUd55o51Jyw45KKBxK2DCu6a9PQ
         r25sWGJpI1A6EkWfOvTZH+a9kzWXrsmZLL++osM9Q6lrW+FOzZYePFoUmWdnZek/zkaj
         xTDpl742RO5mvZMRKQPsOmFgUZMvY7r5mw7M430RONykl8vQgC8stIyGWxkwVeLxkczU
         n84APVS2D293Z6p0zWN01UFdl1CpE9/aY8Di343GgWgGuJTgzGkPjYqvpyXgtyNEyuQ/
         HHJpmuRwUwgREjopO5lclliUdAasX91M/27ZCn/TQcBFmRv6PjPV78V7eZUVIxNL6/y4
         JfNg==
X-Forwarded-Encrypted: i=1; AJvYcCXIbx3JGjLIuqryw+GSRmwPRDduV8CQLi19/uleFXdlgZgcKuF1p43wblcCCUgbHV3K9vPaiHcqw57w0RG4wtVovLsCp2p9nACMRQ==
X-Gm-Message-State: AOJu0YyFYnHNoz0oB8DcUYQuxbljgTM5cezZoucTIs6w2tY2WUWvU8wO
	UFZ2mbf0XzxxDCCzYGe6Vhq1JumeBuu6kK0rM0kEd6UTPuIfsEdyZ8PoKyeLMkoWh51pW3Sv1LF
	PvbsFjzF5cYArZdtbWjjPkjklqbY=
X-Google-Smtp-Source: AGHT+IG0CpMpDeQkSaMaM/le3b3FHsGjAwHYacbQEIRDVQHX58R4XGSf3qmHfl4p7+QvBeaF9OvtrFvu4fswYJ4eBvo=
X-Received: by 2002:a17:906:f6c2:b0:a52:4314:9aec with SMTP id
 jo2-20020a170906f6c200b00a5243149aecmr2278042ejb.6.1713026201432; Sat, 13 Apr
 2024 09:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYOs-szTK0rYvDw5UNGfzbTG_7RvjqFOZA=c6LXvxdUt2g@mail.gmail.com>
 <CAEkJfYMcdmXAhe9oTpEPGL+_661PNAvM58Y+irwnbLW8FKohNw@mail.gmail.com>
 <2d5e3b6c-3a66-4f74-8367-51fa55bf0a1a@acm.org> <CAEkJfYMcLycLfaRzhn=DmQjAuLHn29wSXN0b0Zf0oJr=sDVBTg@mail.gmail.com>
 <2ab31b48-5f89-4ada-848d-89b844f6a6f5@acm.org>
In-Reply-To: <2ab31b48-5f89-4ada-848d-89b844f6a6f5@acm.org>
From: Sam Sun <samsun1006219@gmail.com>
Date: Sun, 14 Apr 2024 00:36:29 +0800
Message-ID: <CAEkJfYMCj69qnsU-UmPu1Csu1smvS9arYJP386WsbfXH9WgR_g@mail.gmail.com>
Subject: Re: [Bug] UBSAN: shift-out-of-bounds in sg_build_indirect
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, jejb@linux.ibm.com, dgilbert@interlog.com, 
	syzkaller@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 6:49=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 4/10/24 6:17 PM, Sam Sun wrote:
> > On Wed, Apr 10, 2024 at 12:59=E2=80=AFAM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >>
> >> On 4/9/24 05:51, Sam Sun wrote:
> >>> We further analyzed the root cause of this bug. In function
> >>> sg_build_indirect of drivers/scsi/sg.c, variable order of line 1900 i=
s
> >>> calculated out using get_order(num), and num comes from
> >>> scatter_elem_sz. If scatter_elem_sz is equal or below zero, the order
> >>> returned will be 52, so that PAGE_SHIFT + order is 64, which is large=
r
> >>> than 32 bits int range, causing shift-out-of bound. This bug is teste=
d
> >>> and still remains in the latest upstream linux (6.9-rc3).
> >>> If you have any questions, please contact us.
> >>
> >> Thank you for having root-caused this issue and also for having shared
> >> your root-cause analysis. Do you perhaps plan to post a patch that fix=
es
> >> this issue?
> >
> > Sure, I am glad to help! But it is my first time submitting a patch, I
> > need to find some instructions. I would appreciate if you could help
> > me out. Also, I need to double check the patch to avoid introducing a
> > new one. It might take some time.
>
> The process for contributing a patch is as follows:
> 1. Clone the Linux kernel tree for the subsystem you want to contribute
>     to. For SCSI, this is the for-next branch in
>     git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
> 2. Make your changes to the code.
> 3. Commit your changes (git commit -as), chose a patch title and explain
>     what has been changed and also why.
> 4. Convert your changes into a patch, e.g. by running this command:
>       git format-patch -1
> 5. Check the patch with scripts/checkpatch.pl.
> 6. Send your patch with git send-email to Martin Petersen and Cc the
>     linux-scsi mailing list.
>
> More information is available here:
> https://docs.kernel.org/process/submitting-patches.html
>
> Best regards,
>
> Bart.

Thanks for your help! I will follow the instructions and submit the
patch as soon as possible.

Best Regards,
Yue

