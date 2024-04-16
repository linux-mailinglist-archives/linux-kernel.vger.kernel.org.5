Return-Path: <linux-kernel+bounces-147530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0318A75CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2490C1C20DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2943147;
	Tue, 16 Apr 2024 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ssQW8vIR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995C3C467
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299979; cv=none; b=qPNxHaZwe/oUcrXMtbuZPSktbT5T/Uzu/rKRb+ps0A1M9bFnsFwJWZal1pZ+P1kCIX+lzgGw1ynh6dLYvd8sZnK7AI+/wCwnEYByMWEESZqgzxU7dOyeUsfdQt0ritCUme/3Z5+DZb52SLCL4mUQXKDZdizcTC4Q4RaVdTejGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299979; c=relaxed/simple;
	bh=83pdUfUUCdF5WrGmIF1GO0LUgsvG5H+wRIvNQRdgzmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/kzRgW0ciAUtnKkn6TaNdL2WDVN94lfK6K3CyKo2W2kx2/6gQ8MtUepmUm0i8e8NBG9hLKfmJRmT2RUrLbcfIB/Vubvr6JS7CoCdIMTIcV8EkvjJBVGwl03pBDwLDVskJt6VFi4Ut2txbUq4A8CfQSmpSdn2L0XE4LoCJPLdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ssQW8vIR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so1181025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713299977; x=1713904777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BMsxIpE4Z9nqdYgum8o4M/KssYPkdpnJdREANM4LfZ4=;
        b=ssQW8vIRunxIy7lC6PDn3XcfeNOontz5cjIBQxhwfMOIiH1ClJZPWOoyydgc0vxNJf
         rx5vNo4mCBe0krsS1Ozx7fbaCmsuGx3cGC+OOeX5+MFZQt7yySoua+CgnT4oBqcuEDro
         ANymcYwQU1aUDK/KYwxplgAPubazLqJzb+X81gD5pKDC4PPhlIDCMW4B4iiHFKhpBbFr
         f2hWm/IIVDl9XgWkcbE9t8WBy3xk4UM8YOUayX/SJqq1qsCFqdC0B/i3F4inL5V8beAM
         J/t2xIxOrpQx8jBd+1GPM/GdGwk8JJ/YzIfYPNrNlxtQKkiIlvBewbJSRJOdc6Q7YQmZ
         6o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713299977; x=1713904777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMsxIpE4Z9nqdYgum8o4M/KssYPkdpnJdREANM4LfZ4=;
        b=W+txmtwyrWHkIBOfS2zL4t7OemuMn3RenovGNmnP0vFE96Q/u0Aq6vW6ZMVElzEaMH
         UoVcOP2NmRZhOsVTevik/4LRwk2VWLYdW+HI5SnhwLF4DwhHssoCSMox8iuXoxRHdRKd
         VhjYgSZF9Q0tBSJx+Osd0LermQJoK4P0sxD9I10hbgY5i6JxG7eGFCzneogbha/fBjO8
         WOIrCeVOpSas4nCDnL80uOipb+9WZpDTlg9rueZ0KAh9nn8LeQJsonDhFsWvkZCwF7ac
         1sg16OTZpq1l/M1mGkrvqvpoo+KYdkFBKFHztkejdaqJBgGnbVqzCB0KNZKrq9+FbtZa
         QORQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH16//rzFu0enOZRMIgYTBihKU8xjmOyeHmRBqtbnqlzK3gwaPqevX/X8LCCNC6I/wNjPu7dRg8Wkfgg8KR3jERUPqIeS5HLKHfePY
X-Gm-Message-State: AOJu0YwPaTxGC9np9/Dg0R/EpyqPwYR5xBWh0nRZGpYA5bu2kxfhhAY0
	+IcxbJdZqxuUWeV4m5zv8AMwGOfjiKPUGHQu0IkCQ4LRalUsS1mmwgX5aWyAQp8=
X-Google-Smtp-Source: AGHT+IH1gf91D0Jx8EX2o/Z8Zgr/8lKTTJMrgChMy1jkDn9GpdgrT/0VA+/pYw0KTlvpLVreUrkRWg==
X-Received: by 2002:a17:902:e811:b0:1e4:6cd7:30b3 with SMTP id u17-20020a170902e81100b001e46cd730b3mr4087832plg.23.1713299976719;
        Tue, 16 Apr 2024 13:39:36 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709026e1600b001e2ba8605dfsm8797603plk.150.2024.04.16.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:39:36 -0700 (PDT)
Date: Tue, 16 Apr 2024 13:39:33 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 04/17] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
Message-ID: <Zh7iBRUybq1BAReT@ghost>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-4-c7d68c603268@rivosinc.com>
 <20240416-scorer-easeful-4dae3c18465d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-scorer-easeful-4dae3c18465d@spud>

On Tue, Apr 16, 2024 at 04:28:19PM +0100, Conor Dooley wrote:
> On Mon, Apr 15, 2024 at 09:12:01PM -0700, Charlie Jenkins wrote:
> > The D1/D1s SoCs support xtheadvector which should be included in the
> > devicetree. Also include vendorid for the cpu.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > index 64c3c2e6cbe0..4788bb50afa2 100644
> > --- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > +++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
> > @@ -27,7 +27,8 @@ cpu0: cpu@0 {
> >  			riscv,isa = "rv64imafdc";
> >  			riscv,isa-base = "rv64i";
> >  			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> > -					       "zifencei", "zihpm";
> > +					       "zifencei", "zihpm", "xtheadvector";
> 
> 
> > +			riscv,vendorid = <0x00000000 0x0000005b7>;
> 
> Isn't this effectively useless given there's only one CPU here?
> We also already know the vendor of the hart, because the compatible says
> it is a "thead,c906" so this doesn't provide any new information.

Yes, it was simply to provide an example of using this field to make it
easier for somebody who wants to use it in the future. I can remove it
if it's confusing.

- Charlie

> 
> >  			#cooling-cells = <2>;
> >  
> >  			cpu0_intc: interrupt-controller {
> > 
> > -- 
> > 2.44.0
> > 



