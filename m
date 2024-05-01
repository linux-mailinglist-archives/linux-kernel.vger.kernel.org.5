Return-Path: <linux-kernel+bounces-165485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACDD8B8D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE181C21E39
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B8131737;
	Wed,  1 May 2024 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ26PfHW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292B13172B;
	Wed,  1 May 2024 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577472; cv=none; b=pLRJ5xpLkRmPq15Ur5yXaz1Q8NGWm4EiuQMy51zhyHhWipEEfcAvRxBxytCrYTwsmgVWeKZ0hdhg1XE1ugKxuGFBxMvaZPrX5FnfAxUUwkhNjFmZZ2qnP/QjehBncFdLFYkjgMCpd96rotbOccA8GTZrBmN5Q7MSLpByfzDhV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577472; c=relaxed/simple;
	bh=5EQCAGJWi1gNMQ9VlfMCPs3pDIh0UsuBaU2aKjFSw3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubd6mSpk3zZksTthSGOxPgfYiPQer6NZtg6F+Q6F62M8SIRUxjAh1fNyk15Cg+gjmlQ1oCXSb2Zkph4AhR0DO6o1fn2VhkB1KtQ7sn8UH7Jw93Ig6WmAyFwhSix3pIMS6MYOZnDW4ngvBStuiaIA8p6vAY34FuOsNJ20A5/7YVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ26PfHW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ef64d04b3so277045e87.3;
        Wed, 01 May 2024 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714577469; x=1715182269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twOO39IK0y3RTrpJCuNRz/HORbt2EjU/IQkWuJv9K7g=;
        b=DJ26PfHWT1fy6zIb7Rf1YS8mWMVEJTw4q3TXroIFn8sONDstDyuSU+6vBaSb7A6hsk
         j4YvktrO4Cwr61k5V/C86JdJi95H8CZL/5fELnXYcbe1+DW/wBWB26316PPa9Th3X3Ts
         qPC22QagKo0SM+PrH1f6JGnLMfnyBBQthy2Yb5sdSlBQvO4VMuPhMNyOcYkQOZ8m+Q+H
         fed1EGpOBLarCgFeHb1/qC6O4b09tYwlEQapjYlPtRRXy5rJh6Mim/IaOz5Uc7LaJrXG
         wQWu+syXyCfVl47y8rZmcbM1k0yVtebL/ZLggwSCLSDRvhGqs2f1kbNcUcjUacLfhHSA
         Ucyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714577469; x=1715182269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twOO39IK0y3RTrpJCuNRz/HORbt2EjU/IQkWuJv9K7g=;
        b=CQL/SqhmAdpbPalZr5mln2Gmue5b2Bc0w5DTnSCO/bSJ1CV22DSVWWE1AjtGZX/ucY
         5CfN1wZojJDTCKA12UBtIYy0hCCO7Bk/9ViKdn16+vH3t53k/Hr6BVQbISkLd/GqDDHF
         QyzhRGSY3KgjE6lGDXfDc+ryl1yueyATNipIGBi4JB1aKdz6B9jOmWKpPHq6D/7le4+t
         qPO4oYr9pfMgGsfhJ1G0mbl2Ctdy02IEwgHCmzooGd2buMj3/1ZhGVCDZWVqSjyKT3p1
         hlDOsYxxZUcGFYI7GacDDGIBj5pZ31k1JClFuE1DxZbjJsyIU6Yr6yg+THC//l1DMQ31
         bAHw==
X-Forwarded-Encrypted: i=1; AJvYcCUgMl4nabC3PDTpgd+A4BuXOmYrcMcGT17FTcTbB0nzE6oJ/PxvClfjYHi823WuQ9d7+x6VMEJfpb8i4kmvU3FFk9bvZoM3Xs6rbc3E2MtYSWMs3RPLIWDO9XZruVjvjFQ1CFb7yrs60us=
X-Gm-Message-State: AOJu0YwM4jJwxWLlZgPN5kC15uj3OHLwLrQEOJl5CjvTU8qQEodY9ugK
	2RIeOl+KXMnLUXMCdKgNU0NwdYrUJ/d5STozNMjeY5pFLxf9yZ16B6/PCWCFEaiR7TBJXUCwyV0
	Q6RuDx9gBEFGOOCtaY448UOCVYjs=
X-Google-Smtp-Source: AGHT+IFii37kJAoGxHEuKDgZh7zDvrHm3VfWjLZHCEx4n6ylXkiOwcCkIxsj5cdcuRCM6DmkrSIEd7CW2IVMvBK7TB0=
X-Received: by 2002:a05:6512:398a:b0:51e:3932:fbff with SMTP id
 j10-20020a056512398a00b0051e3932fbffmr3119308lfu.43.1714577468852; Wed, 01
 May 2024 08:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
 <20240430080019.4242-2-konishi.ryusuke@gmail.com> <650ed9f6-fa50-4a3b-939d-633f9e389137@acm.org>
In-Reply-To: <650ed9f6-fa50-4a3b-939d-633f9e389137@acm.org>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 2 May 2024 00:30:52 +0900
Message-ID: <CAKFNMomCzNMU0tjLkEchr=GQwSVW1zr1GAq7vUToeOvX-M3eVg@mail.gmail.com>
Subject: Re: [PATCH -mm 1/2] nilfs2: use integer type instead of enum req_op
 for event tracing header
To: Bart Van Assche <bvanassche@acm.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-nilfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 11:42=E2=80=AFPM Bart Van Assche wrote:
>
> On 4/30/24 10:00, Ryusuke Konishi wrote:
> >       trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
> > -                                   opf & REQ_OP_MASK);
> > +                                   (__force int)(opf & REQ_OP_MASK));
>
> Please keep the enum req_op type instead of casting that type away with
> "__force int".
>
> Thanks,
>
> Bart.

Hi Bart,

No, this type cast is necessary to prevent the following sparse warning:

  CC [M]  fs/nilfs2/mdt.o
  CHECK   fs/nilfs2/mdt.c
fs/nilfs2/mdt.c:155:43: warning: incorrect type in argument 4
(different base types)
fs/nilfs2/mdt.c:155:43:    expected int mode
fs/nilfs2/mdt.c:155:43:    got restricted blk_opf_t

What we're doing here is just changing the event tracing type back to
int, and keeping blk_opf_t and enum req_op in the rest of the code.

I understand if you have enough reason to ignore the warnings, but
Why do you have to keep enum req_op type instead of int for event tracing?

Regards,
Ryusuke Konishi

