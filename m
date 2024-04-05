Return-Path: <linux-kernel+bounces-133304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9D89A207
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869DBB24B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8E5171083;
	Fri,  5 Apr 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CdTjE8AR"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA416FF4A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332788; cv=none; b=ZjIbc/KHL3FeNERGyPFBAflbatd940pzTektcaD4zS1ppaT3GLbbBaFZNrnYfGkpEhinpa/TsMaD/WGG+947LWRMex/lTcCxNXXIH9dB7WNClHsBuT4E8vMJ0YmtQXH8RzlojlfW+HbNnTG5EU6tcI2fLI6bfs7E87mZsJOv03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332788; c=relaxed/simple;
	bh=6WysufP42FX2Az3Xx8MgB1cNuc1CYX+XUTX4q5FvCN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWhpYVrLjkE2ydS5aYV0W9Y5QD7ClIxTcJMuPLBOSBGjHznXf2rM8js6Brn/o9odIk8Xu80bFjqygj97r+AU5yYPhsgjV/2wBdYWakYtlFT172ZKTM0/nCX2RmieyOMmY1nPTzB/mkF4nzKnsB2c6esEYfEccd7NZmH75DcRnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=CdTjE8AR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415584360c0so18545045e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712332783; x=1712937583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/+tn7yaOy1bWCod1Hwz4ffQkyy0MXOXzF4xEGdBkSM=;
        b=CdTjE8ARyIrDoCIL7WSqdKga/mX+JFEK79Pi4jCyaf58yf9SvW7NkQNcfHqbHp4W5r
         QPbw7HCfvDOKgZ5bR1EmCP3Nfn1Tn40R+eOWRXyXyahTFxDWNNlptlLkTJ9rLzKeQCA7
         HnZW0wWacuyTjqy85ar0AkWeZCOIasnLZlW3/AftFoGtEa6MUUPVHpms2GrWdvXOAkx1
         nFLnZ2IonAAOcX4LlKDVyfCWj/tVwHuULEz4NbH3X6bYscW3VUaUzsysVqgcSqUreJGs
         sWXp9dkTrCwWkSLVGBjjLlEbNfT7exPe5e2MDN3Ll4xaFqU4eMITnytPqpuqQRbTpky0
         Qw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332783; x=1712937583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/+tn7yaOy1bWCod1Hwz4ffQkyy0MXOXzF4xEGdBkSM=;
        b=aWEmkjHeEqLhRqWZ9vWgfZf3PqfWYq+nJN0Dd81TERV4r6jNCoT7N9tngX3VhaQMWT
         +rpF8VTwVR6D9zj0ct/CXf6EYrf3WtXgl5b3hj+8qxgMIm9gW0LCZBXY3rs7IBgXzYiw
         K3i/xzOnypaWmNHo7j4rv0MOSlqi/ubjALrz+vOGqMsr1ZgD5qtSBqgc2iQBWIjYHmis
         TNqdy9OTSN0oxjejHbYAvMvrrPx0zF5ZXNDgXroNVsCQZy7NyqSOrtKwCbo8uyrY4iue
         2SpeqDOi/IlkeSt2yIw3tTIrqfpH9eWRYG54/abQ1As8r6PCjEJaPhUh7Wyd9zDqThbs
         WT5w==
X-Forwarded-Encrypted: i=1; AJvYcCVtG651KS35VHBqQzYUT/5wUgr346Q1RTjvmbsePEEuLJs4rYxmQMfxegdiCCrYBAJsIU4emFq8FWptk7WlUvC4vjsi+9KLsP3PmUiE
X-Gm-Message-State: AOJu0YxPbtOQVZ9Mn1qRQSxs09dZJQkd2rdnb9rzhzIymCB/y2Z6Z2Dd
	tjeSSgT1sFKon3vg12ugwhV27Zks7Pxc+sC47D1qiR+qH2Yle6QQ4VxFgzE1g7E=
X-Google-Smtp-Source: AGHT+IHm5FdCsOG2D2FwTVsRXO+4kOPqszWyczb81zB17ksFNLVDMEKpcib6RWK3ysnM3lM9cg2ZBw==
X-Received: by 2002:a05:600c:3107:b0:414:7909:6680 with SMTP id g7-20020a05600c310700b0041479096680mr1487874wmo.16.1712332783307;
        Fri, 05 Apr 2024 08:59:43 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0041632171f51sm1770044wmq.13.2024.04.05.08.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:59:42 -0700 (PDT)
Date: Fri, 5 Apr 2024 17:59:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Max Hsu <max.hsu@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atishp@atishpatra.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] dt-bindings: riscv: Add Sdtrig optional CSRs
 existence on DT
Message-ID: <20240405-ebdb2943657ab08d2d563c03@orel>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
 <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>
 <20240329-affidavit-anatomist-1118a12c3e60@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-affidavit-anatomist-1118a12c3e60@wendy>

On Fri, Mar 29, 2024 at 10:31:10AM +0000, Conor Dooley wrote:
> On Fri, Mar 29, 2024 at 05:26:18PM +0800, Max Hsu wrote:
> > The mcontext/hcontext/scontext CSRs are optional in the Sdtrig extension,
> > to prevent RW operations to the missing CSRs, which will cause
> > illegal instructions.
> > 
> > As a solution, we have proposed the dt format for these CSRs.
> 
> As I mentioned in your other patch, I amn't sure what the actual value
> is in being told about "sdtrig" itself if so many of the CSRs are
> optional. I think we should define pseudo extensions that represent
> usable subsets that are allowed by riscv,isa-extensions, such as
> those you describe here: sdtrig + mcontext, sdtrig + scontext and
> sdtrig + hcontext. Probably also for strig + mscontext. What
> additional value does having a debug child node give us that makes
> it worth having over something like the above?

Yeah, Sdtrig, which doesn't tell you what you get, isn't nice at all.
I wonder if we can start with requiring Sdtrig to be accompanied by
Ssstrict in order to enable the context CSRs, i.e.

 Sdtrig          - support without optional CSRs
 Sdtrig+Ssstrict - probe for optional CSRs, support what's found

If there are platforms with Sdtrig and optional CSRs, but not Ssstrict,
then maybe the optional CSRs can be detected in some vendor-specific way,
where the decision as to whether or not that vendor-specific way is
acceptable is handled case-by-case.

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Max Hsu <max.hsu@sifive.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > index d87dd50f1a4b..c713a48c5025 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -137,6 +137,24 @@ properties:
> >        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >        in the system.
> >  
> > +  debug:
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        const: riscv,debug-v1.0.0
> > +      trigger-module:
> > +        type: object
> > +        description: |
> > +          An indication set of optional CSR existence from
> > +          riscv-debug-spec Sdtrig extension
> > +        properties:
> > +          mcontext-present:
> > +            type: boolean
> > +          hcontext-present:
> > +            type: boolean
> > +          scontext-present:
> > +            type: boolean
> > +
> >  anyOf:
> >    - required:
> >        - riscv,isa
> > 
> > -- 
> > 2.43.2
> > 



> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv


