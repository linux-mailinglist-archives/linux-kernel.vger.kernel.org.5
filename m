Return-Path: <linux-kernel+bounces-103734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2287C3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E221C20DC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261157602B;
	Thu, 14 Mar 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="oelIcVXH"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CA757F5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710445283; cv=none; b=NVgEWLt8fKir9zyCUIq36UvlCF0xoSHfipTm36IcsyH5oSrx8kjaFcfLutHp84yn0LScuTViykGUkBjlspKZv9bLsm54fgi0qPBE/t8jPsQdHDUbW1eLgQk0wKQ+MBsEJPTTyTk0Ffo7QHG1Z4e4lA8aFkBnH59hhxpMh0O66wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710445283; c=relaxed/simple;
	bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cf2zSVs/6aGubUaOgz4bmNqZdjzjjUEgbDPEY6iCJpOLLyE5SIq10Ov5IIVSTVYmj55KBa6M3mRmzI+WTzK7Y91nG4UBJD/5U35Co2q/KrylwislpNLkeXMGgXy4ZfcF5Dd6+9inWQvpWzjWKMXyLNTByOF2+/HtiyVEzMaaOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=oelIcVXH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46692ec303so186120966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710445279; x=1711050079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
        b=oelIcVXHmAxAgJy++hRkxCKVyUb5JZiFiSwX6PT+K54sa6aWdq6+QmNCPY2vjzOxVB
         BImHM41VK05Bc3zhxrNYknDQNjth5ZliXoGozxhwA59IZSy1CBuAR6XYnT7CT2fL6jCM
         V3sbwrtJ5Z5NJ1KIhyEzbilcM0EBtXbCAV5/BEsvzGnPk9W0bqSGRIVyJT5+dQEf+00D
         d2X/8F/SqKPztERzQ2A8CndAXCWMcPcHc+R54eaVrRYaFCvtXsPNio9ENcThnMzTmhY+
         /9E8VctpEGb384dNrS242BoPCBSlkHE61f/8fB6eO7PPZS/KhTt2IfJ9T4KT7A5fjmmg
         mMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710445279; x=1711050079;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onEktwJBHB2eXNJMOcrh4ORRowNVQ4kkEBJ7zXW9BpA=;
        b=hkBrPoXbI3+e1ljQkBCYz+x7G7+XMqjcoYmG6Uf7z21IT4f6jQqk+sAaC8kEpYRajf
         VMdgJUGiI17BTlYQ1VhD18VjEbxTOESdSPbvSA4UmMSr/dfbDEbBFVDw5P2XfjxzCA0e
         ZeBDeY2lLC63t/V95Wj6mksRFL6EM0mVRYXAlhIgcgr2dvBYF7s+v+5A6sSGBQlGV4bU
         Snjs1WpuKL5QHXZyV5IH3qkeLqA/L05+VHkEiKNAlTQeeeiswGE4fE+ZuxdaHJSMtbhu
         agbtU4jRtfwjUrlhPVCC4WdUepFbWJdgGh3m/dHgBw3RvKs4TmaqADo7OLBSJ/++QS50
         5flg==
X-Forwarded-Encrypted: i=1; AJvYcCUTGmiDO7Csij3jxm1xgYVjUrFST0a3+BlNxPVVqcy5I/NBzOSmGOlHe6/4kotI+F4KyioTZRTDIfrn5ObDBpGFvWx0X+1PzJgshrbj
X-Gm-Message-State: AOJu0YwNUSRHZUwJxnPQ/twr93urJ7decCBo592FU5YrGcKmPpspvfPj
	mlluidOs+SsgbcMf3udEJXxtAyTARiUxdMNIsxnd620JmsnLnb2yRA/Swp2uZ0Q=
X-Google-Smtp-Source: AGHT+IH8czNlNagx2kXUJ8xAoaQoY9sfM4cx5YqDd4DehyKpFMZ6MjCDM1M528wBaOxegt8hCWznIQ==
X-Received: by 2002:a17:906:c0cc:b0:a46:2100:da56 with SMTP id bn12-20020a170906c0cc00b00a462100da56mr1804417ejb.55.1710445278810;
        Thu, 14 Mar 2024 12:41:18 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o11-20020a1709061b0b00b00a3fb9f1f10csm972383ejg.161.2024.03.14.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 12:41:18 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Jens Axboe <axboe@kernel.dk>,
  Christoph Hellwig <hch@lst.de>,  Keith Busch <kbusch@kernel.org>,  Damien
 Le Moal <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,
  Hannes Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,  Niklas Cassel
 <Niklas.Cassel@wdc.com>,  Greg KH <gregkh@linuxfoundation.org>,  Matthew
 Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Alice Ryhl <aliceryhl@google.com>,  Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,  Luis Chamberlain <mcgrof@kernel.org>,  Yexuan
 Yang <1182282462@bupt.edu.cn>,  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado
 <sergio.collado@gmail.com>,  Joel Granados <j.granados@samsung.com>,
  "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,  Daniel Gomez
 <da.gomez@samsung.com>,  open list <linux-kernel@vger.kernel.org>,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
  "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
  "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <87plvwsjn5.fsf@metaspace.dk> (Andreas Hindborg's message of
	"Thu, 14 Mar 2024 20:22:54 +0100")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 20:41:10 +0100
Message-ID: <87h6h8sisp.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <nmi@metaspace.dk> writes:

> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>
>> On Thu, Mar 14, 2024 at 9:58=E2=80=AFAM Andreas Hindborg <nmi@metaspace.=
dk> wrote:
>>>
>>> Yes, good point. Another option suggested by Miguel is that
>>> `__blk_mq_free_request` need not be exported at all. We can make it
>>> non-static and then call it from
>>> `rust_helper_blk_mq_free_request_internal()`. Then only the latter will
>>> be in the kernel image symbol table, which might be better in terms of
>>> not exposing `__blk_mq_free_request()` directly.
>>
>> The helper is not needed, i.e. what I meant was to make it non-static
>> and add it to `include/linux/blk-mq.h`.
>
> The way the current code compiles, <kernel::block::mq::Request as
> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
> module. A relocation for `rust_helper_blk_mq_free_request_internal`
> appears in `rnull_mod.ko`. I didn't test it yet, but if
> `__blk_mq_free_request` (or the helper) is not exported, I don't think
> this would be possible?
>

I just tested what you suggested Miguel, and I get a link error for
`__blk_mq_free_request` being undefined when the module is linked. This
is even though the code that calls this function lives in the `kernel`
crate, because it is inlined.

BR Andreas

