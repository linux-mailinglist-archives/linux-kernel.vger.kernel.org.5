Return-Path: <linux-kernel+bounces-112111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D503A8875DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EE28360E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59AB82C9F;
	Fri, 22 Mar 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jrJM7e1T"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877FD82D7A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150869; cv=none; b=tELfuY1B9oWGl7T9Y4Z7raYtAFjYeyTeAzokulqzv0nUaerJLwW/tziZvoNadltG6f0KVFN+14Rhd9yTT8eFrFmuLHNOZUznBeA4iWGwssMyRxhhuWZ2J6PjlTFWHrlQ0JsB1yRXI5UGWVtKzZy+Cu1GEbS5cCP5u7bxa01Ti/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150869; c=relaxed/simple;
	bh=66HRfpzX/o38/4xCed2zqJBmXhtGmdbyDZ0R8s03NSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KPjqbgQnmInSoekr5D8LZLIE3oKc+UvcZyXM3w9OATcU/eTF3ypvkgCSghlNWeG8r8ZXI2pDDOdq1iXQIzRoBRuUmFn8pLVRULoEY9wsK3g8Med7mt5SJPb10bVGxoRrtidkbgJ5GGrh/7bVav4z6oAzBQJTvJ7SljJJKPVAM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jrJM7e1T; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1711150857; x=1711410057;
	bh=WIWZJaN6KGNWrAs5kM6lzilD6nXcRQzFiD5iVK3yU6g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jrJM7e1TDbJjkU3xF3nNlStiG+2p6ymaxtYewTmEOBOg95J+LUOV6oY6RIckr57vl
	 1A4hUYQuyABzvgKFbOx2U4PjfQvPuNuLM74VqgzrUMy7No/aeALNI+KSYcO+X3ccFN
	 YY4NolFt8Q9oxe6UyQfSSlc4PsepBxD7tXRDWpRHtj9jmHfq9ZgFJbpuCjXSPMwY5E
	 g29A+twWJm4Bhvl+N6ZYzpSRZftvyvs0dLwnz/WD7hcavV0DPu8zJTDfZu285aFvI3
	 nDD63rp13c5fFhxMDRZ4pEAcvEmtwVkZ6qaFBz5+40C0SM9ZWIh5Tmk1hfYE/vXU3f
	 exwD8lkrbWKkA==
