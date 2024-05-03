Return-Path: <linux-kernel+bounces-168145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8358BB443
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5231F21D8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56F524BE;
	Fri,  3 May 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO70nfrz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555DC13957E;
	Fri,  3 May 2024 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765156; cv=none; b=F9ZEUBDna5K78mJiNJaLg3/ObXWNr729rPVkt+SJLBM0BMRFaHp5avgoS2teEglVT3J4q4aiRSyzaJrRr08+aphbfGzHAe7k9qMUcJ80W4f2P/bi6vFRoy1WSppqWDyHTkkbFR6MmG22EbcAFY4qjmJxphAwGaemh5kekUJTbQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765156; c=relaxed/simple;
	bh=kz5QM7ohZQWoGwCDRooPeCesA7DdX2T5IDw4jkGpQpY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O72yJGPOYIMS3QUa0RrM94wO0SeLofdCEUJ/eSw5tJ+sdests0iqZgUxsQ+mfzaiNzpWTZvmUf1s5lFs0Xjj8690xLwR5SWCjt7H6tFoumuR1WZu/tgbKVnvVEuhEXcDIhnX9aaG/RkDA7lTUd6oCuYG6AGHJPUx5EHHw4wnG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO70nfrz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34dc129accaso20734f8f.0;
        Fri, 03 May 2024 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714765153; x=1715369953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=esCvH2EjpXiL6Ux6iq1p6xHlRACpAYrTng9Vg9T+Qac=;
        b=MO70nfrzSeH3mhjfPEZ+v9FtK1EKRJC9vErHISZUcJj37KPwFObDOxVlFG4kT2mRQp
         rQ5CK7FicE1mQMmGQubV8w4T+P/1V5y7k9iexZ+otfmqahre2pQ1pfsziviI6fkiaZn4
         jBtx3J+zg3XJ0K8XSEro6E71mOjGby7WR+F2s2g5Rw0i/U0MDw0X4G7tDvxYy5X8G1NQ
         XIW7gKYbGo83WUSWqX7h5cmK0p3zRT6G1NPfY7D/JKy9l/aAZ4pleLGpbquvV6jJCQIv
         NWdVL+KqhRr3pPqBEiAgExj8PSP5RQpBUBF/yNdzvqu1qZQ+M7DPQs6AMwUWojSor5yK
         tLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765153; x=1715369953;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esCvH2EjpXiL6Ux6iq1p6xHlRACpAYrTng9Vg9T+Qac=;
        b=oYAPzZUjhxAjwMiAO106WhE2YogCc6Ep02TY/Tc0zw/Y+0cFEMcDIC8KVA/azYMgQY
         3ZuFAoFoIBkILOc+CWBz72SREijaGfZVGqwjmiXwj7+TvZ3OlFQJ0QAeyjJJl8cALyxq
         OG9go2qPUbCs8FTgbtnAzF00mtRL1phs+aahy43UTWk7PpjrSOCdOiRrNdkDiwZQIuk9
         Xx0TCIDtTxK4Ia/ejZiuhfiiGG2tT2ysHYoDHCD910h//InJsuyDZmH3d/QFYptAlsTW
         tmpwzq0kHkCfI63LzFgjHkWol6FWnIlXSXzexDHHZ3G3ShDyVMKwY50Z6Qj0AMhhXt8W
         5IKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpL2rN/TfQbAdKFj5Z759hl67LFFqwoRHGtSPAvOAEtztDpb5lfKZuVWhh5AgLL9qy+3R6In9hYCkPaJnecbSqztyShOd7BvVbTBidqRMZh8PsdLej71fOgr8mcEWI6PuEuB7TUY2XXZjDFPWWskng4rnJZ4BtWHvcC6qrSgELT/ebMiU=
X-Gm-Message-State: AOJu0YzITfPmc6C8lJAwG/uw0FQnBxwIPgpM+4sTF0ze+zGi+rnh4zYW
	/jZOtbc7ewiC5XETvIvtM5+s+aJfdwVm359/uWx22o0kw5HclHc4
X-Google-Smtp-Source: AGHT+IGRKX7RVrz6tr7a2J9+jiwbag+JzHZOc7DcycenKbBraedG+n0aNPGpDk70qyrmKVKPUEvmnA==
X-Received: by 2002:a5d:5102:0:b0:34d:9639:79bc with SMTP id s2-20020a5d5102000000b0034d963979bcmr2775337wrt.44.1714765153275;
        Fri, 03 May 2024 12:39:13 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c4e9400b0041b5500e438sm6705944wmq.23.2024.05.03.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:39:12 -0700 (PDT)
Message-ID: <66353d60.050a0220.df862.761f@mx.google.com>
X-Google-Original-Message-ID: <ZjU9X81oysF7XRcB@Ansuel-XPS.>
Date: Fri, 3 May 2024 21:39:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
	linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Subject: Re: [PATCH 6/6] bmips: dma: drop redundant boot_cpu_type in
 arch_dma_sync
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-7-ansuelsmth@gmail.com>
 <4821338d-bae1-418e-b4a8-6218f62d74dd@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4821338d-bae1-418e-b4a8-6218f62d74dd@broadcom.com>

On Fri, May 03, 2024 at 12:07:45PM -0700, Florian Fainelli wrote:
> On 5/3/24 06:54, Christian Marangi wrote:
> > Drop redundant boot_cpu_type in arch_sync_dma_for_cpu_all. These needs
> > to be parsed only once and we can make use of bmips_rac_flush_disable to
> > disable RAC flush on unsupported CPU.
> > 
> > Set this value in bmips_cpu_setup for unsupported CPU to skip this
> > redundant check every time DMA needs to be synced.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> You are taking a shortcut that is reasonable in premise, but keying off the
> bmips_rac_flush_disable is IMHO misleading. The RAC is enabled in the
> BMIPS5000 and BMIPS5200 cores, just it does not need SW management unlike
> earlier cores.
> 
> If you renamed it to bmips_rac_flush_needed that might be more compelling.
> Also, the other reason is that on a kernel that was configured for
> supporting only BMIPS5000 and BMIPS5200 CPUs, I think we could get some
> decent dead code elimination of the boot_cpu_type() check, which would not
> be the case.

I was a bit confused by the last part, should I drop this or just rename
the variable? Cause I think for kernel that support ONLY those CPU I
guess the DMA function will be optimized anyway since the bool will
always be false I guess?

-- 
	Ansuel

