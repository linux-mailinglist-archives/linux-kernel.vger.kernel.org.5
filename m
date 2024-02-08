Return-Path: <linux-kernel+bounces-57573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEBD84DAE1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA06BB21B16
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894F69319;
	Thu,  8 Feb 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvjZ/H0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A6931C;
	Thu,  8 Feb 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707378486; cv=none; b=SgIWApc7BZiJRpjvK7yIBdUC10Zee8w9oGCoJIq3sWhnmoWlZRTYie9uTZoK85hMY5QfEXpWvmyIMqhghKYLKeY8zgjsmnt4B3m+PUl8R7vsRvQuVAHYgGx/9gUo5TWuUZ0KIQZlcpAyzfyR/UAM2jf8c2ZIVnydCAvNAIt7lMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707378486; c=relaxed/simple;
	bh=jZMUdWHkmuyiccRDiX/XmlwP+EtJ+UC+ZfMpRO0yzuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOivRFwZZRSpTQhhuCgor5FEg68Sb5msxmj+xSa3jrod4pr6keMrDVSYJH5Z7ovzmH9tz4ioe8mBwyy+GViIL2UHFr0jqAKOajvpUUCPqECeweNbvmWmGguLImMGtBBY/JDZUEHUamnlFO4+BtZTLSwN2xGgI87FmNwqqU+y0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvjZ/H0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A342C43394;
	Thu,  8 Feb 2024 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707378486;
	bh=jZMUdWHkmuyiccRDiX/XmlwP+EtJ+UC+ZfMpRO0yzuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LvjZ/H0PJ6PA4kDstJNrec15gNE3xSexlVYX7ujuCwsJuDDwWbawTa47UBqgtJSIl
	 hML+ldKEX9GG0PZHwHvuD37GaaiPn7lKZJGDQ9yIOUcyqZ9RxgHuv3GhoiA9nn9YKo
	 MGidCyXuJNlGrEYB2ykIridRtoMnquBDoViy7mwo1FgQXCc6DUD3nVShfVsXD6Doya
	 MlA2qMCbxCDYYPTAUrwypD3W6HJsp4Oa8XuU9315kwjiYR6nXrFjAK4gqW0K9rMdmn
	 C9GJFyGQxL5VoQ7WNpDvM9Zo7LjtOTi7e+bx+NIgn+HSa+tmubFT8+m//FnHb3z/00
	 XV9rXpf27UPPQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf4fafa386so19016351fa.1;
        Wed, 07 Feb 2024 23:48:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFHsaGr1TWlzvQpupD/BYEvWMaMQJr/Fib6RWOuYLjBTkFkWF8mqxPdTAHLwvI9axNqPa5hJUYVLFRkZsGqg8sKjCSlQlHgYXrEZMzRCWHVxxBq2eMr4UthZ4KkJc9x89bMScsKtRErw==
X-Gm-Message-State: AOJu0YzFprn2T8oa02lIdHZgQRxBvg/QHynbLY1+XUgJSI/YDDLN/RHe
	+SPtrDmimmMsOYbbOumv9ynKT7y7cMcYlEz/XLmksJK4yJxSMp3URm/oBkBhRfCo5WAMtaT7rER
	h9xMJKPom6J1IqKlrbE2tUfc7CFg=
X-Google-Smtp-Source: AGHT+IF3sWZiN3bsyBbnY4+tH54sqgYqWfPyT3iTjpzFJGcA1tg87m0ypveXEyQBCA21Y/zCuAluTdcHEAHmGjE/oHo=
X-Received: by 2002:a2e:870f:0:b0:2d0:cb13:652 with SMTP id
 m15-20020a2e870f000000b002d0cb130652mr2273964lji.12.1707378484457; Wed, 07
 Feb 2024 23:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com> <20240201092559.910982-7-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-7-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 7 Feb 2024 23:47:52 -0800
X-Gmail-Original-Message-ID: <CAPhsuW51gFwRdCNmoLuwmCuofAKetV2-gj-5Hb3fNGgu+5yUyA@mail.gmail.com>
Message-ID: <CAPhsuW51gFwRdCNmoLuwmCuofAKetV2-gj-5Hb3fNGgu+5yUyA@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] md: fix missing release of 'active_io' for flush
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, xni@redhat.com, 
	blazej.kucman@linux.intel.com, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, yukuai3@huawei.com, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 1:30=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> submit_flushes
>  atomic_set(&mddev->flush_pending, 1);
>  rdev_for_each_rcu(rdev, mddev)
>   atomic_inc(&mddev->flush_pending);
>   bi->bi_end_io =3D md_end_flush
>   submit_bio(bi);
>                         /* flush io is done first */
>                         md_end_flush
>                          if (atomic_dec_and_test(&mddev->flush_pending))
>                           percpu_ref_put(&mddev->active_io)
>                           -> active_io is not released
>
>  if (atomic_dec_and_test(&mddev->flush_pending))
>   -> missing release of active_io
>
> For consequence, mddev_suspend() will wait for 'active_io' to be zero
> forever.
>
> Fix this problem by releasing 'active_io' in submit_flushes() if
> 'flush_pending' is decreased to zero.
>
> Fixes: fa2bbff7b0b4 ("md: synchronize flush io with array reconfiguration=
")
> Reported-by: Blazej Kucman <blazej.kucman@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20240130172524.0000417b@linux.intel.=
com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied this patch to md-6.8.

Thanks,
Song

