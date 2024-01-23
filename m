Return-Path: <linux-kernel+bounces-35798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329438396B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF1E2922E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986618005F;
	Tue, 23 Jan 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6fNOKV8"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C4811E4;
	Tue, 23 Jan 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031912; cv=none; b=TG4H/sMevIbta3Vz0uBaZG8OOyQzPYOeHp7KLAox05vCDZZUNdRG6S6F22ziKDBG7+b98C9X4YY2f8H/xSVv4kQcE6ok7fPe+NM7NcxEhSRmkJUxTike7BUxo+aAYDRjelQ2q+x68EeNHMLKHZIMG1zvPgm5H2MN+kBBlvvy6so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031912; c=relaxed/simple;
	bh=hiYpf5YTmy2SgRtEVXbmJOPkhwnjcJIUaFmiSYESsd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxXAh1hIqyNZyECEPjSjszGYsgU1Kh3OSCFsEB6ea6tBiQSnLS6RsMKRSvAmhJh2AFe3M5GhghQsGO3eq5J1v3anBwd3oruv68BaDGJSa6fU8Hzu1JBLaNhYPQ1KXIhYu8zg4BMTyd7ncWpu5cWRLionRt0DI+2ipFOptcAuu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6fNOKV8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e775695c6so45190635e9.3;
        Tue, 23 Jan 2024 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031909; x=1706636709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4oyBrQ4+qtvNHd22bRaiLV27J7OcLKPIojk24G7ULU=;
        b=E6fNOKV8eltoEw0cXzEo7w9kUircsqvGkdr52sS9pUBS0BCHqnT78i57GBLojr+wW9
         U8Rp2yq+2u1vOMx5LywwxbC6hAYtKZKbPsCyc6RuQqxZ4S5kluSdzzsYdvjJ+NUTauGF
         K/Z33B4EXqmOkQUGJ8YMU/EUGPvVir3MH7nok9YKx4RsWC2YnN/QfFe6+cz8pvNahi/H
         iHj1jHXQh2hzb8Bo2+Dy/NQaDKdWgsyXyteJVrfg1ZP7cI2eysBaxRXHwcP0xaPTJfLI
         pQ1V7e00gba7gbPkIQQdEhO1R+bS533KzZLCALd1KFDn4QCpsNypBr63y1SxuYLpvZW+
         tj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031909; x=1706636709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4oyBrQ4+qtvNHd22bRaiLV27J7OcLKPIojk24G7ULU=;
        b=FwkmQ/8yWeUipg9YP6Nd16O/IAQsIcanQvggCHlYzg+nE9NB2yP6iydas0CyrqNNHY
         pjEJVKIMbfbjjVc4xV7dppJEEJEj7gYgA3lvc/X0sbKzvX2r5DppnzDL/sw8s9Zxj0+S
         2ndiq1QK9fWLqVmkosD/B/c591uaAJGA+UwnL90rUoKkI8Fjk3fxPUysaRgaAwaOW9ST
         H7z89Ch10wg38wiATNpz9agbY/cxoN8GECUvDE9wfC1VTKvl6pjqbGhKWzfygpHqWW0Y
         KzJjiTNNXnz8rdfFvdqFe0ZvrPQ8OZ1IS9Goxp2fscm9h+VN3UJnLnCB++SsDqXxarv5
         QGog==
X-Gm-Message-State: AOJu0YyjsG2UU99JxpX6orgLaQegjHQAm/DhYk/9rjfy0AEl2twrseDY
	B4N0vGmt0M+CQE3JGN8lhHvrh1dtJTHUT6QbHqv4BkSLO9S8qA8m
X-Google-Smtp-Source: AGHT+IFvQq2aPOGlvF4JOsf/hb7L41ATp/rSHCn3ZpEvu3AEHPAoSdqMSCs8os0KHLA0EEadsR8H9A==
X-Received: by 2002:adf:e84c:0:b0:337:cdc1:daff with SMTP id d12-20020adfe84c000000b00337cdc1daffmr3997048wrn.71.1706031908892;
        Tue, 23 Jan 2024 09:45:08 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdd88000000b003392ae3aee8sm9009835wrl.97.2024.01.23.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:45:08 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Jonathan Corbet <corbet@lwn.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@gmx.com>
Cc: Erick Archer <erick.archer@gmx.com>, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ce - Use kcalloc() instead of kzalloc()
Date: Tue, 23 Jan 2024 18:45:07 +0100
Message-ID: <1876185.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20240121153407.8348-1-erick.archer@gmx.com>
References: <20240121153407.8348-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 21. januar 2024 ob 16:34:07 CET je Erick Archer napisal(a):
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc() function instead of the argument
> size * count in the kzalloc() function.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej





