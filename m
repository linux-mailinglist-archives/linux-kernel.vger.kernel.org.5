Return-Path: <linux-kernel+bounces-146559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D878A6736
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5340E1C21612
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD298627D;
	Tue, 16 Apr 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlOS9Phb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56EA84E0A;
	Tue, 16 Apr 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260139; cv=none; b=VzEOJMCl+dEolIOkTpwh6zEt9EguvF65XjooZf+UaWgRqv/4+qW2L88MUT0uKalD4tdHvne1p4ZlSevYDiXGe+0zj1W83temgh8yRZqMdnqh52Eogm1QccDwknzN4h/lnsnVpRgJWkfGNjN/+R/OuZdsG981YW8nzmLHTl4FO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260139; c=relaxed/simple;
	bh=TXjR9xbgKlkVD5MSHyUOUHK+MxEvC/yY2LrCydJVlHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2yW3bqhvKO1mf5O7JXtafiE09g/dTF6oS28mc8OW5Jms5Vrki/HjQw2l0GaJbicM6RH0UoCxqrmKrwxxjX+Y1m70lRjeZNyXFJZNMCk7ddUoWTWhcfb7MQUkgbCQKokRiyCskmOjTnwE3VdTsi+IqL9p18uwnG7lCK04KXdTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlOS9Phb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso3765001b3a.0;
        Tue, 16 Apr 2024 02:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713260137; x=1713864937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXjR9xbgKlkVD5MSHyUOUHK+MxEvC/yY2LrCydJVlHI=;
        b=FlOS9PhbxYa6bBjwNXf6oLYl1HI9KlBiOUQL47a2BysCRfI82B1ziVu+TY7jI0v6o7
         vzTeVWA6JWrATfb1Hf4GZ6u7emBnOGS9FX7nAm4LD//zNqcdJQSZy8Qr/PwyU883oi7E
         gOHzS+7herVRQuS2ZFNPq1qlYMmaaSjDd9KyjhPA+16NXNC2bin7/0SMEeQwxAthteKs
         oxs6fmqd4TiYT5AjD6upNDkiPNeCjaCk9l4Lft7Gm0QoAhPliraopr3UkbTT5Na8jIDz
         Hhlv5f6y445bGi2XnFWQQU1dbMQNvi6mlC6eAEyv1+u6ZFxMDuw5McuYJFkkrbM/u+cc
         3MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260137; x=1713864937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXjR9xbgKlkVD5MSHyUOUHK+MxEvC/yY2LrCydJVlHI=;
        b=IuslWSM1bQbx4A/UOBKKwe2LG5TROgQAiXuplSitA0N8u/MXQO7ObrnwJDR0oN+l48
         pjZYCX1a8QvhagKXchVRmrfDdjHyOWTVgDDs3tovu3SNxuYt6+jodZrTamST1CDpUO8Z
         PcLeDcEEEsgGeb47rK/ao123P5zEXIV028wWCmGrxeNxNJWLDkJDtGg5C4/23m4UDhny
         sNk6d3yatnJMUwK/I7krH6R077EDjj3Af6Zbj6afwDJUVZZ4ZUC9Vkx+/g8KXanocqvz
         WeYUg73thQwqx5ZFg/i4kvXYJEwx2lhTqYIiHyUCUwLC9IU0oNE57SMJQYf6FT8CjYUj
         muCA==
X-Forwarded-Encrypted: i=1; AJvYcCWyBRePgKbtAuJWUIkOHKh7d1pLU1yF/R5rrXgLoIxfBVSn5PP7NhqLWG3vDb1RnJHMblfvYg+E54HDnKL46MCKZTkTDrAhAsYEFi+vEKsIYYqsEg5VfpdqKkFjNUvjl0YE1kOsBEIOL9KMWc4=
X-Gm-Message-State: AOJu0YyHKplhbrLrh09WFNdUMvdsRSW/9MpfHlbU02BQObU0NndzHRps
	MHUUS9OQufWy82Ktm26gW72zhrDL7IVfVgBt0R5KKcIEKGY8JKD2boVAi1M/v3zj5Mwrp6l47/7
	JeM4W6MD1IBgH0v2HhhShQg5EsyY=
X-Google-Smtp-Source: AGHT+IGGTJSZi/o0GvE6gTWBhLqQlBbbdubtxGyMcXyhwIcNgas9k736GQDK3WUb50qOFb9wE7Q8bmiIwAYPd68jBUM=
X-Received: by 2002:a05:6a20:9c8f:b0:1aa:33a5:c5d8 with SMTP id
 mj15-20020a056a209c8f00b001aa33a5c5d8mr4241053pzb.46.1713260137154; Tue, 16
 Apr 2024 02:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eba70259-9b10-4bf7-ac4f-d7accf6b8891@smtp-relay.sendinblue.com> <CALNs47uct--R4CGEQEO1vXTwMuBiqLaO1tREL2T4pP-ebZC+=Q@mail.gmail.com>
In-Reply-To: <CALNs47uct--R4CGEQEO1vXTwMuBiqLaO1tREL2T4pP-ebZC+=Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Apr 2024 11:34:38 +0200
Message-ID: <CANiq72msHmV7CXZVKehZLw4jtG9S_XsmX48OGNVp6sz32TMhtw@mail.gmail.com>
Subject: Re: [PATCH] rust: update `dbg!()` to format column number
To: Trevor Gross <tmgross@umich.edu>
Cc: dev@raxyte.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:58=E2=80=AFAM Trevor Gross <tmgross@umich.edu> wr=
ote:
>
> The second link could be "Fixes: ..." (but whoever picks this up can
> probably do that)

`Fixes:` references a commit, not a URL. I think you meant `Closes:`,
but that one in turn is meant for bug fixes, which does not really fit
either. That is why I suggested `Link:` in the issue instead.

> Reviewed-by: Trevor Gross <tmgross@umich.edu>

Thanks!

Cheers,
Miguel