Date: Fri, 22 Mar 2024 23:40:37 +0000
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@samsung.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
Message-ID: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/13/24 12:05, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add initial abstractions for working with blk-mq.
>=20
> This patch is a maintained, refactored subset of code originally publishe=
d by
> Wedson Almeida Filho <wedsonaf@gmail.com> [1].
>=20
> [1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268b=
bd4382a891/rust/kernel/blk/mq.rs
>=20
> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>   block/blk-mq.c                     |   3 +-
>   include/linux/blk-mq.h             |   1 +
>   rust/bindings/bindings_helper.h    |   2 +
>   rust/helpers.c                     |  45 ++++
>   rust/kernel/block.rs               |   5 +
>   rust/kernel/block/mq.rs            | 131 +++++++++++
>   rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
>   rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
>   rust/kernel/block/mq/raw_writer.rs |  60 +++++
>   rust/kernel/block/mq/request.rs    | 182 +++++++++++++++
>   rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
>   rust/kernel/error.rs               |   5 +
>   rust/kernel/lib.rs                 |   1 +
>   13 files changed, 1071 insertions(+), 1 deletion(-)

Do you think that it's possible to split this into smaller
patches? It would make review a lot easier.

>   create mode 100644 rust/kernel/block.rs
>   create mode 100644 rust/kernel/block/mq.rs
>   create mode 100644 rust/kernel/block/mq/gen_disk.rs
>   create mode 100644 rust/kernel/block/mq/operations.rs
>   create mode 100644 rust/kernel/block/mq/raw_writer.rs
>   create mode 100644 rust/kernel/block/mq/request.rs
>   create mode 100644 rust/kernel/block/mq/tag_set.rs

[...]

> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
> new file mode 100644
> index 000000000000..4c93317a568a
> --- /dev/null
> +++ b/rust/kernel/block.rs
> @@ -0,0 +1,5 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for working with the block layer

Missing '.'.

> +
> +pub mod mq;
> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
> new file mode 100644
> index 000000000000..08de1cc114ff
> --- /dev/null
> +++ b/rust/kernel/block/mq.rs
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! This module provides types for implementing block drivers that inter=
face the
> +//! blk-mq subsystem.
> +//!
> +//! To implement a block device driver, a Rust module must do the follow=
ing:
> +//!
> +//! - Implement [`Operations`] for a type `T`

I think it would be nicer to use `Driver` (or `MyBlkDevice`) instead of
`T`.

> +//! - Create a [`TagSet<T>`]
> +//! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
> +//! - Add the disk to the system by calling [`GenDisk::add`]
> +//!
> +//! The types available in this module that have direct C counterparts a=
re:
> +//!
> +//! - The `TagSet` type that abstracts the C type `struct tag_set`.
> +//! - The `GenDisk` type that abstracts the C type `struct gendisk`.
> +//! - The `Request` type that abstracts the C type `struct request`.
> +//!
> +//! Many of the C types that this module abstracts allow a driver to car=
ry
> +//! private data, either embedded in the stuct directly, or as a C `void=
*`. In
> +//! these abstractions, this data is typed. The types of the data is def=
ined by
> +//! associated types in `Operations`, see [`Operations::RequestData`] fo=
r an
> +//! example.
> +//!
> +//! The kernel will interface with the block evice driver by calling the=
 method

Typo: "block evice driver"

> +//! implementations of the `Operations` trait.
> +//!
> +//! IO requests are passed to the driver as [`Request`] references. The
> +//! `Request` type is a wrapper around the C `struct request`. The drive=
r must
> +//! mark start of request processing by calling [`Request::start`] and e=
nd of
> +//! processing by calling one of the [`Request::end`], methods. Failure =
to do so
> +//! can lead to IO failures.

I am unfamiliar with this, what are "IO failures"?
Do you think that it might be better to change the API to use a
callback? So instead of calling start and end, you would do

     request.handle(|req| {
         // do the stuff that would be done between start and end
     });

I took a quick look at the rnull driver and there you are calling
`Request::end_ok` from a different function. So my suggestion might not
be possible, since you really need the freedom.

Do you think that a guard approach might work better? ie `start` returns
a guard that when dropped will call `end` and you need the guard to
operate on the request.

> +//!
> +//! The `TagSet` is responsible for creating and maintaining a mapping b=
etween
> +//! `Request`s and integer ids as well as carrying a pointer to the vtab=
le
> +//! generated by `Operations`. This mapping is useful for associating
> +//! completions from hardware with the correct `Request` instance. The `=
TagSet`
> +//! determines the maximum queue depth by setting the number of `Request=
`
> +//! instances available to the driver, and it determines the number of q=
ueues to
> +//! instantiate for the driver. If possible, a driver should allocate on=
e queue
> +//! per core, to keep queue data local to a core.
> +//!
> +//! One `TagSet` instance can be shared between multiple `GenDisk` insta=
nces.
> +//! This can be useful when implementing drivers where one piece of hard=
ware
> +//! with one set of IO resources are represented to the user as multiple=
 disks.
> +//!
> +//! One significant difference between block device drivers implemented =
with
> +//! these Rust abstractions and drivers implemented in C, is that the Ru=
st
> +//! drivers have to own a reference count on the `Request` type when the=
 IO is
> +//! in flight. This is to ensure that the C `struct request` instances b=
acking
> +//! the Rust `Request` instances are live while the Rust driver holds a
> +//! reference to the `Request`. In addition, the conversion of an ineger=
 tag to

Typo: "of an ineger tag"

> +//! a `Request` via the `TagSet` would not be sound without this bookkee=
ping.
> +//!
> +//! # =E2=9A=A0 Note
> +//!
> +//! For Rust block device drivers, the point in time where a request
> +//! is freed and made available for recycling is usualy at the point in =
time
> +//! when the last `ARef<Request>` is dropped. For C drivers, this event =
usually
> +//! occurs when `bindings::blk_mq_end_request` is called.
> +//!
> +//! # Example
> +//!
> +//! ```rust
> +//! use kernel::{
> +//!     block::mq::*,
> +//!     new_mutex,
> +//!     prelude::*,
> +//!     sync::{Arc, Mutex},
> +//!     types::{ARef, ForeignOwnable},
> +//! };
> +//!
> +//! struct MyBlkDevice;
> +//!
> +//! #[vtable]
> +//! impl Operations for MyBlkDevice {
> +//!     type RequestData =3D ();
> +//!     type RequestDataInit =3D impl PinInit<()>;
> +//!     type QueueData =3D ();
> +//!     type HwData =3D ();
> +//!     type TagSetData =3D ();
> +//!
> +//!     fn new_request_data(
> +//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed=
<'_>,
> +//!     ) -> Self::RequestDataInit {
> +//!         kernel::init::zeroed()
> +//!     }
> +//!
> +//!     fn queue_rq(_hw_data: (), _queue_data: (), rq: ARef<Request<Self=
>>, _is_last: bool) -> Result {
> +//!         rq.start();
> +//!         rq.end_ok();
> +//!         Ok(())
> +//!     }
> +//!
> +//!     fn commit_rqs(
> +//!         _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
> +//!         _queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'=
_>,
> +//!     ) {
> +//!     }
> +//!
> +//!     fn complete(rq: &Request<Self>) {
> +//!         rq.end_ok();
> +//!     }
> +//!
> +//!     fn init_hctx(
> +//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed=
<'_>,
> +//!         _hctx_idx: u32,
> +//!     ) -> Result<Self::HwData> {
> +//!         Ok(())
> +//!     }
> +//! }
> +//!
> +//! let tagset: Arc<TagSet<MyBlkDevice>> =3D Arc::pin_init(TagSet::try_n=
ew(1, (), 256, 1))?;
> +//! let mut disk =3D GenDisk::try_new(tagset, ())?;
> +//! disk.set_name(format_args!("myblk"))?;
> +//! disk.set_capacity_sectors(4096);
> +//! disk.add()?;
> +//!
> +//! # Ok::<(), kernel::error::Error>(())
> +//! ```

