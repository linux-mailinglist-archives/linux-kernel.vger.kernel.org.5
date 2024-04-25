Return-Path: <linux-kernel+bounces-157990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7AF8B19DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE76B244B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FF12D60A;
	Thu, 25 Apr 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEMg7jx8"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CA10A16
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018800; cv=none; b=hqyF90aY3HEFTx50B19SUNQTeFFKS8BW4Iq8Wal1Cso+ZnHwVXfr+oXFC4I/iys6U/FsuNiyYzbdT9TIRxPlBVV1zY4fUStzJmnfqXrjFNvwQuHej2EsTVOU6NR/3Z1mC7LDQ/2KPsYefwKrYaS5LYqxdqGGW/0uoSPiiihPRsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018800; c=relaxed/simple;
	bh=NMg+9hCwbXrc++Qvh4TJXQuS5Ly3hwbseR/9XIPaNGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UP47CEJl6n9iqgK7v8di7DTamfHLFZBOIA8JwTufz93HgQJIniFUquc6TnZuCWCAVOiDdty9CRhChzeXInbKBeQkDfNCcV+bC9iJq0l2subLped05T0Vr3pBC8OdmrWGwcNyABuMbKll426B+0h9myAnUWO6EyJ83HFxVZo/7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEMg7jx8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8b194341eso4716991fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714018797; x=1714623597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMg+9hCwbXrc++Qvh4TJXQuS5Ly3hwbseR/9XIPaNGw=;
        b=mEMg7jx84p8kGsMkmnNGj1OcYzj2i33aBmviPHll77YphA03Iubw6C+riwucIsHBSy
         Y69glTcyQ2HPIsPJ3KbiFB2CpQtid6FXELmpCLmIZNFYqHfkLcRmbRpCW/OERtW0khG3
         IbcBAkKGC46oBTXHt7bOFY1ECWAMN3k6v7z8L3wkmpjp0NnJRNHXXMvOcS1W5OQ25IYt
         BiO+da23d865clHYEsBi4NzBH31AR3/LnJQvGvIw5a0mTbpWns2Ug/PrjxsP1/elr8pC
         5aW/qPWAVJki57asGF/O8oJbTHFhtoPALElLXQyJFEnUO4Ai7sZXl9Ln97SPIbZ/41c2
         w3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714018797; x=1714623597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMg+9hCwbXrc++Qvh4TJXQuS5Ly3hwbseR/9XIPaNGw=;
        b=pE9Tk7071GAO1hF5cBcHUsFsKkI3gB/b0tFRIe7e0uKq7R36Y7WC1InDK97kkr2PlU
         ZBny75FfhVrVOYTrNUxmuddFPWKBTR+3GfkcRJzYdHZyYyj1jq1ef5neZyDdnchFvPvp
         yauS+wuR0WFTDnuFegHycBTeNrdSR/Pfqo7lUJOECDc6SUUU1IR/kbWv/KPzuCL4pi1R
         0/TrmDYRF/Pdjz/oGkA3Qef3oIW29SFcY5ahvI6y2bMFyziSFY3Lq78/9EnR809d4pHT
         T8Hfs5NQ91EWimQs7uakWKgA/PnI3R8FSLaLnJD9O+RpLaS0HaJYIkXVMB90VFlCOR4a
         D9BA==
X-Forwarded-Encrypted: i=1; AJvYcCVVOCNoxxB8Y/cXltM8/ieDcSwiec01wn0J9TP7ZYn8Fd+q3LHAz3ufilZimAE3CXVJTVBsdDDKrtQoeBszE54HaeksQ1HUyErMT3jq
X-Gm-Message-State: AOJu0Yz4z7jdFTF9Oa13g2H8OtlutAIf3b48XIbBXb/n2Iv+SMGO0aoR
	Y5Tkx5aWa06YU4ZusaDxnBS8UVbAwE6/UDzRM6RQ0MsvTTjlA/KrR/pJuLjdTax+JriWH/vL66p
	jhOPonLDFps1OTp8+9+QojUboFh4=
X-Google-Smtp-Source: AGHT+IH4Dp2AKt8vVX0I/RfdKEAnIUxVFSKVd77V3vF6aJkMoz4IDJP/E4UiD0m1B/rW4k7ve5L8LDfqzwlVo/WCfj4=
X-Received: by 2002:a2e:9d06:0:b0:2d8:6b0c:d91c with SMTP id
 t6-20020a2e9d06000000b002d86b0cd91cmr2438642lji.47.1714018796709; Wed, 24 Apr
 2024 21:19:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422055213.60231-1-ioworker0@gmail.com> <ZiiHSwG_bnLJbwfb@casper.infradead.org>
 <CAK1f24kaHcKOS1ajfLney-1+Pqrwrk_0LWqRr2DmZ+41YBzXug@mail.gmail.com> <20240424142009.149eb988cca33822ce0fd0f1@linux-foundation.org>
In-Reply-To: <20240424142009.149eb988cca33822ce0fd0f1@linux-foundation.org>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 12:19:45 +0800
Message-ID: <CAK1f24m2fR5EynwBN64Nuhcgctbd2RLXjLx7W_H+uywKLLO+cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:20=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 24 Apr 2024 23:46:59 +0800 Lance Yang <ioworker0@gmail.com> wrote=
:
>
> > On Wed, Apr 24, 2024 at 12:15=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
> > > > When the user no longer requires the pages, they would use
> > > > madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would =
not
> > > > typically rewrite to the given range.
> > > >
> > > > At present, PMD-mapped THPs that are marked as lazyfree during
> > > > shrink_folio_list() are unconditionally split, which may be unneces=
sary.
> > > > If the THP is clean, its PMD is also clean, and there are no unexpe=
cted
> >
> > "If the THP is clean, its PMD is also clean" can be confusing - sorry. =
It should
> > be modified to "If the THP and its PMD are both marked as clean".
>
> I made that changelog edit.

Thanks for updating, Andrew!
Lance

