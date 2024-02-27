Return-Path: <linux-kernel+bounces-83052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12939868DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4AB28675
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34E913A250;
	Tue, 27 Feb 2024 10:38:35 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CCF9D6;
	Tue, 27 Feb 2024 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030315; cv=none; b=UKT3ISO4GnE5pNFNhn95Qk7iVdQuJUr4uOL557KXfaQDO/sj9GL8SKrE309/2nKPXiXhM5Yts8HM1ZR03JnH/aIO+DioN1Q/AQNdetEaPWaqhyPS3cfqPTZEooidWTLEMhXrqkmQcvjxtfy6Stpjc7hVhtQ6tpO7bWb4O8CNeZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030315; c=relaxed/simple;
	bh=VKeI3ESIRwCObZdyZEhBLyqspU4s24P6Gj9IetSfbBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtCOln6IcTPI9Zs3NRkKoRCToIu95R3wX4u5b3Y8xbo7zw+BoRTwgI+Hv0z2g8cPgnr90QCXUAA2aDgMbTM+JCp85fclhRWllySRxuRITOJyvu8LTfTnpTKkjzWpSFQMzOqrtwgifKqc+J1yMIZyy3wqiZhe/vOxixbdDkfo6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608342633b8so37370277b3.1;
        Tue, 27 Feb 2024 02:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709030311; x=1709635111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cleTC/BMG3GM/DYSkVkxg9xk1wjwdvoTgmxdT3NQoWo=;
        b=W9DakqwgMRV3nB/pj5Q8Lmaqf8d+UsQVacViPLlJMQi8Ojj7E4jLWfXwl6nZV8TEWv
         U78y8SaUcpiDR9mnmHg+/aPgAYi9Mkk2WgjyEjjDULhMJnAxgO5R40+11klsL/eDwSby
         SdV6xCWWq75uMVMQyVggeV8/aYNIMRSCeDkMYKZ97hvrBnwEv8jiMDs2RqHbkXGDOJ5c
         b2mUsb6irKuI+PwrgNje6q3MBgggVJmVHl8nsAl8RsE9R9O73tkUmstnZX/+ra6jGXhQ
         Mjtc7CfHeG6Hz/7HfbkcijNDoJIJfF8rcmTUIztRi2sTozGNxn+Ygav4KBTYEh/cBSh2
         pOpw==
X-Forwarded-Encrypted: i=1; AJvYcCXwvwBeUy+IltIFd3qFixaj3BmQSyuupz6pP1mWJGsBMPY/+nuWuJyVdLXEMBTOxlF0KcmyUEMTy3JHaDnE2UwzXfGKBU23zs278JrELFMvZRF7HYSnRnces7yIjr2q+tlYniMjq0dr7D6U+F3ytfzSwzhC42WVuiRkoS48HHhnFkB3K7pRr+Z0MHBi
X-Gm-Message-State: AOJu0Yy0P9ewHtY61aQsvDQctgeEGwYfbbD8taEOXgkd3u6pRtdTnJvq
	suZ+6vAufqGSl+OG2wUOFfeGt/cWkNs1UCgif2NjddXBPw7lkff6xWrkL72/0SY=
X-Google-Smtp-Source: AGHT+IG6Spm/b+arOrLfmf8dg1Ns182tBav3LBNPrsO1HTSRGPP4LHRs1M0SBYuqBvjQCtxmDbo1kw==
X-Received: by 2002:a81:ca4d:0:b0:608:e02c:e3d9 with SMTP id y13-20020a81ca4d000000b00608e02ce3d9mr1866094ywk.8.1709030311176;
        Tue, 27 Feb 2024 02:38:31 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id u64-20020a818443000000b006091cafab5dsm585932ywf.25.2024.02.27.02.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 02:38:30 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-608959cfcbfso42498017b3.3;
        Tue, 27 Feb 2024 02:38:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRvWeShT6uBS1+Qy2vApHFPImNUAW5E1+x8u9P5wY+GC0RB6Y9OgcOjfJRp7PCSeUPxW3D8F3SJfp+htdNSKDcQ5yxbsveMBZd9qwS1z8RSm1SBZZW88qcictrI5AKyO1834SErjpSawjgrNxzN9J4JCMMebFYvOzVdtDVruP1zDnqRi5Ol5QXaZm/
X-Received: by 2002:a25:bb41:0:b0:dcd:1b8f:e6d3 with SMTP id
 b1-20020a25bb41000000b00dcd1b8fe6d3mr1801332ybk.48.1709030310016; Tue, 27 Feb
 2024 02:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-2-aford173@gmail.com>
 <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com> <CAMuHMdViTAxWk8uvT-tgD4X2MJW5R3R1aqrv1K=FyQLdAciFcg@mail.gmail.com>
In-Reply-To: <CAMuHMdViTAxWk8uvT-tgD4X2MJW5R3R1aqrv1K=FyQLdAciFcg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 11:38:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLfyqJdvoquqqUBakA8Cm3NX2gSNCLSE=KwaiLQJDskQ@mail.gmail.com>
Message-ID: <CAMuHMdVLfyqJdvoquqqUBakA8Cm3NX2gSNCLSE=KwaiLQJDskQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: gpu: powervr-rogue: Add PowerVR support
 for some Renesas GPUs
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:09=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Feb 27, 2024 at 8:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> =
wrote:
> > > Update the binding to add support for various Renesas SoC's with Powe=
rVR
> > > Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so =
update
> > > the table to indicate such like what was done for the ti,am62-gpu.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> > > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
>
> > > +          - renesas,r8a77951-gpu
> >
> >     ... # PowerVR Series 6XT GX6650 on R-Car H3 ES2.0+
>
> All compatible values for R-Car H3 variants use the r8a7795 "base" value,
> so that should be:
>
>      - renesas,r8a7795-gpu # PowerVR Series 6XT GX6650 on R-Car H3

Same for R-Car M3-W, so

  - renesas,r8a77960-gpu # PowerVR Series 6XT GX6250 on R-Car M3-W

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