This piece of documentation is **really** valuable, thanks a lot for
taking the time to write it.

> +
> +mod gen_disk;
> +mod operations;
> +mod raw_writer;
> +mod request;
> +mod tag_set;
> +
> +pub use gen_disk::GenDisk;
> +pub use operations::Operations;
> +pub use request::{Request, RequestDataRef};
> +pub use tag_set::TagSet;
> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_=
disk.rs
> new file mode 100644
> index 000000000000..b7845fc9e39f
> --- /dev/null
> +++ b/rust/kernel/block/mq/gen_disk.rs
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic disk abstraction.
> +//!
> +//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
> +//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
> +
> +use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
> +use crate::{
> +    bindings, error::from_err_ptr, error::Result, sync::Arc, types::Fore=
ignOwnable,
> +    types::ScopeGuard,
> +};
> +use core::fmt::{self, Write};
> +
> +/// A generic block device
> +///
> +/// # Invariants
> +///
> +///  - `gendisk` must always point to an initialized and valid `struct g=
endisk`.
> +pub struct GenDisk<T: Operations> {
> +    _tagset: Arc<TagSet<T>>,
> +    gendisk: *mut bindings::gendisk,
> +}
> +
> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `A=
rc` to a
> +// `TagSet` It is safe to send this to other threads as long as T is Sen=
d.
> +unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
> +
> +impl<T: Operations> GenDisk<T> {
> +    /// Try to create a new `GenDisk`
> +    pub fn try_new(tagset: Arc<TagSet<T>>, queue_data: T::QueueData) -> =
Result<Self> {
> +        let data =3D queue_data.into_foreign();
> +        let recover_data =3D ScopeGuard::new(|| {
> +            // SAFETY: T::QueueData was created by the call to `into_for=
eign()` above
> +            unsafe { T::QueueData::from_foreign(data) };
> +        });
> +
> +        let lock_class_key =3D crate::sync::LockClassKey::new();
> +
> +        // SAFETY: `tagset.raw_tag_set()` points to a valid and initiali=
zed tag set
> +        let gendisk =3D from_err_ptr(unsafe {
> +            bindings::__blk_mq_alloc_disk(
> +                tagset.raw_tag_set(),
> +                data.cast_mut(),
> +                lock_class_key.as_ptr(),
> +            )
> +        })?;
> +
> +        const TABLE: bindings::block_device_operations =3D bindings::blo=
ck_device_operations {
> +            submit_bio: None,
> +            open: None,
> +            release: None,
> +            ioctl: None,
> +            compat_ioctl: None,
> +            check_events: None,
> +            unlock_native_capacity: None,
> +            getgeo: None,
> +            set_read_only: None,
> +            swap_slot_free_notify: None,
> +            report_zones: None,
> +            devnode: None,
> +            alternative_gpt_sector: None,
> +            get_unique_id: None,
> +            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_stati=
c feature to be merged
> +            // https://github.com/rust-lang/rust/issues/119618
> +            owner: core::ptr::null_mut(),
> +            pr_ops: core::ptr::null_mut(),
> +            free_disk: None,
> +            poll_bio: None,
> +        };
> +
> +        // SAFETY: gendisk is a valid pointer as we initialized it above
> +        unsafe { (*gendisk).fops =3D &TABLE };
> +
> +        recover_data.dismiss();
> +        Ok(Self {
> +            _tagset: tagset,
> +            gendisk,

Missing INVARIANT comment.

> +        })
> +    }
> +
> +    /// Set the name of the device

Missing '.'.

> +    pub fn set_name(&mut self, args: fmt::Arguments<'_>) -> Result {
> +        let mut raw_writer =3D RawWriter::from_array(
> +            // SAFETY: By type invariant `self.gendisk` points to a vali=
d and initialized instance
> +            unsafe { &mut (*self.gendisk).disk_name },

To create a `&mut` reference, you need exclusive access, it should be
sufficient to add to the invariant that `gendisk` is owned/unique.

> +        );
> +        raw_writer.write_fmt(args)?;
> +        raw_writer.write_char('\0')?;
> +        Ok(())
> +    }

[...]

> +impl<T: Operations> Drop for GenDisk<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points to=
 a valid
> +        // and initialized instance of `struct gendisk`. As such, `queue=
data`
> +        // was initialized by the initializer returned by `try_new` with=
 a call
> +        // to `ForeignOwnable::into_foreign`.

This should also be an invariant of `GenDisk`.

> +        let queue_data =3D unsafe { (*(*self.gendisk).queue).queuedata }=
;
> +
> +        // SAFETY: By type invariant, `self.gendisk` points to a valid a=
nd
> +        // initialized instance of `struct gendisk`
> +        unsafe { bindings::del_gendisk(self.gendisk) };
> +
> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()`=
 with a
