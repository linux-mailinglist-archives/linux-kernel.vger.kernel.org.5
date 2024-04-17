Return-Path: <linux-kernel+bounces-149294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E998A8EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03070281B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C481748;
	Wed, 17 Apr 2024 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ypiMJC8h"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2E828DB3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394291; cv=none; b=ZZxRYH7iHFBKB2XWmxRfsSdDfjLX2QrxwkFLr5wqgZtAEj25FOFcZTlHz5yN2mW04RbJ7qHuV0diINcccCbjSCnPNnmTwfpDudiNm0aXg9mJG5jxTvjKNBeaMX0v5tFgPGMcQaN74QahPkrmtJ/d8IhdrTzpqz7bgMR+zFHAwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394291; c=relaxed/simple;
	bh=ABLnPb+FzE7ddsHXVQyfOs5AvG3SKdeaNiBYdaJWL7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAEin0A8oCaGVEqiXIu4kSxzg0/fQaTyqbtg8X/CG3Sjp+sbVZEHDuOxpth/spptuU3bcv6xDBPu5o5Zu9ANWCEkgB85ZqfjP1rFMnq6P3JVnyTT4xaX5AnVQKqBmA52zmgGgaM8gMQd+wewrDvznt2dyGjWhGk9qBZIaqSOuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ypiMJC8h; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e86d56b3bcso2509215ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713394288; x=1713999088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTSo6mWPNg3MYfgUA4f7wbCrE3rgzEA/5uO9sngH9Ec=;
        b=ypiMJC8htz0SzV77OnH1hGDY07FCkm1Cn/l8moaxQghn1omkNBLjqd3M8WFbsgX7Fd
         luCccF6roizrWvBweEw0T2xvDggtFz3bJrKFgjeVgPC6UTMxNRWLAuPw/KJll1x+X+C1
         T7ToNcG1nIvST2X45TtQE7v+H82C6JEGRkkTMXkXakwiHBP/NnL0ql7mkS+zzPYU/+VS
         X5Fez+X+kkUAEPBE236UjvylCZWD9i+eQIwRXcjCrFGZd7ihl/SvubSuLWIIhPgIi48+
         lkYMVXNCqpdhoc7ufwIZxqvBy9zpftGZZplyNY1GIL3XyVEPPsv6W5n0h1MJJODWQboV
         erWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713394288; x=1713999088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTSo6mWPNg3MYfgUA4f7wbCrE3rgzEA/5uO9sngH9Ec=;
        b=ln27fSFtx3PzwRTFmxg2N1kG7eyhsrshbqsMGtmZxKnMM+EmjsiP+unMI4w6G9qQUd
         8tDcoUC3ap0ajxN3wbvNxWGw99Tbzo7Ea6l3ipjpp1udGhfg+9J6mSrwVjHrdJIRb21H
         S3ij/J/ooTKc6YcrHiRaSLySU5+tEn4OC9FZXEUb8SRM94rfM7zXm+Vc1tUrpS+0f9nZ
         4TCV22yiAGxHbMuBE11ann9zqbmLOhuQXmM2J1IY6dBCt1ZH6p8plyGxr+akbfbFCsMw
         BLQtYiuWQFxCyXNb/ntkLVFr4Gf5C8CNtEvpEOXQUK66geDM+HmhVoZbTBdMBHpMg4eN
         8w1g==
X-Forwarded-Encrypted: i=1; AJvYcCVCxjtHWfILApOhrRj/68dbhSgGs+vW4VaYNE3l/aCWu1uXJIdOWPCDJld0p0c8gsz6K+vjuSVxpYcHfzbe99Gwg4Rupl22sMZRU/C5
X-Gm-Message-State: AOJu0Yx6B3lMWzX90+GvAyulMvGI/XpevhJKGMz16uFAphx6wcL3md2l
	DeE6uvY/YmMsDkKOTWCO/W83htpp8Zmr2+pvsi01BmdTdqoPJDXqAJppH17fXng=
X-Google-Smtp-Source: AGHT+IHrFjHxUYakHuwCu0KxAXJxMjlVzPR4wDunk8LV/EImWNwQf6hbQbYi/IvWQK0xsqjlBoez7Q==
X-Received: by 2002:a17:902:76c9:b0:1e5:3d8a:75fd with SMTP id j9-20020a17090276c900b001e53d8a75fdmr859944plt.69.1713394288489;
        Wed, 17 Apr 2024 15:51:28 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001e45572a253sm172327plb.14.2024.04.17.15.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 15:51:27 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:51:24 -0700
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
Subject: Re: [PATCH v2 02/17] dt-bindings: riscv: Add xtheadvector ISA
 extension description
Message-ID: <ZiBSbETx++uIIknH@ghost>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
 <20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com>
 <20240416-underwire-bright-b2ab0fa991ec@spud>
 <Zh7i2pir0j6tXfPD@ghost>
 <20240416-budget-cause-c4002a9cc05b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-budget-cause-c4002a9cc05b@spud>

On Tue, Apr 16, 2024 at 10:10:39PM +0100, Conor Dooley wrote:
> On Tue, Apr 16, 2024 at 01:43:06PM -0700, Charlie Jenkins wrote:
> > On Tue, Apr 16, 2024 at 04:16:30PM +0100, Conor Dooley wrote:
> > > On Mon, Apr 15, 2024 at 09:11:59PM -0700, Charlie Jenkins wrote:
> > > > The xtheadvector ISA extension is described on the T-Head extension spec
> > > > Github page [1] at commit 95358cb2cca9.
> > > > 
> > > > Link: https://github.com/T-head-Semi/thead-extension-spec/blob/95358cb2cca9489361c61d3
> > > > 35e03d3134b14133f/xtheadvector.adoc [1]
> > > 
> > > This should not be wrapped btw.
> > > Otherwise,
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > 
> > I don't believe it is wrapped? It appears wrapped in your response but
> > it appears on lore correctly:
> > 
> > https://lore.kernel.org/lkml/20240415-dev-charlie-support_thead_vector_6_9-v2-2-c7d68c603268@rivosinc.com/
> 
> IDK man, looks wrapped on lore too. The other copy of the same link
> isn't wrapped & I've never had mutt wrap stuff like this before.

Oops, I was looking at the second one and not the one in the commit message...

Thanks.

- Charlie



