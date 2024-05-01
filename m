Return-Path: <linux-kernel+bounces-165171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082958B8906
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15E4285A75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58C60269;
	Wed,  1 May 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbOZuWai"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1555E74;
	Wed,  1 May 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561823; cv=none; b=sMlOXNxidBXclLBTaC+X2s2DyFEOoqZ+7yJWu5Shc+pb3YRqP9ULoNgKYEwvTSceNy+mNHrxthpuOwPox/ez/f18wxCXhv1OKzak8OtIKT6j0f+0/cVpVeycYl1tpziWhIpQPWJxi4N5EOscaNx0mY4BCGtKJNdQO/lyAX+s4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561823; c=relaxed/simple;
	bh=mXtWlpJjv4r58BbTHgexbIC8BOjMoH+j0kTfB4fkELg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxfoFBbGvc9VkKph7MmlB98puQLUiHhmBsjoRYsFlm9a1Fe0yXIUOrkIx7b4KWvALJu3XIKo2rNe9H0cd46vxOjiMoo39bg65rKdYEYxNp2lvN1iOLA9rvL1I317LdpM/BBQn/Ix8Qp87+kj+r6iJqti4cOwhRC5IUUBaEN02sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbOZuWai; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5894c1d954so203671166b.1;
        Wed, 01 May 2024 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714561820; x=1715166620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r4L4cuvOpUVxE20o6fm6YjgY0mUNU2VgesemMamP54=;
        b=fbOZuWaisaCvY8sKikiWoTpsCUx7i29Ptuijt7HeKu7WhEtgYzVZoZnPHccbZvvb+N
         G8SIYjF13xGajr9GdGwia2W+1oWRHI53aD155QS0QSE4j9vsPK43KYL16924AbuSpdpd
         UtWQw0VWQS9K5U1X+i/cKTKLtZ7NFkanjFpwHfRdC+VEwUz5Cl73ASSe0QiZzJVg85zg
         hAQMWKBcyyo5a40k69QvPEuzhHQa7+knQCVBt6bo1GyalEsNSjf4lGcoL3+THpc9YY6F
         s+a/N2eNQkYbUtAo5wDECnVCRyMOb78tpFCp745GnXhnrfwKBQGTGtsbAzMECjioLev9
         QnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561820; x=1715166620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r4L4cuvOpUVxE20o6fm6YjgY0mUNU2VgesemMamP54=;
        b=EPhr4ZsUd4euyC2R40dtSezZ20ry6nSjQwONlAWA8UTRGx8LM2AM89j09HOuor5EOx
         Bi4H613o+c+qQccPRIYJ2DFx5SDYB9BD7Q7q5dtQwtbG+o+Em7asyStroSEkrtv4io/p
         PCPKiIzWub+vC5D9a2CCxSOZsDkq/TlJutdxUWajfB6gbRMzps3ZHkzyEZle3gC4so6l
         0rhqAwL50PJSe0Y046lCnrcs9mDl1UYfDxiU9ZJ9lGqIPSMzZ23TIDHsLDoF7UwJa9zU
         JLJ36tbO41C8PbvAheSQrHnoCZ+eiyikgXm6s7m/7aaDTUWL4NsB06N1c9hS5dUszubY
         /MPg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRnhWWo/YN+hUbVNvcYPF8hRC1PzdfzGbuIXWqQjik3bx4tQ6WBAhvOynI5Aldj7vPUhvCTb8sM4/B0Ez1AhKKcHF5MzI68zvKmZYuaV5LL37MvPMJHpbmXiurhCD9pWJ5vYRUYvmkiDoYLQ=
X-Gm-Message-State: AOJu0Ywh3wviORN2AFd0NSKwYL0XkbSXXaanbQiMJm65/GIC5BFLMmT2
	38OpE1UVYPF4QTYb/4vy9aZOg5IliVWoN4HFf1Z4xeVqrF31fCnl0K1NzXXld1Ub0ewFIX1EOZP
	v4zL5wjUGl6YVh/I/tKDwXh2esHE=