> +        // call to `ForeignOwnable::into_pointer()` to create `queuedata=
`.
> +        // `ForeignOwnable::from_foreign()` is only called here.
> +        let _queue_data =3D unsafe { T::QueueData::from_foreign(queue_da=
ta) };
> +    }
> +}
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/op=
erations.rs
> new file mode 100644
> index 000000000000..53c6ad663208
> --- /dev/null
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! This module provides an interface for blk-mq drivers to implement.
> +//!
> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
> +
> +use crate::{
> +    bindings,
> +    block::mq::Request,
> +    error::{from_result, Result},
> +    init::PinInit,
> +    types::{ARef, ForeignOwnable},
> +};
> +use core::{marker::PhantomData, ptr::NonNull};
> +
> +use super::TagSet;
> +
> +/// Implement this trait to interface blk-mq as block devices
> +#[macros::vtable]
> +pub trait Operations: Sized {
> +    /// Data associated with a request. This data is located next to the=
 request
> +    /// structure.
> +    ///
> +    /// To be able to handle accessing this data from interrupt context,=
 this
> +    /// data must be `Sync`.
> +    type RequestData: Sized + Sync;
> +
> +    /// Initializer for `Self::RequestDta`. Used to initialize private d=
ata area
> +    /// when requst structure is allocated.
> +    type RequestDataInit: PinInit<Self::RequestData>;

Just to let you know, this dance with the associated types is not needed
any longer. RPITIT (return position impl trait in trait) has been
stabilized in 1.75 and you should be able to just write this:

     fn new_request_data(
         //rq: ARef<Request<Self>>,
         tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
     ) -> impl PinInit<Self::RequestData>;


> +
> +    /// Data associated with the `struct request_queue` that is allocate=
d for
> +    /// the `GenDisk` associated with this `Operations` implementation.
> +    type QueueData: ForeignOwnable;
> +
> +    /// Data associated with a dispatch queue. This is stored as a point=
er in
> +    /// the C `struct blk_mq_hw_ctx` that represents a hardware queue.
> +    type HwData: ForeignOwnable;
> +
> +    /// Data associated with a `TagSet`. This is stored as a pointer in =
`struct
> +    /// blk_mq_tag_set`.
> +    type TagSetData: ForeignOwnable;
> +
> +    /// Called by the kernel to get an initializer for a `Pin<&mut Reque=
stData>`.
> +    fn new_request_data(
> +        //rq: ARef<Request<Self>>,
> +        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,

Since you need to use this pattern a lot, it might be a good idea to
introduce a type alias to help with this:

     type ForeignBorrowed<'a, T> =3D <T as ForeignOwnable>::Borrowed<'a>;

What do the others think?

The function would then become (with the RPITIT improvement as well):

     fn new_request_data(
         //rq: ARef<Request<Self>>,
         tagset_data: ForeignBorrowed<'_, Self::TagSetData>,
     ) -> impl PinInit<Self::RequestData>;


> +    ) -> Self::RequestDataInit;
> +
> +    /// Called by the kernel to queue a request with the driver. If `is_=
last` is
> +    /// `false`, the driver is allowed to defer commiting the request.
> +    fn queue_rq(
> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
> +        rq: ARef<Request<Self>>,
> +        is_last: bool,
> +    ) -> Result;
> +
> +    /// Called by the kernel to indicate that queued requests should be =
submitted
> +    fn commit_rqs(
> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
> +    );
> +
> +    /// Called by the kernel when the request is completed
> +    fn complete(_rq: &Request<Self>);
> +
> +    /// Called by the kernel to allocate and initialize a driver specifi=
c hardware context data
> +    fn init_hctx(
> +        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
> +        hctx_idx: u32,
> +    ) -> Result<Self::HwData>;
> +
> +    /// Called by the kernel to poll the device for completed requests. =
Only
> +    /// used for poll queues.
> +    fn poll(_hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>) ->=
 bool {
> +        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Called by the kernel to map submission queues to CPU cores.
> +    fn map_queues(_tag_set: &TagSet<Self>) {
> +        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    // There is no need for exit_request() because `drop` will be called=
.

I think it would be a good idea to mention this in the documentation of
the trait.

> +}

[...]

> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/ra=
w_writer.rs
> new file mode 100644
> index 000000000000..f7857740af29
> --- /dev/null
> +++ b/rust/kernel/block/mq/raw_writer.rs
> @@ -0,0 +1,60 @@
> +use core::{
> +    fmt::{self, Write},
> +    marker::PhantomData,
> +};
> +
> +/// A mutable reference to a byte buffer where a string can be written i=
nto
> +///
> +/// # Invariants
> +///
> +/// * `ptr` is not aliased and valid for read and write for `len` bytes

You probably also want to add "for the duration of `'a`".

