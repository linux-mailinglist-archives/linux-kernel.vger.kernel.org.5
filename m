Return-Path: <linux-kernel+bounces-139381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9C8A0243
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDB71F2429C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF5B184107;
	Wed, 10 Apr 2024 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAhqVLAr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC43181D0E;
	Wed, 10 Apr 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785069; cv=none; b=H5fcosc+VPa7hceSIj7M95h4j73qXPVBenJbPw0tAJNQoK0HXveAKvUWdG8mkzx+0BaYVsZHscCx2Dj1QzJ1onSkpJEZcMLWoMnViXPOSN/FbzRg1pws47rIrmvwgiQb9STjMv1e9MI1cT0Teffov7QEzHDl1xxQcTLZhIdyl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785069; c=relaxed/simple;
	bh=nM8tFnJ3b4IcOjThnUEgs03Kdst1jvcztzJykBzdF/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogsuRfksjrFL+EtnmjS0h5x6X3+Q+v9YgR6rj3lDOMw3y3bruwiZOSQ/8kaoDixi1teliOHIGq0DaAEfgFDBmQWW6ebcFNJ7C1xuz0K8uGieszWsJg3a+sdXHrF3ViF2omaxAU0qhihurSiSkae335Z0xz55VkXBUd7ceVM73ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAhqVLAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7E0C433A6;
	Wed, 10 Apr 2024 21:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712785068;
	bh=nM8tFnJ3b4IcOjThnUEgs03Kdst1jvcztzJykBzdF/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZAhqVLArofwPn1VsdNt5uUNzfZUZkF2GCAaIpk33/fDL9pNd9J43v2y70Vj1dJzeY
	 NT/3pFF/6DbKBK0Ju5SxsP4TPkE8UezaME9b/7WTif6kYm5AMP/vajfkjfasi1hmje
	 JU5xU3BHtm7VM8gu6/fKzheBgoUMA0ueAw5OCaisWzTOdVPo35IRF193tsPY3OjA+X
	 2egovVQi3BxTcbjXsPrVRmTwCIQ1GOIiWiaJpzUqQd3JNFpOGdK9Rygr3u3lk2cpup
	 RfwbljJR/ab0Fi6CEqaw0srGI2DlWDgmaBDeW0L4yxb/tPFildBhnLea6faYfhbMAY
	 0dew/zZvzBtUw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5176f217b7bso1876057e87.0;
        Wed, 10 Apr 2024 14:37:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkbqfHrdEppjD7M9vJq+Zm7zEyq0o0HUkVx7jQg1GEfQ2Gckl/NA502Zc87MrrtAwpjlP/LdxweaasB4Zs1tU9wagLl/c3eX0Ee0X09s1rUd1mX1tmLUAlhh4vAXhCJ5LcY+qgD0lCOw==
X-Gm-Message-State: AOJu0YwUQjHHV1MbX6SFIdYrztduzqYB89w7t7+ZYL9nyLDfSvDI36vY
	OOXei37UQM0AsL+pOgHRqZPbHIXuAkA2qAst4kwcdJcBv5azdMlugWlmoUbh22/jwICgVfx/M9P
	DSh6LhbYxeLOkSusTSaBkfzfCb5E=
X-Google-Smtp-Source: AGHT+IFXWzd+u6HCGsAkZespxnjBVQGyzROoi7T6JcOTfo35KmjpLZxSVfES0MaiRKRXmZh80vp10HYZLkdmLozZ1w4=
X-Received: by 2002:ac2:554c:0:b0:516:c44a:657d with SMTP id
 l12-20020ac2554c000000b00516c44a657dmr2970482lfk.64.1712785067212; Wed, 10
 Apr 2024 14:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322081005.1112401-1-yukuai1@huaweicloud.com>
In-Reply-To: <20240322081005.1112401-1-yukuai1@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 10 Apr 2024 14:37:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4XSdtSYxVu9rDzDZZfy3AzACJMCej=sC5hUO3QmJJpxg@mail.gmail.com>
Message-ID: <CAPhsuW4XSdtSYxVu9rDzDZZfy3AzACJMCej=sC5hUO3QmJJpxg@mail.gmail.com>
Subject: Re: [PATCH] md/raid5: fix deadlock that raid5d() wait for itself to
 clear MD_SB_CHANGE_PENDING
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: logang@deltatee.com, dan@danm.net, junxiao.bi@oracle.com, xni@redhat.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 1:17=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
[...]
>
> Refer to the implementation from raid1 and raid10, fix this problem by
> skipping issue IO if MD_SB_CHANGE_PENDING is still set after
> md_check_recovery(), daemon thread will be woken up when 'reconfig_mutex'
> is released. Meanwhile, the hang problem will be fixed as well.
>
> Fixes: 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d")
> Reported-and-tested-by: Dan Moulding <dan@danm.net>
> Closes: https://lore.kernel.org/all/20240123005700.9302-1-dan@danm.net/
> Investigated-by: Junxiao Bi <junxiao.bi@oracle.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-6.10. Thanks!

Song

