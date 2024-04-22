Return-Path: <linux-kernel+bounces-153169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D766A8ACA85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17241C20D23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913F13E8BC;
	Mon, 22 Apr 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikInrQqy"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D931713E021
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781463; cv=none; b=U2wb3obWlJ/SZGHAaXXtsPeP/MnRostfqEhZguRu0g04P8w4Ce4o3zbVgFyR7Z5rdK2NNipvBrAhnzyPaa9P6mj6E5asQLnlqKPKiM97Z4ADZ6T1CEcmI1A3FE9c2T9/jajG+AhH8v0CjNTaej7GcUtWiFWudn6D7AEumFsaQUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781463; c=relaxed/simple;
	bh=mi0xbrKlB0lvxkZS1ncAzwN1QGAG0nmule/crbDY71k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4B7t9csdMRQ9SSskxu1ZDiA7D1VcZE2PfSgNgFRa6XEa9vdbyOC3TrkaXikstquoyoBPirB9BK1XxweF5t+D5+G4i3U3SuVLZGCGlmiflvKEERpLnqAY1/51Ot4nPyt89Oe6LBlZqvXRnfkavBjZWzaDgFG45lNtDoBGs6JRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikInrQqy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so412379b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713781459; x=1714386259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tslZ+Qzlz1j5Pd1EMs/tUwgGlMzPb/+Wlp3pdjhK+8=;
        b=ikInrQqy8FJ0aXG306PBj+B4lyeN2eYBvqiPqw2wfTd1RPGqYeAiMGN/U1w4P82nBf
         sDNQVtWNdzwgoBi+6HiE3ZvdZohsEQf2306rPfnTrYarOSsO3Y7RShkIKxPFRd2/5dgI
         Kq3u/4k8UJeWKrd4qOBbKB6pyjYuki5ql1IpVPGQZ8onybiL0s2CHw4bpcXxilnUixes
         MXvrgSSVrU+s8hTF/2ok6pzrT005gwi29O+Ml1l8yLP2L19Ka+ly65nEKx93CO3Qmsm/
         YL8iL/QPBw66YMw3h3vbJ/3SZyrJ9dTl9JG3CxJtUhVqSbDJSbByBFQNbJkGRGiiLS2U
         Az2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713781459; x=1714386259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tslZ+Qzlz1j5Pd1EMs/tUwgGlMzPb/+Wlp3pdjhK+8=;
        b=qibPKMKvpSkSbJxE28QpEPgGyWx0fmWq9GqZGXNh5IfaOj3wCitQJ0IoMtF4TTK1kw
         oM0ylvTxRs9Sj8goFvJQNFXpNrMvrEKgoOC3XxXBgdFovUSvKhHi1kfi/AeMmCfKYcu1
         2PApR7cizNCcs9gzUt/1y8XHDFY+n4eIJ5mNhRAEPULJPIu1aWIU9Mlkr+EukICH9jVe
         HA678RoMJ18AgMFzPYrFJ+Xt/QVvPgs/BBa+YQeo4yVPFM4caS2hkbtnhdzNtNpYF7n8
         J9/PIp0aNQbRSAUyIZlRofVitfXHK2cJt8XulijzYH6iJ12Mx04Etzz0aglOnPYWNVAm
         9rzw==
X-Forwarded-Encrypted: i=1; AJvYcCV5DcaaCQFZOwiuJmfO7gd+vn51gCK8sGxhHA8GPhEXHGea3Vjit/HA1VeLv2+NPuVnL7QFnbi5M3jGwqB9uXtPgJWvZ48mEskmGGS9
X-Gm-Message-State: AOJu0Yw8lD28Ir7ZRrYXcj4yK0pw7zgWQ1EwK3UZVaZNbqsERyVHpXWB
	2bo/gMlN4igMsY91BgwvCJ8tl+GCZnlinOYGZP1/Iw28CxjV9LWlRW8Ol3UwD5M=
X-Google-Smtp-Source: AGHT+IEjJwvMj3wsFB7mtO4AuZk3RgS0Hh/NjtPjk3W3VxiPq2Dl3ewPossm0AZtDcrzzo4rj3dBrw==
X-Received: by 2002:a05:6a20:d806:b0:1ac:f1a0:a626 with SMTP id iv6-20020a056a20d80600b001acf1a0a626mr6870548pzb.3.1713781458591;
        Mon, 22 Apr 2024 03:24:18 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm7533394pfn.69.2024.04.22.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:24:17 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:54:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] rust: Add bindings for OPP framework