> +///
> +pub(crate) struct RawWriter<'a> {
> +    ptr: *mut u8,
> +    len: usize,
> +    _p: PhantomData<&'a ()>,
> +}
> +
> +impl<'a> RawWriter<'a> {
> +    /// Create a new `RawWriter` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * `ptr` must be valid for read and write for `len` consecutive `=
u8` elements
> +    /// * `ptr` must not be aliased
> +    unsafe fn new(ptr: *mut u8, len: usize) -> RawWriter<'a> {
> +        Self {
> +            ptr,
> +            len,
> +            _p: PhantomData,
> +        }
> +    }

Since this function is not used (except in the function below), what is
the reason for using a raw pointer?
I looked in your other patches, but did not find another user, so could
this be improved by using mutable references?

> +
> +    pub(crate) fn from_array<const N: usize>(a: &'a mut [core::ffi::c_ch=
ar; N]) -> RawWriter<'a> {
> +        // SAFETY: the buffer of `a` is valid for read and write for at =
least `N` bytes
> +        unsafe { Self::new(a.as_mut_ptr().cast::<u8>(), N) }
> +    }
> +}
> +
> +impl Write for RawWriter<'_> {
> +    fn write_str(&mut self, s: &str) -> fmt::Result {
> +        let bytes =3D s.as_bytes();
> +        let len =3D bytes.len();
> +        if len > self.len {
> +            return Err(fmt::Error);
> +        }
> +
> +        // SAFETY:
> +        // * `bytes` is valid for reads of `bytes.len()` size because we=
 hold a shared reference to `s`
> +        // * By type invariant `self.ptr` is valid for writes for at les=
t `self.len` bytes
> +        // * The regions are not overlapping as `ptr` is not aliased
> +        unsafe { core::ptr::copy_nonoverlapping(&bytes[0], self.ptr, len=
) };
> +
> +        // SAFETY: By type invariant of `Self`, `ptr` is in bounds of an
> +        // allocation. Also by type invariant, the pointer resulting fro=
m this
> +        // addition is also in bounds.
> +        self.ptr =3D unsafe { self.ptr.add(len) };
> +        self.len -=3D len;
> +        Ok(())
> +    }
> +}
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs
> new file mode 100644
> index 000000000000..b4dacac5e091
> --- /dev/null
> +++ b/rust/kernel/block/mq/request.rs
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! This module provides a wrapper for the C `struct request` type.
> +//!
> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
> +
> +use crate::{
> +    bindings,
> +    block::mq::Operations,
> +    error::{Error, Result},
> +    types::{ARef, AlwaysRefCounted, Opaque},
> +};
> +use core::{ffi::c_void, marker::PhantomData, ops::Deref};
> +
> +/// A wrapper around a blk-mq `struct request`. This represents an IO re=
quest.
> +///
> +/// # Invariants
> +///
> +/// * `self.0` is a valid `struct request` created by the C portion of t=
he kernel
> +/// * `self` is reference counted. a call to `req_ref_inc_not_zero` keep=
s the
> +///    instance alive at least until a matching call to `req_ref_put_and=
_test`
> +///
> +#[repr(transparent)]
> +pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomData=
<T>);
> +
> +impl<T: Operations> Request<T> {
> +    /// Create a `&mut Request` from a `bindings::request` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// * `ptr` must be aligned and point to a valid `bindings::request`=
 instance
> +    /// * Caller must ensure that the pointee of `ptr` is live and owned
> +    ///   exclusively by caller for at least `'a`
> +    ///
> +    pub(crate) unsafe fn from_ptr_mut<'a>(ptr: *mut bindings::request) -=
> &'a mut Self {
> +        // SAFETY:
> +        // * The cast is valid as `Self` is transparent.
> +        // * By safety requirements of this function, the reference will=
 be
> +        //   valid for 'a.
> +        unsafe { &mut *(ptr.cast::<Self>()) }
> +    }
> +
> +    /// Get the command identifier for the request
> +    pub fn command(&self) -> u32 {
> +        // SAFETY: By C API contract and type invariant, `cmd_flags` is =
valid for read
> +        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BIT=
S) - 1) }
> +    }
> +
> +    /// Call this to indicate to the kernel that the request has been is=
sued by the driver

