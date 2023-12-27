Return-Path: <linux-kernel+bounces-12307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E781F2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060AFB22064
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDE495C1;
	Wed, 27 Dec 2023 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi2Y0mLL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73748CF2;
	Wed, 27 Dec 2023 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b7fb34265fso259793239f.3;
        Wed, 27 Dec 2023 15:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703719605; x=1704324405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEMOjdbY0fY3N2JjHRStjCumCwdTvGjyUSjt06U4UHI=;
        b=Xi2Y0mLLjy57YPGfnRRzinUCCm3gnrDEMqr6ChIC+WggsOrYm6loJsMcuhtYOPrRBx
         QnkYMODAqTMzKFUYgntYfOrWTj7OAprhlbbFw4gRTboMp0TpUq4DFNHTvEGbWZ15zR0N
         2MBgyzUNigJwSlbtTs0bbie/zWqG6QltI5IOMDWToxRzHyN1R+/YfXW+ZE8Hz/mUvgNu
         cX7vSzz10TL2LSl5h6EmPDGONEuFGGVexrP3NclAjdNrBPHiITBRV6lsH77tdMoPD5BS
         ilfChqN0rTHDrQvr0X8MPH6ArG4n+Kx+DMNZSgN55c8JgnAf2Rcor6CZWc3Zx19FNz8v
         Zm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703719605; x=1704324405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEMOjdbY0fY3N2JjHRStjCumCwdTvGjyUSjt06U4UHI=;
        b=luMt+1AzHZ3yh41A/gpbNQwqQnUX9fDi6/zAcVoanGBgLY784pnhN/O0J7Zhq5l8EF
         zdNMo/UK+4K5qSPmyPo/R743N00WnRiSRfBM7y0W7eNZmS8waOo6irmqJM31LOW8YgEf
         TbyisDcQtinFiw42Y35aHz2JICVgJ2c/tK5bvQ2yCK1SQU6LSSwtD/EILNkXcgPSVjQA
         AdE6ue1UJA80IuYNizMTLrhtX9k8nNwI7cjzZzK0HmfDLSvNtWgjJuPtC7yanOpnmjii
         9ICa7hpM0rgvPIjCY6IJj86DUmJte2TzpukCVmhN34LjKf6LKKKtqQNwj5pEcPjBRoT8
         AFDg==
X-Gm-Message-State: AOJu0YzcXc3CHbwJssm50RVSNmBpY0EcxEwoS/vQc++hQ0Blvn/pREAc
	HvoBznGRdyIXblih9ycgdfI/VfLts7ANBt4js2g=
X-Google-Smtp-Source: AGHT+IFf/qwYN/xcEguZs0O55XvpYjto0J9S5LeglXBCb9SH5FUnzV9uStqIYLu+qOAa6TOJlpjqyxeMd7w/DdOXYEI=
X-Received: by 2002:a05:6602:1512:b0:7b7:fc0c:63cd with SMTP id
 g18-20020a056602151200b007b7fc0c63cdmr10728294iow.39.1703719604978; Wed, 27
 Dec 2023 15:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
 <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
 <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com> <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com> <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
 <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com> <CAGsJ_4xknGt5Q6vTKHdnqvXi7fKMORwXywurdN09G2uOUJzCSg@mail.gmail.com>
In-Reply-To: <CAGsJ_4xknGt5Q6vTKHdnqvXi7fKMORwXywurdN09G2uOUJzCSg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 27 Dec 2023 15:26:34 -0800
Message-ID: <CAKEwX=PYK3hUzgm+qfs2sNU686RaE+_M3W4Zo_Q4mTMAgKaB2A@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Barry Song <21cnbao@gmail.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>, 
	syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 3:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Dec 27, 2023 at 5:16=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Thanks for your explanation! Maybe it's best for us to return to 2 page=
s
> > if no other people's comments. And this really need more documentation =
:-)

Fine by me. Hmm we're basically wasting one extra page per CPU (since
these buffers are per-CPU), correct? That's not ideal, but not *too*
bad for now I suppose...

>
> I agree. we need some doc.
>
> besides, i actually think we can skip zswap frontend if
> over-compression is really
> happening.

IIUC, zsmalloc already checked that - and most people are (or should
be) using zsmalloc for zswap anyway. I wouldn't be opposed to adding
an added layer of protection on the zswap side, but not super high
priority I'd say.

