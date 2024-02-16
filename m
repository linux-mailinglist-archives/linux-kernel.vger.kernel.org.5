Return-Path: <linux-kernel+bounces-69299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAB8586BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FE51C21634
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8711E1E536;
	Fri, 16 Feb 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmbSuJ/7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2D1EA90
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115430; cv=none; b=ftfewh9AbEPEGTo2TCzeDrCnnfzZHAK28nXmfAvFtbsXb5UoSHwCG0aaWdQWWNkvWb4BkHQOK8dWJhfgwuaJZghqxnGExdRD+31eQFJFPLG+GvG1De7Ktokrc7viOSVCy4a3OUnRQz04Vd4lfAlXcavIZQtWErCYLpF1HdZICRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115430; c=relaxed/simple;
	bh=HWIjr5/59taS8YpBBo7ebv0rKOCWRQ/5J9QUZ3NT2aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgNbWEmhb9Hi1VQKOhZIU4iuc3rtXf1MSz/YdeA9mhRLSxiQwfyorSGfcC1MLmlxckCUs/3acqTt10d2EYYbZHs0Yw4/WKuZ+FFAhtzxoL+s75huBWDF5loRmNpB3WAd18+yPsHW5L6KtQ9CS+tZAsejWK75TmWHvMTVbKtBCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmbSuJ/7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3debe0167fso109211366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115427; x=1708720227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pH0qD4eQ9yoqb3qmhmjfrX0mmcBGSF4Iayx1D/NOKIE=;
        b=hmbSuJ/7NoFHts7lby2w7ttNbWbzqjr8lZUgm8iovBfuF+eBL0NGPY97yrF+M3FO8S
         v56OjJaokdNZ/zwLTKTpF1I9m/lI3TkTySYawQuHp8o572yqSH+CwXVF789e5Hf8aXtW
         sGsX+meXiR7n0he98abhF9roNw7K3/KMwAU/xmF7J/XPuAjGpkbNOPt08wmbkvm90Bi2
         ZLM3mrvTNvjubACST+P/1YRCiu8ANO8GePJyihYdjPqu7UI8iTyDb33hqtND/LG0kPF1
         sZTpHna6vp4vV9rt3Kzg2rohqlS82GyNo9Wph6OU3mI4MYh4w0w/0+MkLxpKOia3vZZr
         Vnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115427; x=1708720227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pH0qD4eQ9yoqb3qmhmjfrX0mmcBGSF4Iayx1D/NOKIE=;
        b=CIUWLUnpDJFwN9Hu52knnPkq0LW64CODdj6/4GXcOhBL/nkSa4l19h07h2MnAHTpkC
         SVKt0j9m2ioGf7s/xjoV7gCq5W58DH9rwNbCn/43ZwMus7+vLqQJ8Sa0qUpB/cs+GF1C
         9CatnQjuIO7O7vTv6OfBCn2qzpVL/XavK/T+kO6w6Gb9rYeoOiH7vlKN1QoxqTgilqgL
         OISlhPNfmogqTy/ehc1pKouW6HHTXacq9Hfg9POFa4gk7o80FjvSuviUjEm9TFV94pDC
         6WLKGi2yt5BAmWfcbpJxR3gAuJRWJ88+omEl2BoPdcoNelJzKfpauld3w9RtD0+QljnW
         vzlA==
X-Forwarded-Encrypted: i=1; AJvYcCVxRIb9iFyKJfzof0rmrmP5hZ9o1/NEUhfx9c6gAJ8jPciTMGL7hIhqX0Ctcb4eZctrXwF102TwVOkF4w/Q8CuB/k+HqKdtzUKrCNlt
X-Gm-Message-State: AOJu0YxezCP56VuY0ehFIRQ40YdM2jV7Beg2YZt4sGI/L4+UxJT8Egnn
	owZLGSQ8Dqve161E9st6pV94BXyWCkAPjbiagLjCGMtYjnVsQ4lGuDmDr9Ny
X-Google-Smtp-Source: AGHT+IGcDan+MHupoKMtiTLo/p8jVQOdKLMDi8rbZuJ5C8LLozz5mEsLJNFCMX0JHRFnVvXKEDV3eA==
X-Received: by 2002:a17:907:382:b0:a3d:841e:3d75 with SMTP id ss2-20020a170907038200b00a3d841e3d75mr4032285ejb.61.1708115427233;
        Fri, 16 Feb 2024 12:30:27 -0800 (PST)
Received: from andrea ([31.189.39.37])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3dd52e758bsm312334ejc.100.2024.02.16.12.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:30:26 -0800 (PST)
Date: Fri, 16 Feb 2024 21:30:22 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Chan <ericchancf@google.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] riscv/barrier: Define __{mb,rmb,wmb}
Message-ID: <Zc/F3qB8I+AaN9Wr@andrea>
References: <20240213223810.2595804-1-ericchancf@google.com>
 <20240213223909.2596587-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213223909.2596587-1-ericchancf@google.com>

On Tue, Feb 13, 2024 at 10:39:09PM +0000, Eric Chan wrote:
> Introduce __{mb,rmb,wmb}, and rely on the generic definitions for
> {mb,rmb,wmb}. Although KCSAN is not yet support, it can be made more

                                        supported, the code/definitions


> -#define mb()		RISCV_FENCE(iorw,iorw)
> -#define rmb()		RISCV_FENCE(ir,ir)
> -#define wmb()		RISCV_FENCE(ow,ow)
> +#define __mb()		RISCV_FENCE(iorw,iorw)
> +#define __rmb()		RISCV_FENCE(ir,ir)
> +#define __wmb()		RISCV_FENCE(ow,ow)

It seems you forgot to apply Emil's suggestion from v3; please do in v6.
(No need to do something immediately, still reviewing this version.  ;))

  Andrea

