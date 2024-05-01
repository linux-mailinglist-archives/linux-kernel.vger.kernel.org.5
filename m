Return-Path: <linux-kernel+bounces-165670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B158B8F4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C60A2833EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C051474A7;
	Wed,  1 May 2024 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MADNhq7u"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7F748D
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586298; cv=none; b=TxHSbQ/MLABqw4j8XcB3tUOTzov6lJbxYfDQNo1Cf3EVNR5LXOAu0/eBfmg4vMDu8mHrtoCy79FzEkKBz+EcZGGGL4rxL61OWji45CQX6KdSK2ghyJti+uM/z3S+vYnzMoRqme2hoWaYTSkGahW7GhdSDNsPP/unGgnD6QkiD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586298; c=relaxed/simple;
	bh=aEhywgK1Wn89FaWrhTM0HBEIeT3AwLow+BB6CKrQbCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVUAYA/O9VE65Uah/Pd4yUtvfNWnEJqFmDjoFdizQysLbNeVIX0URQo5kFOC6vbfbRWO8BWYQsVe2la0Ukk4djb0m515epqbTQF6Kan+yG4Q5fs3n4apSz/AB/DFasn3FaciUVvYGQw9HM3gXG8ZmZTE4qL75L2Yuen0cuaW0MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MADNhq7u; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so6640626b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714586296; x=1715191096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewiZxKEDhipFv9WpDKT1OvAInIM8Qy/YnJeIqtYAQ20=;
        b=MADNhq7uxAPe3Mo8Oc0YkZUpGYLzdPHDbZPF0TfE7xGFeexml65gBIKfVcJjORoU4p
         8O2TNe1B5m4MNfZTfj+Jy6ZYBlydcqSy0FA+cL8RCeMe1EZUB5H0fGYWvfKLPqhnceYM
         /STiwv/l0HTWBmNoRId3ivMlkEmVYGxSFFXtgDeihan/5IjX4PDFc5CQ9/l2L48tmBHY
         G0sEDO+kJVE5Cu0ebMu7fBOv/6pkqCMks7+RjYjChg2plhaV3zFSFXoOKua0AccgcuOr
         ksfy5Av2m/c0UzdUxMDccwhWVBHydx6XU72bR1NAkHa5LLp9ZZVJrsYwCB7irWAW+JPp
         9vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714586296; x=1715191096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewiZxKEDhipFv9WpDKT1OvAInIM8Qy/YnJeIqtYAQ20=;
        b=uwlXHvDhorL/ylSPsk+ekTi0rukGJrYZAyk0bIA+Z8Su9QYWNYvmvE7IU6tvkxKN1X
         bJVm3+LsAadWUtjlsPDIlT92rnFJY9pq5SjvXZDhYfU8LpzmxdQvk9rcfRDvYMrKOw66
         l07YPzJDJpQjzjs1zUMnwfW8nzK1TwUOqv+j8axRfsgsGQ6RP4RP10L9wtatp9Z8WLql
         gYBvZHF3G/uJ+rYhOB4qr8c+UhDSLmBpG+3ToGUh7fjp/zOdS7xmoh06FCXGT/Bylp6h
         jPibaZmsSIzCwolao7qYkyzE/jdVLvSuhrj7zLrk/7cPqD/1QlVTPmzEC5gurP9CFwQr
         TsBw==
X-Forwarded-Encrypted: i=1; AJvYcCUK3MwfYOeL8l5v1BIWqDIHmBmy3ctcEjJ1eup64/SqAWdrN2jY86kV/QwhmppIJE9Py+jIsgg7vsvB/aXLCTK322EKByXZjGVq1Deo
X-Gm-Message-State: AOJu0Yzb+RuGEyMQEqplcBBRZkXjPauQgy9j3c+AQRnVK4oaTaAZGxtQ
	7sHDhrIiw5FJXvaVLBi9lAkXrJ/kp6c/zrs1zzlQ05S67nrm6dyhU3VxZnhyy3w=
X-Google-Smtp-Source: AGHT+IHowJBwbgP8/Vm7zaF9odAFfRxagmDXAI/fLRPFmpGJdmGG+eEAuwcNKsDXaL6jhqUEVkKVOQ==
X-Received: by 2002:a05:6a00:1305:b0:6e8:f57d:f1ec with SMTP id j5-20020a056a00130500b006e8f57df1ecmr4107317pfu.17.1714586296277;
        Wed, 01 May 2024 10:58:16 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:1dcc:e03e:dc61:895d])
        by smtp.gmail.com with ESMTPSA id o7-20020a056a001b4700b006edcbbff2b0sm22940382pfv.199.2024.05.01.10.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:58:15 -0700 (PDT)
Date: Wed, 1 May 2024 10:58:12 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Conor Dooley <conor@kernel.org>
Cc: Evan Green <evan@rivosinc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 05/16] riscv: Extend cpufeature.c to detect vendor
 extensions
Message-ID: <ZjKCtJWqoiLM3xZv@ghost>
References: <20240426-dev-charlie-support_thead_vector_6_9-v4-0-b692f3c516ec@rivosinc.com>
 <20240426-dev-charlie-support_thead_vector_6_9-v4-5-b692f3c516ec@rivosinc.com>
 <CALs-HstM64Hy_=XVz=0sWQt=8j1u+bq6RhthUuD3P0E4=HyvcA@mail.gmail.com>
 <20240501-flagstone-zealous-2fc722bfad39@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501-flagstone-zealous-2fc722bfad39@spud>

On Wed, May 01, 2024 at 06:19:34PM +0100, Conor Dooley wrote:
> On Wed, May 01, 2024 at 09:44:15AM -0700, Evan Green wrote:
> > On Fri, Apr 26, 2024 at 2:29 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> 
> > > +struct riscv_isa_vendor_ext_data_list {
> > > +       const struct riscv_isa_ext_data *ext_data;
> > > +       struct riscv_isainfo *per_hart_vendor_bitmap;
> > > +       unsigned long *vendor_bitmap;
> > 
> > It took a lot of digging for me to understand this was the set of
> > vendor extensions supported on all harts. Can we add that to the name,
> > maybe something like isa_bitmap_all_harts? (I wonder if we could drop
> > the vendor part of the name since we already know we're in a
> > vendor_ext_data_list structure).
> 
> Reading this made me wonder, why is the all-hart bitmap an unsigned long
> when the per hart one is a riscv_isainfo struct?

Hmm I don't think there is a good reason for that. I believe this can
become struct riscv_isainfo * with no issues.

- Charlie


