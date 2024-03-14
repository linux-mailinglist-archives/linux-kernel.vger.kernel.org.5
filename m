Return-Path: <linux-kernel+bounces-103789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612D687C481
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13FAB21DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E457641A;
	Thu, 14 Mar 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArR2IdJa"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47176763F3;
	Thu, 14 Mar 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710449805; cv=none; b=TXa9RnzJC1BpBik4so3sxnM7H+Z7sIJZQ1ufXVa7VXvgvzMvhAauhpkZtxiUoQP22iI1kU8R9VotaF5t1Et0XfJJcJwBSfEP26s5JWNiG3EB3HizcebcqF+pYIAdZXWglNLYQhHOf0cJPojhXEQWfMB0EYLcd504tYE1645O82Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710449805; c=relaxed/simple;
	bh=vVexG+y35tQ9uiNulQsBhDXB6JraRtnHZp6M/RG+asg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEkMQuH5vGHB+zpmlDRkl9A+09NCb2Aqv9iKce2ckDFaQCuOWbh06WavVv0kGf0Vw193+PZLJvJD3J4ZbxjUILMyWB4aie25LW+fKwhjKrUk2dXNkZWbm0uQPjk0HvmUqkbA5jQ8HnhkqA1R6Xtf9e6TSZt4D0ZnnlFZoBQeabo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArR2IdJa; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c731ba369so1156382a91.3;
        Thu, 14 Mar 2024 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710449803; x=1711054603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVexG+y35tQ9uiNulQsBhDXB6JraRtnHZp6M/RG+asg=;
        b=ArR2IdJaBNB6LDskwV1CvU0y3BCddnsUJ15ZQea5mhdl7HVHeBJRHhocwskvkAvXXe
         qBvoUfuOsQiVhjhHP5XviKFca454LBq9X+5i5tfeX6pumPU73Rs6TiNktmE3X0SgPRPS
         DBt0/e9LJPsSZ8YXe3Bn4akZSlNtlusudo04KjDOGX2FrURlekhQbaGOJrAAenmEVya5
         Z2ojscwHEZSjHMgVEQ84R1j4bw0YkDRjlPpGYPmH+NwS7lXYuXIgm+w1TWCEXRriM3B7
         MN+5git9hsrT4varHBvm0kvKypVo57gH19mYR6zTX8C0KxX0WRkHfig1DeJV8P35RljF
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710449803; x=1711054603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVexG+y35tQ9uiNulQsBhDXB6JraRtnHZp6M/RG+asg=;
        b=ZyBysuIFfrncaJz1Il8NT2/4Iwrlynu6sez/MsZVzKrUmE0LuaJWgdhb5ZN9wsu7F2
         dBdfKs0jpchXD7/cOVmEOAoQudOTcvk02gq0svwdjEhN/3EEHmGcp+DP3CvkuKnoTKEb
         a8L+lTxfJ+4DiqFS5xyT0dvpm3JretDgD0PGAPyFMngnaSTUf54KGKnmVNIMlJajQf/i
         P5aqCbwcS9VaDfNLW5KoW7oSXm1mKMInKO1/Tv3LV1Vzer178H/sPkQofem+P6lMWNlr
         DCIHJwX8s4FZicC+R12/eHtj3AsErjhgoI7bngSIlSn4MCRZbF+4scZIMlbg0/eEGzo7
         r1KA==
X-Forwarded-Encrypted: i=1; AJvYcCWapOBqqoIcYdP6w4WpsOTttTH5uyaNdDMhwdtytTp76wLc4g+kUq5x05C6bzDlOce6H4qCTKehtonb+1f2RRpza6omA/KAiCM3BL9SMFNEHG9uaHNPDmsrRYRMwWzaUcGfjri0zLh/X4VJyDnHB3Xay2uzYJJxT1AoGy/j+xPff21+ZzN3Nv8ytg==
X-Gm-Message-State: AOJu0YwvP3tjm8Y4kvTfixOqi/OPEsIp921MhOc4dzALu3kK68F6Vf0g
	Lmkcp27Udat9h6os2GS8HSRkVKbrKSl7SC+83bBgx5UIRXnIVU5IOTEPXORFq/44JhDls2PnZSS
	w2CtTDJ2sza1BqK+ZnoqDjy/Wvk8=
X-Google-Smtp-Source: AGHT+IG4wxqkAxjdwKlg1zhlT5ni1nrZhArv7cmYlou+sBdAxdO9JwjEtP6sfS1qBKW4ZUbRHqGkBMyDjHAU8zKgLeM=
X-Received: by 2002:a17:90a:ce12:b0:29b:f2b1:6973 with SMTP id
 f18-20020a17090ace1200b0029bf2b16973mr2930051pju.20.1710449803547; Thu, 14
 Mar 2024 13:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-2-nmi@metaspace.dk>
 <ZfI8-14RUqGqoRd-@boqun-archlinux> <87il1ptck0.fsf@metaspace.dk>
 <CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
 <87plvwsjn5.fsf@metaspace.dk> <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
In-Reply-To: <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Mar 2024 21:56:31 +0100
Message-ID: <CANiq72noqwU9_wC28Emc2LNyD70JFcS+4MXWuwYUTUWq8ragCg@mail.gmail.com>
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

On Thu, Mar 14, 2024 at 8:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> In any case, if we really want to avoid exporting the original symbol
> (perhaps so that "only Rust" can use it -- or someone trying hard to
> bypass things on purpose), then we could still avoid the helper and
> instead write a non-generic `kernel`-private Rust function instead.

The advantages would be that we get the export done automatically and
that we could write in Rust, e.g. with restricted visibility.

But we could need `#[inline(never)]` (or ideally `#[used]` if it could
go on functions) or `#[no_mangle]` (but we would lose the mangling).

Anyway, the simplest is to export the original symbol, but we could
consider to provide support one way or another for this kind of
"helpers" (i.e. leaving the current helpers as those for macros and
inline functions), so that it is clear what symbols are only exported
for Rust use (and not other C code).

Cheers,
Miguel

