Return-Path: <linux-kernel+bounces-45501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DD843198
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEE1F258AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8778479DB2;
	Tue, 30 Jan 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShsKa0Qi"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3A77EEFD;
	Tue, 30 Jan 2024 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658851; cv=none; b=NTVeeEDju0JuPfIKotpewPkiiwVAOh09W9zMi+KoGK/MlWDjUp6UFpJn5LolfoolmIZVbK7PG6Hli8A5hoxWmgTAbBiiWE6Zmx6Ye9yWYNAjObOtGfY2x/v/BFG1ZTwXVzFncbveMym840z4HcrFKKS2/acp4O67N0Sl+eekTdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658851; c=relaxed/simple;
	bh=OmptIwhlgwDDdmhkFqgoAUMwqihSVOSlH9BzTj4os4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEPwPlsGmoC4kMpEESl4ek0bKwWtFUk+JBXk3IfiXQDvE4cuAswxtObWkTiAjZScOkXn+WoL6lo3jrsSGujBMdNi6Nt3Dz81jD8WQxunV6kMbuR9fVaTfe3oj1yJ1EjhHpMgk0Qxpp/+35M5j2fHC2kBCob6B9vIlUTqdXlWfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShsKa0Qi; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-603c5d7997aso32200167b3.1;
        Tue, 30 Jan 2024 15:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706658849; x=1707263649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmptIwhlgwDDdmhkFqgoAUMwqihSVOSlH9BzTj4os4k=;
        b=ShsKa0Qi2A9zq+L3PHXvzYBtJXO0SYtRlmflJ2UbtthpQFQwE4p6OsXikwLEn3whiN
         Rgwm4VDINXrWdAh1T2wXArp488KfFAAdBmzWJ3bSfjXASReNVOUTK7vGEJZkjCktT6Vs
         t1f5fUft8J7hLjDJJc2ILqigODbcu/FilrD22EAAkn3iM79aQtYFYVvFzTPlRNRJkeTG
         YZ4KV0FI65MAcRIWA/5f7b57Vwhxjgz+aQjm35Xmx014WmUIhrjTTSAyjRV+sHG20Zo5
         muH+pR6uylESK45l296Il730tdSRMCXHAKJbFxF5xmMnTNtj/zedzYISkHCfNFHXfcJK
         U2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658849; x=1707263649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmptIwhlgwDDdmhkFqgoAUMwqihSVOSlH9BzTj4os4k=;
        b=Ffebo45VMCsSEEpkOPinqO/KfFSTHcJjLljWgtwqKALDewDVR7L8c/Ztf41WsbHCmb
         qv6q9ce7ot5jQw/blylPGRV+xA7GXQ0VDIn2iXmd6M7mkeiVXF1bFvklO5lhz0te8W6U
         CoCRL9cUzfXjzpRe0WiENVMxfAOaO+BnCMd5udnEfBFFlSzUVUxp34WRXullm2yP1H+o
         9r/bLlX+QVtltEGoPQ33Re2kVBTvhHzkVSfHE9uogHkaCUwhgi+jOOYQA8a3Bun3U9hv
         xcUxun16jDcO0TzDa/IQJJ8XH2wcnxk5lJMqPv+pwkejpFaWWIgUtUaUc9iL38odfcDB
         Lcug==
X-Gm-Message-State: AOJu0YxhWY3Ao7ulWPuY6Y+XMx2ildqn0jmAPbkoPSF6uXIAtKC9UT/t
	5WMtFD9kIDga+jcRrRt5T9NhjUrtFbKq5p/sPBSE1LOrE0oupVImUQ4d98rFx8aOdmPRo14TC+a
	iH9BL15/4shxy0qYE6gtAofyJvJM=
X-Google-Smtp-Source: AGHT+IHKhinxJu3Fsc/6EFnC05xYxRpIJI5hfm5RLDPm+j5XOEJ1d/OO7naRToqOEkmp2cnObTWbzLw6rsEwa21X8u4=
X-Received: by 2002:a25:dccc:0:b0:dc2:2799:981a with SMTP id
 y195-20020a25dccc000000b00dc22799981amr134346ybe.18.1706658849249; Tue, 30
 Jan 2024 15:54:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215194828.2611213-1-mmaurer@google.com> <CANiq72musVZbNW5MuhrRJEmA8G_D3D7Ms0pTYu16WrqhFx2pXg@mail.gmail.com>
 <f17ce61b-7f4f-4851-aa23-b8489686b840@intel.com>
In-Reply-To: <f17ce61b-7f4f-4851-aa23-b8489686b840@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jan 2024 00:53:58 +0100
Message-ID: <CANiq72kPfDt83AxhO1c9N2Ua+cLCA7xvag7T4N=z+pZUom1evA@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
To: Dave Hansen <dave.hansen@intel.com>
Cc: Matthew Maurer <mmaurer@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 12:46=E2=80=AFAM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> Do we need a 'rust-option' equivalent of 'cc-option', like:

No, at least until we start supporting several versions of the Rust
compiler (and the current version will not be in that set, so there is
no need to add complexity and spawning extra processes during the
build).

Cheers,
Miguel

