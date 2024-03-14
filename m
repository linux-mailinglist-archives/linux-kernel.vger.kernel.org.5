Return-Path: <linux-kernel+bounces-103703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A19587C329
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F0C1F25D71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37C67581A;
	Thu, 14 Mar 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wd1TFFLy"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89AA74E0C;
	Thu, 14 Mar 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442563; cv=none; b=Or0uC0MkYbZK0BKLs8ezbJv1VwOSXcS8HqnsHl+m/LM0xc887vcx6QprLlOMEuCloT6RTTeCkZMmc+5bYtSVgxEa6mHXrJd1ZYRjMAaCDhzYGzkzCNaGpgZ7jxqL9On73aKzrw3AT/CgaoBUzSS5wTDUM/WG2SurMtszRIsanZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442563; c=relaxed/simple;
	bh=lXCDCtLjliLRIDCwXgxxcrhvVk5QMWTHOJ5iNfcya/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2aLyKEgeoMLvZNqJllz8UrZmuz+rQf+j+g2Cu+6onOTl/lgVwxTgRZ2AASkUJmj8p1XZsjp4zL1OlZK1r4ZYcWsgd7cQPbsYnzdqZMh4kBVxEZi/QMo54hFHy000G1/9ynKx4cYC0ZgSuLyuN9Phv5fXSFwAEL1GfrsT8BPFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wd1TFFLy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b5831bc8so1326351b3a.0;
        Thu, 14 Mar 2024 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710442561; x=1711047361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXCDCtLjliLRIDCwXgxxcrhvVk5QMWTHOJ5iNfcya/Q=;
        b=Wd1TFFLyOeHSF/XO1RBto/Fwk4d1G88e6p28Fj6SiD8WG1B/FhK4cGTKX6eKqdp6QX
         UwOXe6VOhVuCfkhOOAS0sweAZPr5J2n1KVSo0Bb8Yeers6HglXyKpudQrLBCcLORNw07
         Cki86xVd24WY72snZfo4MTsX8/UD7yT/C3gPOO/BkmIVA4qQ6UBnjvoAzzziIDzXPW/l
         cL1zegk3wCa6WeEeZYP3plU0BWIksL3Gj2R50NHxzcumR/AmpngPCY8s9Y31shaWDqKE
         M/xX7fv3pUYLjW0FbXEeJ38GL/wEpbvtqSv4l3Pkd2pyohrygX4cxtxJsdJSta5SxtsE
         Kw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442561; x=1711047361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXCDCtLjliLRIDCwXgxxcrhvVk5QMWTHOJ5iNfcya/Q=;
        b=mAjmlWakjp3C0pD0v0gx2nFR3rAaxtPYvrSi64YN7wtSso5XcCbT0pLRtQXMz4+4as
         g+QUeUqLm8O68b5WYheLRmqS6g9Y4SD3XS2Ey81CNSs/FB9oResiieYk1iUY+oefYprk
         XDxXJnr7QTFJnaCEqAdrMn6HDmCfldEHQcBuuERVFsnxeTZKOG8DzScGSv/QXQOzH7dA
         V+4L/7O6xJH5DaHQUREIBsfj/NbXtaTqGOoQv1yaFHwwTDhdyGim8TpA5UgjFDAAph2O
         eLHmQq3vJGLLLM2PETxN9QYAt76NXZQB/64aZHb8cglUuGTdHlrNBnnATWnWC3w0jRrH
         dfUg==
X-Forwarded-Encrypted: i=1; AJvYcCVFMLJgXMlo5W5IcCjn5hKyZRX2MHfPzM3wCaOwBkx3zzGWoF+tJCWMDbORoxRPWIBDWgBwX4ko9BQFdI6Xs/9pUw7ZpJYQq6BSFb2Pd889PyE/HBoTMCfMgZ3KmUc3iLHBK4xcwr10wv4ex9Cq5uFZC2sBtzuOHy1UlO5jksj9NATpgaGBXLxDKw==
X-Gm-Message-State: AOJu0YxUU6xI5qoPgpZXFBmarP3Zy4dhHtVJpMqALRzasKIzDyYvnVsC
	F42GEXHeP5tk9v5JnocTMgBL8K0MyggQ5wLKL0WtYS0OVQtiF/GhyA3PVL6GEHz3Rfke8QePH1c
	gxTSN9vS9G2joXCkt8pdR691ctLk=
X-Google-Smtp-Source: AGHT+IEnu03FR8JFSQifycdpZdIBld8Nxy1K+eVI2/iw75BYuHlS1IUh/3pjIIQrZ4L7UK2XEJZc66O8iR5FIsCb+Z8=
X-Received: by 2002:a17:90b:290:b0:29b:9e72:8ade with SMTP id
 az16-20020a17090b029000b0029b9e728ademr2608700pjb.13.1710442561101; Thu, 14
 Mar 2024 11:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-2-nmi@metaspace.dk>
 <ZfI8-14RUqGqoRd-@boqun-archlinux> <87il1ptck0.fsf@metaspace.dk>
In-Reply-To: <87il1ptck0.fsf@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Mar 2024 19:55:49 +0100
Message-ID: <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Boqun Feng <boqun.feng@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yexuan Yang <1182282462@bupt.edu.cn>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	Joel Granados <j.granados@samsung.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 9:58=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk>=
 wrote:
>
> Yes, good point. Another option suggested by Miguel is that
> `__blk_mq_free_request` need not be exported at all. We can make it
> non-static and then call it from
> `rust_helper_blk_mq_free_request_internal()`. Then only the latter will
> be in the kernel image symbol table, which might be better in terms of
> not exposing `__blk_mq_free_request()` directly.

The helper is not needed, i.e. what I meant was to make it non-static
and add it to `include/linux/blk-mq.h`.

Cheers,
Miguel

