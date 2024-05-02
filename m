Return-Path: <linux-kernel+bounces-166044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA68B9528
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5BA2831D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5141C224DD;
	Thu,  2 May 2024 07:21:21 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072971CD31;
	Thu,  2 May 2024 07:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634480; cv=none; b=EdvZjUHqL89Py6rKVhUVhyWoIsKrqjKeUzWrRge8uZi5An1xts3P2efDdaO1jxHdwDiXxoTDFqlW7xh/tK6MmyaLXYhx3TPyF2vmqeMAAQlVl8tzI0Pe+7czFwm2+DpbMP4UWkpDeg7SmZ+y7SzJaWkLG1rj/FnRLhtsFdseoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634480; c=relaxed/simple;
	bh=aMR9JSzBugnFdGzC7oW37CSM2SHXLH9wKHs5yoyxVjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RViycAo6FNFbCoIlWNhyPULY+rW692KfDZ9t8rv4rAvUqP5xsYYoVQoYPrpGqVBNemIuxV1bL1cfzWh7az/G7lNB7jMydXSQ5/Kk5n0V0bDqzUstkjF7l7vDrFMD+zKDoAw1RVUxchFQfV3eL5blPvaKEJnSP8Kx6NtdQzdQxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc236729a2bso7669447276.0;
        Thu, 02 May 2024 00:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714634477; x=1715239277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3h8OHZvBcOiq+Yulnbt5Wx1RNFCijX/7KF1ix5Zccw=;
        b=N7Gsd64l97htXuLC08qtsqAdcm+Afi/rB1gFColVU35NMPElnw3OTKNDGPr5KwNLAZ
         sI3KAU7tp89BfLwoFFsda9GYtHOuCJDiQ1cPzq/q1eD9seb1U5ZsQhJF1ucwVnIkhzTQ
         adzmMzpS8qL6sRe8kqPQgVKnzj3VJgEqWjasZtSTOAaPiiejZSy+8iGsLYMjHkUNIjfR
         vRC012wtPf2aaekNxDQLO6FJRIL39JekMVt8DhgKzJeZGcxmHrLGuNl4ScvIZ+HXj/IQ
         i+netgVidsxOTkxuFrRIsuFSOGMOj6LY1c9x9tTaqBUuEPfTG7XEMxeaXcmcwnsloo+h
         BHEw==
X-Forwarded-Encrypted: i=1; AJvYcCVf5/vTWO3WHbpqcubMcZqb9urjrPO8pvTMxtiRlCW4s19jc/Oh7jglkSH3HOmOeZ1A9imU2Zldcheg9eJpyH6qzB++Nnl3YWV8aRViRS2eaDItqtFvTQkIqSFYs2AUIxgVl6jhGYY=
X-Gm-Message-State: AOJu0YxCWwSp0NNenFki/srCHPOaxoF9OFF7dMJ5oRkrrX+ALQAahpL0
	pDv4Ru1bxc4dsuxSIVHbBzC0pUX9F7BZTHJgxJqvn+PjG1JZGrRI5BktOR9J
X-Google-Smtp-Source: AGHT+IFzM3lRZL5W/UNWGiYZyUzKCRRkxKXlfs6Gv3GRGAbwbCE58ZQMn+GtfBBIkXd+huh6P79mRg==
X-Received: by 2002:a25:d388:0:b0:de5:5575:99b5 with SMTP id e130-20020a25d388000000b00de5557599b5mr4847991ybf.0.1714634476635;
        Thu, 02 May 2024 00:21:16 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x193-20020a254aca000000b00de5a5fcee44sm80734yba.13.2024.05.02.00.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:21:16 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61bec6bab2bso26602597b3.1;
        Thu, 02 May 2024 00:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwTbIcG/+cVwUgx31HDZSItKE/pG1+Ip8Am73RnT8WD2oHygu4pBTC32Gm9D7MlDN6g2S2LpC84MGCkbI5PFU66aIZkOxvXEcIt69DAfhycwPIi2dDIz69ce/uqwyvpTCrIb6hrsI=
X-Received: by 2002:a25:9249:0:b0:de5:4cbf:a517 with SMTP id
 e9-20020a259249000000b00de54cbfa517mr5395855ybo.10.1714634475345; Thu, 02 May
 2024 00:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324231804.841099-1-linux@roeck-us.net> <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
 <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net> <cb8d3d2a-b843-49d5-a219-10a29b5877d0@roeck-us.net>
 <1e77ade4fb1d924ffaf226cb946ba3314ba59a1d.camel@physik.fu-berlin.de> <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