Message-ID: <20240422102415.xvmuja6bdfxgl4pv@vireshk-i7>
References: <cover.1712314032.git.viresh.kumar@linaro.org>
 <06bb914eae00671a69b393bf86bb01ddec86c16f.1712314032.git.viresh.kumar@linaro.org>
 <ff6c7d5e-d6e9-4331-b8cc-eab139160e59@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6c7d5e-d6e9-4331-b8cc-eab139160e59@proton.me>

Thanks for the review Benno. I was waiting for more review comments to
come in and hence didn't reply earlier with an update.

On 07-04-24, 09:54, Benno Lossin wrote:
> On 05.04.24 13:09, Viresh Kumar wrote:
> > +    clk_names: Option<Pin<Vec<CString>>>,
> 
> Why are you using `Pin<Vec<_>>`? The vector may reallocate the backing
> storage at any point in time.

> > +    /// Sets the configuration with the OPP core.
> > +    pub fn set(&mut self, dev: &Device) -> Result<()> {
> > +        // Already configured.
> > +        if self.token.is_some() {
> 
> Why does the config hold onto this token? Would it make sense to consume
> the config and return a `Handle` or `Token` abstraction? Then you don't
> need to check if the config has been "used" before.
 
> > +#[repr(transparent)]
> > +pub struct OPP(*mut bindings::dev_pm_opp);
> 
> I think you should use the `ARef` pattern instead:
> 
>      #[repr(transparent)]
>      pub struct OPP(Opaque<bindings::dev_pm_opp>);
> 
>      unsafe impl AlwaysRefCounted for OPP {
>          // ...
>      }
> 
> Then you can use `ARef<OPP>` everywhere you use `OPP` currently.

All these comments look good to me. Updated the code with them (not
reposting them for now)

-------------------------8<-------------------------

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/opp.rs              | 888 ++++++++++++++++++++++++++++++++
 3 files changed, 891 insertions(+)
 create mode 100644 rust/kernel/opp.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index baabff999bd5..370043838a54 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,6 +22,7 @@
 #include <linux/platform_device.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
+#include <linux/pm_opp.h>
 #include <linux/poll.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a153336973e6..56b666f466a0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,8 @@
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
+#[cfg(CONFIG_PM_OPP)]
+pub mod opp;
 pub mod platform;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
new file mode 100644
index 000000000000..25e9e818b270
--- /dev/null
+++ b/rust/kernel/opp.rs
@@ -0,0 +1,888 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Operating performance points.
+//!
+//! This module provides bindings for interacting with the OPP subsystem.
+//!
+//! C header: [`include/linux/pm_opp.h`](../../../../../../include/linux/pm_opp.h)
+
+use crate::{
+    bindings,
+    device::{Device, RawDevice},
+    error::{code::*, from_err_ptr, from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    prelude::*,
+    str::CString,
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+#[cfg(CONFIG_CPU_FREQ)]
+use crate::cpufreq;
+
+use core::{ffi::c_char, marker::PhantomData, ops::Deref, ptr};
+
+use macros::vtable;
+
+// Creates a null-terminated slice of pointers to Cstrings.
+fn to_c_str_array(names: &Vec<CString>) -> Result<Vec<*const c_char>> {
+    // Allocated a null-terminated vector of pointers.
+    let mut list = Vec::try_with_capacity(names.len() + 1)?;
+
+    for name in names.iter() {
+        list.try_push(name.as_ptr() as _)?;
+    }
+
+    list.try_push(ptr::null())?;
+    Ok(list)
+}
+
+/// Equivalent to `struct dev_pm_opp_data` in the C Code.
+#[repr(transparent)]
+pub struct Data(bindings::dev_pm_opp_data);
+
+impl Data {
+    /// Creates new instance of [`Data`].
+    pub fn new(freq: u64, u_volt: u64, level: u32, turbo: bool) -> Self {
+        Self(bindings::dev_pm_opp_data {
+            turbo,
+            freq,
+            u_volt,
+            level,
+        })
+    }
+}
+
+/// OPP search types.
+#[derive(Copy, Clone, Debug, Eq, PartialEq)]
+pub enum SearchType {
+    /// Search for exact value.
+    Exact,
+    /// Search for highest value less than equal to value.
+    Floor,
+    /// Search for lowest value greater than equal to value.
+    Ceil,
+}
+
+/// Implement this trait to provide OPP Configuration callbacks.
+#[vtable]
+pub trait ConfigOps {
+    /// Called by the OPP core to configure OPP clks.
+    fn config_clks(
+        _dev: &Device,
+        _table: &Table,
+        _opp: ARef<OPP>,
+        _scaling_down: bool,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Called by the OPP core to configure OPP regulators.
+    fn config_regulators(
+        _dev: &Device,
+        _opp_old: ARef<OPP>,
+        _opp_new: ARef<OPP>,
+        _data: *mut *mut bindings::regulator,
+        _count: u32,
+    ) -> Result<()> {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Config token returned by the C code.
+pub struct ConfigToken(i32);
+
+impl Drop for ConfigToken {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_clear_config(self.0) };
+    }
+}
+
+/// Equivalent to `struct dev_pm_opp_config` in the C Code.
+pub struct Config<T: ConfigOps> {
+    clk_names: Option<Vec<CString>>,
+    prop_name: Option<CString>,
+    regulator_names: Option<Vec<CString>>,
+    genpd_names: Option<Vec<CString>>,
+    supported_hw: Option<Vec<u32>>,
+    required_devs: Option<Vec<Device>>,
+    _data: PhantomData<T>,
+}
+
+impl<T: ConfigOps> Config<T> {
+    /// Creates a new instance of [`Config`].
+    pub fn new() -> Self {
+        Self {
+            clk_names: None,
+            prop_name: None,
+            regulator_names: None,
+            genpd_names: None,
+            supported_hw: None,
+            required_devs: None,
+            _data: PhantomData,
+        }
+    }
+
+    /// Initializes clock names.
+    pub fn set_clk_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured.
+        if self.clk_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.clk_names = Some(names);
+        Ok(())
+    }
+
+    /// Initializes property name.
+    pub fn set_prop_name(&mut self, name: CString) -> Result<()> {
+        // Already configured.
+        if self.prop_name.is_some() {
+            return Err(EBUSY);
+        }
+
+        self.prop_name = Some(name);
+        Ok(())
+    }
+
+    /// Initializes regulator names.
+    pub fn set_regulator_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured.
+        if self.regulator_names.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.regulator_names = Some(names);
+
+        Ok(())
+    }
+
+    /// Initializes genpd names.
+    pub fn set_genpd_names(&mut self, names: Vec<CString>) -> Result<()> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if names.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.genpd_names = Some(names);
+        Ok(())
+    }
+
+    /// Initializes required devices.
+    pub fn set_required_devs(&mut self, devs: Vec<Device>) -> Result<()> {
+        // Already configured. Only one of genpd or required devs can be configured.
+        if self.genpd_names.is_some() || self.required_devs.is_some() {
+            return Err(EBUSY);
+        }
+
+        if devs.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.required_devs = Some(devs);
+        Ok(())
+    }
+
+    /// Initializes supported hardware.
+    pub fn set_supported_hw(&mut self, hw: Vec<u32>) -> Result<()> {
+        // Already configured.
+        if self.supported_hw.is_some() {
+            return Err(EBUSY);
+        }
+
+        if hw.is_empty() {
+            return Err(EINVAL);
+        }
+
+        self.supported_hw = Some(hw);
+        Ok(())
+    }
+
+    /// Sets the configuration with the OPP core.
+    pub fn set(self, dev: &Device) -> Result<ConfigToken> {
+        let (_clk_list, clk_names) = match &self.clk_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_regulator_list, regulator_names) = match &self.regulator_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let (_genpd_list, genpd_names) = match &self.genpd_names {
+            Some(x) => {
+                let list = to_c_str_array(x)?;
+                let ptr = list.as_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null()),
+        };
+
+        let prop_name = match &self.prop_name {
+            Some(x) => x.as_char_ptr(),
+            None => ptr::null(),
+        };
+
+        let (supported_hw, supported_hw_count) = match &self.supported_hw {
+            Some(x) => (x.as_ptr(), x.len() as u32),
+            None => (ptr::null(), 0),
+        };
+
+        let (_required_devs_list, required_devs) = match &self.required_devs {
+            Some(x) => {
+                // Create a non-NULL-terminated vectorof pointers.
+                let mut list = Vec::try_with_capacity(x.len())?;
+
+                for dev in x.iter() {
+                    list.try_push(dev.raw_device())?;
+                }
+
+                let ptr = list.as_mut_ptr();
+                (Some(list), ptr)
+            }
+            None => (None, ptr::null_mut()),
+        };
+
+        let mut config = bindings::dev_pm_opp_config {
+            clk_names,
+            config_clks: if T::HAS_CONFIG_CLKS {
+                Some(Self::config_clks)
+            } else {
+                None
+            },
+            prop_name,
+            regulator_names,
+            config_regulators: if T::HAS_CONFIG_REGULATORS {
+                Some(Self::config_regulators)
+            } else {
+                None
+            },
+            genpd_names,
+            supported_hw,
+            supported_hw_count,
+
+            // Don't need to support virt_devs for now.
+            virt_devs: ptr::null_mut(),
+            required_devs,
+        };
+
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. The OPP core guarantees to not use fields of `config`, after this call has
+        // returned and so we don't need to save a copy of them for future use
+        let ret = unsafe { bindings::dev_pm_opp_set_config(dev.raw_device(), &mut config) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ConfigToken(ret))
+        }
+    }
+
+    // Config's config_clks callback.
+    extern "C" fn config_clks(
+        dev: *mut bindings::device,
+        opp_table: *mut bindings::opp_table,
+        opp: *mut bindings::dev_pm_opp,
+        _data: *mut core::ffi::c_void,
+        scaling_down: bool,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::new(dev) };
+            T::config_clks(
+                &dev,
+                // SAFETY: 'opp_table' is guaranteed by the C code to be valid.
+                &unsafe { Table::from_ptr(opp_table, dev.clone()) },
+                // SAFETY: 'opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(opp)? },
+                scaling_down,
+            )
+            .map(|_| 0)
+        })
+    }
+
+    // Config's config_regulators callback.
+    extern "C" fn config_regulators(
+        dev: *mut bindings::device,
+        old_opp: *mut bindings::dev_pm_opp,
+        new_opp: *mut bindings::dev_pm_opp,
+        regulators: *mut *mut bindings::regulator,
+        count: core::ffi::c_uint,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: 'dev' is guaranteed by the C code to be valid.
+            let dev = unsafe { Device::new(dev) };
+            T::config_regulators(
+                &dev,
+                // SAFETY: 'old_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(old_opp)? },
+                // SAFETY: 'new_opp' is guaranteed by the C code to be valid.
+                unsafe { OPP::from_ptr(new_opp)? },
+                regulators,
+                count,
+            )
+            .map(|_| 0)
+        })
+    }
+}
+
+/// CPU Frequency table created from OPP entries.
+#[cfg(CONFIG_CPU_FREQ)]
+pub struct FreqTable {
+    dev: Device,
+    table: cpufreq::Table,
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl FreqTable {
+    /// Creates new instance of [`FreqTable`] from raw pointer.
+    fn new(table: &Table) -> Result<Self> {
+        let mut ptr: *mut bindings::cpufreq_frequency_table = ptr::null_mut();
+
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_init_cpufreq_table(table.dev.raw_device(), &mut ptr)
+        })?;
+        Ok(Self {
+            dev: table.dev.clone(),
+            // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+            table: unsafe { cpufreq::Table::from_raw(ptr) },
+        })
+    }
+
+    /// Returns reference to the underlying [`cpufreq::Table`].
+    pub fn table(&self) -> &cpufreq::Table {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Deref for FreqTable {
+    type Target = cpufreq::Table;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        &self.table
+    }
+}
+
+#[cfg(CONFIG_CPU_FREQ)]
+impl Drop for FreqTable {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // relinquish it now.
+        unsafe {
+            bindings::dev_pm_opp_free_cpufreq_table(self.dev.raw_device(), &mut self.as_ptr())
+        };
+    }
+}
+
+/// Operating performance point (OPP) table.
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+pub struct Table {
+    ptr: *mut bindings::opp_table,
+    dev: Device,
+    em: bool,
+    of: bool,
+    cpumask: Option<cpufreq::Cpumask>,
+}
+
+// SAFETY: The fields of `Table` are safe to be used from any thread.
+unsafe impl Send for Table {}
+
+// SAFETY: The fields of `Table` are safe to be referenced from any thread.
+unsafe impl Sync for Table {}
+
+impl Table {
+    /// Creates a new OPP table instance from raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `ptr` is valid and non-null.
+    unsafe fn from_ptr(ptr: *mut bindings::opp_table, dev: Device) -> Self {
+        // SAFETY: By the safety requirements, ptr is valid and its refcount will be incremented.
+        unsafe { bindings::dev_pm_opp_get_opp_table_ref(ptr) };
+
+        Self {
+            ptr,
+            dev,
+            em: false,
+            of: false,
+            cpumask: None,
+        }
+    }
+
+    /// Find OPP table from device.
+    pub fn from_dev(dev: &Device) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. Refcount of the OPP table is incremented as well.
+        let ptr = from_err_ptr(unsafe { bindings::dev_pm_opp_get_opp_table(dev.raw_device()) })?;
+
+        Ok(Self {
+            ptr,
+            dev: dev.clone(),
+            em: false,
+            of: false,
+            cpumask: None,
+        })
+    }
+
+    /// Add device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of(dev: &Device, index: i32) -> Result<Self> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. Refcount of the OPP table is incremented as well.
+        to_result(unsafe { bindings::dev_pm_opp_of_add_table_indexed(dev.raw_device(), index) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        table.of = true;
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for the device.
+    #[cfg(CONFIG_OF)]
+    fn remove_of(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. We took the reference from `from_of` earlier, it is safe to drop the same
+        // now.
+        unsafe { bindings::dev_pm_opp_of_remove_table(self.dev.raw_device()) };
+    }
+
+    /// Add device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    pub fn from_of_cpumask(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<Self> {
+        // SAFETY: The cpumask is valid and the returned ptr will be owned by the [`Table`] instance.
+        to_result(unsafe { bindings::dev_pm_opp_of_cpumask_add_table(cpumask.as_ptr()) })?;
+
+        // Fetch the newly created table.
+        let mut table = Self::from_dev(dev)?;
+        // SAFETY: The `cpumask` is guaranteed by the C code to be valid.
+        table.cpumask = Some(unsafe { cpufreq::Cpumask::new(cpumask.as_mut_ptr()) });
+
+        Ok(table)
+    }
+
+    // Remove device tree based OPP table for CPU devices.
+    #[cfg(CONFIG_OF)]
+    fn remove_of_cpumask(&self, cpumask: &cpufreq::Cpumask) {
+        // SAFETY: The cpumask is valid and we took the reference from `from_of_cpumask` earlier,
+        // it is safe to drop the same now.
+        unsafe { bindings::dev_pm_opp_of_cpumask_remove_table(cpumask.as_ptr()) };
+    }
+
+    /// Returns the number of OPPs in the table.
+    pub fn opp_count(&self) -> Result<u32> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        let ret = unsafe { bindings::dev_pm_opp_get_opp_count(self.dev.raw_device()) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u32)
+        }
+    }
+
+    /// Returns max clock latency of the OPPs in the table.
+    pub fn max_clock_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_clock_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns max volt latency of the OPPs in the table.
+    pub fn max_volt_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_volt_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns max transition latency of the OPPs in the table.
+    pub fn max_transition_latency(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_max_transition_latency(self.dev.raw_device()) }
+    }
+
+    /// Returns the suspend OPP.
+    pub fn suspend_freq(&self) -> u64 {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_get_suspend_opp_freq(self.dev.raw_device()) }
+    }
+
+    /// Synchronizes regulators used by the OPP table.
+    pub fn sync_regulators(&self) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_sync_regulators(self.dev.raw_device()) })
+    }
+
+    /// Gets sharing CPUs.
+    pub fn sharing_cpus(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_get_sharing_cpus(dev.raw_device(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Sets sharing CPUs.
+    pub fn set_sharing_cpus(&self, cpumask: &cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_set_sharing_cpus(self.dev.raw_device(), cpumask.as_ptr())
+        })
+    }
+
+    /// Gets sharing CPUs from Device tree.
+    #[cfg(CONFIG_OF)]
+    pub fn of_sharing_cpus(dev: &Device, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_get_sharing_cpus(dev.raw_device(), cpumask.as_mut_ptr())
+        })
+    }
+
+    /// Updates the voltage value for an OPP.
+    pub fn adjust_voltage(
+        &self,
+        freq: u64,
+        u_volt: u64,
+        u_volt_min: u64,
+        u_volt_max: u64,
+    ) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_adjust_voltage(
+                self.dev.raw_device(),
+                freq,
+                u_volt,
+                u_volt_min,
+                u_volt_max,
+            )
+        })
+    }
+
+    /// Create cpufreq table from OPP table.
+    #[cfg(CONFIG_CPU_FREQ)]
+    pub fn to_cpufreq_table(&mut self) -> Result<FreqTable> {
+        FreqTable::new(self)
+    }
+
+    /// Sets a matching OPP based on frequency.
+    pub fn set_rate(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_rate(self.dev.raw_device(), freq) })
+    }
+
+    /// Sets exact OPP.
+    pub fn set_opp(&self, opp: ARef<OPP>) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_set_opp(self.dev.raw_device(), opp.as_mut_ptr()) })
+    }
+
+    /// Finds OPP based on frequency.
+    pub fn opp_from_freq(
+        &self,
+        mut freq: u64,
+        available: Option<bool>,
+        index: Option<u32>,
+        stype: SearchType,
+    ) -> Result<ARef<OPP>> {
+        let rdev = self.dev.raw_device();
+        let index = index.unwrap_or(0);
+
+        let ptr = from_err_ptr(match stype {
+            SearchType::Exact => {
+                if let Some(available) = available {
+                    // SAFETY: The requirements are satisfied by the existence of `RawDevice` and
+                    // its safety requirements. The returned ptr will be owned by the new [`OPP`]
+                    // instance.
+                    unsafe {
+                        bindings::dev_pm_opp_find_freq_exact_indexed(rdev, freq, index, available)
+                    }
+                } else {
+                    return Err(EINVAL);
+                }
+            }
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_freq_ceil_indexed(rdev, &mut freq as *mut u64, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_freq_floor_indexed(rdev, &mut freq as *mut u64, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_ptr_owned(ptr) }
+    }
+
+    /// Finds OPP based on level.
+    pub fn opp_from_level(&self, mut level: u32, stype: SearchType) -> Result<ARef<OPP>> {
+        let rdev = self.dev.raw_device();
+
+        let ptr = from_err_ptr(match stype {
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Exact => unsafe { bindings::dev_pm_opp_find_level_exact(rdev, level) },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_level_ceil(rdev, &mut level as *mut u32)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_level_floor(rdev, &mut level as *mut u32)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_ptr_owned(ptr) }
+    }
+
+    /// Finds OPP based on bandwidth.
+    pub fn opp_from_bw(&self, mut bw: u32, index: i32, stype: SearchType) -> Result<ARef<OPP>> {
+        let rdev = self.dev.raw_device();
+
+        let ptr = from_err_ptr(match stype {
+            // The OPP core doesn't support this yet.
+            SearchType::Exact => return Err(EINVAL),
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Ceil => unsafe {
+                bindings::dev_pm_opp_find_bw_ceil(rdev, &mut bw as *mut u32, index)
+            },
+
+            // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its
+            // safety requirements. The returned ptr will be owned by the new [`OPP`] instance.
+            SearchType::Floor => unsafe {
+                bindings::dev_pm_opp_find_bw_floor(rdev, &mut bw as *mut u32, index)
+            },
+        })?;
+
+        // SAFETY: The `ptr` is guaranteed by the C code to be valid.
+        unsafe { OPP::from_ptr_owned(ptr) }
+    }
+
+    /// Enable the OPP.
+    pub fn enable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_enable(self.dev.raw_device(), freq) })
+    }
+
+    /// Disable the OPP.
+    pub fn disable_opp(&self, freq: u64) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_disable(self.dev.raw_device(), freq) })
+    }
+
+    /// Registers with Energy model.
+    #[cfg(CONFIG_OF)]
+    pub fn of_register_em(&mut self, cpumask: &mut cpufreq::Cpumask) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe {
+            bindings::dev_pm_opp_of_register_em(self.dev.raw_device(), cpumask.as_mut_ptr())
+        })?;
+
+        self.em = true;
+        Ok(())
+    }
+
+    // Unregisters with Energy model.
+    #[cfg(CONFIG_OF)]
+    fn of_unregister_em(&self) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements. We registered with the EM framework earlier, it is safe to unregister now.
+        unsafe { bindings::em_dev_unregister_perf_domain(self.dev.raw_device()) };
+    }
+}
+
+impl Drop for Table {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe
+        // to relinquish it now.
+        unsafe { bindings::dev_pm_opp_put_opp_table(self.ptr) };
+
+        #[cfg(CONFIG_OF)]
+        {
+            if self.em {
+                self.of_unregister_em();
+            }
+
+            if self.of {
+                self.remove_of();
+            } else if let Some(cpumask) = &self.cpumask {
+                self.remove_of_cpumask(cpumask);
+            }
+        }
+    }
+}
+
+/// Operating performance point (OPP).
+///
+/// # Invariants
+///
+/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
+/// `self`, and will be decremented when `self` is dropped.
+#[repr(transparent)]
+pub struct OPP(Opaque<bindings::dev_pm_opp>);
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, which is safe to be used from any thread.
+unsafe impl Send for OPP {}
+
+// SAFETY: `OPP` only holds a pointer to a C OPP, references to which are safe to be used from any
+// thread.
+unsafe impl Sync for OPP {}
+
+// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
+unsafe impl AlwaysRefCounted for OPP {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dev_pm_opp_put(obj.cast().as_ptr()) }
+    }
+}
+
+impl OPP {
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_ptr_owned(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let ptr = ptr::NonNull::new(ptr).ok_or(ENODEV)?;
+
+        // SAFETY: The safety requirements guarantee the validity of the pointer.
+        //
+        // INVARIANT: The refcount is already incremented by the C API that returned the pointer,
+        // and we pass ownership of the refcount to the new `ARef<OPP>`.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`OPP`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`OPP`] reference.
+    pub unsafe fn from_ptr(ptr: *mut bindings::dev_pm_opp) -> Result<ARef<Self>> {
+        let opp = unsafe { Self::from_ptr_owned(ptr) }?;
+
+        // Take an extra reference to the OPP since the caller didn't take it.
+        opp.inc_ref();
+
+        Ok(opp)
+    }
+
+    fn as_mut_ptr(&self) -> *mut bindings::dev_pm_opp {
+        self.0.get()
+    }
+
+    /// Adds an OPP dynamically.
+    pub fn add(dev: &Device, mut data: Data) -> Result<()> {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        to_result(unsafe { bindings::dev_pm_opp_add_dynamic(dev.raw_device(), &mut data.0) })
+    }
+
+    /// Removes a dynamically added OPP.
+    pub fn remove(dev: &Device, freq: u64) {
+        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
+        // requirements.
+        unsafe { bindings::dev_pm_opp_remove(dev.raw_device(), freq) };
+    }
+
+    /// Returns the frequency of an OPP.
+    pub fn freq(&self, index: Option<u32>) -> u64 {
+        let index = index.unwrap_or(0);
+
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_freq_indexed(self.as_mut_ptr(), index) }
+    }
+
+    /// Returns the voltage of an OPP.
+    pub fn voltage(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_voltage(self.as_mut_ptr()) }
+    }
+
+    /// Returns the level of an OPP.
+    pub fn level(&self) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_level(self.as_mut_ptr()) }
+    }
+
+    /// Returns the power of an OPP.
+    pub fn power(&self) -> u64 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_power(self.as_mut_ptr()) }
+    }
+
+    /// Returns the required pstate of an OPP.
+    pub fn required_pstate(&self, index: u32) -> u32 {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_get_required_pstate(self.as_mut_ptr(), index) }
+    }
+
+    /// Returns true if the OPP is turbo.
+    pub fn is_turbo(&self) -> bool {
+        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
+        // use it.
+        unsafe { bindings::dev_pm_opp_is_turbo(self.as_mut_ptr()) }
+    }
+}