X-Google-Smtp-Source: AGHT+IHkJbmTSZcZ4Csl7k18MFzWjGrcXLQRLAZEAJuOfVaSgayUbIvHp6NVOZ18/bfB3IeEPgq548IRe82lcia/22A=
X-Received: by 2002:a50:c048:0:b0:572:3f41:25aa with SMTP id
 u8-20020a50c048000000b005723f4125aamr1756947edd.11.1714561819574; Wed, 01 May
 2024 04:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416074607.1395481-1-nmi@metaspace.dk>
In-Reply-To: <20240416074607.1395481-1-nmi@metaspace.dk>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Wed, 1 May 2024 13:09:43 +0200
Message-ID: <CAA76j92Eagjv7FjyCHs_fVH+SernJkOQE1htkSB0HDCgnuH37w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: split up helpers.c
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Apr 2024 at 09:46, Andreas Hindborg <nmi@metaspace.dk> wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch splits up the rust helpers C file. When rebasing patch sets on
> upstream linux, merge conflicts in helpers.c is common and time consuming
> [1]. Thus, split the file so that each kernel component can live in a
> separate file.
>
> This patch lists helper files explicitly and thus conflicts in the file
> list is still likely. However, they should be more simple to resolve than
> the conflicts usually seen in helpers.c.
>
> Link:
> https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/topic/=
Splitting.20up.20helpers.2Ec/near/426694012 [1]
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/Makefile               |  36 ++++++--
>  rust/helpers.c              | 180 ------------------------------------
>  rust/helpers/Makefile       |   7 ++
>  rust/helpers/README.md      |  18 ++++
>  rust/helpers/bug.c          |   9 ++
>  rust/helpers/build_assert.c |  25 +++++
>  rust/helpers/build_bug.c    |  10 ++
>  rust/helpers/err.c          |  22 +++++
>  rust/helpers/kunit.c        |  10 ++
>  rust/helpers/mutex.c        |  10 ++
>  rust/helpers/refcount.c     |  22 +++++
>  rust/helpers/signal.c       |  10 ++
>  rust/helpers/spinlock.c     |  27 ++++++
>  rust/helpers/task.c         |  22 +++++
>  rust/helpers/wait.c         |  10 ++
>  rust/helpers/workqueue.c    |  16 ++++
>  16 files changed, 246 insertions(+), 188 deletions(-)
>  delete mode 100644 rust/helpers.c
>  create mode 100644 rust/helpers/Makefile
>  create mode 100644 rust/helpers/README.md
>  create mode 100644 rust/helpers/bug.c
>  create mode 100644 rust/helpers/build_assert.c
>  create mode 100644 rust/helpers/build_bug.c
>  create mode 100644 rust/helpers/err.c
>  create mode 100644 rust/helpers/kunit.c
>  create mode 100644 rust/helpers/mutex.c
>  create mode 100644 rust/helpers/refcount.c
>  create mode 100644 rust/helpers/signal.c
>  create mode 100644 rust/helpers/spinlock.c
>  create mode 100644 rust/helpers/task.c
>  create mode 100644 rust/helpers/wait.c
>  create mode 100644 rust/helpers/workqueue.c
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 846e6ab9d5a9..ef76dcd5aa7a 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -6,10 +6,22 @@ rustdoc_output :=3D $(objtree)/Documentation/output/rus=
t/rustdoc
>  obj-$(CONFIG_RUST) +=3D core.o compiler_builtins.o
>  always-$(CONFIG_RUST) +=3D exports_core_generated.h
>
> -# Missing prototypes are expected in the helpers since these are exporte=
d
> -# for Rust only, thus there is no header nor prototypes.
> -obj-$(CONFIG_RUST) +=3D helpers.o
> -CFLAGS_REMOVE_helpers.o =3D -Wmissing-prototypes -Wmissing-declarations
> +RUST_HELPERS :=3D \
> +       bug \
> +       build_assert \
> +       build_bug \
> +       err \
> +       kunit \
> +       mutex \
> +       refcount \
> +       signal \
> +       spinlock\
> +       task \
> +       wait \
> +       workqueue
> +
> +export RUST_HELPERS
> +obj-y +=3D helpers/
>
>  always-$(CONFIG_RUST) +=3D libmacros.so
>  no-clean-files +=3D libmacros.so
> @@ -339,6 +351,10 @@ quiet_cmd_bindgen =3D BINDGEN $@
>                 -o $@ -- $(bindgen_c_flags_final) -DMODULE \
>                 $(bindgen_target_cflags) $(bindgen_target_extra)
>
> +quiet_cmd_cat =3D CAT     $@
> +      cmd_cat =3D \
> +       cat $(patsubst %,$(srctree)/$(src)/helpers/%.c, $(RUST_HELPERS)) =
> $@
> +
>  $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags =3D =
\
>      $(shell grep -Ev '^#|^$$' $(srctree)/$(src)/bindgen_parameters)
>  $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra =3D =
; \
> @@ -353,9 +369,9 @@ $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helpe=
r.h \
>      $(src)/bindgen_parameters FORCE
>         $(call if_changed_dep,bindgen)
>
> -# See `CFLAGS_REMOVE_helpers.o` above. In addition, Clang on C does not =
warn
> -# with `-Wmissing-declarations` (unlike GCC), so it is not strictly need=
ed here
> -# given it is `libclang`; but for consistency, future Clang changes and/=
or
> +# See `ccflags-remove-y` in helpers/Makefile . In addition, Clang on C d=
oes not
> +# warn with `-Wmissing-declarations` (unlike GCC), so it is not strictly=
 needed
