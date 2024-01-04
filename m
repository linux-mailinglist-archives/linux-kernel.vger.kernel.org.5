Return-Path: <linux-kernel+bounces-16846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8378244D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16E61C22173
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADC0249FD;
	Thu,  4 Jan 2024 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BwQV3B/o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FC249E8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-203fe0e3fefso282354fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704381560; x=1704986360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC60muPixeBjriui0b/NBYmBxbA4VVNVHrp1WJSoqbQ=;
        b=BwQV3B/oOFf6xjdPwEz7F8Z1MNHq9OcLbciKmWMA3mMwwvL9RYFA9efgX+hVo4MZHS
         ORbMjonx+GtodKU0DpCbAJyKAjXggUH3R/LKIxolorXNc51/Oc8ayKM5sH1+dnKpBWEp
         1XIKUmwK7zvyS4YWulkZCGA7wCYt3H/CsopqltDuacW5SkpBoHCyVOAM743ts4/f2XtU
         XYShoP7K2svY73xRKLcUJfgveGBJ+p1jolw2IdT/j95D31SpuVmyEaK26MeTOPSnKU6b
         cJaQre9aSIPTJ+mf4BYQ/ACk1LV00C/tmRjm7xKzDsPi5Xx4epFwO0ty5MzGVUynIqRF
         u8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381560; x=1704986360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC60muPixeBjriui0b/NBYmBxbA4VVNVHrp1WJSoqbQ=;
        b=DVBu4vH2+LaUv1t5m5TWG3yeXHuFEXqRRFO4qlU56yeYCN/uLzEhnEOoGShPw9wvRZ
         P4wKMJ/NAkm6vYAZe2geBYC1PCTAsjYrCAt+y5As8gU1/NhwX1rd3HU3PddlBlLu7l1V
         OniVhpUERTuQQtsDPmiI7un1w+0Ag1uKZS6mhYTvg7RAs7jDLTMSh+zLYZw62xzHkBDt
         8h8JuymKOWHMYuPPMhOBSSbrdf7TW2ZUY1Uykq5h9s88V0XUY1OkUjuPsOUJwZzUdAjw
         GYQwkUQZ4/CANTk0ODN1IlsOaSHyrFDs9d4nz4ofKehWSnLjQKRv6tN2l5xw3+OalZcf
         eTYw==
X-Gm-Message-State: AOJu0YzaSDWyOY7Cfd4+ekVq8kjqwS9Wgznv4R2FJOVGJgulNhm8VBlO
	/C3gkNJ6iZe+XpUhbK9HcZ/R4j/hjKcof7xDjww95e+MhdbH
X-Google-Smtp-Source: AGHT+IErRlTx5zwMOpHP2trOdXcIEsUR8p0uVjo9gXaPVEMvgmPoql8aCAKZFcQvEJYkTsWgJPC+u4aQQ5a90WVxJbo=
X-Received: by 2002:a05:6870:558d:b0:204:4437:57fc with SMTP id
 qj13-20020a056870558d00b00204443757fcmr657149oac.54.1704381560358; Thu, 04
 Jan 2024 07:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213220447.3613500-1-benno.lossin@proton.me> <20231213220447.3613500-3-benno.lossin@proton.me>
In-Reply-To: <20231213220447.3613500-3-benno.lossin@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jan 2024 16:19:09 +0100
Message-ID: <CAH5fLgjpvGciMpS8WnU6XM0Q3+niy1=XOkOQ3Rq9mJ6VNo85pw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rust: workqueue: add `#[pin_data]` to `Work`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Wedson Almeida Filho <walmeida@microsoft.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 11:09=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> The previous two patches made it possible to add `#[pin_data]` on
> structs with default generic parameter values.
> This patch makes `Work` use `#[pin_data]` and removes an invocation of
> `pin_init_from_closure`. This function is intended as a low level manual
> escape hatch, so it is better to rely on the safe `pin_init!` macro.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

