Return-Path: <linux-kernel+bounces-84128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DBF86A274
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92044285C03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23205153518;
	Tue, 27 Feb 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THuZIp/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD1B4CE17;
	Tue, 27 Feb 2024 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072894; cv=none; b=DUWp6Vp/frSEET8XVKiH6WZN/ivw4RzVP7oFhBimjmDVzIXXrJRK4uCJaRiJ21jtA6LV83bLiGh6SEcjvgyBiSvPjlrWwAuhoWKoz6ImpZRA/Tn9Jfnb21m+fn0iA92dM4DGbp1sJrvRfO+SN5tJI+iYXtwtBCR7Z3YI9liONEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072894; c=relaxed/simple;
	bh=rq5VxReaCZ6zZmuMXVvkYiFrYUC8jOzAqu0lsOo9zTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJQ9zgzXhSby3JTKXiFYBHTElRksGIFoLX8fZH9NblAW6rZCVGdj5cXZnn5RHTThMHYRsghDfoDBosd/HCg6UDnsj406/2nboILRolZ7j8bolqUhDvKjmIG9hYNvonNPuT53V6zcNQrG70Yi3q4RKB8ExZW8PD+aFH1OU3sc3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THuZIp/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4EC433C7;
	Tue, 27 Feb 2024 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072893;
	bh=rq5VxReaCZ6zZmuMXVvkYiFrYUC8jOzAqu0lsOo9zTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=THuZIp/J958Rmvpj4U7OVE19BLOS79ghs/+fZxHSdj9XreINqHt7rZ7lDgjAwPeKY
	 LJyPHsRX3O5mx/wSSvPi1fP71RTGLAfMfXNNg5XoN7tPSAZM4kkhBvPNH2C2XdHRCf
	 Jh0VeNa8Zff0LwB4ypH2HeIQyLRK01m6Ek89VrQGJB7OrI0cHicj40tWHQFg60ABNJ
	 eSQPJr8/Y1PgGOJIZYcZKCMKPUfEA0vCAI/A0Qo6+rfwgWm/UL2+3/nnJ/+Wy+ZyjB
	 eJrD+hYXsPtQyQdOSzEzrassiDVNg3uJ7n5ddaM65Jku3UAU8xsIsAdfpqAxku8/cm
	 Jtze6Uer9oLnA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e1991237so237235e87.1;
        Tue, 27 Feb 2024 14:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqfHwWlta+fsJqBIs1L7sL4n7ii1OBY2BCBQQfnnNwBXTxrw7LHJpEM4UBHwdvrFqAyxnEY85/mJ2CRI+dWCr4bBzIpIKOR3A9FUcfTRuTm0hfNHqFE/o0p8ecTl7nUuRehKgooiRHb46jXkkLHwMRpZJcLEQ/6cFHJvjaiXKiFQ==
X-Gm-Message-State: AOJu0YxWXaGZXVS7PbE5gQiRoF/t18h/NaP25MkukW/P3qNQstZ2+ceV
	mLR5Hn1zLWq2nJeeHoQHlcOF15C2EH9XfRzoIK2pwuZuvn9vK5kLF5RTdQljDrHRuJCwNnepO5Z
	wV1JTzIupyywhrVjC+LdR593o+Ow=
X-Google-Smtp-Source: AGHT+IHPCE9VGH4KYv23+HRG3ommCFvDawXNIPNsaBlvTa4vIxiYEKna29+G+UgzxCEZv6JYO1hKdMh4jFKc3BMumdY=
X-Received: by 2002:ac2:4c92:0:b0:513:1957:d011 with SMTP id
 d18-20020ac24c92000000b005131957d011mr131607lfl.5.1709072892171; Tue, 27 Feb
 2024 14:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112071017.16313-1-2045gemini@gmail.com> <CAPhsuW64FjJEqTFKX9WVzrXvC4rpcjojBw5A3StUq0C20F_vyA@mail.gmail.com>
 <e0c5f9d4-6b65-02f7-2a8c-0484fd1f9815@huaweicloud.com>
In-Reply-To: <e0c5f9d4-6b65-02f7-2a8c-0484fd1f9815@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Tue, 27 Feb 2024 14:28:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5u1SHCjw-0EUEvOp9-+nyh3s67Nio=OR=P1ftRTe33gA@mail.gmail.com>
Message-ID: <CAPhsuW5u1SHCjw-0EUEvOp9-+nyh3s67Nio=OR=P1ftRTe33gA@mail.gmail.com>
Subject: Re: [PATCH v4] md/raid5: fix atomicity violation in raid5_cache_count
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Gui-Dong Han <2045gemini@gmail.com>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com, 
	stable@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:11=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/01/30 15:37, Song Liu =E5=86=99=E9=81=93:
> > On Thu, Jan 11, 2024 at 11:10=E2=80=AFPM Gui-Dong Han <2045gemini@gmail=
com> wrote:
> >>
> > [...]
> >>
> >>          raid5_release_stripe(sh);
> >> -       conf->max_nr_stripes++;
> >> +       WRITE_ONCE(conf->max_nr_stripes, conf->max_nr_stripes + 1);
> >
> > This is weird. We are reading max_nr_stripes without READ_ONCE.
>
> We don't need READ_ONCE() here because writers are protected by
> 'cache_size_mutex', there are no concurrent writers, it's safe to
> read 'max_nr_stripes' directly.

OK, that makes sense. Applied to md-6.9.

Thanks,
Song

