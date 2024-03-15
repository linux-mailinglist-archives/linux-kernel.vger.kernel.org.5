Return-Path: <linux-kernel+bounces-104411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22A87CD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A785B21E29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAA3398B;
	Fri, 15 Mar 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="tRJTmdfu"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E05C28DB5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710506806; cv=none; b=NURRGop2HSymL+MR8VWojJHjXGNblv+hjRKVrZzTAj2NBLMLHR+ssu0iTeTv/BAfQ9uDwI99duVfSzd7dZsxTW8GFTl+uBr8Wg7BJBh5Kw2cPlWKvnjqPHjFCVPM8bWRsTEzpPzWQHJ4qEz29iBQc8qEpmqi0M40r24bHXB4aT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710506806; c=relaxed/simple;
	bh=hB8oK/5XlyqfQU8m5HzAPGAAkaEN7H/T9Hy28QbhaJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nDegnyCG01Q/n7DPM/8Yn1iigD2KW+qw437vTXOg9SfxRurYyAcqbT6mJazvRf7MHNb1BUkrziGE0mV3kdXevYi/CNO9AW2nw2gl1wKz5suFMHigGSEVBLdDEfSUlDrju1k04AfI3SPECTWzxZGuiuSW7zjLMt8HMr3qsj6PgBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=tRJTmdfu; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-413f8f5541eso8886695e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710506802; x=1711111602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx9d4AYyT6utH8rhaCIhMxw7irDgaTXcHKpwOBwjTHs=;
        b=tRJTmdfuPmCivpM6dGfWpFo8WvOXjW3TdmZnACkB8EIJ1+GegSP2b3Bl525JgcOA4Z
         xECGeYQAm9bcOniB0uwS6TQC+xYGd85hQyw7u73r8pEM6mzvoLPeiVNxWFbsmeyqz4ay
         JV0K1UOwiEakhbUo+YL00SfhdeQrnhUariToxO+0r2K8NVLH4gg+JttaMEUeH7w+2dla
         xXcEtnYQ5HQFl42ZuGo7Yo/uep42k3m25ixlan0LZK/Rx0pUkfQVK7m5Zf8ffMFAt79V
         uU/jf86AyInIrahXFku5RgsnH4Uax51Je16NwYsSAktnlY5T+4uy1MHkt/2ubt33CdGQ
         PNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710506802; x=1711111602;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kx9d4AYyT6utH8rhaCIhMxw7irDgaTXcHKpwOBwjTHs=;
        b=MLi8VxMVu6o5PHErj2YSKYPEYsiP1OlLNx4oTC6ScrgcjwYXFQjByirPyCMJm+DDTD
         P9HZBwJftfbBJgbTVptXG+l54xmsrWrnvuY+xgE5EmmM5eNBZCM9J5PQCsZB+XuOSMoj
         JC+qXJQQD2hBX9y0hlZQtaTJxEgjjzfIf2VHZA15dvZLt1jNBNRQHaiYS1ir4n1m7yil
         SXXLglELkWKcr/IN/cSPyKuILi90JI5vpujWaoGrdP0XfDqy3Xh3Bekl1Gp4j8HkfDfR
         TNBzTzBwdRKr+Le1ZPk/b3I36pGKxXjPk+hygOOYlOaUsTxIM5RIGgHj8X6MgDkYO0ST
         OQpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXS9qYizX5v39tDsae4FhqsACpIUPtiPear8WClPfFohX1VTHcG5UbgqqEDalgXq9eeRQEDc/fOgguzyEP6cR6IhNzoRxsVpmSOzcyT
X-Gm-Message-State: AOJu0YzA7sNvhEQCxINIYurdNavdF5TKkzG90KAmN9OJRaxsKoTFc8JG
	hKtjw9ltvYGEgJAgi+bzBzVn7iTewIqrX1QC+z1sG6LF4BHhnnpiLZUVG2tvZkM=
