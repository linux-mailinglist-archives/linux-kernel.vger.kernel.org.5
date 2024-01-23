Return-Path: <linux-kernel+bounces-34573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D048C838151
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6651C27E23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9ED14A0AA;
	Tue, 23 Jan 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgz6B3Ac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101814A081;
	Tue, 23 Jan 2024 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972100; cv=none; b=G6hPuuaoe0p0qmMxdXcEneCdDd7Q7bEfbRPO71xSWu1EuqPxwizs1dizuW44pQH/PqCDEYmpUlO7xEX+N9CtF9lWNkk7glP6Fk6DWmyq7NQpdfKAjWqANmdmBcH/IKQHW+EbHMMXzcyGk7XUedjzlmeXhbyme5hniMUROc4E3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972100; c=relaxed/simple;
	bh=cFM0lETpxAxxe4lzIBOzXCWMkQDrw4kdYwJuTiI8ptg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j55iWGuDa2emirmv0LiTDMkm47c0k/pZ5IdqPx7uSKaqNNNIXYD/92GyR//VkIY+HIVwI8VNqQuJ/D/2LSi0fdpZf2sOlFLTPGsmj4FRHEPcB7OFpC/1dw00/hyWaMy5sNEkeeC3H3eyJeJ1XOUAGSU5CM8A68Y8i3DlFJpSIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgz6B3Ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD0EC433B1;
	Tue, 23 Jan 2024 01:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705972100;
	bh=cFM0lETpxAxxe4lzIBOzXCWMkQDrw4kdYwJuTiI8ptg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dgz6B3AcZAL2UZz/RhWtm9KFTux680MsPtG5x9+b9dJLTWQgg2PyeVPeD9zIDGGXW
	 No1ElWZ0DWAb/FmHHR+46fHTNqebvZMaNQF7OJYliWO/K8QDPU0xcfI69drUP0MBGX
	 wtpnYlf+3cXzE/vXW9QRQ+2W8wZ3SMXrwezIZ4pWfDe0R0mLxAgOyvCAPGfNVkQXNc
	 UYXRmRWPZpNKCPKDljmx5/xJDm5vNwJSjlv3LoNyIvnTCaVr3WuvIBtjvXcRuc8CWZ
	 pbVAcYxKY4eFdOyX6cVX+dyKZPYgoUWuBVSwpGsDmp5SgLdb3WXWUhC+lcUyk0dFd6
	 fwQ+bFTbBXR1g==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso4017637e87.3;
        Mon, 22 Jan 2024 17:08:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwNQsBgjehH6aBDRCX5QFFcqZzOJxssLUS56k+n69Rj7ZI6GFtg
	h3vLIHggJsqnewYBDCwNwGl9pVtLF8DYPEKnUJvCmWZ/XRSmodINkmw+pDuVzLJ3uMHHd8+uy7+
	qkuWW5wIcmW3VCHpT7LNDXAbsAgg=
X-Google-Smtp-Source: AGHT+IG4Rp5vKJqJFxqo8Nu7q5lj7JH9AjDuWeOPC9PCtExPzrPS6D48AjxSRjvzl2TfuKbCz25dC1mN/XJSp8xFD8A=
X-Received: by 2002:a05:6512:a90:b0:50e:a9da:7b2b with SMTP id
 m16-20020a0565120a9000b0050ea9da7b2bmr2631297lfu.94.1705972098150; Mon, 22
 Jan 2024 17:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123005700.9302-1-dan@danm.net>
In-Reply-To: <20240123005700.9302-1-dan@danm.net>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Jan 2024 17:08:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4WSfcJWjYt56eCamgc1nqyQ1gxFc=6-2DV-NJs9wroeg@mail.gmail.com>
Message-ID: <CAPhsuW4WSfcJWjYt56eCamgc1nqyQ1gxFc=6-2DV-NJs9wroeg@mail.gmail.com>
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
To: Dan Moulding <dan@danm.net>
Cc: regressions@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Junxiao Bi <junxiao.bi@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Yu Kuai <yukuai1@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:57=E2=80=AFPM Dan Moulding <dan@danm.net> wrote:
>
> After upgrading from 6.7.0 to 6.7.1 a couple of my systems with md
> RAID-5 arrays started experiencing hangs. It starts with some
> processes which write to the array getting stuck. The whole system
> eventually becomes unresponsive and unclean shutdown must be performed
> (poweroff and reboot don't work).
>
> While trying to diagnose the issue, I noticed that the md0_raid5
> kernel thread consumes 100% CPU after the issue occurs. No relevant
> warnings or errors were found in dmesg.
>
> On 6.7.1, I can reproduce the issue somewhat reliably by copying a
> large amount of data to the array. I am unable to reproduce the issue
> at all on 6.7.0. The bisection was a bit difficult since I don't have
> a 100% reliable method to reproduce the problem, but with some
> perseverence I eventually managed to whittle it down to commit
> 0de40f76d567 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in
> raid5d"). After reverting that commit (i.e. reapplying the reverted
> commit) on top of 6.7.1 I can no longer reproduce the problem at all.
>
> Some details that might be relevant:
> - Both systems are running MD RAID-5 with a journal device.
> - mdadm in monitor mode is always running on both systems.
> - Both systems were previously running 6.7.0 and earlier just fine.
> - The older of the two systems has been running a raid5 array without
>   incident for many years (kernel going back to at least 5.1) -- this
>   is the first raid5 issue it has encountered.
>
> Please let me know if there is any other helpful information that I
> might be able to provide.

Thanks for the report, and sorry for the problem.

We are looking into some regressions that are probably related to this.
We will fix the issue ASAP.

Song

