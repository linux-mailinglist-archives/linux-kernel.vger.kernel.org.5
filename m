Return-Path: <linux-kernel+bounces-104128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0887C979
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F421F223B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D240D14A99;
	Fri, 15 Mar 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="FpDoodmo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313F1426E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710489181; cv=none; b=iI4crHKPJhvSxx1wXZ9gZ94HvqEu6VORuYfPD7aIHf0S5CSr5Van9uEtf7Hd4vPZbjWT7lKwCF7lIYLVpm0yOM8Okr9JxCtH/Ma38/qNFIkjbrwTTyN5dGQtIlaYfMlbyVBvNWe2wtXS3X7W5nSdk8qalcDoy4sl+fHaLCzPsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710489181; c=relaxed/simple;
	bh=fKPj1XO0uWZHux7BrNWQJTo/4+56D+wBsGix9OTtOtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W5StMUUy6r+cihMXMzHNirEPHJujJV+uLFB/Mz11Tk7QfXYeqnhRlC1CXWOsM3ISlUT7LmP+EAR2YyX22HgVlBe4AFRh42+6jjxr6R4n+W5siugD8wu+xsBGtmKabjCWhQvueI2V/pKnvGgA7ulufvsOLhsp0qpCFX3bHRLzTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=FpDoodmo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46692ec303so239848766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710489176; x=1711093976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXPP3lJYG4o/agsHuJCSdDmnxTSG2DCox+x3uG23L18=;
        b=FpDoodmoXqEe6hPy6+1y5/Dr+WNp/Q7zvhg11e+5fSfMqPwe6yhhGoGlPyq5r8gaDt
         fuSqsroJsqtMUHZYqptnunmNuGpZbSvCG+FMrLsj3h7vLHUQhOHiIYe7ZOpOXmpt7kQe
         Df6EzyDtEvE/k1U+TKR94osfjbl5k4y2zjXmTBJQA/7L6Bj/dVSpKrDJOovXtxbgeVAJ
         Evr7NSqSbAo5nRt7XDKAbwKQXRXZwKC18Fd3JL0EjLio4WZVc/m+Pg6VT06HDXsrHvrn
         1w0lFma0CpAyLYVcBzKWDuudhNaV8HOopQHEA+vNGdVt75Qwd2gbIg1FnD50mwes5GnB
         lP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710489176; x=1711093976;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXPP3lJYG4o/agsHuJCSdDmnxTSG2DCox+x3uG23L18=;
        b=mcfLwFY+xmTtj2kngDldiW89GtDD1hWVhZl7HTpQYjxqnbDRhKKijyCcXl2+HvqxBP
         NjsYFwKMcJL4hlZdvNFYitiTpRUkmB2jMgSV7cLv7er2lZMhX6jsLOgIoH20fB1Az6h9
         E6EhFXAgRSL/Etj7kwT63gXKJYVjh5ZQT4b9uUn3KinXvkOhMJU60a1rOFtBgw5NAks4
         r2Elnlvnnud/NgPYPoXKNViApx6KhIy/JNKAoS2oNUgmny8usJi4BTUe5L9daeyRoH+h
         vKSRdMrh8TDy4HrwcjgD/zV4bXQuo2hQaXgCPrKgS63rw9m1WxmVKWfNVcP1nau3/NDB
         mw/A==
X-Forwarded-Encrypted: i=1; AJvYcCXeiBg95wUDckAf9zjtcdUPKmGU44oHTtwxzBHcnaa15ckxfXtNi8aRXVOjiipKkZRpkM3EwTVmg7zuFcKsRn/jh11A+mfhOhdGbtA2
X-Gm-Message-State: AOJu0Yyl4NyEbVhQYT48ADjvtEV3jojkW0BUFXmIj2zxUh8G0cfn0TTE
	X/o1C79n5Pi0LcM107B2vnbSL9K0TsWQpe02bWWKAPNyhYz5Xd/gmZgQiUSrN3M=
X-Google-Smtp-Source: AGHT+IFTO2DYaoVAjSu0M3KgKLmvykW5UhcvX3tBlSuDHByvqa85Ukxe2YkzMKaS2gKC+1a2E1+wEQ==
X-Received: by 2002:a17:907:c244:b0:a46:66d4:6d24 with SMTP id tj4-20020a170907c24400b00a4666d46d24mr3647427ejc.37.1710489176432;
        Fri, 15 Mar 2024 00:52:56 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id wr6-20020a170907700600b00a466c66804bsm1436273ejb.49.2024.03.15.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 00:52:56 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Jens Axboe
 <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Keith Busch
 <kbusch@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Christoph Hellwig <hch@lst.de>,
    Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart Van Assche
 <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>,  Alice Ryhl
 <aliceryhl@google.com>,  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis
 Chamberlain <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,
  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
 (Miguel
	Ojeda's message of "Thu, 14 Mar 2024 20:41:32 +0100")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
	<87il1ptck0.fsf@metaspace.dk>
	<CANiq72mzBe2npLo=CVR=ShyMuDmr0+TW4Gy0coPFQOBQZ_VnwQ@mail.gmail.com>
	<87plvwsjn5.fsf@metaspace.dk>
	<CANiq72neNUL1m0AbY78eXWJMov4fgjnNcQ_16SoT=ikJ3K7bZQ@mail.gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Fri, 15 Mar 2024 08:52:46 +0100
Message-ID: <8734ssrkxd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Thu, Mar 14, 2024 at 8:23=E2=80=AFPM Andreas Hindborg <nmi@metaspace.d=
k> wrote:
>>
>> The way the current code compiles, <kernel::block::mq::Request as
>> kernel::types::AlwaysRefCounted>::dec_ref` is inlined into the `rnull`
>> module. A relocation for `rust_helper_blk_mq_free_request_internal`
>> appears in `rnull_mod.ko`. I didn't test it yet, but if
>> `__blk_mq_free_request` (or the helper) is not exported, I don't think
>> this would be possible?
>
> Yeah, something needs to be exported since there is a generic
> involved, but even if you want to go the route of exporting only a
> different symbol, you would still want to put it in the C header so
> that you don't get the C missing declaration warning and so that we
> don't have to write the declaration manually in the helper.

That is what I did:

@@ -703,6 +703,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
=20
+void __blk_mq_free_request(struct request *rq);
 void blk_mq_free_request(struct request *rq);
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
 		unsigned int poll_flags);

> In any case, if we really want to avoid exporting the original symbol
> (perhaps so that "only Rust" can use it -- or someone trying hard to
> bypass things on purpose), then we could still avoid the helper and
> instead write a non-generic `kernel`-private Rust function instead.

Let's see what the block layer experts say first. Perhaps it is OK to
expose this symbol like this or maybe it can be made more generic
somehow.

Jens, Ming, Keith, do you have any comments?

Best regards,
Andreas