> +# here given it is `libclang`; but for consistency, future Clang changes=
 and/or
>  # a potential future GCC backend for `bindgen`, we disable it too.
>  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_fl=
ags =3D \
>      --blocklist-type '.*' --allowlist-var '' \
> @@ -364,9 +380,13 @@ $(obj)/bindings/bindings_helpers_generated.rs: priva=
te bindgen_target_cflags =3D \
>      -I$(objtree)/$(obj) -Wno-missing-prototypes -Wno-missing-declaration=
s
>  $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_ex=
tra =3D ; \
>      sed -Ei 's/pub fn rust_helper_([a-zA-Z0-9_]*)/#[link_name=3D"rust_he=
lper_\1"]\n    pub fn \1/g' $@
> -$(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers.c FORCE
> +$(obj)/bindings/bindings_helpers_generated.rs: $(obj)/helpers/helpers_co=
mbined.c FORCE
>         $(call if_changed_dep,bindgen)
>
> +targets +=3D helpers/helpers_combined.c
> +$(obj)/helpers/helpers_combined.c: $(patsubst %,$(src)/helpers/%.c, $(RU=
ST_HELPERS)) FORCE
> +       $(call if_changed,cat)
> +
>  quiet_cmd_exports =3D EXPORTS $@
>        cmd_exports =3D \
>         $(NM) -p --defined-only $< \
> diff --git a/rust/helpers.c b/rust/helpers.c
> deleted file mode 100644
> index 70e59efd92bc..000000000000
> --- a/rust/helpers.c
> +++ /dev/null
> @@ -1,180 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Non-trivial C macros cannot be used in Rust. Similarly, inlined C fun=
ctions
> - * cannot be called either. This file explicitly creates functions ("hel=
pers")
> - * that wrap those so that they can be called from Rust.
> - *
> - * Even though Rust kernel modules should never use directly the binding=
s, some
> - * of these helpers need to be exported because Rust generics and inline=
d
> - * functions may not get their code generated in the crate where they ar=
e
> - * defined. Other helpers, called from non-inline functions, may not be
> - * exported, in principle. However, in general, the Rust compiler does n=
ot
> - * guarantee codegen will be performed for a non-inline function either.
> - * Therefore, this file exports all the helpers. In the future, this may=
 be
> - * revisited to reduce the number of exports after the compiler is infor=
med
> - * about the places codegen is required.
> - *
> - * All symbols are exported as GPL-only to guarantee no GPL-only feature=
 is
> - * accidentally exposed.
> - *
> - * Sorted alphabetically.
> - */
> -
> -#include <kunit/test-bug.h>
> -#include <linux/bug.h>
> -#include <linux/build_bug.h>
> -#include <linux/err.h>
> -#include <linux/errname.h>
> -#include <linux/mutex.h>
> -#include <linux/refcount.h>
> -#include <linux/sched/signal.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
> -#include <linux/workqueue.h>
> -
> -__noreturn void rust_helper_BUG(void)
> -{
> -       BUG();
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_BUG);
> -
> -void rust_helper_mutex_lock(struct mutex *lock)
> -{
> -       mutex_lock(lock);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> -
> -void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> -                                 struct lock_class_key *key)
> -{
> -#ifdef CONFIG_DEBUG_SPINLOCK
> -       __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CON=
FIG);
> -#else
> -       spin_lock_init(lock);
> -#endif
> -}
> -EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
> -
> -void rust_helper_spin_lock(spinlock_t *lock)
> -{
> -       spin_lock(lock);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
> -
> -void rust_helper_spin_unlock(spinlock_t *lock)
> -{
> -       spin_unlock(lock);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
> -
> -void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> -{
> -       init_wait(wq_entry);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_init_wait);
> -
> -int rust_helper_signal_pending(struct task_struct *t)
> -{
> -       return signal_pending(t);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> -
> -refcount_t rust_helper_REFCOUNT_INIT(int n)
> -{
> -       return (refcount_t)REFCOUNT_INIT(n);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> -
> -void rust_helper_refcount_inc(refcount_t *r)
> -{
> -       refcount_inc(r);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> -
> -bool rust_helper_refcount_dec_and_test(refcount_t *r)
> -{
> -       return refcount_dec_and_test(r);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> -
> -__force void *rust_helper_ERR_PTR(long err)
> -{
> -       return ERR_PTR(err);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
> -
> -bool rust_helper_IS_ERR(__force const void *ptr)
> -{
> -       return IS_ERR(ptr);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
> -
> -long rust_helper_PTR_ERR(__force const void *ptr)
> -{
> -       return PTR_ERR(ptr);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> -
> -const char *rust_helper_errname(int err)
> -{
> -       return errname(err);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_errname);
> -
> -struct task_struct *rust_helper_get_current(void)
> -{
> -       return current;
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_get_current);
> -
> -void rust_helper_get_task_struct(struct task_struct *t)
> -{
> -       get_task_struct(t);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
> -
> -void rust_helper_put_task_struct(struct task_struct *t)
> -{
> -       put_task_struct(t);
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> -
> -struct kunit *rust_helper_kunit_get_current_test(void)
> -{
> -       return kunit_get_current_test();
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> -
> -void rust_helper_init_work_with_key(struct work_struct *work, work_func_=
t func,
> -                                   bool onstack, const char *name,
> -                                   struct lock_class_key *key)
> -{
> -       __init_work(work, onstack);
> -       work->data =3D (atomic_long_t)WORK_DATA_INIT();
> -       lockdep_init_map(&work->lockdep_map, name, key, 0);
> -       INIT_LIST_HEAD(&work->entry);
> -       work->func =3D func;
> -}
> -EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> -
> -/*
> - * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we c=
an
> - * use it in contexts where Rust expects a `usize` like slice (array) in=
dices.
> - * `usize` is defined to be the same as C's `uintptr_t` type (can hold a=
ny
> - * pointer) but not necessarily the same as `size_t` (can hold the size =
of any
> - * single object). Most modern platforms use the same concrete integer t=
ype for
> - * both of them, but in case we find ourselves on a platform where
> - * that's not true, fail early instead of risking ABI or
> - * integer-overflow issues.
> - *
> - * If your platform fails this assertion, it means that you are in
> - * danger of integer-overflow bugs (even if you attempt to add
> - * `--no-size_t-is-usize`). It may be easiest to change the kernel ABI o=
n
> - * your platform such that `size_t` matches `uintptr_t` (i.e., to increa=
se
> - * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
> - */
> -static_assert(
> -       sizeof(size_t) =3D=3D sizeof(uintptr_t) &&
> -       __alignof__(size_t) =3D=3D __alignof__(uintptr_t),
> -       "Rust code expects C `size_t` to match Rust `usize`"
> -);
> diff --git a/rust/helpers/Makefile b/rust/helpers/Makefile
> new file mode 100644
> index 000000000000..f0236099f209
> --- /dev/null
> +++ b/rust/helpers/Makefile
> @@ -0,0 +1,7 @@
> +
> +# Note: `RUST_HELPERS` is defined in `../Makefile`
> +
> +# Missing prototypes are expected in the helpers since these are exporte=
d
> +# for Rust only, thus there is no header nor prototypes.
> +obj-$(CONFIG_RUST) +=3D $(patsubst %,%.o, $(RUST_HELPERS))
> +ccflags-remove-y +=3D -Wmissing-prototypes -Wmissing-declarations
> diff --git a/rust/helpers/README.md b/rust/helpers/README.md
> new file mode 100644
> index 000000000000..7b94ac69878f
> --- /dev/null
> +++ b/rust/helpers/README.md
> @@ -0,0 +1,18 @@
> +# Rust Helpers
> +
> +Non-trivial C macros cannot be used in Rust. Similarly, inlined C functi=
ons
> +cannot be called either. The files in this directory explicitly create f=
unctions
> +("helpers") that wrap those so that they can be called from Rust.
> +
> +Even though Rust kernel modules should never use directly the bindings, =
some
> +of these helpers need to be exported because Rust generics and inlined
> +functions may not get their code generated in the crate where they are
> +defined. Other helpers, called from non-inline functions, may not be
> +exported, in principle. However, in general, the Rust compiler does not
> +guarantee codegen will be performed for a non-inline function either.
> +Therefore, this file exports all the helpers. In the future, this may be
> +revisited to reduce the number of exports after the compiler is informed
> +about the places codegen is required.
> +
> +All symbols are exported as GPL-only to guarantee no GPL-only feature is
> +accidentally exposed.
> diff --git a/rust/helpers/bug.c b/rust/helpers/bug.c
> new file mode 100644
> index 000000000000..e2afbad23dcd
> --- /dev/null
> +++ b/rust/helpers/bug.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bug.h>
> +
> +__noreturn void rust_helper_BUG(void)
> +{
> +       BUG();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_BUG);
> diff --git a/rust/helpers/build_assert.c b/rust/helpers/build_assert.c
> new file mode 100644
> index 000000000000..6a54b2680b14
> --- /dev/null
> +++ b/rust/helpers/build_assert.c
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/build_bug.h>
> +
> +/*
> + * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we c=
an
> + * use it in contexts where Rust expects a `usize` like slice (array) in=
dices.
> + * `usize` is defined to be the same as C's `uintptr_t` type (can hold a=
ny
> + * pointer) but not necessarily the same as `size_t` (can hold the size =
of any
> + * single object). Most modern platforms use the same concrete integer t=
ype for
> + * both of them, but in case we find ourselves on a platform where
> + * that's not true, fail early instead of risking ABI or
> + * integer-overflow issues.
> + *
> + * If your platform fails this assertion, it means that you are in
> + * danger of integer-overflow bugs (even if you attempt to add
> + * `--no-size_t-is-usize`). It may be easiest to change the kernel ABI o=
n
> + * your platform such that `size_t` matches `uintptr_t` (i.e., to increa=
se
> + * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
> + */
> +static_assert(
> +       sizeof(size_t) =3D=3D sizeof(uintptr_t) &&
> +       __alignof__(size_t) =3D=3D __alignof__(uintptr_t),
> +       "Rust code expects C `size_t` to match Rust `usize`"
> +);
> diff --git a/rust/helpers/build_bug.c b/rust/helpers/build_bug.c
> new file mode 100644
> index 000000000000..f3106f248485
> --- /dev/null
> +++ b/rust/helpers/build_bug.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/errname.h>
> +
> +const char *rust_helper_errname(int err)
> +{
> +       return errname(err);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_errname);
> diff --git a/rust/helpers/err.c b/rust/helpers/err.c
> new file mode 100644
> index 000000000000..fba4e0be64f5
> --- /dev/null
> +++ b/rust/helpers/err.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/err.h>
> +#include <linux/export.h>
> +
> +__force void *rust_helper_ERR_PTR(long err)
> +{
> +       return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
> +
> +bool rust_helper_IS_ERR(__force const void *ptr)
> +{
> +       return IS_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
> +
> +long rust_helper_PTR_ERR(__force const void *ptr)
> +{
> +       return PTR_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> diff --git a/rust/helpers/kunit.c b/rust/helpers/kunit.c
> new file mode 100644
> index 000000000000..905e4ff4424a
> --- /dev/null
> +++ b/rust/helpers/kunit.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <kunit/test-bug.h>
> +#include <linux/export.h>
> +
> +struct kunit *rust_helper_kunit_get_current_test(void)
> +{
> +       return kunit_get_current_test();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
> diff --git a/rust/helpers/mutex.c b/rust/helpers/mutex.c
> new file mode 100644
> index 000000000000..29fd141c387d
> --- /dev/null
> +++ b/rust/helpers/mutex.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/mutex.h>
> +
> +void rust_helper_mutex_lock(struct mutex *lock)
> +{
> +       mutex_lock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> new file mode 100644
> index 000000000000..13ab64805f77
> --- /dev/null
> +++ b/rust/helpers/refcount.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/refcount.h>
> +
> +refcount_t rust_helper_REFCOUNT_INIT(int n)
> +{
> +       return (refcount_t)REFCOUNT_INIT(n);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> +
> +void rust_helper_refcount_inc(refcount_t *r)
> +{
> +       refcount_inc(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> +
> +bool rust_helper_refcount_dec_and_test(refcount_t *r)
> +{
> +       return refcount_dec_and_test(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> diff --git a/rust/helpers/signal.c b/rust/helpers/signal.c
> new file mode 100644
> index 000000000000..d44e8096b8a9
> --- /dev/null
> +++ b/rust/helpers/signal.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/sched/signal.h>
> +
> +int rust_helper_signal_pending(struct task_struct *t)
> +{
> +       return signal_pending(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
> new file mode 100644
> index 000000000000..04fd8ddb4986
> --- /dev/null
> +++ b/rust/helpers/spinlock.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/spinlock.h>
> +
> +void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
> +                                 struct lock_class_key *key)
> +{
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +       __raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CON=
FIG);
> +#else
> +       spin_lock_init(lock);
> +#endif
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___spin_lock_init);
> +
> +void rust_helper_spin_lock(spinlock_t *lock)
> +{
> +       spin_lock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_lock);
> +
> +void rust_helper_spin_unlock(spinlock_t *lock)
> +{
> +       spin_unlock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
> diff --git a/rust/helpers/task.c b/rust/helpers/task.c
> new file mode 100644
> index 000000000000..b176c347f0d4
> --- /dev/null
> +++ b/rust/helpers/task.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/sched/task.h>
> +
> +struct task_struct *rust_helper_get_current(void)
> +{
> +       return current;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_current);
> +
> +void rust_helper_get_task_struct(struct task_struct *t)
> +{
> +       get_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
> +
> +void rust_helper_put_task_struct(struct task_struct *t)
> +{
> +       put_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> diff --git a/rust/helpers/wait.c b/rust/helpers/wait.c
> new file mode 100644
> index 000000000000..bf361f40c7cb
> --- /dev/null
> +++ b/rust/helpers/wait.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/wait.h>
> +
> +void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> +{
> +       init_wait(wq_entry);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_wait);
> diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
> new file mode 100644
> index 000000000000..12e2ee66aa4f
> --- /dev/null
> +++ b/rust/helpers/workqueue.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/export.h>
> +#include <linux/workqueue.h>
> +
> +void rust_helper_init_work_with_key(struct work_struct *work, work_func_=
t func,
> +                                   bool onstack, const char *name,
> +                                   struct lock_class_key *key)
> +{
> +       __init_work(work, onstack);
> +       work->data =3D (atomic_long_t)WORK_DATA_INIT();
> +       lockdep_init_map(&work->lockdep_map, name, key, 0);
> +       INIT_LIST_HEAD(&work->entry);
> +       work->func =3D func;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>
> base-commit: 8db31d3f3bd5dbc8cf3a22bba04b4b4add7f984e
> --
> 2.44.0
>
>

Reviewed-by: Sergio Gonz=C3=A1lez Collado<sergio.collado@gmail.com>
Tested-by: Sergio Gonz=C3=A1lez Collado<sergio.collado@gmail.com>

