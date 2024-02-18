Return-Path: <linux-kernel+bounces-70570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814EF85993E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C64E281726
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A373162;
	Sun, 18 Feb 2024 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Teq0CS78"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEB9442;
	Sun, 18 Feb 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708287872; cv=none; b=RGWzkWxO3v7Rf/xh4bI2P/L/yoFN7fy40ylq+73nDl632+ztTa2hpXyD6dqiM8kxFQ0P5t3XcHBxscfoIuUPidi3wezamwyv5NRl+0brU8h8xfi7eqQDU6WUwDuQQsSA7PeghBg8w4xSkYeMFDSp6BPWW8YcTMq94f6PyQYcgwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708287872; c=relaxed/simple;
	bh=k2eWUbloHM5GzbpGgEM45TZn1D+d6JagD3rQgrEyiG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDKJJ8AE+EYN3k3E3dIJAm2NG6gOlFAtH/RsD6eQP2+fJ6xq8pO9dD2ORoQLshEQjDrA1J0Y0iCleTLZCBfiaTtPCKlic7sV4WwFWrGIG8PJGE0+M0DmuXqE8RwWa78LSdS3uzHmJD6uaj0/KugCQpqDZYDS1QGjNjW8t5pbcBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Teq0CS78; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so3088344276.0;
        Sun, 18 Feb 2024 12:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708287870; x=1708892670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FE2POvbgpro+g/QwsyhusX3/NaHLUh6rfzmipD6GZyM=;
        b=Teq0CS78UrUdda06oQGbLumFoarxVxCfd3LHJISrrONjLlKIKPDiSQWdLHqBy+p/9f
         CXh80Y3ef9JYnbOhx3l/0LUtykYrIzkh/yjoWsdyF2thMSxs65EIN7MOOWVgVH1CNqAb
         6dEwttlqTIBIyr30le6unifNFYhBXBDqIi5CIBP4p4rQKD1kIKsbOYvvjEq3kLPPVol+
         R/QkXtoICYl1xDrmPHG6iDDkVi4C8m2DTlt9OAqDVY8THxltP3id8OnWXvB4dQfg7MeG
         Ef7accg6c2bPyVJ9w5iuDCvuvUE7MGubOZAlSW/jZ6eN6OxD5unUXmp65L981qY6VTdS
         uZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708287870; x=1708892670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE2POvbgpro+g/QwsyhusX3/NaHLUh6rfzmipD6GZyM=;
        b=qdVGUv8D5Ds1au6Qq+gRi+5GpOZSIpIjiCyknsbaZffmoGHpumXpYSFvZK0Xiq5JZ3
         UntaLuXeEj+AXXH3nUl3DFQgzUaS5sStQVHGQX07dS/ZGvLisFNmCAyPWKqsbF4c6ly4
         +mv982pqLs3Ild9ijg1eWOtSM+BwckhUC2qVQ29YfwYeuAHB0gubR6r6kqw+3GpOnGCK
         +3ZgTlYzpES5QPsqKRxK5lB1aGyVruDNBaV959wUfEHXTTfc67+2QQDFt7J8Xuq6YfTQ
         0hcoa7mqhwdNywmmQjelRfG7zyYBJ9CAjSwhokmF9VCJBdkULvwpehUOVrrQRtlCwQz/
         jogw==
X-Forwarded-Encrypted: i=1; AJvYcCX+nNbPxfYZrqGhCzKJJP+7PGQTJNTd/KV+WbGvWRb6dck9T/JqT+b4PTRoAFA3o+OQnNIQzPz88FGSHwvkOgFveK9P/XCgyi4Pgz81cS1cuKMbZeoS43pLjM2qdWaGSK/zPV+3t31Kbyu/87w=
X-Gm-Message-State: AOJu0YybDRQ9rCN9rWxiw0hSU9r5prl5Vy8FB++e/4qmwkO7Q4RQMG44
	Mfin4TVZBGB/gXXAp1eaGIdN2oayYHoU5yV5e6aWszb0CniKmmVOkhaeDFvBXW0DRshukWsf4TK
	49vUCGnMvPFCLdflSD3TqugbSNbI=
X-Google-Smtp-Source: AGHT+IHKMkWla55QyxO/A6pF43tqSlvjmZ6mBAQed7/0/Y3eOsq5DwiDvZ2hTNWG/n8536DpLKK9sQUqtLN6BFwpic0=
X-Received: by 2002:a25:f505:0:b0:dcd:30f7:f7d0 with SMTP id
 a5-20020a25f505000000b00dcd30f7f7d0mr8743128ybe.21.1708287869825; Sun, 18 Feb
 2024 12:24:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
In-Reply-To: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Feb 2024 21:24:18 +0100
Message-ID: <CANiq72=CrXBUPQ4cH7++kwHs=o_mwaiEuECNfADCVAwBFWcCyA@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] rust: kernel: documentation improvements
To: kernel@valentinobst.de
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:24=E2=80=AFPM Valentin Obst via B4 Relay
<devnull+kernel.valentinobst.de@kernel.org> wrote:
>
> This patch set aims to make small improvements to the documentation of
> the kernel crate. It engages in a few different activities:
> - fixing trivial typos (commit #1),
> - updating code examples to better reflect an idiomatic coding style
>   (commits #2,6),
> - increasing the consistency within the crate's documentation as a whole
>   (commits #3,5,7,8,9,11,12),
> - adding more intra-doc links as well as srctree-relative links to C
>   header files (commits #4,10).

Applied to `rust-next` with a small reword in one of the commits to
use the kernel's commit description style -- thanks everyone!

Cheers,
Miguel

