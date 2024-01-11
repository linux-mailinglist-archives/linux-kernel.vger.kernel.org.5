Return-Path: <linux-kernel+bounces-23612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A582AF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DAE1C230DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6216412;
	Thu, 11 Jan 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="0D8Du/mR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2A15E90
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e6275e9beso911645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704978256; x=1705583056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUK2zT0BPfdydNsT5EJn5ISOoo/X1IO0KyG0yLRREqg=;
        b=0D8Du/mRMMnX8woI/jhgIOIO6kXrqNctCoMTiAhd+qWiD03E1FeQAu12HMjWPimMAR
         WLgj4uikobeKBzy1FQYt99v5wFQEXn4QcTsIpUJOS6Nr7vTIkJDbQa0tbdlvO/ZS7Jtr
         5lcQ6ivTQCQkToBmO0pReBo6luQnKoLmRZkKzoIDLfQ4kYwPqKCc4nHyLeJqnCNvtLsg
         aZUXttQa3HS9YT/xxYX9970dTODZXdQqpiQQIVyx2wqHQf3r5V42JP3vDf6qjPFp/22v
         JA5Y0PiAl5gpuVTkL1AuJMZmQcvH1EaL9kUVPAYndV7sVNSbgBfu4xFvmmP4Li6lKR2P
         4Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704978256; x=1705583056;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TUK2zT0BPfdydNsT5EJn5ISOoo/X1IO0KyG0yLRREqg=;
        b=WbR0U96fO8M+vIpu8b6nRjJjShbIKGMtJ8O+2AovdjJMb99JuCT6PkPbNNlYWRHYn5
         E8fTwaCPC9C5A9idEmdG4KXyGqiJLwneFxnC+8acsyMFTyFvQq98YR0s8cEQhK29Eozl
         dpBHHBSb2Jd6wkCARFuFC0e85ThdPsr4ojKZD7g3LzG8NUdK0J11jBSPjn8rlT2dIaXS
         zeuVS4xpptAF+4vpKKK4by4J7INeK9CpyctNdrHRn6wQtyqxgJdSsTCHAF7iuMbRVgd7
         RDtAgjJbEqCcXBDf0aGC2gWB1Fhud2ObGIhFfw414Cnoa7xqnOg2/qMZw9Kf3EFJY+Nf
         bOpQ==
X-Gm-Message-State: AOJu0Yx6pLVZrYChGzJfVXMFvbzsXpvmTtDw2YaRURI/Ym6aX8Wo3Y51
	XYAQzZZcAhMYbLirlEHF1VNxHcrT4h2f9w==
X-Google-Smtp-Source: AGHT+IFF9WMMBpGrWeM0BHAltriDJcHnFIQQ9fcUKOSAiJEE8dv3V03p30sSgqAaj2i4HbEA8OuF+A==
X-Received: by 2002:a05:600c:1e84:b0:40e:6259:82e3 with SMTP id be4-20020a05600c1e8400b0040e625982e3mr165637wmb.56.1704978256036;
        Thu, 11 Jan 2024 05:04:16 -0800 (PST)
Received: from localhost ([165.225.194.217])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b0040e549c77a1sm5762576wmq.32.2024.01.11.05.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:04:15 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-5-nmi@metaspace.dk>
 <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Hannes
 Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, linux-kernel@vger.kernel.org,
 gost.dev@samsung.com
