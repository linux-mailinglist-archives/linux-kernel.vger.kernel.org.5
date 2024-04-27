Return-Path: <linux-kernel+bounces-160885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7DF8B4404
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5916BB21B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A913C482;
	Sat, 27 Apr 2024 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRr4Oe8I"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197039ACD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714190819; cv=none; b=DTl/jmxrwf3nkHGnL7VF07zr5V1Txa+fEcIcfWi6NsCfxV3NDHY6ifLsubNmNXz5p63gGX1yK1diF/9UkxJMvvczpKp3p3h5eya0e47QNDDKBoythHOhjhXFeBofefz2pANi8hul4mS6fzm+KKee6ogmJ5LrTXWy3ZM7R5GHfUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714190819; c=relaxed/simple;
	bh=IWrGoZdPFLVH26tVoXsyJ6fbWNR4Er2atcH2Gh/bqmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phAnP0Ag9ULZo2I8j4gmdeDLctFqkXpStgvSspnJ2iKZQnNtpO2k3p4wwIpOkvDg+iqVBLWYuHtLwUxgjluJRo4ujlMpqsLIJq33XMjzseM9Gmb7bXyJtMKcWsHJd3HjTbKjj+3O1MLmh9Aot/Vcx0FnT3DBaCD5q4D5Wytr8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRr4Oe8I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516ef30b16eso3163944e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 21:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714190816; x=1714795616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K/f+dxXYDgieEAmNtvU2lm4Kz1R5O4qgn/yAw0pjEQ=;
        b=eRr4Oe8IkTPxxrXgq2w1KGaS6G0ZaD4D6pE79K+tx+1Vz2tAvftHeb3YhrZrJgQHhS
         X3CHbuJu4BXGqFvUyEC+tONIiwy3H0J1pGrjjBv/qPlUITSCSnHRvAAqLYXJmSKO8K1n
         cYKOIIgA0+ApSrSe3vAWPYBXQOSDoMSwP+EwLsm6bFxxujRV4Wbz8OCBwDcC6w+wFitK
         ymo9POPIIcgJIdh9++Hk9WvtMPoxSCRnxekxJvNgbqoZgP7JBVneicGx8q9kQzeB4kca
         WaWlVCFAJLP6WGRDaeN8ySnJX3GZVKfo+ZXS8Kdp+uC/ylnlj9ZRLn4UmfEQZotTPbZl
         TURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714190816; x=1714795616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9K/f+dxXYDgieEAmNtvU2lm4Kz1R5O4qgn/yAw0pjEQ=;
        b=eXm+0Q6twb6OeJybT4tWYwl8ElNxGvUQYje8WK67qjIX16DlXOZoOX4spdMZZI0M7U
         gEF17joalyVlgNkhdg0TGZ6+C8MXgDAwFJ/pohAzNsp1fOuez51JOmHHlEKE2Krs+M85
         0lj21f8KXabRO/RME7ubKloII8cknLAA7sUQFf7PcdpRrngh7a8ElZcihCfJWYZ3Z6Gk
         w2fxTH8JhuYwxCJNu/wLbQpw5DIZU1lA8Duye4eaJwDmi2Cehr7rjxl1530rCT8qIbzq
         hYS2LzGY920f3zsEzxvr5nrxPtRjwwFPUL+cfap9y/7K6UnosjKqGgd5MmznvE0KEN6a
         AUyA==
X-Forwarded-Encrypted: i=1; AJvYcCWtfzvZmOtQ/d81yPkKS3CrPjjgQVswtQ8KYhhpgXiaLO2IQ/kBkM0Njq6YIsIgIaHQcbOnoLMJsRVfxya8SWiU9jaRjvW337pE9uS0
X-Gm-Message-State: AOJu0Ywg7tldw4tGfSP5NHop9PQuEs1MqclApJ3Jm/fLcMH7hXpiXfP8
	t8lg7W4tZsFVu6HaedaQLrLKDONHlST90rgahpBIK2mVU7ljCP6hmHk0vdOroGevealvYMiEOvL
	1hlVHIixWF7pVvMhnIyy+VMcxqjo=
X-Google-Smtp-Source: AGHT+IGVv1kSk/OSs+CWD9taUY6vf6uhAQkRImQCkL+FjIpFV6QscIoqsROinfXP6kmFjWmz/5iYBS+jwT0y7+ey1VA=
X-Received: by 2002:a05:6512:3102:b0:51d:2c37:6c15 with SMTP id
 n2-20020a056512310200b0051d2c376c15mr85964lfb.8.1714190815422; Fri, 26 Apr
 2024 21:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426190253.541419-1-zi.yan@sent.com> <e274ad3b-bbeb-49b0-81bf-24fd33106f05@redhat.com>
 <CB058583-C99A-4897-B3AE-11C56D6E3A59@nvidia.com> <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
