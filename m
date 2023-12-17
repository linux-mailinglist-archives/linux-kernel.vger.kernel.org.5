Return-Path: <linux-kernel+bounces-2780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749638161B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737DDB21F27
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFBE481A0;
	Sun, 17 Dec 2023 19:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC3iBgPA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B799547F61
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso3089120a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 11:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702840442; x=1703445242; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAlIATYK6g6ASaeNglWYD7dTnzBHWW3q/ZKCMEGpKSw=;
        b=HC3iBgPA8Y6BJyCXU504SIhIMnXvbXq6IfEbsLfXWxAKyksey83YWuif9GJnGPmLRt
         8Pu/KOxOTZfLzh+9JkVCC+p7PbHYwqzNZ8byFqwtIf8iiVo7E7nUcW5WRsBxC1h+RvMj
         rqOksVAuIdQYlQJ6O5lYZ76csRBKlHUXawQgAu5KDZwxr4+3uv6L/VarcaysL4Fd03mG
         OHQ4B2JROf0luhoOXmjwNegRZ18apxYfDuALWntF5jmrf+qjTkPWDv+1L3J3OeYIRXCb
         0OdsFhtX15t/Z6wCghwSdFiMCcMswv914A7HezPWXW7cQc9u4yYVX+qtbrpxhF9nDKRf
         e+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702840442; x=1703445242;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAlIATYK6g6ASaeNglWYD7dTnzBHWW3q/ZKCMEGpKSw=;
        b=MwkY3ZU2hwLwzD4SUPDrTdPJzDupGBtqFZU5lxEA3VWOWG+xrGooNvbp/CQ9WIUHjw
         LcxXhPrrntakcbUPf2gxy0iIYz3D7n9SugnDyJdRDypq0UvkLp2/KHRYnbpFNR6gwdkZ
         6p8UsUQ/ox5thMMItq/tfzFXQz8mSQo2zMnDXs3Z21lKg+xae8rhJy5hTW0p9jAz7Igq
         2x2jWRvy05uHtCw6wjJzpK+89tD8c9s63tRQMKj8Nhu6dBL71/SKJ/q8YxFH9nALedaF
         XY0/QZ91ru02zlOdzZLeCOcKb8brqvDCG9m6WVkC5am2nJ0424NrGfnG5qDhxl6fAw3J
         hr1A==
X-Gm-Message-State: AOJu0YwBucgzeJZdElEwPlFqyIX9GF3qbXhsDX1CsTl/FOh1NvdTemg6
	Y+cAis+djjjEEfEJaWGM794=
X-Google-Smtp-Source: AGHT+IEN3tIZdbpdVnFfl95tahRpNjWbRQOVznLJZHfiRY6lrr6de7Vw2kGd+7/mTy1LnW405nG+0Q==
X-Received: by 2002:a17:906:116:b0:a1b:7df6:11dd with SMTP id 22-20020a170906011600b00a1b7df611ddmr8445806eje.80.1702840441526;
        Sun, 17 Dec 2023 11:14:01 -0800 (PST)
Received: from smtpclient.apple ([31.154.57.136])
        by smtp.gmail.com with ESMTPSA id ts4-20020a170907c5c400b00a1cc1be1158sm13295978ejc.165.2023.12.17.11.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 11:14:01 -0800 (PST)
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
In-Reply-To: <20231124132626.235350-8-david@redhat.com>
Date: Sun, 17 Dec 2023 21:13:52 +0200
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
Message-Id: <F5EF2C8E-2902-447C-BD97-05AF6FF8832D@gmail.com>
References: <20231124132626.235350-1-david@redhat.com>
 <20231124132626.235350-8-david@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


> On Nov 24, 2023, at 3:26=E2=80=AFPM, David Hildenbrand =
<david@redhat.com> wrote:
>=20
> 5. sub-IDs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> To achieve (2), we generate sub-IDs that have the following property,
> assuming that our folio has P=3Dfolio_nr_pages() pages.
>  "2 * sub-ID" cannot be represented by the sum of any other *2* =
sub-IDs
>  "3 * sub-ID" cannot be represented by the sum of any other *3* =
sub-IDs
>  "4 * sub-ID" cannot be represented by the sum of any other *4* =
sub-IDs
>  ...
>  "P * sub-ID" cannot be represented by the sum of any other *P* =
sub-IDs
>=20
> The sub-IDs are generated in generations, whereby
> (1) Generation #0 is the number 0
> (2) Generation #N takes all numbers from generations #0..#N-1 and adds
>    (P + 1)^(N - 1), effectively doubling the number of sub-IDs
>=20
> Consequently, the smallest number S in gen #N is:
>  S[#N] =3D (P + 1)^(N - 1)
>=20
> The largest number L in gen #N is:
>  L[#N] =3D (P + 1)^(N - 1) + (P + 1)^(N - 2) + ... (P + 1)^0 + 0.
>  -> [geometric sum with "P + 1 !=3D 1"]
>        =3D (1 - (P + 1)^N) / (1 - (P + 1))
>        =3D (1 - (P + 1)^N) / (-P)
>        =3D ((P + 1)^N - 1) / P

David, as you know it took me a while to understand your impressive =
work.

I think that part of what made it hard for me is the presentation and =
the
formulation of sub-IDs in arithmetic means instead of bit manipulations.

Basically, IIUC, you want for order-K pages to add K-1 =E2=80=9C0=E2=80=9D=
 bits between
each rmap-id bits.

In this case, in x86-64 (with BMI2) there is the PDEP instruction that =
can
generate these values rather easily with little overhead.

I think that besides the easier generation of sub-ids values in this
manner, discussing the matter without the =E2=80=9Cgenerations" also =
makes it
easier to understand the correctness (at least for me).


