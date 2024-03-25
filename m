Return-Path: <linux-kernel+bounces-117674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96D288AE4E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0001F60F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3D6F068;
	Mon, 25 Mar 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwihusL6"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D586CDCB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389793; cv=none; b=mOeZY7Xf1F1vEvk1xS+W/FwTeAQCBZUmxOFrgt4+/EoYptZFZVY6v9boNY2Kvs021oz2JST0tf4X8OUKbZhJ/e25+SSd4b+hcOwygo+6Y4/IjFFsjYO0ViTYgRJD08n4AHLgzJG2KceR2IPQ7ReZKtY4fiWR1r2riYLcC2JQKoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389793; c=relaxed/simple;
	bh=VqJAK9LMf19BLXaKwjLTQamBgAZ8wVxbTGeY7jkLLj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YovGKEJ6cFihI1/uHjYvAbifmfD876gPRytgCprc1ONHGt3g4B4tZX+C+30Ck5j48RAIOC0RLMyCfjTL02fjoC7/NJ4GgiudHZrwu5Jr00qSocd5cKrEX1ekxflh3SUbIIwQwYSPSaMZUUIHlGp1VKuQKX2kera6OV13TGDB7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwihusL6; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a46abf093cso2958497eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711389790; x=1711994590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fLUiUk1Q+DQhrsVzmksa6nwMomZ8debQ8tnp6AHgtVs=;
        b=UwihusL6xWZtfEs1Xe40tUessHq8S91lQ76lX/P3zEyMQBu/Uqr+6F0RtspcoFX8FN
         oRbluUKzCnybTcDcuqOL/4LZW9+Fl5VmnqBXeR9FzaDQfqsxzPtKozdi4IKUVtiw1JUu
         RoI0Y3KFoGPefNsBvr0t/YJPgxp6ZTJseuNefPNZuhxj8WxtzIE3YExVSYFYCqERlLXC
         3sisQGeoX+JJz8cEtVm4Y35VmxP0/6y4YZiQpHKh47tcSUxWcVhGB7WOIBWsIVbpTfn/
         59IRFEpJ4e6N8XYT85EL22gQiXylCnXcIYL6ZAHFD+nC5OASFZrFulAOaA6oEOzhC+cu
         wlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389790; x=1711994590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLUiUk1Q+DQhrsVzmksa6nwMomZ8debQ8tnp6AHgtVs=;
        b=X6U5SsCTU02DRVIbUWqW5wJ1n54635lVIP85H0iMoX0Tb76HQ5Mf+VtvrpYMCwuVJd
         XjMdArjtFa5PVGRfVqzoBaPBpo11JrPRHCSqFoHYdNL7mhlRz2VeqQJNi9Z2TXQhLmmi
         2LA6B2qyoxRuOFoxK1WX/oLHxof0TFFKOKBBjhlKfDMkrfo8Y/jbbgIUFKwIkPBk6FUw
         wi/ZkCWH5rTM15SzKqL3dOY551WY9aF+3ILZOV7xAHgioUmelcxHzrjgtiCf93Bm3hX1
         TFa/YAU4dXhhlYz4RoSP4lEH/imb/ddjJCFbrk9B/qcxR+abwc+ywtQT66K8JIsAF7IT
         +kig==
X-Forwarded-Encrypted: i=1; AJvYcCXpOqDOlpfRqfxI6E7kD47FK7uHj0zb+tMMva72lbyQBUi3SUZtlRb33LKVEI6dlAtcnhl5Sp3CV0kyIy+KT9HK6ke9K1xeRwM990ew
X-Gm-Message-State: AOJu0YxksN3ZV9rQ2F47g23YxViy8K0E552cU7t7VUPP3to4mFHwCUwY
	h0liFT6zATxVGi1D2dPIfyoyQcBNZ+9+9GKkWFIBZWCeMlWxjvx4RjfUM1IYfcNSXs5rmWQDZTv
	vpMnTDYMZafSOHjmCdO/3U6xIy3I=
X-Google-Smtp-Source: AGHT+IFmpJtRfFjPuhiADJlAxpMJSsW/XgyalzqXN7JIrg0wgfhBiSSdcnA4Mpj6OHKa6ZMz54b0Vq1OI8W1OdcAajM=
X-Received: by 2002:a05:6808:90f:b0:3c3:b10c:efad with SMTP id
 w15-20020a056808090f00b003c3b10cefadmr450826oih.27.1711389789916; Mon, 25 Mar
 2024 11:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228181850.5895-1-apais@linux.microsoft.com>
 <Zd96XzRHI_jMOCip@slm.duckdns.org> <CAOMdWSK9_1LMA-ULLa-iZ26P75UCOrO4gScAqmYvqbrvJi7wSQ@mail.gmail.com>
 <ZfIIUyip4U-hGZ4l@slm.duckdns.org> <ZgG12HiYSowiTtTy@slm.duckdns.org>
In-Reply-To: <ZgG12HiYSowiTtTy@slm.duckdns.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 25 Mar 2024 11:02:58 -0700
Message-ID: <CAOMdWSJYKBRzjdgwTnigO566uv8HqcFdS7DTFAMVNjyjaNMSUQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: Introduce enable_and_queue_work() convenience function
To: Tejun Heo <tj@kernel.org>
Cc: Allen Pais <apais@linux.microsoft.com>, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > >
> > >  Could you please let me know once this is applied or point me to the branch.
> > > I have all the conversion based on this.
>
> The enable/disable patchset is applied to wq/for-6.10. I was going to apply
> the enable_and_queue_work() patch but you wrote that you were gonna update
> the documentation but I can't find the updated version. Can you please send
> the updated one?
>

 Sure, I will send out v2 right away.

Thanks.