Subject: Re: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio`
 module
Date: Thu, 11 Jan 2024 13:49:53 +0100
In-reply-to: <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me>
Message-ID: <87a5pcyqf8.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Benno Lossin <benno.lossin@proton.me> writes:

>> +/// A wrapper around a `struct bio` pointer
>> +///
>> +/// # Invariants
>> +///
>> +/// First field must alwyas be a valid pointer to a valid `struct bio`.
>> +pub struct Bio<'a>(
>> +    NonNull<crate::bindings::bio>,
>> +    core::marker::PhantomData<&'a ()>,
>
> Please make this a struct with named fields. Also this is rather a
> `BioRef`, right? Why can't `&Bio` be used and `Bio` embeds
> `bindings::bio`?

Yes, it feels better with a &Bio reference, thanks.

>> +);
>> +
>> +impl<'a> Bio<'a> {
>> +    /// Returns an iterator over segments in this `Bio`. Does not consi=
der
>> +    /// segments of other bios in this bio chain.
>> +    #[inline(always)]
>
> Why are these `inline(always)`? The compiler should inline them
> automatically?

No, the compiler would not inline into modules without them. I'll check
again if that is still the case.

>
>> +    pub fn segment_iter(&'a self) -> BioSegmentIterator<'a> {
>> +        BioSegmentIterator::new(self)
>> +    }
>> +
>> +    /// Get a pointer to the `bio_vec` off this bio
>> +    #[inline(always)]
>> +    fn io_vec(&self) -> *const bindings::bio_vec {
>> +        // SAFETY: By type invariant, get_raw() returns a valid pointer=
 to a
>> +        // valid `struct bio`
>> +        unsafe { (*self.get_raw()).bi_io_vec }
>> +    }
>> +
>> +    /// Return a copy of the `bvec_iter` for this `Bio`
>> +    #[inline(always)]
>> +    fn iter(&self) -> bindings::bvec_iter {
>
> Why does this return the bindings iter? Maybe rename to `raw_iter`?

Makes sense to rename it, thanks.

>> +        // SAFETY: self.0 is always a valid pointer
>> +        unsafe { (*self.get_raw()).bi_iter }
>> +    }
>> +
>> +    /// Get the next `Bio` in the chain
>> +    #[inline(always)]
>> +    fn next(&self) -> Option<Bio<'a>> {
>> +        // SAFETY: self.0 is always a valid pointer
>> +        let next =3D unsafe { (*self.get_raw()).bi_next };
>> +        Some(Self(NonNull::new(next)?, core::marker::PhantomData))
>
> Missing `INVARIANT` explaining why `next` is valid or null. Also why not
> use `Self::from_raw` here?

Thanks, will change that.

>
>> +    }
>> +
>> +    /// Return the raw pointer of the wrapped `struct bio`
>> +    #[inline(always)]
>> +    fn get_raw(&self) -> *const bindings::bio {
>> +        self.0.as_ptr()
>> +    }
>> +
>> +    /// Create an instance of `Bio` from a raw pointer. Does check that=
 the
>> +    /// pointer is not null.
>> +    #[inline(always)]
>> +    pub(crate) unsafe fn from_raw(ptr: *mut bindings::bio) -> Option<Bi=
o<'a>> {
>> +        Some(Self(NonNull::new(ptr)?, core::marker::PhantomData))
>> +    }
>> +}
>> +
>> +impl core::fmt::Display for Bio<'_> {
>> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
>> +        write!(f, "Bio {:?}", self.0.as_ptr())
>
> this will display as `Bio 0x7ff0654..` I think there should be some
> symbol wrapping the pointer like `Bio(0x7ff0654)` or `Bio { ptr: 0x7ff065=
4 }`.
>

Sure =F0=9F=91=8D

>> +    }
>> +}
>> +
>> +/// An iterator over `Bio`
>> +pub struct BioIterator<'a> {
>> +    pub(crate) bio: Option<Bio<'a>>,
>> +}
>> +
>> +impl<'a> core::iter::Iterator for BioIterator<'a> {
>> +    type Item =3D Bio<'a>;
>> +
>> +    #[inline(always)]
>> +    fn next(&mut self) -> Option<Bio<'a>> {
>> +        if let Some(current) =3D self.bio.take() {
>> +            self.bio =3D current.next();
>> +            Some(current)
>> +        } else {
>> +            None
>> +        }
>
> Can be rewritten as:
>     let current =3D self.bio.take()?;
>     self.bio =3D current.next();
>     Some(cur)
>

Thanks =F0=9F=91=8D

>> +    }
>> +}
>> diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
>> new file mode 100644
>> index 000000000000..acd328a6fe54
>> --- /dev/null
>> +++ b/rust/kernel/block/bio/vec.rs
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Types for working with `struct bio_vec` IO vectors
>> +//!
>> +//! C header: [`include/linux/bvec.h`](../../include/linux/bvec.h)
>> +
>> +use super::Bio;
>> +use crate::error::Result;
>> +use crate::pages::Pages;
>> +use core::fmt;
>> +use core::mem::ManuallyDrop;
>> +
>> +#[inline(always)]
>> +fn mp_bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings:=
:bvec_iter) -> u32 {
>> +    (unsafe { (*bvec_iter_bvec(bvec, iter)).bv_offset }) + iter.bi_bvec=
_done
>> +}
>> +
>> +#[inline(always)]
>> +fn mp_bvec_iter_page(
>> +    bvec: *const bindings::bio_vec,
>> +    iter: &bindings::bvec_iter,
>> +) -> *mut bindings::page {
>> +    unsafe { (*bvec_iter_bvec(bvec, iter)).bv_page }
>> +}
>> +
>> +#[inline(always)]
>> +fn mp_bvec_iter_page_idx(bvec: *const bindings::bio_vec, iter: &binding=
s::bvec_iter) -> usize {
>> +    (mp_bvec_iter_offset(bvec, iter) / crate::PAGE_SIZE) as usize
>> +}
>> +
>> +#[inline(always)]
>> +fn mp_bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bv=
ec_iter) -> u32 {
>> +    iter.bi_size
>> +        .min(unsafe { (*bvec_iter_bvec(bvec, iter)).bv_len } - iter.bi_=
bvec_done)
>> +}
>> +
>> +#[inline(always)]
>> +fn bvec_iter_bvec(
>> +    bvec: *const bindings::bio_vec,
>> +    iter: &bindings::bvec_iter,
>> +) -> *const bindings::bio_vec {
>> +    unsafe { bvec.add(iter.bi_idx as usize) }
>> +}
>> +
>> +#[inline(always)]
>> +fn bvec_iter_page(
>> +    bvec: *const bindings::bio_vec,
>> +    iter: &bindings::bvec_iter,
>> +) -> *mut bindings::page {
>> +    unsafe { mp_bvec_iter_page(bvec, iter).add(mp_bvec_iter_page_idx(bv=
ec, iter)) }
>> +}
>> +
>> +#[inline(always)]
>> +fn bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bvec_=
iter) -> u32 {
>> +    mp_bvec_iter_len(bvec, iter).min(crate::PAGE_SIZE - bvec_iter_offse=
t(bvec, iter))
>> +}
>> +
>> +#[inline(always)]
>> +fn bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings::bv=
ec_iter) -> u32 {
>> +    mp_bvec_iter_offset(bvec, iter) % crate::PAGE_SIZE
>> +}
>
> Why are these functions:
> - not marked as `unsafe`?
> - undocumented,
> - free functions.
>
> Can't these be directly implemented on `Segment<'_>`? If not,
> I think we should find some better way or make them `unsafe`.

Yes, you are right. I will move them to `Segment` and document them
better. They definitely need to be unsafe because they rely on C API
contract that the iterator is not indexing out of bounds.

[...]

>> +impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
>> +    type Item =3D Segment<'a>;
>> +
>> +    #[inline(always)]
>> +    fn next(&mut self) -> Option<Self::Item> {
>> +        if self.iter.bi_size =3D=3D 0 {
>> +            return None;
>> +        }
>> +
>> +        // Macro
>> +        // bio_vec =3D bio_iter_iovec(bio, self.iter)
>> +        // bio_vec =3D bvec_iter_bvec(bio.bi_io_vec, self.iter);
>
> Weird comment?

Yes, will fix, thanks.

Thanks for the comments!

BR Andreas