X-Google-Smtp-Source: AGHT+IHzHryvy+XKoDE8f2x1YmS2YdHacbOh+fS/Wum7//zeltKmmmsFfRAAIsN0rqJ6s/WmkhYYYw==
X-Received: by 2002:a05:600c:4ed4:b0:414:37f:276f with SMTP id g20-20020a05600c4ed400b00414037f276fmr718232wmq.22.1710506801605;
        Fri, 15 Mar 2024 05:46:41 -0700 (PDT)
Received: from localhost ([147.161.155.79])
        by smtp.gmail.com with ESMTPSA id j3-20020a05600c1c0300b004131310a29fsm5815498wms.15.2024.03.15.05.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 05:46:41 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,  Jens Axboe
 <axboe@kernel.dk>,  Keith Busch <kbusch@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Christoph Hellwig <hch@lst.de>,  Damien Le Moal
 <Damien.LeMoal@wdc.com>,  Bart Van Assche <bvanassche@acm.org>,  Hannes
 Reinecke <hare@suse.de>,  "linux-block@vger.kernel.org"
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
In-Reply-To: <ZfQ8Wz9gMqsN02Mv@fedora> (Ming Lei's message of "Fri, 15 Mar
	2024 20:17:31 +0800")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
	<CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
	<8734ssrkxd.fsf@metaspace.dk> <ZfQ8Wz9gMqsN02Mv@fedora>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Fri, 15 Mar 2024 13:46:30 +0100
Message-ID: <87o7bfr7bt.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ming Lei <ming.lei@redhat.com> writes:
> On Fri, Mar 15, 2024 at 08:52:46AM +0100, Andreas Hindborg wrote:
>> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
>>=20
>> > On Thu, Mar 14, 2024 at 8:23=E2=80=AFPM Andreas Hindborg <nmi@metaspac=
e.dk> wrote:
>> >>
>> >> The way the current code compiles, <kernel::block::mq::Request as
>> >> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
>> >> module. A relocation for `rust_helper_blk_mq_free_request_internal`
>> >> appears in `rnull_mod.ko`. I didn't test it yet, but if
>> >> `__blk_mq_free_request` (or the helper) is not exported, I don't think
>> >> this would be possible?
>> >
>> > Yeah, something needs to be exported since there is a generic
>> > involved, but even if you want to go the route of exporting only a
>> > different symbol, you would still want to put it in the C header so
>> > that you don't get the C missing declaration warning and so that we
>> > don't have to write the declaration manually in the helper.
>>=20
>> That is what I did:
>>=20
>> @@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *s=
et,
>>  		unsigned int set_flags);
>>  void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
>>=20=20
>> +void __blk_mq_free_request(struct request *rq);
>>  void blk_mq_free_request(struct request *rq);
>>  int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
>>  		unsigned int poll_flags);
>
> Can you explain in detail why one block layer internal helper is
> called into rnull driver directly? It never happens in C driver code.

It is not the rust null block driver that calls this symbol directly. It
is called by the Rust block device driver API. But because of inlining,
the symbol is referenced from the loadable object.

The reason we have to call this symbol directly is to ensure proper
lifetime of the `struct request`. For example in C, when a driver
converts a tag to a request, the developer makes sure to only ask for
requests which are outstanding in the driver. In Rust, for the API to be
sound, we must ensure that the developer cannot write safe code that
obtains a reference to a request that is not owned by the driver.

A similar issue exists in the null block driver when timer completions
are enabled. If the request is cancelled and the timer fires after the
request has been recycled, there is a problem because the timer holds a
reference to the request private data area.

To that end, I use the `atomic_t ref` field of the C `struct request`
and implement the `AlwaysRefCounted` Rust trait for the request type.
This is a smart pointer that owns a reference to the pointee. In this
way, the request is not freed and recycled until the smart pointer is
dropped. But if the smart pointer holds the last reference when it is
dropped, it must be able to free the request, and hence it has to call
`__blk_mq_free_request`.

We could tag the function with `#[inline(never)]`, but that would impact
performance.

Best regards,
Andreas

