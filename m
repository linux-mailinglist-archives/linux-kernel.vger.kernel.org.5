Return-Path: <linux-kernel+bounces-3840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CA8173AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9506DB22A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83DE1D14B;
	Mon, 18 Dec 2023 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbhHKQpf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B25372
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a234dc0984fso144367766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702910096; x=1703514896; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZnVMVuDE2QNpmk3RDuxFUNQe38gWS5UD9x48gZuVzI=;
        b=BbhHKQpfl/nfdhg3hvJNHXRQ/HXPu3fIpjp/fnf28GebsLBq/q7nIyQ9kRfHCWc+7j
         caHOBrZZ16HvTuGiannSEXXfKdsg3bigLsPzw8/SmoyvU8kccHjrJEC78QlpS5ILOxvb
         N1NRkbkKjct308O+YQr8gk+R0Aio1Q+l6SDpnJ+5THVHqgIl9hYlSKBoo6ER9tk6v4BD
         Q+rBIHlhn7BWBD5J+dTxGqRY5X5O0kUNyjuZQC+YvjzYx78UrxgNtk82NuI3Eq7Z67I1
         /v/wxI9xzTxAEGcZj1A2IengcJDaf0dbFpm8MogRRAl7VIw6ykWeTVlRlupfPtMJEr72
         ujfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910096; x=1703514896;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZnVMVuDE2QNpmk3RDuxFUNQe38gWS5UD9x48gZuVzI=;
        b=l7ZSFmU9NtXONIGM+pj59yvh1dff1s0lm7fwv1C/s8/xENT+rGE9R0Q6BHg5rVFAWA
         YmmQMZ9TKjTCZupqjg7MHz12O3oKdVTfXwYqYZXEJIp/W5ijbty39pVn2xDjruWJ0TE7
         mE67VI5V/3iSSG+35urAtoRApwoiRnMMoB6bVM7P6Zyv7WcJ0dQejT4m0wYCU18q2cJe
         Z151Qs8ddoNmwdjhFeVUDayy8Qm2cZ6HYugCcqs3o/UQePXDhGUguZ2x4l6oCxt5CwUB
         y+EXr1ZUX5T5SJXZVNezajTCS1sOgw5zfWNzTruB8A9uM6Bf/Dm23AF3ZdNK9d0uRirx
         mQrQ==
X-Gm-Message-State: AOJu0Yxuwacxpz0mnOOldkB1Te3h62rMEnobUZp5WRgAn4aXW4bJlge5
	YbJji0gAzlUZeCuhnLCouJQ=
X-Google-Smtp-Source: AGHT+IF/h1m7zfTRYBWuerU3GcTvJeCxIDtf/mcrueGPKZ13jdZms5mSQBDVbayXHUoe3unw5c/YBw==
X-Received: by 2002:a17:907:94c9:b0:a18:4cf3:c8d0 with SMTP id dn9-20020a17090794c900b00a184cf3c8d0mr9543652ejc.49.1702910095638;
        Mon, 18 Dec 2023 06:34:55 -0800 (PST)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm587575ejq.62.2023.12.18.06.34.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2023 06:34:55 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH WIP v1 07/20] mm/rmap_id: track if one ore multiple MMs
 map a partially-mappable folio
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <944d990f-3c98-4ade-8176-4e4b25eae0b8@redhat.com>
Date: Mon, 18 Dec 2023 16:34:42 +0200
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>,
 Yin Fengwei <fengwei.yin@intel.com>,
 Yang Shi <shy828301@gmail.com>,
 Ying Huang <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FFED5A1-BF86-480D-8CB7-BECE5C413B44@gmail.com>
References: <20231124132626.235350-1-david@redhat.com>
 <20231124132626.235350-8-david@redhat.com>
 <F5EF2C8E-2902-447C-BD97-05AF6FF8832D@gmail.com>
 <944d990f-3c98-4ade-8176-4e4b25eae0b8@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Dec 18, 2023, at 4:04=E2=80=AFPM, David Hildenbrand =
<david@redhat.com> wrote:
>=20
> But adding 1 "0" bit is not sufficient for handling order-2 folios (P =
=3D 4), only for handling order-1 folios. So what the current approach =
does is the following (P =3D 4):
>=20
> RMAP-ID |       | Subid |
> -----------------------------------
> 0       | 0000 | 0     | 0000 0000
> 1       | 0001 | 1     | 0000 0001
> 2       | 0010 | 5     | 0000 0101
> 3       | 0011 | 6     | 0000 0110
> 4       | 0100 | 25    | 0001 1001
> 5       | 0101 | 26    | 0001 1010
> 6       | 0110 | 30    | 0001 1110
> 7       | 0111 | 31    | 0001 1111
> 8       | 1000 | 125   | 0111 1101
> 9       | 1001 | 126   | 0111 1110
> 10      | 1010 | 130   | 1000 0010
> 11      | 1011 | 131   | 1000 0011
> 12      | 1100 | 150   | 1001 0110
> 13      | 1101 | 151   | 1001 0111
> 14      | 1110 | 155   | 1001 1011
> 15      | 1111 | 156   | 1001 1100

Yes, of course. Silly me. You want to take advantage of the counter not
saturating for orders K where K-1 is not a power of 2.

I get your point. Not sure whether it worth the complexity though=E2=80=A6=




