Return-Path: <linux-kernel+bounces-157739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B920F8B153B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE761C2243D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37613156F5E;
	Wed, 24 Apr 2024 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eGzdI0Bq"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C256156F25
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994708; cv=none; b=mCXBSvZ59RVdRjoqgTnkYlYknbdekYEaU7vYLk3r7xAjbdmmCqQK8kmymYNLSyXTFUJ8MHEW43jOQiHbtCjEm44fkSjBucFYB8ZGYr2Ul6RY1ePFNeVqktoclxK2KhTY3PnoYtMem9kQl00NMCA1qwujgjH0haY/q6yCkQhXM9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994708; c=relaxed/simple;
	bh=7c5t4kP0JlufT7hNb2boqOwbDbZoAEUVhrSORP9aXFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1io8hlJRX4Rnw4z38/fpAwi9E8MRRLSX5tDsAWnpiEwjqJXPvo0Q0oyjqhFmIRqfe3en7fvjiMxOSu3+Y8892EJvEM3i2ZydrpN68o28pZYtsjnEr7Anj7SulZ9pMUEcWntm83CSZPWUzc8Shf15uwlyO4d7EFWL2om3hlYMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eGzdI0Bq; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb77e56b20so231898a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713994706; x=1714599506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mCSAAudt8oKZ7AoxbtS66uOuESn00+WtuUOSOogqNgQ=;
        b=eGzdI0BqsoY8y8i1HMStYdMdbayEPVPPKoFS9j9mrTxKiXDYpUz2piBR+dY2VPYOTV
         QbXa/XhzVHQ9811WzSG+s6o7on7LC6Bh74R9mIIfcmokdc8rYZxVZqV7/VLgC1gCZN34
         WRyqZFOISvjRDJoQEYOmUdmHT7SD+Q8m58DkTapmwZBAjOZdwR1NE1QXmtsNnvbRq9qB
         FS4I1e3VIOPWGYEDNMYz3z6LQlsGGbndiyTiWDtAINuXZmc9Igp2QM314UgF7+5bEIps
         VkHLTqM/FAiKLJerufwpKc8N+lZODUkfkUal6ahZgoedwKB3b1HlIkDL9gffdfCvk3Dh
         ExQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994706; x=1714599506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCSAAudt8oKZ7AoxbtS66uOuESn00+WtuUOSOogqNgQ=;
        b=qjhjVMic+TVzqCuQyQfZPfbYiFB13S6ujD0I6F3qql7wAYfYsyg71XESpl+xWcRBUh
         /zSPDcs0x76iKGnPELpX/ffhFuutochFCl+z9xkoCRDIT69adkKck2d2L86AqkRwoYIC
         rDx0T9j8Z/I0+GOAuwNIPBukkIxSNTRWQdHq43hhsQru4TK2vnYHi3t9WwAI4mwrBc9e
         UxtJ3T9mUMCP2IOBWX0Enl6wkcrpprNBI4jPwowZrRqi09Vz/OVBPCyb9J0RvomnP43G
         iYzsOJu7dgbdx00xIw2799cHsYXl3p3CPT56uEAAOYgIUKOzQVFNoD30uBQjzOso8jC9
         9Fjw==
X-Forwarded-Encrypted: i=1; AJvYcCVbR1sWPKHZe8KpDHH3xK/cherSmP2jsMRf5BVxBB7VAKsQhSUuXj2PT8UMokH7E2D1oqnGPF4xv/WZ6R/pE1hbnxnQ4cVXt8TpwFbz
X-Gm-Message-State: AOJu0Yw4dYpxiYlPCNAfMtTWDvQjfjUZwawYuAnSLUu3BrW9cqQTeP/U
	1bAPaPWq1qBH6vEcAsj4kiYklIA8lpmwnjIRWR6siD2Y3WwbBI8VwmOnLiIpthI=
X-Google-Smtp-Source: AGHT+IHZ/YT25pef4JHoXBaJ+6FQRYLNP+/n2pVh1usBYPwTHcqVXj7WcdcTLvAD0fmz1HD+0VXiqg==
X-Received: by 2002:a05:6830:148a:b0:6eb:8d07:606f with SMTP id s10-20020a056830148a00b006eb8d07606fmr4812912otq.8.1713994706315;
        Wed, 24 Apr 2024 14:38:26 -0700 (PDT)
Received: from vedvyas-XPS-13-9310 ([72.177.88.222])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm2499204otj.17.2024.04.24.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:38:26 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:38:23 -0500
From: Ved Shanbhogue <ved@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/7] dt-bindings: riscv: add Ssdbltrp ISA extension
 description
Message-ID: <20240424213823.GA1889117@vedvyas-XPS-13-9310>
References: <20240418142701.1493091-1-cleger@rivosinc.com>
 <20240418142701.1493091-3-cleger@rivosinc.com>
 <20240423-poser-splashed-56ab5340af48@spud>
 <e39f2fea-868a-4a79-b7a5-bef8f15de688@rivosinc.com>
 <20240424-rehydrate-sloppy-62132c72fe18@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240424-rehydrate-sloppy-62132c72fe18@spud>

Conor Dooley wrote:
>Usually I'd just not ack the RFC patches, but I do at least check how
>far they might be from frozen before I move on, The jira for this one
>says "Actual ARC Freeze Approval:	18/Apr/24", which made me think
>a freeze was gonna happen soon.

Yes, should happen soon - expected by 5/4. 

regards
ved