In-Reply-To: <fb0293d85dbf82341c6b7e4d56fe8f1d23f7768a.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 May 2024 09:21:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVcE79i0RPQHJBJjpXY6U-M-AQ2gh+C25u_777PZgPxXQ@mail.gmail.com>
Message-ID: <CAMuHMdVcE79i0RPQHJBJjpXY6U-M-AQ2gh+C25u_777PZgPxXQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned data"
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 10:28=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2024-04-02 at 16:09 +0200, John Paul Adrian Glaubitz wrote:
> > On Tue, 2024-04-02 at 07:06 -0700, Guenter Roeck wrote:
> > > On Mon, Mar 25, 2024 at 07:34:00AM -0700, Guenter Roeck wrote:
> > > > On 3/25/24 00:39, John Paul Adrian Glaubitz wrote:
> > > > > Hi Guenter,
> > > > >
> > > > > On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
> > > > > > This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
> > > > > >
> > > > > > Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misa=
ligned
> > > > > > data") causes bad checksum calculations on unaligned data. Reve=
rting
> > > > > > it fixes the problem.
> > > > > >
> > > > > >      # Subtest: checksum
> > > > > >      # module: checksum_kunit
> > > > > >      1..5
> > > > > >      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/c=
hecksum_kunit.c:500
> > > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > > >          ( u64)result =3D=3D 53378 (0xd082)
> > > > > >          ( u64)expec =3D=3D 33488 (0x82d0)
> > > > > >      # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 tota=
l:1
> > > > > >      not ok 1 test_csum_fixed_random_inputs
> > > > > >      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/chec=
ksum_kunit.c:525
> > > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > > >          ( u64)result =3D=3D 65281 (0xff01)
> > > > > >          ( u64)expec =3D=3D 65280 (0xff00)
> > > > > >      # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > > > >      not ok 2 test_csum_all_carry_inputs
> > > > > >      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/check=
sum_kunit.c:573
> > > > > >      Expected ( u64)result =3D=3D ( u64)expec, but
> > > > > >          ( u64)result =3D=3D 65535 (0xffff)
> > > > > >          ( u64)expec =3D=3D 65534 (0xfffe)
> > > > > >      # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
> > > > > >      not ok 3 test_csum_no_carry_inputs
> > > > > >      # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
> > > > > >      ok 4 test_ip_fast_csum
> > > > > >      # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
> > > > > >      ok 5 test_csum_ipv6_magic
> > > > > >   # checksum: pass:2 fail:3 skip:0 total:5
> > > > > >   # Totals: pass:2 fail:3 skip:0 total:5
> > > > > > not ok 22 checksum
> > > > >
> > > > > Can you tell me how the tests are run so I can try to verify this=
 on real hardware?
> > > > >
> > > >
> > > > Enabling CONFIG_KUNIT and CHECKSUM_KUNIT and booting with those tes=
ts enabled
> > > > should do it.
> > > >
> > >
> > > Did you have time to test this on real hardware ?
> >
> > Not yet. I just returned from Easter holidays and need to get synced wi=
th work first.
>
> I might have to skip this for v6.10 as I haven't been able to test this y=
et.
>
> I agree with the change in general, but I want to make sure I can reprodu=
ce
> this on real hardware.

On landisk:

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: checksum
     # module: checksum_kunit
     1..5
-    # test_csum_fixed_random_inputs: ASSERTION FAILED at
lib/checksum_kunit.c:500
-    Expected ( u64)result =3D=3D ( u64)expec, but
-        ( u64)result =3D=3D 53378 (0xd082)
-        ( u64)expec =3D=3D 33488 (0x82d0)
-    not ok 1 test_csum_fixed_random_inputs
-    # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c=
:525
-    Expected ( u64)result =3D=3D ( u64)expec, but
-        ( u64)result =3D=3D 65281 (0xff01)
-        ( u64)expec =3D=3D 65280 (0xff00)
-    not ok 2 test_csum_all_carry_inputs
-    # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:=
573
-    Expected ( u64)result =3D=3D ( u64)expec, but
-        ( u64)result =3D=3D 65535 (0xffff)
-        ( u64)expec =3D=3D 65534 (0xfffe)
-    not ok 3 test_csum_no_carry_inputs
+    # test_csum_fixed_random_inputs: Test should be marked slow
(runtime: 9.814991070s)
+    ok 1 test_csum_fixed_random_inputs
+    # test_csum_all_carry_inputs: Test should be marked slow
(runtime: 19.621274580s)
+    ok 2 test_csum_all_carry_inputs
+    # test_csum_no_carry_inputs: Test should be marked slow (runtime:
19.614096540s)
+    ok 3 test_csum_no_carry_inputs
     ok 4 test_ip_fast_csum
     ok 5 test_csum_ipv6_magic
-# checksum: pass:2 fail:3 skip:0 total:5
-# Totals: pass:2 fail:3 skip:0 total:5
-not ok 1 checksum
+# checksum: pass:5 fail:0 skip:0 total:5
+# Totals: pass:5 fail:0 skip:0 total:5
+ok 1 checksum

As we aim for correctness over performance:
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

However, given the big impact on performance, it would be great if
someone could find out what's wrong with the optimized version.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

