Return-Path: <linux-kernel+bounces-48980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50D8846454
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040B31C2348C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDC47F57;
	Thu,  1 Feb 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCdyF+GC"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA933FB37;
	Thu,  1 Feb 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829139; cv=none; b=V85TlwWY20g6OjCWN0nNIeLpd6St9lzYPKHtkEIIhn3PjfN2fyQqdmiQeRNghGQdisRei0JkoiSxfTmnlAiYDTO3gtiyu90pxRCXyzx2TEQBMXABiArobW3OJPqCDnDNfWCYUoO8klkPbW0QoTdI4TXZ4KanitQ7D156wESLvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829139; c=relaxed/simple;
	bh=+PN1aVVdJv7dQ6u3SE9gXNMJ5i8PkALkHFjLI1LOmKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2XNJAK5f1fjpgdVy3IvlapXL1+t1zM/wluKYdc121a79qd31T9Y4EiJniH5+5fKMjaxkJeuYheg+vCgdmA41B86XsN9fmjqgdSmC9CpRm/MZANJCTer2m8ziwLNo7jUhpY6oXpdaukI/wnmQXAjjr3AAOL05Xp8X1PUerHGX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCdyF+GC; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60412f65124so15178117b3.3;
        Thu, 01 Feb 2024 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706829137; x=1707433937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PN1aVVdJv7dQ6u3SE9gXNMJ5i8PkALkHFjLI1LOmKY=;
        b=BCdyF+GCqK8XLGf5CxqL+kvzbQlcwsWAODILEHQfRrU6Z3qVUwS4xL2aVaRkZ/vY37
         L/zv+0QDa7jPjNo2M8qtqk37aOQtr6xPrALOW6SrEpmEwjSi977uzkJM4gYR6rTtiHg5
         QVYbMY1XxByuZhab7VZLtcDtYq5NzGQJBmYyU/CJRG55D1lie8Jn9ZlJG/lER44If11K
         uzjvWloMvfyVHv4n2AQMSx71ce0PENYnK3z00G/3VdcZtnlQbiFB+FegDcQMRidpgUYI
         W2BIGwVLXuCiFc3REWU8aAoNSDqZrdEBK7VTo14zXY8tBqm9r/gmg/COrStx8wF70NdR
         Ow/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829137; x=1707433937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PN1aVVdJv7dQ6u3SE9gXNMJ5i8PkALkHFjLI1LOmKY=;
        b=RwO8r/GHMjufytvtJJ+6rX7m6ZOYatl9d2CWJxJ9IkL5HG/x5RPcp9t7R4ex8qn7L1
         5snrf3WDVpNItr1qRoMYDjkuJWnBgsGZdCyxMuEEoqFWRNaONFYevHQzXPTw4vrr9y0q
         WcDgU2U0adw1al4JDvjyY64lgVEvsERIQMGGN+0YBfl5FIMsRP0O6gBuN+vasUqnpbCi
         ZBVc7fMIh0b1NrEPANyUzqDY3XwMXC/Cna8FHHVGJvzoJ6jjSLAx6ZagqxWlTOpD/V55
         zoqg6N9O7oroa2cEa3ipwEYT3D2eRysYZ4sDAieLWXkTul+rhuuQLNLWH0YWNLg3Gk6T
         Fkaw==
X-Gm-Message-State: AOJu0YyDIps9Rwlis6xqKGAeHLBB7xPpIp9mXN5j8+MGFovqm+H1TAYO
	kLnaYCalIsq8jUhUIRIXLE9DbloZWlCU1gPaX11zG1Tm2Ne1GJCFIXFcUVkZ2LPxkedtEZhbR5K
	Ed4Laa8ITp+tqdEYvmu2QHlmvNxg=
X-Google-Smtp-Source: AGHT+IFznqZD386j38NqZlpMPZjSrbX0IVvxdtH06xaGlCHWUb0CmZLJnLZmRce7XPhhGHqaSHLrFy/x9r3vOSy+mk0=
X-Received: by 2002:a0d:cbc9:0:b0:5ff:81fa:16e6 with SMTP id
 n192-20020a0dcbc9000000b005ff81fa16e6mr622138ywd.38.1706829136716; Thu, 01
 Feb 2024 15:12:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-rockchip-rust-phy_depend-v2-0-c5fa4faab924@christina-quast.de>
 <20240201-rockchip-rust-phy_depend-v2-3-c5fa4faab924@christina-quast.de>
 <2024020105-bankroll-opium-a6e5@gregkh> <6725eeac-45ee-4f3f-a612-0ef5725b9fd9@lunn.ch>
In-Reply-To: <6725eeac-45ee-4f3f-a612-0ef5725b9fd9@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Feb 2024 00:12:05 +0100
Message-ID: <CANiq72nnHj2PnsM-=RREOcq1wsyydFZQ67-DewDa18=tAHe4NA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Rockchip PHY driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Christina Quast <contact@christina-quast.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:30=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> As one of the PHY Maintainers, i would say no.
>
> Now we have an example, i think we should be a lot more strict about
> what we actually merge. It should be a driver for hardware which does
> not have a C driver.

Yeah, a single "Rust reference driver" is likely enough to give a good
example of how things would look.

I guess more than one could be justified if there are significant
differences, e.g. if the maintainers want to cover more of the
abstractions API for some reason.

> We cannot drop C drivers since Rust at the moment does not support all
> architectures GCC/Clang does. PHY drivers are architecture
> independent, and in real life used on multiple architectures. When
> Rust eventually catches up, we could consider dropping C drivers when
> there is an equivalent Rust driver, but from what i hear, that is a
> few years away. I don't want to be supporting a C and Rust driver for
> the same hardware.

The `rustc_codegen_gcc` backend can already build the kernel without
changes, so hopefully we will see some results sooner than that. If we
are talking multiple years, GCC Rust likely enters the equation too.

But, indeed, there is a lot of work to do until we can drop C code in gener=
al.

Cheers,
Miguel

