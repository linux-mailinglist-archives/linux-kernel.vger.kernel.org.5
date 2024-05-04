Return-Path: <linux-kernel+bounces-168512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85048BB977
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 06:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6834E1F235C3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F5E111AD;
	Sat,  4 May 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Y5+Be6"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA5710A23
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714796846; cv=none; b=u5m8ahahDm6+xwgvj9U9EEADRGFmBNabLYuFzHqdzGbvga2rdFQQaX6ra5OcZ+Fu5Awjr+pI09DAiv7TAR0auFlTnDSc/8O0vfwXcWEGPmF4GIkXq9jU1JDzyu+HgIsVLxvgYhDrDwI1X4pTeE/MAwzdEaYOAo3wevHUka9xegI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714796846; c=relaxed/simple;
	bh=XDD/yCGw7jn5yR/Hffav3ixMpXa6OVJh41weDeDyIKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCEwiVSS9EjkYzJhmfT6jwsPb0cIDFD1FTxunG/Naak8DcOFxWYWgnyrjEDwRMCSpr1dqgCMG1A5KJegI3CcwWLu3Lqz0ENqepgs9ZhY9g3IQhYyh8IcDqy6R59Vs20/6v8P+MuDBEbLjHEMxb14QdARprH5WTxqR8k35vCau8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Y5+Be6; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-de4665b4969so292315276.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 21:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714796844; x=1715401644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDD/yCGw7jn5yR/Hffav3ixMpXa6OVJh41weDeDyIKY=;
        b=J2Y5+Be6W3SU6Y1mOqIsZMEOAz0UnAiOMJPkcKhzaIOwE3W9/6Z+nLh8cINylseU7z
         DNu8wOeNq8qZu2bj2hPxauHIYS8htJKFgNXRtLQcf4JXwqDLNyxeXa4wWtXYhMqPHkSu
         JXhX5bLby3IGpG1WAdBlQKgpNXHoz3tybIwzAh437CdN/VAYMRqYaLSIs0KhAV/DrkRK
         fzMK92afnmWL8s74xfbMfNko5BMwD3OA4sGxNl3fd84h1NzKPCNOZFrWoybR1VooD4Lq
         pguBrl867wfNYoRcQ9q7MUgyRyj2DQKovcDsMIaWeMAPUO/yRAr3EEV1yh6yT9RqqjzW
         pdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714796844; x=1715401644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDD/yCGw7jn5yR/Hffav3ixMpXa6OVJh41weDeDyIKY=;
        b=UMegK7L4zjGlDy4SprsbIIu9dg8CPv70AR6Pbq33Gcr+QXzzWM5fIZkLrdKMcceJu9
         T7Tcv7a3+uHdVmgEezpRP7PSzznPA/WITq0VF9+9+YRZRqEa4wuDkbRv2+mPC1SPq7ON
         dzvAoCxbS/Tp6WUgESt4r28ryCDNx8J9a1OAVVlq6fhRl/l7MJvIq7toCON8tlxi1GyU
         f2V2a/u8rXos8vBS4pVNF6KPXGGdLOtRgyByfmI1f+huHIn/ZNJWMTA91bGGt2FfAPs2
         1ZsJT4uyrQpLF4GCDgrDvGzK8knUgxWxwWphTQV1W55+Q92o3fSo3/Tbx+XPWsR04j4i
         AkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1q4NorGkzuhuPDZB60OScaCF3HzM3ojKI6bJZnYMS5V00cxGbPxg/npljKl1lbK2HQ3Pk8dn/Nddi4fypKSVLXjI2ldp7k/eQBByV
X-Gm-Message-State: AOJu0Yz+aZr2sZcFvpXqh/OVe7M0rOCERPHrmcGlNSXTnxvXFBGZb3H+
	awSWpVU25CsEH39u7IQPvU7wYTbFMMjsGD7G9NRE6btCZd70OK7zr9suFkk6tJIz0uNSPv0/vn3
	KeWSTm/jtZEDX3jbM5hFraWnycIE=
X-Google-Smtp-Source: AGHT+IG61Q1cd6ycuy3/N+FKbe3xiOJoP8sklaJY/Unop+PZLPH07XSMkYLc13/d909KkYHzQiNtwH8d/qnR4KPlCc4=
X-Received: by 2002:a25:2009:0:b0:de5:c1a4:560c with SMTP id
 g9-20020a252009000000b00de5c1a4560cmr4983744ybg.56.1714796843850; Fri, 03 May
 2024 21:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com> <CANeU7QkYXmpmTAVjGqin4Wpg9hydPPYZKho-MwQMMt9uJ8Lu4Q@mail.gmail.com>
 <ZjWzoGg3MRs0yiBR@infradead.org>
In-Reply-To: <ZjWzoGg3MRs0yiBR@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 4 May 2024 12:27:11 +0800
Message-ID: <CAGsJ_4xdgD8grbW98Gfoc7X-fAVYzFtobczNCWApw-oPhj9dwg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use swap_free_nr()
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, baolin.wang@linux.alibaba.com, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com, 
	ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 12:03=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, May 03, 2024 at 01:37:06PM -0700, Chris Li wrote:
> > Either way works. It will produce the same machine code. I have a
> > slight inclination to just drop swap_free(entry) API so that it
> > discourages the caller to do a for loop over swap_free().
>
> Then just ad the number of entries parameter to swap_free and do away
> with the separate swap_free_nr.

swap_free_nr() isn't separate, after this patch, it is the only one left.
there won't be swap_free() any more. it seems you want to directly
"rename" it to swap_free()?

