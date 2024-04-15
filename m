Return-Path: <linux-kernel+bounces-145992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67C8A5DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F14E1C20F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD55158875;
	Mon, 15 Apr 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN2w1seY"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51D1B80F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222182; cv=none; b=Qjv6sZ9FJSxImq4IsrelM53zaLV5I6lIstciKkkSIpYMu1g6Qi/sX9MSO4QlM0dxJenR8ku4xX63Mi19MzRkY1UYIOyMy8RVCW4STJLAiSFcuK+Pol68Ab4FuYSDrvofzahG+ckOw1x65dnSkSC0RzxM2WRmTeilhmWFE18rptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222182; c=relaxed/simple;
	bh=xr3YKTFSvnIyYP9LT3OaZuprPOkhA8clQOk5AXEN1/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfyJzqc4NPOikJbIo/kaIE4TtrCry1WKwMBk5LV7/1ZWCFgwU8oCWW92BAwWkFWYhFyDqkggyh6QQ5iPkcNRcNsYL7eEgaHCVP2C96Hfaz4RFMNdk62YWG26q6q0m8H0PhyWAOo9IrHor+no5vyqKXLrv7CwT37pWa1YV0Xc0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN2w1seY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61ab6faf179so24055827b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713222180; x=1713826980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zixM8fcSFTGU7EoKEyJyngzis3PHUKVx8GoIuPBbUXk=;
        b=HN2w1seYeUBJGiFZtFWcAp1qSeU3xpr7G1bDhRRTNKhfXwpFM0WEXixNKDk4I+g0+/
         8cu1uKBXJUnWjRSpm/uvka3O49sX4nHuQAGZUqqDXXIulRYpUcDLW8NAYGpAI4ndwa8X
         aKzIj67dY02bqxo9TgkItxE6SWYsnvYnToXK+DAKrfoXeK5Suj5oev0IED/VXZ0rh7ie
         vXItcRqN2qUoDH7sedjEHHWcAqFw2oUku5tgBnxy7CIF4rqKHD/NlC/w93OgtvthDwPi
         B1eHd2yzLDLXfj/wSLydcBcYxL5g91iq+qAlsDyN62Uy8p2Ck3drSXoELVJUhDmRfdEh
         hi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713222180; x=1713826980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zixM8fcSFTGU7EoKEyJyngzis3PHUKVx8GoIuPBbUXk=;
        b=V+qBVtObwnYhxh4RJxxroroCOHgY8Rb+5DPtijQo9M+uQSg3847PS/fxQnfA4R2yF4
         3kLp8AxncXMtJe5kJvOoi20OVgxhgy/2yQ2y3Hqyzm7xF5Cq9JG91P7P+USn0kE/KKeS
         gaen9/UZhRTlZt9kvNzdbztbWrgUg+ekN+1/VRvHg+IeiQDLwG5qcfuzZvwTo6BJGYwg
         g7gzqeAdiPQrpu8Nfjhh+yZVtw4HbNSNWztf110toA8gE2nLsMz6A7SB+wuFPvWmPj7w
         5TNeeX1fUCul1M7tAk1diYbKEY3NORhNmEG2rD+ma4as+atfSNanAGU6T+gh0u8dJlrg
         +FHg==
X-Forwarded-Encrypted: i=1; AJvYcCUiIlC1EzUKOtZfnfG5BQJYYsi/3/PDnRwnGSekjMr3Lm4Ae8RYmzT1qba7hXG5vCx8+1wGIH+nRaVs312c8IIcQv4E9eBinMXpp3+h
X-Gm-Message-State: AOJu0Yz5jq65OVsKtXxtwhb+UXO1ZF4mHiCCHypBcdwns/g1qR07s5e0
	5eYC8An3AUYRRXpy7LYrVZ+pfbhj7Nfu0Y1HgVAvqb/aRNrhc+wqx3M7/4JbTTAicc5TBw3J2Tu
	UatxJ59/JwuMQBxDY2NfSeutjnpuKCYFe
X-Google-Smtp-Source: AGHT+IGXsz28y5CQ10Oefmh9Jx2hMsRnfKUS2iaknbNbz0ZrfM5C4L7WBIj/DzJrUu/xhPwAlAfj+hnsRuIZ3O9CgU4=
X-Received: by 2002:a25:ac24:0:b0:dc7:6f13:61e2 with SMTP id
 w36-20020a25ac24000000b00dc76f1361e2mr11247143ybi.58.1713222179867; Mon, 15
 Apr 2024 16:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000daf1e10615e64dcb@google.com> <000000000000ae5d410615fea3bf@google.com>
 <Zh2kuFX9BWOGN1Mo@fedora> <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
In-Reply-To: <Zh2m5_MfZ45Uk-vD@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Mon, 15 Apr 2024 16:02:48 -0700
Message-ID: <CAOzc2pzFSkwo21Uba3ys5u8=okYbtA2ptyc5bQJwHoS=H_UMtA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
To: Matthew Wilcox <willy@infradead.org>
Cc: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:15=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Apr 15, 2024 at 03:05:44PM -0700, Vishal Moola wrote:
> > Commit 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of
> > anon_vma_prepare()") may bailout after allocating a folio if we do not
> > hold the mmap lock. When this occurs, vmf_anon_prepare() will release t=
he
> > vma lock. Hugetlb then attempts to call restore_reserve_on_error(),
> > which depends on the vma lock being held.
> >
> > We can move vmf_anon_prepare() prior to the folio allocation in order t=
o
> > avoid calling restore_reserve_on_error() without the vma lock.
>
> But now you're calling vmf_anon_prepare() in the wrong place -- before
> we've determined that we need an anon folio.  So we'll create an
> anon_vma even when we don't need one for this vma.

That's true. Though that can be addressed through something like:

if (!(vma->vm_flags & VM_MAYSHARE)) {
                       ret =3D vmf_anon_prepare(vmf);
                       if (unlikely(ret))
                               goto out;
}

> This is definitely a pre-existing bug which you've exposed by making it
> happen more easily.  Needs a different fix though.

I interpreted the bug report to showcase how restore_reserve_on_error()
depends on the vma lock being held - and vmf_anon_prepare() drops that
lock by the time we get to restore_reserve_on_error(). In this case, this
would address it without reworking restore_reserve_on_error().

There very well could be something completely different going on, however
I have no ideas as to what that may be.

