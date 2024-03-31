Return-Path: <linux-kernel+bounces-126361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C4F8935A5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FF7B213AA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C571474D7;
	Sun, 31 Mar 2024 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaIgpK1M"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02576290A;
	Sun, 31 Mar 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711914686; cv=none; b=sUQWRsS0DZpDNpct9hgEB7Tg/VHnjYb23/TMTq0CrV+n/7djztcHkGP1ySYVmRv4aY6Po41xajZdwfshwSNFTHz5CdUJyGbi6tS3Awjr79kZaiT1EcAcVOD4OyaAYNqR/jbRw4cTRjRabyQo+PVu4xedDGZlyZdnvSCnOorUcwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711914686; c=relaxed/simple;
	bh=LjQ6zFAl1yf7nvVoJ7cWz8SQxRB/DSUiDImr6nWf8iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZbdSzF+2s8DOMjEs8QaTsi8+3bvQ7kgJ50ZZj2C4ZvAKfuj66PRRd/FhxfyY5y0/oOu2ThHtN/YUx7PXomCf/bHe0Zb7yO6GKRLVkeSFy9TFVHIE8MWWe2ktzFWesPeR/qhZOeewC0quOqJGAzL2ZTTypajiTjefF5SI5MndfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaIgpK1M; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a496fde460so2217544eaf.1;
        Sun, 31 Mar 2024 12:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711914684; x=1712519484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjQ6zFAl1yf7nvVoJ7cWz8SQxRB/DSUiDImr6nWf8iI=;
        b=aaIgpK1Mj/WbLz+Yx3y5z42x7l8B1T05A5PdFJTDGfqotX1ll3Mo+Jtd0EYCCFbahj
         +S2/KGguLByvL4b+dLWBpIfFPSDyuocj/1xqTaOl8cjxiMugxtNqVyVVCRKQ3fRPduMS
         Q1tELU08HMUq4EEILRgbKmkHyLJ2DfKKxBuyK2Vk61wgQiYjMWVrArEYz8s7M+w7vnId
         j2L5KvUpZCw36FF1zbBINO5NioB31peq5828yaxK+E1eR+i7NLGj6DmJ0uN6tPiqR942
         fnYcEXio6La+2mm+HeXNXxZxQ6V1X0zcQCXiZxCQcS48QnxY2wObOK4wjBk/8aEV96U3
         LUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711914684; x=1712519484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjQ6zFAl1yf7nvVoJ7cWz8SQxRB/DSUiDImr6nWf8iI=;
        b=DsXytCs7lOiDTEO6SJXRfFFxo6fhSLizA+Bh+tLc3+7HVwAt4OjEwhilth+q+AZGA8
         40g/asuDNrkMIuh5hnE+v45u0sVu42xmLKx5oKJBuNb+dYG8hTRosKZyi9tjkOb+4u4R
         944ECTSqf7a/55P55QoW5TcoLRNba3/h1/wCT2IqYm4zQuRZdfJ4lbGP/3Ls63fyrTb/
         qgXuBHSus2nWRP7zv8BwEhg+yIrd2Nla2fJ1nijPyvyNoC+/IvkZQASx2SSK0DEJLGRn
         K5t4XJ4CSB6so4bWg5F6y33UqwmPl7D7Z9YL4/Dr6b1ZnGh/W3zPxsBetTW+zCVMzneE
         Z1oA==
X-Forwarded-Encrypted: i=1; AJvYcCVUzqVcW5rxwvVIiFk3d88tI/IpGEAyEZnap0dfFoBVt1pmgOMkkNApCmGnD7HUCM39hJIahahrTWF/eBgFi6cGBH+NRl0W0rVaJGOW/ml5MOTzno2lGNl3pUAh4wbfCAmtmT0ycI/YTWzVZO0=
X-Gm-Message-State: AOJu0YykVO76CYOrp/NRjGh05K2tuq0PR6aPiXhxZCAVF2VG/WuYuYS8
	8wjfUYyhfCmA1O1hauznh6eL5g2vFUrUXjr+Hf6rAVwXgF7fP2rVXsylrSoxT7msgltb4hAwAHL
	7wxL1Kmsn66NxBX86xuI5GN/mp18=
X-Google-Smtp-Source: AGHT+IH6kocTpUiLpf3V1q7VtdTVVTmNnPr5vvDCsebLmuag3NC09eLIzd9Qod4SvPmy+cHHbosxi1PBLk6AlW819jM=
X-Received: by 2002:a05:6358:9486:b0:17f:7807:3204 with SMTP id
 i6-20020a056358948600b0017f78073204mr10157078rwb.25.1711914683933; Sun, 31
 Mar 2024 12:51:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-constructors-v1-1-4c811342391c@google.com>
In-Reply-To: <20240308-constructors-v1-1-4c811342391c@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 31 Mar 2024 21:50:49 +0200
Message-ID: <CANiq72kZBw5J_S03bLC--iNXqRhNk=5+Vd+MFpB-stZ=SdKZUA@mail.gmail.com>
Subject: Re: [PATCH] rust: don't select CONSTRUCTORS
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 10:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This was originally part of commit 4b9a68f2e59a0 ("rust: add support for
> static synchronisation primitives") from the old Rust branch, which used
> module constructors to initialize globals containing various
> synchronisation primitives with pin-init. That commit has never been
> upstreamed, but the `select CONSTRUCTORS` statement ended up being
> included in the patch that initially added Rust support to the Linux
> Kernel.
>
> We are not using module constructors, so let's remove the select.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-fixes` and marked for stable too -- thanks everyone!

Cheers,
Miguel

