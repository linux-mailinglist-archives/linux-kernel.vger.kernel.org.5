Return-Path: <linux-kernel+bounces-98854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258187804F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CED1F21D96
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB73D541;
	Mon, 11 Mar 2024 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUnSdRye"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B138394;
	Mon, 11 Mar 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710162612; cv=none; b=ZVC9fIesfQMYgLKibayd32aAvZfiSQgdesiVuBVQ8csSqhYJKUw6VFDio99UCi9yhtP79bqLdJuIg4Qz4GxlD75kZx4iAYlzSReMavPuCM3uDYS03tkzDv5ZTha9X5gMvXUlh+zLoM4uG57+lgHb5RcQurWXpYvV9J0CVgtEr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710162612; c=relaxed/simple;
	bh=A+Mu6MgYNCf5RgY7hNoPKWfgf2zDD0mxKr1RXHYNs0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3EM31cl64HXgZJP0sdMqTGx4ohmYlCnjUAuNbqYmSMPgqfoDtsxZ41I/KBqIpjCJYKvhD9vALx3zrD9+1d+6hGWE5lrSEXkOhOFstf/6Qp/rCNib6mDFtR87X8vqfWooBfaNqKpErV9JmDGClG332w0WSY3KzTSxhK6uFIkxBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUnSdRye; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29c07fac7a4so528970a91.1;
        Mon, 11 Mar 2024 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710162610; x=1710767410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Mu6MgYNCf5RgY7hNoPKWfgf2zDD0mxKr1RXHYNs0k=;
        b=IUnSdRyeFVAUoym+HZipHTkp+XWGum7rudQhtEGVG2cV9+spoowLJhJgtBOCr4gr+m
         LOos9HiWW60S8iVEyWL99bxZZ8h7+wIj8wrnlopNXLCkPdZ5yDBy/B749hkjH/r1/Wkm
         Sx6t1vTe6Dfy9lTp23i6WR4LKDP6t9ySjMPo4xGnJ2sTsD+YcEJkQNByUZhOBBqr1ZdI
         o7zrVmLYSsOxwPExcz5IwAkWeQwQOWSsOx2LZrayt9mWWdIzhSLng2Dpm1vtD3mYoYhn
         c2XK+eiqddMvwnO1kUgFquK0r3GmM+37w/WivFZuG3dWu/8UeGrmA3276QD/MwfLLt24
         WoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710162610; x=1710767410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Mu6MgYNCf5RgY7hNoPKWfgf2zDD0mxKr1RXHYNs0k=;
        b=HbDFAkyC4yoK7elCXKk5RUhaQfyVIBOxYZ5DLOMEWjtXZFjYfE9V+VI3XFD7Vzjz7L
         3Oq8WKxVGOlD4ag4WEXLRESVSZzEvbGPVTJkjT2FQwPJffzUvHsJn+cxwm5mSScYq03B
         orPRLcXbJ2WUn9V3UpxByauSl5/vJTZFax+MYFv2k/SIpxzXpvbvdJKIlRnp5KpgG6zb
         3yXQGRjnYptEXkd6YschAxi2BkhMDty7hbddHDsImZl/8KlRbt1+qh2JYILtNOy+eo8D
         1/nU2FZu1uVM9OJ2yBuYg768dR5Ix1mcRlWujGbMPidz11JosAHrqjNBggFwmwymZFxE
         K0Og==
X-Forwarded-Encrypted: i=1; AJvYcCVWhboMIqBIY2YrlZCkkPsKrMRaZI0lT52PDbY/g0dU4hct8yA34EU80qTcgny3uUYc1PGgluyalsJKeWYNUCE9wToCvcggUzxPTl3OHModZwckfHxXqt2yGkDOPKQh3RG0dIxDazsYoG+P6E0=
X-Gm-Message-State: AOJu0YyL8nCYp7+xrKGvWKU2/uM7DSngQLnVrFrrSOdd66qDwNaIXcQH
	1yAl+WvUv6vDkzsuYpKcjXX6ilXbcpploR//4uWqI24BHBmRnSIjPrAAY/wNvMXmABPCxAFI6Cs
	43Ue2r40jrB4tzk0ISqmSBYA0+aM=
X-Google-Smtp-Source: AGHT+IF6DQWdMMr6b36B8Qz2fGLuC79eyZPhod5NR7nCa/zXGZCZy785W52NqbWXaaLJ8404xu7I3KJw04gurxqO/5M=
X-Received: by 2002:a17:90a:f3c4:b0:29a:a31d:695a with SMTP id
 ha4-20020a17090af3c400b0029aa31d695amr8716304pjb.1.1710162610571; Mon, 11 Mar
 2024 06:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223163726.12397-1-dakr@redhat.com> <6ba16a74-6fa4-4051-8cc6-f0e53a68d8b4@redhat.com>
 <Ze73aPMEg-BUCE8W@hs01.dakr.org>
In-Reply-To: <Ze73aPMEg-BUCE8W@hs01.dakr.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 11 Mar 2024 14:10:04 +0100
Message-ID: <CANiq72kK5CF0RQathACD_=7K1Ye4eMVdUnRcvkDZx4ALtq46wg@mail.gmail.com>
Subject: Re: [PATCH v5] rust: str: add {make,to}_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:22=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> =
wrote:
>
> It doesn't seem there's any further feedback, thus can this be merged?

No, it cannot be applied until the merge window closes, i.e. 2 weeks from n=
ow.

Please note that there are other patches yet to be applied that were
sent before this v5 -- we aim to send early PRs to Linus, and in
general for at least a week in -next and for at least a week for
review. Thus -rc5/6 is already quite late in general.

Cheers,
Miguel

