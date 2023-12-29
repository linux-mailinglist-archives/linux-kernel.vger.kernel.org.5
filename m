Return-Path: <linux-kernel+bounces-12950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F146C81FD33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25FB1C20D72
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E4023DC;
	Fri, 29 Dec 2023 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTCNWJm7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2B23B3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5b7be937so163225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 22:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703831006; x=1704435806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFyAqIAqau5boFzi7imCn05sN0LoD3roNAUjQ9SH8p8=;
        b=cTCNWJm7+rMFdjhNvC9Vs/EPezrDxXt7JYRMj9H1pXMcRkDDnk/nKQ1dvFfuLViZnE
         lmyTik4sfxpX2TUpJ5+Eers9QoIH6J5avx7xfmbgYtC77BbxEzey2CzfISb3cIC6QRwl
         Fh4NgBV6VXkoZDzYhRVS4SD0ouzqbbDq73hTL+gOlUAMkFzQ5RFdj+g9esAYKWm1KHgm
         L/KbP0wZ8X399N/N8P0+jFmz/wysSPQ+0ABhoepb5wJqG8uy3FHIK3J0/98j2pyhYz+h
         Q9DozXSIeWih55EKpbWZZf9Tj4swIKsO+ZvJLO/cMVcNWLizJw7/H93lY+nwy/h0nczi
         pT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703831006; x=1704435806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFyAqIAqau5boFzi7imCn05sN0LoD3roNAUjQ9SH8p8=;
        b=JlkEo+2GK7CbfkYJoocSKsknwStWhFSOQRQsW8ujNbdlmeVWZOFiAtQTrpIr9nDx5J
         KvP8cc1e8rGXERYDfznSt02Wr4LNJlT4SxkCsms5yJGfH/zRAXyOceGN/BzK18DfeDKT
         SjZwDJ1lM9ateyLDP012rvHG4MEzIPpRODYt/cjgy4S6WVnj12JTMly/ir1rLhwkFmrZ
         xiXS7nquQJHKL1BSVvnP4oPTFTmpGdi7jKSj3PN42m3ItlJ/Sr+owulLXWEq5N2ItaNC
         EJ7rCE1kGVsObGt3C0lqwHFkLTgH4M/0Z6KB98yp2sFJfiRp3MMBBylK0S5ZiOTVEvJ1
         mUPQ==
X-Gm-Message-State: AOJu0YxOzg2LCCUOqWZuIxzzR/SvXmPaK9SHlQUm7xu4BBJOjLzUTTza
	O/eyPy8s0bzXLAOyXdhSzul+Q1gv1t4MnX2quvo7z8xXMmHu
X-Google-Smtp-Source: AGHT+IE1nKnPmWRnXwgTQKpCmYzQCUCJoBM6Hv/oBssp2S6IMe0Gt9VBFt7U+W/LTVii7jCUYc0DtEjR0b/xxWkWVGw=
X-Received: by 2002:a05:600c:2313:b0:40d:27c5:9c16 with SMTP id
 19-20020a05600c231300b0040d27c59c16mr816481wmo.0.1703831005684; Thu, 28 Dec
 2023 22:23:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 29 Dec 2023 07:23:13 +0100
Message-ID: <CACT4Y+YFk_7z_n2SyTGAWYBa_HRjMqNwXUO8AiDqHpDy_H2Rsg@mail.gmail.com>
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
To: "Yang, Chenyuan" <cy54@illinois.edu>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"jani.nikula@intel.com" <jani.nikula@intel.com>, 
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>, 
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "mchehab@kernel.org" <mchehab@kernel.org>, 
	"Zhao, Zijie" <zijie4@illinois.edu>, "Zhang, Lingming" <lingming@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Dec 2023 at 10:58, Yang, Chenyuan <cy54@illinois.edu> wrote:
>
> Hello,
>
> We encountered 5 different crashes in the cec device by using our generat=
ed syscall specification for it, here are the descriptions of these 5 crash=
es and the related files are attached:

Hi Yang,

Nice!

Do you plan to upstream your cec descriptions to syzkaller? That would
be useful.




> 1. KASAN: slab-use-after-free Read in cec_queue_msg_fh (Reproducible)
>
> 2. WARNING: ODEBUG bug in cec_transmit_msg_fh
>
> 3. WARNING in cec_data_cancel
>
> 4. INFO: task hung in cec_claim_log_addrs (Reproducible)
>
> 5. general protection fault in cec_transmit_done_ts
>
>
>
> For =E2=80=9CKASAN: slab-use-after-free Read in cec_queue_msg_fh=E2=80=9D=
, we attached a syzkaller program to reproduce it. This crash is caused by =
` list_add_tail(&entry->list, &fh->msgs);` (https://elixir.bootlin.com/linu=
x/v6.7-rc7/source/drivers/media/cec/core/cec-adap.c#L224), which reads a va=
riable freed by `kfree(fh);` (https://elixir.bootlin.com/linux/v6.7-rc7/sou=
rce/drivers/media/cec/core/cec-api.c#L684). The reproducible program is a S=
yzkaller program, which can be executed following this document: https://gi=
thub.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md.
>
>
>
> For =E2=80=9CWARNING: ODEBUG bug in cec_transmit_msg_fh=E2=80=9D, unfortu=
nately we failed to reproduce it but we indeed trigger this crash almost ev=
ery time when we fuzz the cec device only. We attached the report and log f=
or this bug. It tries freeing an active object by using `kfree(data);` (htt=
ps://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/cec-ad=
ap.c#L930).
>
>
>
> For =E2=80=9CWARNING in cec_data_cancel=E2=80=9D, it is an internal warni=
ng used in cec_data_cancel (https://elixir.bootlin.com/linux/v6.7-rc7/sourc=
e/drivers/media/cec/core/cec-adap.c#L365), which checks whether the transmi=
t is the current or pending. Unfortunately, we also don't have the reproduc=
ible program for this bug, but we attach the report and log.
>
>
>
> For =E2=80=9CINFO: task hung in cec_claim_log_addrs=E2=80=9D, the kernel =
hangs when the cec device ` wait_for_completion(&adap->config_completion);`=
 (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/core/c=
ec-adap.c#L1579). We have a reproducible C program for this.
>
>
>
> For =E2=80=9Cgeneral protection fault in cec_transmit_done_ts=E2=80=9D, t=
he cec device tries derefencing a non-canonical address 0xdffffc00000000e0:=
 0000 [#1], which is related to the invocation ` cec_transmit_attempt_done_=
ts ` (https://elixir.bootlin.com/linux/v6.7-rc7/source/drivers/media/cec/co=
re/cec-adap.c#L697). It seems that the address of cec_adapter is totally wr=
ong. We do not have a reproducible program for this bug, but the log and re=
port for it are attached.
>
>
>
> If you have any questions or require more information, please feel free t=
o contact us.
>
>
>
> Best,
>
> Chenyuan
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/PH7PR11MB57688E64ADE4FE82E658D86DA09EA%40PH7PR11MB5768.namprd11=
.prod.outlook.com.

