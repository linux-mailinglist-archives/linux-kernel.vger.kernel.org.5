Return-Path: <linux-kernel+bounces-102603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA887B476
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CAEB20D87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910535C606;
	Wed, 13 Mar 2024 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="AAvDmDtL"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE259B56
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369514; cv=none; b=ASle99cDAqLXe9/btrtN60no9zNuCkkN5JcVZxCloBU0RDPQy/wuyhWxLfPgjTSCTuXzm9RLZO6gCXzJYqEgKPJMIuJkujpOEcVawBGwcn0VBSxyO8P7vs8cWAZ8tvTiHNpTn+GDh5IdIg5EHO0iuFwQo8XAjRgBW/zcu5V5Pao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369514; c=relaxed/simple;
	bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce+fxYIVTSW8z2uVKYGOCAQWWJJcq8sfnZNozRLC1r+IUvFxONFG4Yqkz0rNt0pVIiSz9jbqdI7UD7A4k0ZjyKty3tA13zT1+uZl7+KaBPm+L3+kCHFOk5YSKS2rQmhDO3S7RzrKqxkL99BZj5PIm07CU8zD7VRkBQgHw9KzKWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=AAvDmDtL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a046c5262so3807457b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1710369512; x=1710974312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
        b=AAvDmDtLRvPhQjkNy4GbjNZNH7YnTwOMBjzjqLls2aTQnvALkCWDfq3sBRmYtY66NT
         8mvwm2h4p0nD2RN3MdjD6Ym6M6zunbIawW9Jdcloem2jeb17WGcXdy7X30CxLPh7EXkq
         rabuDO4SlRVoR0PUvYNDDq9/9VBBL82caRRQXSip2tDHJeGXvNPmSxZiqIBZ0TPYZFcY
         oLl9i6Fol6c/uC7tDy9lt6k2lS2uQyZ0eEsaErQjRu5hbM7iAW1DNkWSbMtDi0jXxi49
         7jBZwYD0OiuPkIozy1PiE7b6Xr0g6cFB9OuTOgxJK9YlqoKsiTHtpZKygu7HV20j089g
         JV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369512; x=1710974312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AeK6IryRQEcZsy2w1FTI8NpS8Vj9IE8PhmQeFns2gg=;
        b=LXX2o7IdXGYaAIV6DvELLVeVe3KDKnvQD5udEbq2wMbrWeprW5pKZbciiP6JQVBMf+
         py5rbevHKh01ygZOHKyjI7HXfrKHCmSrTRO+Vs+4BZVym2d+OgD7ixYjfAmXufFMocNF
         mcnmStWOBFyRJ0sOLszw3AF4yHeVbb14Lni3Sr/VshaH3MEsh8JRy1wYEraNT9I5hVvw
         5mU/nWRkMy0Yg3O/ZW4vUsFWEz8KZPkYvHo1E212gf3ZzJjkNgUhYeY7iynGTDCHzbc1
         i4YFZjWRaF6nUvaXeQ3e7zPuC6DCKZXH/cDHcYZr/0uscS39h2AhbzBfdqIBU4gE459N
         ehGA==
X-Forwarded-Encrypted: i=1; AJvYcCVaH8MPoVNgTex6jUhduIiSqXgoeQr0yaWE5fOjIuYI/JCMLBL0wSD+SEJGy++hQ098YTfER5oIZeO+PNBe6qLJ+8DtUdnrXxDPpyYP
X-Gm-Message-State: AOJu0YyXpaLh7Kw3IBeGDAPH0zFuM95qgv+SHGuSW4NvxYtYrh3V6saB
	MIBX8u+CqtLO2dalyUk4fiVaHSfujkqEcK2r4cs4dNvlFPMdJ3vCqaVEfXfP7Zj8bcTviGLAUoi
	8sLSsVDrO04Q4KDr5J2T0XSj8J25GxFCiXh7R2A==
X-Google-Smtp-Source: AGHT+IH5HYI6/U5oWgLdvGxeY0fpFg8OXqHHr5ZUzkK1XxyJyiWCmyb/BKEtIMTTf0er7LlSWB8J4HGSxys17t9+Qmk=
X-Received: by 2002:a81:830a:0:b0:60c:a4b7:139e with SMTP id
 t10-20020a81830a000000b0060ca4b7139emr13653ywf.16.1710369512263; Wed, 13 Mar
 2024 15:38:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220214558.3377482-1-souravpanda@google.com>
 <20240220214558.3377482-2-souravpanda@google.com> <CAAPL-u-0RekH-ptg9U2pzPJxCAR+jMTxKTZU49LR_isjNkSPWg@mail.gmail.com>
In-Reply-To: <CAAPL-u-0RekH-ptg9U2pzPJxCAR+jMTxKTZU49LR_isjNkSPWg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 13 Mar 2024 18:37:55 -0400
Message-ID: <CA+CK2bAqdFL-kGmTR8msdy_FSr4Zt7+riJgjdTxX+FN+-M0pLA@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
To: Wei Xu <weixugc@google.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 1:12=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> On Tue, Feb 20, 2024 at 1:46=E2=80=AFPM Sourav Panda <souravpanda@google.=
com> wrote:
> >
> > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > to /proc/meminfo. This information can be used by users to see how
> > much memory is being used by per-page metadata, which can vary
> > depending on build configuration, machine architecture, and system
> > use.
>
> /proc/vmstat also has the system-wide nr_memmap and nr_memmap_boot.
> Given that nr_memmap in /proc/vmstat provides the same info (in
> different units) as Memmap in /proc/meminfo, it would be better to
> remove Memmap from /proc/meminfo to avoid duplication and confusion.

There are many items both in meminfo and in vmstat. Given that
/proc/meminfo covers all kmem memory, it is beneficial to keep the
kmem part of memmap in meminfo as another classification item.

Pasha

