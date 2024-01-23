Return-Path: <linux-kernel+bounces-35787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D57839688
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B39CB21D80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA08003F;
	Tue, 23 Jan 2024 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdOlcLOy"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A777FBA1;
	Tue, 23 Jan 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031334; cv=none; b=cKU3ttc8KcJoGQbFb5M/DwCd4J20pS44ktHLvnG6bkBFJ4MX0y6DjPh2iy0TvuTQIKchnKHR6Qh/sQnwpwdjUPD+GvrXFAL0cYKZAWPmyyM2CEYvYxU5P1HXXX09E3aGj9wlHDvTXH74Y27bk4NO99krH56Hn0l1CoDrQTe/RDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031334; c=relaxed/simple;
	bh=jQs7fGJdWnlx4B7KYsa9czsKMESCKI+vjorr+zCUCwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOeBcR+JdbKBjzl24qf3MswRZey1Cy1xaAzF6wpDMvuWC6IM4Ds6pz9f2N5+hkOCV4/F3LswJG04pvWA0TDWTqR2vezZJqzBVy/g/LwfIVzEOMlA2bZaEaXjGYvvWZJwSjhDMW7SBYA0CRaySWe31MjknTMnLY7nfHOKQeVltmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdOlcLOy; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffa694d8e5so31778897b3.0;
        Tue, 23 Jan 2024 09:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031332; x=1706636132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQs7fGJdWnlx4B7KYsa9czsKMESCKI+vjorr+zCUCwY=;
        b=HdOlcLOysbpO4hVEJaD/Ayzdmu5PoUUluRy33+I+ts7yIoLqMJ53XpgZsKfFHIopOh
         dSvZukvchfqBlxmDbfNvWLEpLoA7XB1pzMneItj+ZokHbnIho1Ds7ICVtmGaB3HisAeu
         36MOF2wIOc6U3mYbhxbowjQiQHQMs8aIM30IWFuNddU8C/UCgxXxDq15BEtLSkw8eRNT
         g9osPuFrpLSC5Lh/tpHrI4iesY8wX+q5PVuLZDyAkza/qRtC2GvHnNBwaU/9M6Z9Y6EP
         Nd4R2E2GUhwUzPqaUGReevmWGdNSRZ2iinJLYAcuG34g5PpBPS01v7aKyi965r6djeic
         FjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031332; x=1706636132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQs7fGJdWnlx4B7KYsa9czsKMESCKI+vjorr+zCUCwY=;
        b=HmnUfP6YL1OPtE4sy2eHfJppykNX5/JMVS7BAeIBrDrVEo7sfpmzy/4pyxcgOu/IeK
         v65xfmX/D+qHf06zSgxfwDSl+aEhe8GgwLdMUqBksU/J0GxfxFFTvLf3iYmrpLJxPRds
         UY8dP4G1s65djt99uzFY2Sz62pIoBYRMkmT5m6bAjsDEKioZbwxd+4GhFIIXNqCM4ZcT
         mw+oAZEhsK5GwIq3moWZZ997G5Xm1mUD5AP7xfJCtCuYD4sC5H7gypWL8IbcqIFZYY0v
         CNrXqd1KVnySZi2RuvyV91oRnmPpCNI/hJYY610GAXbLJ5vWyEOY/biwyZgJBXBnp98q
         +DWA==
X-Gm-Message-State: AOJu0Yx3Tb3lY4PDk/z/JaFqfATT2/81XdBp01EjSRO9U7SfraPbqG+o
	PC9N71l50m4HGkkqVXf4dHQS3LlGwyHiSxngb5L6IhmKKKj2ubH/h5EuOr1ZYK55gQjWcV/ypjK
	C5UIuPbEgJljlgB21MprKyZ5v7hE=
X-Google-Smtp-Source: AGHT+IFu6qvgKyphbyQEl4ITZ0EK6+7fXQtYD2opf8fsVO6PjBBEvq7eStuaUX1XX9J4AGI5ZvC+glSIgVPfB7sirOE=
X-Received: by 2002:a81:a54b:0:b0:5ff:890f:b082 with SMTP id
 v11-20020a81a54b000000b005ff890fb082mr4956311ywg.2.1706031331580; Tue, 23 Jan
 2024 09:35:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122184608.11863-1-dakr@redhat.com> <CANiq72kdX-LK=OurnR5ZGDXEf90DxshUX13up4c8kiz0jxHc+Q@mail.gmail.com>
 <Za7pRc1wTtEhObTN@cassiopeiae>
In-Reply-To: <Za7pRc1wTtEhObTN@cassiopeiae>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jan 2024 18:35:20 +0100
Message-ID: <CANiq72n1K7FcXMxr-bCNwT43ChMPUfQBnZJOwsJaSJfFHMDmeQ@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
To: Danilo Krummrich <dakr@redhat.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:16=E2=80=AFPM Danilo Krummrich <dakr@redhat.com>=
 wrote:
>
> If preferred, I can add this to the commit message.

Ah, yeah, I meant in the commit message. Thanks!

> Mimic, as in copy them over (to the extent they actually apply)?

Yeah -- well, if you think they are better (sometimes they may be,
i.e. I typically mention it when we have something close to the
standard library as a potential source for inspiration).

> Sure, I'm fine adding them as well. Not sure we'll need them for Nova tho=
ugh.

Up to you -- I think either way would be fine, i.e. I would say it is
reasonable to think the others would be useful if these already have a
user (similarly, say, not adding `uppercase` because we only have a
`lowercase` use so far sounds a bit too strict I guess).

In fact, in the Zulip use case you showed, you were using the
new-object one rather than the in-place, no? Or that changed?

Cheers,
Miguel