I am a bit confused, is this not supposed to signal that the processing
of the request is going to start now? cf C documentation:

     /**
      * blk_mq_start_request - Start processing a request
      * @rq: Pointer to request to be started
      *
      * Function used by device drivers to notify the block layer that a re=
quest
      * is going to be processed now, so blk layer can do proper initializa=
tions
      * such as starting the timeout timer.
      */

> +    pub fn start(&self) {
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`. By
> +        // existence of `&mut self` we have exclusive access.
> +        unsafe { bindings::blk_mq_start_request(self.0.get()) };
> +    }
> +
> +    /// Call this to indicate to the kernel that the request has been co=
mpleted without errors

I dislike the "Call this", it feels redundant, what about "Signal the
block layer that the request has been completed without errors.".

Also with the other functions below.

> +    pub fn end_ok(&self) {
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`. By
> +        // existence of `&mut self` we have exclusive access.
> +        unsafe { bindings::blk_mq_end_request(self.0.get(), bindings::BL=
K_STS_OK as _) };
> +    }
> +
> +    /// Call this to indicate to the kernel that the request completed w=
ith an error
> +    pub fn end_err(&self, err: Error) {
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`. By
> +        // existence of `&mut self` we have exclusive access.
> +        unsafe { bindings::blk_mq_end_request(self.0.get(), err.to_blk_s=
tatus()) };
> +    }
> +
> +    /// Call this to indicate that the request completed with the status=
 indicated by `status`
> +    pub fn end(&self, status: Result) {
> +        if let Err(e) =3D status {
> +            self.end_err(e);
> +        } else {
> +            self.end_ok();
> +        }
> +    }
> +
> +    /// Call this to schedule defered completion of the request
> +    pub fn complete(&self) {
> +        // SAFETY: By type invariant, `self.0` is a valid `struct reques=
t`
> +        if !unsafe { bindings::blk_mq_complete_request_remote(self.0.get=
()) } {
> +            T::complete(self);
> +        }
> +    }
> +
> +    /// Get the target sector for the request
> +    #[inline(always)]
> +    pub fn sector(&self) -> usize {
> +        // SAFETY: By type invariant of `Self`, `self.0` is valid and li=
ve.
> +        unsafe { (*self.0.get()).__sector as usize }
> +    }
> +
> +    /// Returns an owned reference to the per-request data associated wi=
th this
> +    /// request
> +    pub fn owned_data_ref(request: ARef<Self>) -> RequestDataRef<T> {
> +        RequestDataRef::new(request)
> +    }
> +
> +    /// Returns a reference to the oer-request data associated with this=
 request

Typo: "the oer-request"

> +    pub fn data_ref(&self) -> &T::RequestData {
> +        let request_ptr =3D self.0.get().cast::<bindings::request>();
> +
> +        // SAFETY: `request_ptr` is a valid `struct request` because `AR=
ef` is
> +        // `repr(transparent)`
> +        let p: *mut c_void =3D unsafe { bindings::blk_mq_rq_to_pdu(reque=
st_ptr) };
> +
> +        let p =3D p.cast::<T::RequestData>();
> +
> +        // SAFETY: By C API contract, `p` is initialized by a call to
> +        // `OperationsVTable::init_request_callback()`. By existence of =
`&self`
> +        // it must be valid for use as a shared reference.
> +        unsafe { &*p }
> +    }
> +}
> +
> +// SAFETY: It is impossible to obtain an owned or mutable `Request`, so =
we can

What do you mean by "mutable `Request`"? There is the function to obtain
a `&mut Request`.
Also this should probably be an invariant if you use it as a
justification here.

> +// mark it `Send`.
> +unsafe impl<T: Operations> Send for Request<T> {}
> +
> +// SAFETY: `Request` references can be shared across threads.

Does not explain why that is the case.

> +unsafe impl<T: Operations> Sync for Request<T> {}
> +
> +/// An owned reference to a `Request<T>`
> +#[repr(transparent)]
> +pub struct RequestDataRef<T: Operations> {
> +    request: ARef<Request<T>>,
> +}

Is this extra type really needed? I have not yet taken a look at patch 3,
which uses this. But would it hurt if you implemented the traits
there directly on `ARef<Request<T>>`?

> +
> +impl<T> RequestDataRef<T>
> +where
> +    T: Operations,
> +{
> +    /// Create a new instance.
> +    fn new(request: ARef<Request<T>>) -> Self {
> +        Self { request }
> +    }
> +
> +    /// Get a reference to the underlying request
> +    pub fn request(&self) -> &Request<T> {
> +        &self.request
> +    }
> +}

I really like how you improved the safety comments and documentation. It
was a lot easier to wrap my head around this time (might also me getting
more experienced, but I think it helped a lot).

--=20
Cheers,
Benno


