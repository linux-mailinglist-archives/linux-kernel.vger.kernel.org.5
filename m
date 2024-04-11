Return-Path: <linux-kernel+bounces-141075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988C8A1A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891EB1C22CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25E11D780A;
	Thu, 11 Apr 2024 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEVv67mH"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D81D6381;
	Thu, 11 Apr 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850000; cv=none; b=Ys/fatOUG5SiwTJm2SNAIbHohIKtyt/5WNlkXkCcdnIilbvlPjMUuE8kPcEVyDctVoYXeS/CdVGGpiSg/G9ONuF1jX7VvMW7C0LPc7HUzmoBW419Nbzur4XmCkE0dMIpiGZzlVYtsG1YA0IOleqGle13a+Px0TmALNxg3FHc8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850000; c=relaxed/simple;
	bh=mOTXpPdaiY/n+o5yUlSF9VJPmoTrThEaztMjh6xCFc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmzmD49Nxnyx8pYcs3Rkz6PKUTzAb0ximiDVin5AeQAn96O/BcA71+2BgvCiq/qud1JP+8FsyHrvVjkLHrFX9PM0MPp/6i/AS9cKBGGZ6Y0YdcIzgNyTfAdnGc/3KzMFjsqHes0pnr0dOuffRuVjvqSZspSPuc2Z9cgLGiLaM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEVv67mH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso4898619a12.3;
        Thu, 11 Apr 2024 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712849998; x=1713454798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOTXpPdaiY/n+o5yUlSF9VJPmoTrThEaztMjh6xCFc8=;
        b=EEVv67mH0srdDt9sS0VMvtb1qDrZeTMxhOI4IpT54v5wbZf4y3VKK0koxLgeZfuguY
         cbIKu76Q4tTlZwYz4Kzt0ywRO6y3dlrta/gG1Tw9VlhdtU5bb8lxWPyCPv7ODv0+Wt82
         fDzIHlPm3qL20NMtz22CjeuPESlI67eBx/k9vtSxiuGKqr3qoNHLpvEqNk3pvEhGnyfG
         Os0m2EGGkcKTkxq65DYpZgzm2E8ts2OrcIug8+MYnrWJk2ePAAuMv4jVSV8yu7dPsG01
         4YP0Jz0N+2TrAHOq36z0hMf3cAcCvGrhJ1+zO3Oldd7oZYdcjgF2UO5a8NPx67Dc+iWe
         jvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849998; x=1713454798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOTXpPdaiY/n+o5yUlSF9VJPmoTrThEaztMjh6xCFc8=;
        b=ic0Ls/AcNXTRls1aFOvEMxylj/2czMZA7wBgIbC6ZLoBTHLgGXs0YynGWb3fSXP7bh
         xl+F4zGTtsh0nI70JbDZ8GxBVHHaysX9zt29qS5YIMVwZd8aW1+AqB67zaVgxscTUmY1
         bZsMz77gdz/auOSikgfWHCpMuiEZWb/uyyqIGecxO6Os1izNmAabjwliwkG6JWe1Hqcr
         2XRriUkUAtVaKbUKeKGp4dr7sGBdKAtLC5FPM2fwVOr62PQ4TyPF8nyNir/gNKTosJQM
         evW2pdYEf1zo/4Qvp42lJUSRDfl1qOQUxG+6p/si59lhO2s0Lid3FXIltMKnAlHUIWO6
         J3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVhbGsaPIxEJMvGJsGlBAgnw3nBLK5tuYj6Hu1Mm0bfn2SfVxtroxX+h75eLCPHYZuHEujncNvtj15eeDbYcIfuvSyK1gEV4LWEy9bR+Yk8Kq54vKnUWwJNoUxq7R5oVBnvzOpL/KbQSB4w25s=
X-Gm-Message-State: AOJu0Yw8SKj3SUbIqpHSoDGDxTG1SME+CU90+lAc/t7WXj4e1E/EcJHa
	Hz/ddKkLtg8/WlTtcd7ChL/+lIwXo5IHT/Cy9FfNIJ4sK2vcO4kVyvLQ9T0PXk83TSLZfVK9GLq
	iig8GXFh5uKREsAWLWs/S1EYvzr8=
X-Google-Smtp-Source: AGHT+IG4q0v3GRTjlxffhMx0OJyMhxg2Z8Fefx5FWiiVhR+otNHOIDhD9CRH/kdE+O9XbKMNEKe4c5HUktwBTuZPx1U=
X-Received: by 2002:a17:90a:b384:b0:2a4:9441:13d3 with SMTP id
 e4-20020a17090ab38400b002a4944113d3mr5562497pjr.12.1712849998503; Thu, 11 Apr
 2024 08:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com> <87v84p2m0c.ffs@tglx>
In-Reply-To: <87v84p2m0c.ffs@tglx>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 11 Apr 2024 17:39:07 +0200
Message-ID: <CANiq72=FSPqAq+jEnC=sjtdkJK45-0CgXKrSFXXOF0KSTcLLCQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: time: add Ktime
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 6:57=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks Thomas -- if you pick it up through timers/core, please feel free to=
 add:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

