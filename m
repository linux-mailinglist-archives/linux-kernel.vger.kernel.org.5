Return-Path: <linux-kernel+bounces-35418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1088390B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618781F2246D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1864B5F563;
	Tue, 23 Jan 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="id9yOuBb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438A5F578
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018434; cv=none; b=o3t7WFLSVAYy5wOs9rcuW6cdvqJCFWlgf86Ktns5mKC3p4KQ4jvCD9k8MBSwU3PEMna/uvjDSY2y3rJpqfiA/+J3frLTZEnDSCIr/sxgEmBfP4Ldhpid625zzbpNmwxKhk9DY0udADUZvuFwJJeHLKGlo5A4TmHY3T4EaQxO3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018434; c=relaxed/simple;
	bh=tsHdP4SaBp55LhE3gGTBwtFXJ1hu9Zclof97rfj+TzE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=diwqK2zb5aZkhE4Lx1zdg2XJgofqoYAq/VkwIFTk3J79PNNaRYiF96M1okwLOCwfYkfqnVHq48wiLqI9dmuzMtXkpSVEZAIP1Xf6sYws9Qwsn7+L45+hmmVvzGw/9xpzvZPysKYom7t+PyFud5N+XW4i6eXNOkiMoD3mHrmx6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=id9yOuBb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40eb0836f8dso16692595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1706018429; x=1706623229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MztHQ/jR+d2tN0W3qQFoilN32wrXuXzc1YcFAuUZ0aI=;
        b=id9yOuBb/qW5DwUO7ETOthp8TfXNqdakz1ME+pmJQ7SCCqorwxhQ8O91tYjPGIfWNK
         C3zRVhCeBZ3OrS+aOVek1fArl6IkG5JFxCnbbrTopBd6OXNab1HVWM4EL19Trl3+SA/w
         87bC8pcStCTX7GFVt7HqgDeGWYEf75jVJr/O2XwCeWIVg7n6OIoHTkgJzLLCcd1RNnJu
         rafqaZzxLpdHrsFBO1hT6XV9+HQ/wGzUy4KR/jCa33msEGePHAXYKBWQWzJqTeFpwtvO
         /9MyxNzmPd0nlNe7msJBU6eWGVxeLE1Zfwtu30sY3Ab3ArcqPNc2NKeM3aeLtm6hjGFb
         r7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018429; x=1706623229;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MztHQ/jR+d2tN0W3qQFoilN32wrXuXzc1YcFAuUZ0aI=;
        b=pWoTMRCfNHuTGJ346I5OFpgDAqIEmf81eeRYCI9q5weqjOLc9wIXL10UK67DqN9Mgs
         GlsfWiDfYgnomlUEvLqj9u5B//XBfpqpouzHjEnA34prfay2PT4MIx80rJNNRmYQVrnr
         beWvTuSj5zI+bry9JbewbNFOGV6wTPn06iJM0lLLSN46qmxG6lXUpQPXc99zzRm1TVil
         nvcm1KGoS3G4qLibVBLiCOARa9ie2lmTnTDYFJm2XFb5HGR1VVZiWVE5M0r1k2uVPGxf
         +WZAxC9sbbbN1ZnBJnBGI4+P6dq6Z0LD4YmO5vKn73xNtlOVLMoCLQtHD20f9eB70lHq
         Qc8Q==
X-Gm-Message-State: AOJu0YzEo722hHIQAJnLiWaoXV1t0I8MhisUAMqZH24k/MCY6tB1HjQi
	UrMV1BeBGopEuv5n92x1C9LKJNjt9mMO7ALXwi9M2cDaNToChvBpm6RCLgPlcug=
X-Google-Smtp-Source: AGHT+IE5AB4guwQBC7A4aJQ+gcIFXJ/hOOzwRn4rWxQtrn0oC5ntvZjrClrP9TO/ZKVOkDKrPUiZbw==
X-Received: by 2002:a05:600c:1e23:b0:40e:758a:96d5 with SMTP id ay35-20020a05600c1e2300b0040e758a96d5mr161123wmb.167.1706018428717;
        Tue, 23 Jan 2024 06:00:28 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o9-20020a056402444900b00559dd0a5146sm7932904edb.44.2024.01.23.06.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:00:26 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-4-nmi@metaspace.dk>
 <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
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
Subject: Re: [RFC PATCH 03/11] rust: block: introduce `kernel::block::mq`
 module
