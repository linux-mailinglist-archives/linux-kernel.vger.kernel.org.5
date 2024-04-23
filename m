Return-Path: <linux-kernel+bounces-154360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5028ADB35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6F21C210F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00C3101E6;
	Tue, 23 Apr 2024 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrU5hzq1"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB390DDB8;
	Tue, 23 Apr 2024 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832999; cv=none; b=dsyguCFR6ifg3BkCNN8o2Su/fecClqFobpfYw2L+743TLysVg89ybgA0UxvUx7C/M6ETWsi3O7HdEgr70gdtEyAsioXy/XtizoomPg0s7qZO32Srl+6AfeqgeS3mLOf03jqhqTF1QSOKDwjaytkNGOhGMUBijfAxg7JCVlscMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832999; c=relaxed/simple;
	bh=/0svhkNP9tWXQlVz3YK2H1TplhT15+dN3ejme8hbH9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVZ56MNlmZK5shNSFjRgpxWG5QXaCLCQHUdmVX+Q0Y+ucXN63fUWLH+RvfZXotRhwI6vnnj3cz1Fr+X5GjFz6Vfm5aXLeYfcItbFOODAcgKMWo3EFe90DoMUfEcoeApgGOI+nOP0hTEqJeeiF6kvNCtNdWCqnqVSsHkO5WCP/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrU5hzq1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ab88634cfaso4025507a91.0;
        Mon, 22 Apr 2024 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713832997; x=1714437797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0svhkNP9tWXQlVz3YK2H1TplhT15+dN3ejme8hbH9k=;
        b=HrU5hzq1hQROXzDG313rzRblIMm86hqPlIVtfg3YmFTc2YRcer4uclX7N16Z75A19/
         QBN5lPtBRuFjZrhUkfMQfGAiEguZiOuxYgYT+dLvnaT2J1fOUAXacbluzqvdK92XAvR1
         vlmMjOMIndJUqtPzK79dRcHhuA94YotCan6W0JnU09XFL/8tZs7KKDh8ZhHF9IKJnhbC
         KzTlvPYBQo/0xv+TPl9iERSjFXGa6Bayxhyh8S3oE5wxxpp7hXYkCgBGHTbFkMlNFF/T
         lmMHmg0BZyIrxi21jxjgUAMygZMq/Z+TeL8UcTyh/oeHIMS29Wl7AiNL8kZnSi4aSeje
         NlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832997; x=1714437797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0svhkNP9tWXQlVz3YK2H1TplhT15+dN3ejme8hbH9k=;
        b=ZdYYkj4sHGP5n4VaaJfAS7dreK7m1wqiAHRXN2GXl1ximoRIwLo2cy8jZu079ksDSD
         G6Q816yXyNlpIoAgYxViVTcdXTB6IenCdaAbudBM4N2PavPZLyL2AVMA9Mon/VzL5Dvg
         cWrZdXSiuPTfcb1RuhzkdGQDnqRui5AcmmBcjtIxJKferrL31AE+QyxwJ4lEdPsV3vJl
         WM7EUFCwRJzm9XfOmqQnNp5MkN7rEFPngdJYUJLOVOImvTlk6zuTaC24NKQRcAxKMxGO
         6OddaFqwEMPj+14QHWIydbBwG7pMsglLKxsmnYxKkruzy0pPfhNesfl4SRwg5C0qM3dM
         95Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU9zisRqYrcGL5GNm6pYRqezkSFbOsDGctJcYpQ4bZp60E5/oYCYdYan5NhlTuMY5m7K7UOhMowoVlpwrD8bPpfggfHZ+6uhiLizQ3t
X-Gm-Message-State: AOJu0YwRaPw6m6N7BfjPgrvkyGlxBcX2iQmKM5kY48EHGmwgXPUkL/5B
	XSWigors5mRLWPX70a4SJeW8/tdYAHx5p3Mv/Em6tKiggs3RPnRIehYV9J1mXH3Zu/6qdhmUo2O
	cf3mewZwRJ6m4IRIYgjPONB4g+NI=
X-Google-Smtp-Source: AGHT+IE93674/r4s/aotzWdUWktoz/5MS6MXc1veR//227ZF7COYHfirZjGmHp/g7UvP5u+k6aeO7v7ie+ekr6JC32s=
X-Received: by 2002:a17:90a:f306:b0:2a5:b73c:8440 with SMTP id
 ca6-20020a17090af30600b002a5b73c8440mr9479420pjb.12.1713832997166; Mon, 22
 Apr 2024 17:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328195457.225001-1-wedsonaf@gmail.com>
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Apr 2024 02:42:11 +0200
Message-ID: <CANiq72=Z8=tpeoeQxd9sH4QN2rfBzaKE7P_6Saz1a_WYHB__Ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] In-place module initialisation
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:55=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> Introduce `InPlaceModule`, which allows modules to be initialised
> inplace, as opposed to the current state where modules must return an
> instance which is moved to its final memory location.
>
> This allows us to have modules whose state hold objects that must be
> initialised inplace like locks. It also allows us to implement
> registrations (e.g., driver registration) inplace and have them similar
> to their C counterparts where no new allocations are needed.
>
> This is built on top of the allocation APIs because the sample module is
> a modified version of rust_minimal, which would be incompatible with the
> allocation API series because it uses vectors.

For the moment, applied 1/5 and 2/5 to `rust-fixes` (tagged for stable
too) -- thanks everyone!

Cheers,
Miguel

