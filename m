Return-Path: <linux-kernel+bounces-26225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D4C82DD06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1891F234F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698117BB5;
	Mon, 15 Jan 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9h72/n8"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7609C17BA1;
	Mon, 15 Jan 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed179f0faso6849497276.1;
        Mon, 15 Jan 2024 08:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705334903; x=1705939703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3v5EekwNwbyCQhxBwrr1k0zzHga5tdMVcMO2ueic0Y=;
        b=D9h72/n8JrI3hQ1zVRKLHfGf6yrkWCu/F0U3If/K9PIRGlxJXqBU4dMtX95awEm1a1
         p/pw8tKRTmQ3gHsx5tOgyicRa3z6GPp6GbcnxoizaK0W853c/gPLCkOiXTORSf7qopW1
         xXkGrGGKFii3pi1DJ631mnwZTn1m6G9+onZwBsyZpDG5JbQcMeWu1VjZtpCOkSN6dI3m
         6+SqMN38suNyZCEoEvIIYFLsCwCQH+3TS9k6hgprTxxhpDjJE3U2lDib3AtuvpABgHmk
         9FcybBv8MzHfrIY4IpFr8rPnyakVKcKnER8HRs3jxLVqCDDK5m5q/QE11kOyryUsFERt
         1uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705334903; x=1705939703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3v5EekwNwbyCQhxBwrr1k0zzHga5tdMVcMO2ueic0Y=;
        b=j3wV44dwxlVB/zByJYnBs7kcYJjJk0GsKuivZN2hmCt03wMucxij30+qxY3KhAMrOl
         DPRTS67vmOoWOJpQ216RCLZW9h1aG06KJoSXPu0oHMt+XzOZc6pNd2lzr5Va+l9Q9s9B
         TxYajByPmIgBt9W74ditNBM758l0rDIeKtguSBgDF9u1mx5E1GCWgcnC7RFMRYOMzJ9D
         5XEwA1OE6fdpkOby5e/MORnYjRxY3MtcYQTwJFH/TaileSulF+qa9r2ypEM+j8+z3Lk5
         snmVojSbN3Ha8VvFinvR0dkF8YhnFpTu60ZxmFZkMMGl/DaKMT3o+8yTIQx0a8W2yqjr
         NVcQ==
X-Gm-Message-State: AOJu0YwjjL5GWOSe4i7feKq7eFmjsYnaUrJcjhU4vF9bt50E/m+slhNr
	8EAruTQSkQ3D5yZZmJV7EcYaElB0TYpaleVxdLY=
X-Google-Smtp-Source: AGHT+IF5lVpaG5zhAB2+/ap5mK0eaqQRLUd+krj5DSXQ0aQKe1cRVSF2/UbAjhQs8dzHm5uDLMc+f90KsJb3hDLIbKg=
X-Received: by 2002:a05:6902:2185:b0:dbe:3a98:5977 with SMTP id
 dl5-20020a056902218500b00dbe3a985977mr3216881ybb.62.1705334903452; Mon, 15
 Jan 2024 08:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108032117.215171-1-wangrui@loongson.cn> <ZZ2fn0scbDKBXWe5@boqun-archlinux>
 <CAHirt9iox8FGV2wrMyxwFRjab2avfOcyLKvBc9K=AqiHxqHXKg@mail.gmail.com>
 <ZZ38XMQw18mw2sTA@Boquns-Mac-mini.home> <CAHirt9jQSVvBF=1wc=sT9FxngeSP30P4FDpu8m0JH_0fOPSO-w@mail.gmail.com>
 <CANiq72=X3cggAn0HLMi7jVFAfypBhog=ZkPB57yfaX4ZUzT-HA@mail.gmail.com>
 <CAHirt9hdtGSsEofxDb0FCtcFeAw9n9LKJALz23Qdqh4n2=Ua5A@mail.gmail.com>
 <CANiq72n7K8LcKrs+beF2sbt1XLdr4zEhEw4xcy3yh4wgTrvYeg@mail.gmail.com> <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
In-Reply-To: <CAAhV-H72Hbfy7n6+AFSFFOzizo0GtpzA074sgo48-W-Dt0VR+w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Jan 2024 17:08:11 +0100
Message-ID: <CANiq72mEPnB7yEZvtUXAM5w0GgYmzdrM9OhioLGb_LzbAJKNOA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Rust enablement for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Rui <wangrui@loongson.cn>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-doc@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 4:23=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Thank you for your suggestion, but since this will be replaced by the
> built-in target soon, and I don't want to change the tag to make Linus
> unhappy. Let's leave it as is.

The issue is not a big deal and I appreciate that you made the effort
to enable Rust for your architecture. However, please note that we do
our best to maintain a clean formatting state for Rust code (i.e.
`rustfmt` should be run) and that people may see this in tests/CIs
that use the Make target.

I don't think Linus would mind too much, and you could point him to
this email if you want (or you could put the fix on top); but if you
really want to keep the tag as-is, then we should consider it as a fix
for this cycle, i.e. we should not wait for e.g. the next cycle for
the built-in target. Could you please send it through your tree as
soon as possible?

Cheers,
Miguel