Date: Fri, 12 Jan 2024 10:18:15 +0100
In-reply-to: <iL2M45BoRlK6yS9y8uo0A5yUXcZWMkdk3vtH3LRFSWXfvPVagVZ-0YC7taIKOBFUcjJYA_2xNNFPoC4WL-_ulCHOLkbqvsZlIshE_LEeYtU=@proton.me>
Message-ID: <87il3kjgk0.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Benno,

Benno Lossin <benno.lossin@proton.me> writes:

<...>

>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen=
_disk.rs
>> new file mode 100644
>> index 000000000000..50496af15bbf
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! GenDisk abstraction
>> +//!
>> +//! C header: [`include/linux/blkdev.h`](../../include/linux/blkdev.h)
>> +//! C header: [`include/linux/blk_mq.h`](../../include/linux/blk_mq.h)
>> +
>> +use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>> +use crate::{
>> +    bindings, error::from_err_ptr, error::Result, sync::Arc, types::For=
eignOwnable,
>> +    types::ScopeGuard,
>> +};
>> +use core::fmt::{self, Write};
>> +
>> +/// A generic block device
>> +///
>> +/// # Invariants
>> +///
>> +///  - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
>> +pub struct GenDisk<T: Operations> {
>> +    _tagset: Arc<TagSet<T>>,
>> +    gendisk: *mut bindings::gendisk,
>
> Why are these two fields not embedded? Shouldn't the user decide where
> to allocate?

The `TagSet` can be shared between multiple `GenDisk`. Using an `Arc`
seems resonable?

For the `gendisk` field, the allocation is done by C and the address
must be stable. We are owning the pointee and must drop it when it goes out
of scope. I could do this:

#[repr(transparent)]
struct GenDisk(Opaque<bindings::gendisk>);

struct UniqueGenDiskRef {
    _tagset: Arc<TagSet<T>>,
    gendisk: Pin<&'static mut GenDisk>,

}

but it seems pointless. `struct GenDisk` would not be pub in that case. Wha=
t do you think?

>
>> +}
>> +
>> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `=
Arc` to a
>> +// `TagSet` It is safe to send this to other threads as long as T is Se=
nd.
>> +unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
>> +
>> +impl<T: Operations> GenDisk<T> {
>> +    /// Try to create a new `GenDisk`
>> +    pub fn try_new(tagset: Arc<TagSet<T>>, queue_data: T::QueueData) ->=
 Result<Self> {
>> +        let data =3D queue_data.into_foreign();
>> +        let recover_data =3D ScopeGuard::new(|| {
>> +            // SAFETY: T::QueueData was created by the call to `into_fo=
reign()` above
>> +            unsafe { T::QueueData::from_foreign(data) };
>> +        });
>> +
>> +        let lock_class_key =3D crate::sync::LockClassKey::new();
>> +
>> +        // SAFETY: `tagset.raw_tag_set()` points to a valid and initial=
ized tag set
>> +        let gendisk =3D from_err_ptr(unsafe {
>> +            bindings::__blk_mq_alloc_disk(tagset.raw_tag_set(), data as=
 _, lock_class_key.as_ptr())
>
> Avoid `as _` casts.

=F0=9F=91=8D

>
>> +        })?;
>> +
>> +        const TABLE: bindings::block_device_operations =3D bindings::bl=
ock_device_operations {
>> +            submit_bio: None,
>> +            open: None,
>> +            release: None,
>> +            ioctl: None,
>> +            compat_ioctl: None,
>> +            check_events: None,
>> +            unlock_native_capacity: None,
>> +            getgeo: None,
>> +            set_read_only: None,
>> +            swap_slot_free_notify: None,
>> +            report_zones: None,
>> +            devnode: None,
>> +            alternative_gpt_sector: None,
>> +            get_unique_id: None,
>> +            owner: core::ptr::null_mut(),
>> +            pr_ops: core::ptr::null_mut(),
>> +            free_disk: None,
>> +            poll_bio: None,
>> +        };
>> +
>> +        // SAFETY: gendisk is a valid pointer as we initialized it above
>> +        unsafe { (*gendisk).fops =3D &TABLE };
>> +
>> +        recover_data.dismiss();
>> +        Ok(Self {
>> +            _tagset: tagset,
>> +            gendisk,
>> +        })
>> +    }
>> +
>> +    /// Set the name of the device
>> +    pub fn set_name(&self, args: fmt::Arguments<'_>) -> Result {
>> +        let mut raw_writer =3D RawWriter::from_array(unsafe { &mut (*se=
lf.gendisk).disk_name });
>
> Missing `SAFETY` also see below.

Yes, I have a few of those. Will add for next version.

>
>> +        raw_writer.write_fmt(args)?;
>> +        raw_writer.write_char('\0')?;
>> +        Ok(())
>> +    }
>> +
>> +    /// Register the device with the kernel. When this function return,=
 the
>> +    /// device is accessible from VFS. The kernel may issue reads to th=
e device
>> +    /// during registration to discover partition infomation.
>> +    pub fn add(&self) -> Result {
>> +        crate::error::to_result(unsafe {
>> +            bindings::device_add_disk(core::ptr::null_mut(), self.gendi=
sk, core::ptr::null_mut())
>> +        })
>> +    }
>> +
>> +    /// Call to tell the block layer the capcacity of the device
>> +    pub fn set_capacity(&self, sectors: u64) {
>> +        unsafe { bindings::set_capacity(self.gendisk, sectors) };
>> +    }
>> +
>> +    /// Set the logical block size of the device
>> +    pub fn set_queue_logical_block_size(&self, size: u32) {
>> +        unsafe { bindings::blk_queue_logical_block_size((*self.gendisk)=
queue, size) };
>> +    }
>> +
>> +    /// Set the physical block size of the device
>
> What does this *do*? I do not think the doc string gives any meaningful
> information not present in the function name (this might just be,
> because I have no idea of what this is and anyone with just a little
> more knowledge would know, but I still wanted to mention it).

I'll add some more context.

>
>> +    pub fn set_queue_physical_block_size(&self, size: u32) {
>> +        unsafe { bindings::blk_queue_physical_block_size((*self.gendisk=
).queue, size) };
>> +    }
>> +
>> +    /// Set the rotational media attribute for the device
>> +    pub fn set_rotational(&self, rotational: bool) {
>> +        if !rotational {
>> +            unsafe {
>> +                bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONRO=
T, (*self.gendisk).queue)
>> +            };
>> +        } else {
>> +            unsafe {
>> +                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NON=
ROT, (*self.gendisk).queue)
>> +            };
>> +        }
>> +    }
>> +}
>> +
>> +impl<T: Operations> Drop for GenDisk<T> {
>> +    fn drop(&mut self) {
>> +        let queue_data =3D unsafe { (*(*self.gendisk).queue).queuedata =
};
>> +
>> +        unsafe { bindings::del_gendisk(self.gendisk) };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()=
` with a
>> +        // call to `ForeignOwnable::into_pointer()` to create `queuedat=
a`.
>> +        // `ForeignOwnable::from_foreign()` is only called here.
>> +        let _queue_data =3D unsafe { T::QueueData::from_foreign(queue_d=
ata) };
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/o=
perations.rs
>> new file mode 100644
>> index 000000000000..fb1ab707d1f0
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -0,0 +1,260 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides an interface for blk-mq drivers to implement.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::{tag_set::TagSetRef, Request},
>> +    error::{from_result, Result},
>> +    types::ForeignOwnable,
>> +};
>> +use core::{marker::PhantomData, pin::Pin};
>> +
>> +/// Implement this trait to interface blk-mq as block devices
>> +#[macros::vtable]
>> +pub trait Operations: Sized {
>
> Is this trait really safe? Are there **no** requirements for e.g.
> `QueueData`? So could I use `Box<()>`?

Yes, it is intended to be safe. `ForeignOwnable` covers safety
requirements for these associated data types.

>
>> +    /// Data associated with a request. This data is located next to th=
e request
>> +    /// structure.
>> +    type RequestData;
>> +
>> +    /// Data associated with the `struct request_queue` that is allocat=
ed for
>> +    /// the `GenDisk` associated with this `Operations` implementation.
>> +    type QueueData: ForeignOwnable;
>> +
>> +    /// Data associated with a dispatch queue. This is stored as a poin=
ter in
>> +    /// `struct blk_mq_hw_ctx`.
>> +    type HwData: ForeignOwnable;
>> +
>> +    /// Data associated with a tag set. This is stored as a pointer in =
`struct
>> +    /// blk_mq_tag_set`.
>> +    type TagSetData: ForeignOwnable;
>> +
>> +    /// Called by the kernel to allocate a new `RequestData`. The struc=
ture will
>> +    /// eventually be pinned, so defer initialization to `init_request_=
data()`
>> +    fn new_request_data(
>> +        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_=
>,
>> +    ) -> Result<Self::RequestData>;
>> +
>> +    /// Called by the kernel to initialize a previously allocated `Requ=
estData`
>> +    fn init_request_data(
>> +        _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_=
>,
>> +        _data: Pin<&mut Self::RequestData>,
>> +    ) -> Result {
>> +        Ok(())
>> +    }
>> +
>> +    /// Called by the kernel to queue a request with the driver. If `is=
_last` is
>> +    /// `false`, the driver is allowed to defer commiting the request.
>> +    fn queue_rq(
>> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
>> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
>> +        rq: &Request<Self>,
>> +        is_last: bool,
>> +    ) -> Result;
>> +
>> +    /// Called by the kernel to indicate that queued requests should be=
 submitted
>> +    fn commit_rqs(
>> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
>> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
>> +    );
>> +
>> +    /// Called by the kernel when the request is completed
>> +    fn complete(_rq: &Request<Self>);
>> +
>> +    /// Called by the kernel to allocate and initialize a driver specif=
ic hardware context data
>> +    fn init_hctx(
>> +        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
>> +        hctx_idx: u32,
>> +    ) -> Result<Self::HwData>;
>> +
>> +    /// Called by the kernel to poll the device for completed requests.=
 Only used for poll queues.
>> +    fn poll(_hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>) -=
> i32 {
>> +        unreachable!()
>
> Why are these implemented this way? Should this really panic? Maybe
> return an error? Why `i32` as the return type? If it can error it should
> be `Result<u32>`.

I will update in accordance with the new documentation for `#[vtable]`.

Return type should be `bool`, I will change it. It inherited the int
from `core::ffi::c_int`.

>
>> +    }
>> +
>> +    /// Called by the kernel to map submission queues to CPU cores.
>> +    fn map_queues(_tag_set: &TagSetRef) {
>> +        unreachable!()
>> +    }
>> +
>> +    // There is no need for exit_request() because `drop` will be calle=
d.
>> +}
>> +
>> +pub(crate) struct OperationsVtable<T: Operations>(PhantomData<T>);
>> +
>> +impl<T: Operations> OperationsVtable<T> {
>> +    // # Safety
>> +    //
>> +    // The caller of this function must ensure that `hctx` and `bd` are=
 valid
>> +    // and initialized. The pointees must outlive this function. Further
>> +    // `hctx->driver_data` must be a pointer created by a call to
>> +    // `Self::init_hctx_callback()` and the pointee must outlive this f=
unction.
>> +    // This function must not be called with a `hctx` for which
>> +    // `Self::exit_hctx_callback()` has been called.
>> +    unsafe extern "C" fn queue_rq_callback(
>> +        hctx: *mut bindings::blk_mq_hw_ctx,
>> +        bd: *const bindings::blk_mq_queue_data,
>> +    ) -> bindings::blk_status_t {
>> +        // SAFETY: `bd` is valid as required by the safety requirement =
for this function.
>> +        let rq =3D unsafe { (*bd).rq };
>> +
>> +        // SAFETY: The safety requirement for this function ensure that
>> +        // `(*hctx).driver_data` was returned by a call to
>> +        // `Self::init_hctx_callback()`. That function uses
>> +        // `PointerWrapper::into_pointer()` to create `driver_data`. Fu=
rther,
>> +        // the returned value does not outlive this function and
>> +        // `from_foreign()` is not called until `Self::exit_hctx_callba=
ck()` is
>> +        // called. By the safety requirement of this function and contr=
act with
>> +        // the `blk-mq` API, `queue_rq_callback()` will not be called a=
fter that
>> +        // point.
>
> This safety section and the others here are rather long and mostly
> repeat themselves. Is it possible to put this in its own module and
> explain the safety invariants in that module and then in these safety
> sections just refer to some labels from that section?
>
> I think we should discuss this in our next meeting.

Not sure about the best way to do this. Lets talk.

<...>

>> +
>> +    pub(crate) const unsafe fn build() -> &'static bindings::blk_mq_ops=
 {
>> +        &Self::VTABLE
>> +    }
>
> Why is this function `unsafe`?

I don't think it needs to be unsafe, thanks.

>
>> +}
>
> Some `# Safety` and `SAFETY` missing in this hunk.
>
>> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/r=
aw_writer.rs
>> new file mode 100644
>> index 000000000000..25c16ee0b1f7
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/raw_writer.rs
>> @@ -0,0 +1,30 @@
>> +use core::fmt::{self, Write};
>> +
>> +pub(crate) struct RawWriter {
>> +    ptr: *mut u8,
>> +    len: usize,
>> +}
>> +
>> +impl RawWriter {
>> +    unsafe fn new(ptr: *mut u8, len: usize) -> Self {
>> +        Self { ptr, len }
>> +    }
>> +
>> +    pub(crate) fn from_array<const N: usize>(a: &mut [core::ffi::c_char=
; N]) -> Self {
>> +        unsafe { Self::new(&mut a[0] as *mut _ as _, N) }
>> +    }
>
> This function needs to be `unsafe`, because it never captures the
> lifetime of `a`. I can write:
>     let mut a =3D Box::new([0; 10]);
>     let mut writer =3D RawWriter::from_array(&mut *a);
>     drop(a);
>     writer.write_str("Abc"); // UAF
> Alternatively add a lifetime to `RawWriter`.

Yes, a lifetime is missing in RawWriter, thanks.

>
>> +}
>> +
>> +impl Write for RawWriter {
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        let bytes =3D s.as_bytes();
>> +        let len =3D bytes.len();
>> +        if len > self.len {
>> +            return Err(fmt::Error);
>> +        }
>> +        unsafe { core::ptr::copy_nonoverlapping(&bytes[0], self.ptr, le=
n) };
>> +        self.ptr =3D unsafe { self.ptr.add(len) };
>> +        self.len -=3D len;
>> +        Ok(())
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/requ=
est.rs
>> new file mode 100644
>> index 000000000000..e95ae3fd71ad
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides a wrapper for the C `struct request` type.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::Operations,
>> +    error::{Error, Result},
>> +};
>> +use core::marker::PhantomData;
>> +
>> +/// A wrapper around a blk-mq `struct request`. This represents an IO r=
equest.
>> +pub struct Request<T: Operations> {
>> +    ptr: *mut bindings::request,
>
> Why is this not embedded?

I have changed it to `struct Request(Opaque<bindings::request>)` for
next version =F0=9F=91=8D

>
>> +    _p: PhantomData<T>,
>> +}
>> +
>> +impl<T: Operations> Request<T> {
>> +    pub(crate) unsafe fn from_ptr(ptr: *mut bindings::request) -> Self {
>> +        Self {
>> +            ptr,
>> +            _p: PhantomData,
>> +        }
>> +    }
>> +
>> +    /// Get the command identifier for the request
>> +    pub fn command(&self) -> u32 {
>> +        unsafe { (*self.ptr).cmd_flags & ((1 << bindings::REQ_OP_BITS) =
- 1) }
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request has been i=
ssued by the driver
>> +    pub fn start(&self) {
>> +        unsafe { bindings::blk_mq_start_request(self.ptr) };
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request has been c=
ompleted without errors
>> +    // TODO: Consume rq so that we can't use it after ending it?
>> +    pub fn end_ok(&self) {
>> +        unsafe { bindings::blk_mq_end_request(self.ptr, bindings::BLK_S=
TS_OK as _) };
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request completed =
with an error
>> +    pub fn end_err(&self, err: Error) {
>> +        unsafe { bindings::blk_mq_end_request(self.ptr, err.to_blk_stat=
us()) };
>> +    }
>> +
>> +    /// Call this to indicate that the request completed with the statu=
s indicated by `status`
>> +    pub fn end(&self, status: Result) {
>> +        if let Err(e) =3D status {
>> +            self.end_err(e);
>> +        } else {
>> +            self.end_ok();
>> +        }
>> +    }
>> +
>> +    /// Call this to schedule defered completion of the request
>> +    // TODO: Consume rq so that we can't use it after completing it?
>> +    pub fn complete(&self) {
>> +        if !unsafe { bindings::blk_mq_complete_request_remote(self.ptr)=
 } {
>> +            T::complete(&unsafe { Self::from_ptr(self.ptr) });
>> +        }
>> +    }
>> +
>> +    /// Get the target sector for the request
>> +    #[inline(always)]
>
> Why is this `inline(always)`?

Compiler would not inline from kernel crate to modules without this. I
will check if this is still the case.

>
>> +    pub fn sector(&self) -> usize {
>> +        unsafe { (*self.ptr).__sector as usize }
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_=
set.rs
>> new file mode 100644
>> index 000000000000..d122db7f6d0e
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides the `TagSet` struct to wrap the C `struct blk_=
mq_tag_set`.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](../../include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::{operations::OperationsVtable, Operations},
>> +    error::{Error, Result},
>> +    sync::Arc,
>> +    types::ForeignOwnable,
>> +};
>> +use core::{cell::UnsafeCell, convert::TryInto, marker::PhantomData};
>> +
>> +/// A wrapper for the C `struct blk_mq_tag_set`
>> +pub struct TagSet<T: Operations> {
>> +    inner: UnsafeCell<bindings::blk_mq_tag_set>,
>> +    _p: PhantomData<T>,
>> +}
>> +
>> +impl<T: Operations> TagSet<T> {
>> +    /// Try to create a new tag set
>> +    pub fn try_new(
>> +        nr_hw_queues: u32,
>> +        tagset_data: T::TagSetData,
>> +        num_tags: u32,
>> +        num_maps: u32,
>> +    ) -> Result<Arc<Self>> {
>
> Why force the users to use `Arc`?

Changed to return a `PinInit<TagSet>` for next version.

>
>> +        let tagset =3D Arc::try_new(Self {
>> +            inner: UnsafeCell::new(bindings::blk_mq_tag_set::default()),
>> +            _p: PhantomData,
>> +        })?;
>> +
>> +        // SAFETY: We just allocated `tagset`, we know this is the only=
 reference to it.
>> +        let inner =3D unsafe { &mut *tagset.inner.get() };
>> +
>> +        inner.ops =3D unsafe { OperationsVtable::<T>::build() };
>> +        inner.nr_hw_queues =3D nr_hw_queues;
>> +        inner.timeout =3D 0; // 0 means default which is 30 * HZ in C
>> +        inner.numa_node =3D bindings::NUMA_NO_NODE;
>> +        inner.queue_depth =3D num_tags;
>> +        inner.cmd_size =3D core::mem::size_of::<T::RequestData>().try_i=
nto()?;
>> +        inner.flags =3D bindings::BLK_MQ_F_SHOULD_MERGE;
>> +        inner.driver_data =3D tagset_data.into_foreign() as _;
>> +        inner.nr_maps =3D num_maps;
>> +
>> +        // SAFETY: `inner` points to valid and initialised memory.
>> +        let ret =3D unsafe { bindings::blk_mq_alloc_tag_set(inner) };
>> +        if ret < 0 {
>> +            // SAFETY: We created `driver_data` above with `into_foreig=
n`
>> +            unsafe { T::TagSetData::from_foreign(inner.driver_data) };
>> +            return Err(Error::from_errno(ret));
>> +        }
>> +
>> +        Ok(tagset)
>> +    }
>> +
>> +    /// Return the pointer to the wrapped `struct blk_mq_tag_set`
>> +    pub(crate) fn raw_tag_set(&self) -> *mut bindings::blk_mq_tag_set {
>> +        self.inner.get()
>> +    }
>> +}
>> +
>> +impl<T: Operations> Drop for TagSet<T> {
>> +    fn drop(&mut self) {
>> +        let tagset_data =3D unsafe { (*self.inner.get()).driver_data };
>> +
>> +        // SAFETY: `inner` is valid and has been properly initialised d=
uring construction.
>> +        unsafe { bindings::blk_mq_free_tag_set(self.inner.get()) };
>> +
>> +        // SAFETY: `tagset_data` was created by a call to
>> +        // `ForeignOwnable::into_foreign` in `TagSet::try_new()`
>> +        unsafe { T::TagSetData::from_foreign(tagset_data) };
>> +    }
>> +}
>> +
>> +/// A tag set reference. Used to control lifetime and prevent drop of T=
agSet references passed to
>> +/// `Operations::map_queues()`
>> +pub struct TagSetRef {
>> +    ptr: *mut bindings::blk_mq_tag_set,
>> +}
>> +
>> +impl TagSetRef {
>> +    pub(crate) unsafe fn from_ptr(tagset: *mut bindings::blk_mq_tag_set=
) -> Self {
>> +        Self { ptr: tagset }
>> +    }
>> +
>> +    pub fn ptr(&self) -> *mut bindings::blk_mq_tag_set {
>> +        self.ptr
>> +    }
>> +}
>
> This is a **very** thin abstraction, why is it needed?

It is not. I changed it to `&TagSet`, thanks.


Thanks for the comments!

Best regards,
Andreas

