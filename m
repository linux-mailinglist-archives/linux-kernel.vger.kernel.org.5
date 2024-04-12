Return-Path: <linux-kernel+bounces-143118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C848A3488
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1D91C239F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DC14D29E;
	Fri, 12 Apr 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tYpMb8qB"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5614B08C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942007; cv=none; b=Sm671YY75I8B7ds2L1tSUVhGYnOdU4/GnsiTPWyp9wL22Lk8vIovw7dwsLKE3BZYcvT6aWwN+fFyxsPXUEE6cbv3ClutVvKYu3Th6AsfCGAd10Ponc2fNLqnAEUBdn1StPTcbvKl0NWhntfeI/jUtzUKQjdkYrAWFJsaxPZ3RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942007; c=relaxed/simple;
	bh=BOw65jefwZAEXrOKSe45kDD1W0vdEDtUimtMT6vNJrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCfIBHT/KMWgXvyexGeiFtlA1eAMb1tO4s7PsQCh9ZiWBWbsZolTxKA7FJmILBtFOENVbbwkxQSia6UBEhrdEcu0DpL8Xe0uiJ6d+kO46vPW2c5rJjgAXQgY5TAKltzPfGDFWV4GXZKeEpDQL5tdeu5aDAazIU0cI+WieJQCGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tYpMb8qB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dca1efad59so795124a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712942005; x=1713546805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Soc0+QXn5W8zbaSk+coOpUVEhCceV3S1TAiuN1SZpPU=;
        b=tYpMb8qBVok4tLcFx96La7WiJdNpXqqy20EUzS3YVi/NyVgxOpj8O4cOr5wIcc7e4M
         cVCqcGg1o7CH5XI7ZMCFlaDBEkuZsKwMcEaQCAOIPbBBQ6AacuVOZACWl3VeJ4LtMnOR
         QmSRuM64j+uwbON13W1VXMM50OCQhvs+dPGPppRCM/wR+rdbVSPv6LEaNvv0Sv5qk4tb
         uG4H1dtgJhf+Stx72hLtiP7cFO/WyYoNpTF/g3D856TcMk04UmsQjLETjVWeng1ashdx
         FSQQ15ncTLxh2Powx/M047b3+816bST/q1NZNdYJoFRLrKsI6SBGOJb4AcfXE7bNZG4o
         w9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712942005; x=1713546805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Soc0+QXn5W8zbaSk+coOpUVEhCceV3S1TAiuN1SZpPU=;
        b=uf1O9AuDWNJ093QvdqzHlmJAv2yKh8bhkxBAu/etO0DZGjsmdmL2rbbippttTNWEYz
         2tI1AlbjgH8crpC75mXkveUBmSdGxGSS2d2seDwCUKhgMuBPoqXzSrz1KvwcvHxwiLUG
         qctTW5eTHOenUsyWVQAL9KePxcTSor5xCqCgOdk9ZKHcvsw3Bre4+c9z3mN30chhVTj6
         ubRecy6Oxc1npJK876TGPZitWVGnWmW84MooTTJIf+8xIwLwSczU2tsgvOXJwwZ4ISbD
         4QUJNeEcvMgHht8EFQllc4sTeHB5UYLefb7QKTW+w/5D3D0Kz+DyIO68FNCw09MeFV09
         Oskw==
X-Forwarded-Encrypted: i=1; AJvYcCWx3RK/dk/wON2w5ldgGhOAoq/B77atZBnTBcjGIeO8zGChPcXtB5rrbibPYXK05sU6rPWXoTFUUxwKEhK0YnbDiAE4qYetNspwQxii
X-Gm-Message-State: AOJu0Yyx4bHBT2GWjohwLTg+feI2S63hsZVvQL4ONKxIUeAmJuX3sHsb
	CCoxuxwbEoQnyijPBKnTT5QQPC6nL7Ae56n9D5BRXzdmY/7kHChiIL2IQggJWw4=
X-Google-Smtp-Source: AGHT+IF776zoVnfiTTi5WIsaQ3v4fo6KtFc0W2tiXFHOJ67WtrOcZCtTV47KUhKhuAyowf9bIsmn8g==
X-Received: by 2002:a17:90b:1001:b0:2a2:775:9830 with SMTP id gm1-20020a17090b100100b002a207759830mr3316998pjb.11.1712942005487;
        Fri, 12 Apr 2024 10:13:25 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:121b:da6b:94f1:304])
        by smtp.gmail.com with ESMTPSA id ge21-20020a17090b0e1500b002a6e67e197dsm1458645pjb.45.2024.04.12.10.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:13:24 -0700 (PDT)
Date: Fri, 12 Apr 2024 10:13:22 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 03/19] dt-bindings: riscv: Add xtheadvector ISA extension
 description
Message-ID: <Zhlrsl7CKcl6cdSC@ghost>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
 <20240411-dev-charlie-support_thead_vector_6_9-v1-3-4af9815ec746@rivosinc.com>
 <20240412-ream-dwarf-8cdc3d0f279c@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-ream-dwarf-8cdc3d0f279c@wendy>

On Fri, Apr 12, 2024 at 11:27:23AM +0100, Conor Dooley wrote:
> On Thu, Apr 11, 2024 at 09:11:09PM -0700, Charlie Jenkins wrote:
> > The xtheadvector ISA extension is described on the T-Head extension spec
> > Github page [1].
> > 
> > [1] https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadvector.adoc
> 
> Link: <foo> [1]
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/devicetree/bindings/riscv/extensions.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > index 468c646247aa..3fd9dcf70662 100644
> > --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -477,6 +477,10 @@ properties:
> >              latency, as ratified in commit 56ed795 ("Update
> >              riscv-crypto-spec-vector.adoc") of riscv-crypto.
> >  
> > +        # vendor extensions, each extension sorted alphanumerically under the
> > +        # vendor they belong to. Vendors are sorted alphanumerically as well.
> > +
> > +        # Andes
> >          - const: xandespmu
> >            description:
> >              The Andes Technology performance monitor extension for counter overflow
> > @@ -484,5 +488,10 @@ properties:
> >              Registers in the AX45MP datasheet.
> >              https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> >  
> > +        # T-HEAD
> > +        - const: xtheadvector
> > +          description:
> > +            The T-HEAD specific 0.7.1 vector implementation.
> 
> This needs the link and a SHA or some other reference to the version
> of the document.

Okay will add, thank you.

- Charlie

> 
> Thanks,
> Conor.
> 
> > +
> >  additionalProperties: true
> >  ...
> > 
> > -- 
> > 2.44.0
> > 