In-Reply-To: <fb58cd88-d5f3-42ea-a710-0cff3764cd32@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 27 Apr 2024 12:06:43 +0800
Message-ID: <CAK1f24=PnZ-Q=TrG9+SKWhwNHF_=EbVBWVcexqsEU-dctrAOFA@mail.gmail.com>
Subject: Re: [PATCH v5] mm/rmap: do not add fully unmapped large folio to
 deferred split list
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi <shy828301@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 4:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.04.24 21:20, Zi Yan wrote:
> > On 26 Apr 2024, at 15:08, David Hildenbrand wrote:
[...]
> >>> +   bool partially_mapped =3D false;
[...]
> >>> +
> >>> +           partially_mapped =3D !!nr && !!atomic_read(mapped);
> >>
> >> Nit: The && should remove the need for both !!.
> >
> > My impression was that !! is needed to convert from int to bool and I d=
o
> > find "!!int && !!int" use in the kernel.
>
> I might be wrong about this, but if you wouldn't write

I think you're correct.

>
>         if (!!nr && !!atomic_read(mapped))
>
> then
>
> bool partially_mapped =3D nr && atomic_read(mapped);
>
> is sufficient.

+1

>
> && would make sure that the result is either 0 or 1, which
> you can store safely in a bool, no matter which underlying type
> is used to store that value.
>
> But I *think* nowdays, the compiler will always handle that
> correctly, even without the "&&" (ever since C99 added _Bool).
>
> Likely, also
>
>         bool partially_mapped =3D nr & atomic_read(mapped);
>
> Would nowadays work, but looks stupid.
>
>
> Related: https://lkml.org/lkml/2013/8/31/138
>
> ---
> #include <stdio.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <inttypes.h>
>
> volatile uint64_t a =3D 0x8000000000000000ull;
>
> void main (void) {
>          printf("uint64_t a =3D a: 0x%" PRIx64 "\n", a);
>
>          int i1 =3D a;
>          printf("int i1 =3D a: %d\n", i1);
>
>          int i2 =3D !!a;
>          printf("int i2 =3D !!a: %d\n", i2);
>
>          bool b1 =3D a;
>          printf("bool b1 =3D a: %d\n", b1);
>
>          bool b2 =3D !!a;
>          printf("bool b2 =3D !!a: %d\n", b2);
> }
> ---
> $ ./test
> uint64_t a =3D a: 0x8000000000000000
> int i1 =3D a: 0
> int i2 =3D !!a: 1
> bool b1 =3D a: 1
> bool b2 =3D !!a: 1
> ---
>
> Note that if bool would be defined as "int", you would need the !!, other=
wise you
> would lose information.

Agreed. We need to be careful in this case.

>
> But even for b1, the gcc generates now:
>
>   40118c:       48 8b 05 7d 2e 00 00    mov    0x2e7d(%rip),%rax        #=
 404010 <a>
>   401193:       48 85 c0                test   %rax,%rax
>   401196:       0f 95 c0                setne  %al
>
>
> My stdbool.h contains
>
> #define bool    _Bool
>
> And I think C99 added _Bool that makes that work.
>
> But I didn't read the standard, and it's time for the weekend :)

I just read the C99 and found some interesting information as follows:

6.3.1.2 Boolean type
    When any *scalar value* is converted to _Bool, the result is 0 if the
    value compares equal to 0; otherwise, the result is 1.

6.2.5 Types
    21. Arithmetic types and pointer types are collectively called *scalar
    types*. Array and structure types are collectively called aggregate typ=
es.

6.5.13 Logical AND operator
    Semantics
    The && operator shall yield 1 if both of its operands compare unequal t=
o
    0; otherwise, it yields 0. The result has type int.

6.5.10 Bitwise AND operator
    Constraints
    Each of the operands shall have integer type.
    Semantics
    The result of the binary & operator is the bitwise AND of the operands
    (that is, each bit in the result is set if and only if each of the
corresponding
    bits in the converted operands is set).

&& would ensure that the result is either 0 or 1, as David said, so no worr=
ies.

We defined partially_mapped as a bool(_Bool). IIUC, "partially_mapped
=3D int & int;"
would work correctly as well. However, "partially_mapped =3D long &
int;" might not.

Using && would be nicer as David suggested :p

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

