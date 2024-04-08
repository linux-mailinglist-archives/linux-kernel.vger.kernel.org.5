Return-Path: <linux-kernel+bounces-135455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C17489C34F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E5B1F22462
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A79D84D03;
	Mon,  8 Apr 2024 13:34:03 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379542046;
	Mon,  8 Apr 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583242; cv=none; b=ZROKON8VXcMp2ViiqJLlPKzgnwKwpIP/y12n4Ia8HfHybOlwqv0JsG2LkKBv7HQjlZxY8fRIZG2CmcylDYjUN+MaIkSRFapYqltZko4THvwuKtYzA8fO+F9uVCDAaPECrknd3b+zcR9/dr7DtzXW0ah5RRkQbSjOCl44c+uj8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583242; c=relaxed/simple;
	bh=NZ39CbTPsstFUFbg48EkUt6r4iWC/wV5cUNKMrLJTPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blNJCn0urrS71hFSusO+bYLN5puONtOzLLPExyorXFWLFlsgtDkmS93URQuTd/cJTtkcyIEbrozfwbJv8ad6r5RnbOZEwXo5KZB8z1XbbSOXZxJIv7XF6ZTs8Y7M/4OxSoH3/d7seu1KJJ614LcTnEmRNMUtTjF3FdYnafoWSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a1c8d931so366327666b.0;
        Mon, 08 Apr 2024 06:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712583239; x=1713188039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+5wDrVmPRuIiSwBrRmVT0PS58QAkfRbs3RzHuiSDAI=;
        b=LWG9dajZb0kll5nBRB39spOicYztSxbSoEQtxr0MG2FRJ/LFVwgLWFfGhomCusboRh
         lpwBWDB7GtjDtpLNlGNRa0LY80ldc+hbrHkpNpSYpbjVI2ZXD8V02l451CDWiXzPM071
         PLOPB3DoGdo/k68Gtjzs2o18KJt5vUlCwTtrqIJMFs+29NVmLXr9ElnEMBOCSgB8SyuZ
         aJsWW3xDP3IUoDghZguth4AL/CBCNe5R7PoCPwgZFHnCcRnYTsx6wf5nuaXFcECdcDcQ
         9ZgYg1Pf9MpxviGGY8pcQjsSFm0qDXTYjGw3PDnoEQRi/KfBAmOBtgXuhlzmcSV+475Y
         Z6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW2UaEHlHRXYRYlYJyagQNrwWcVNVGumlnfVK0CjkZewWN5VW/tJXE11A3eG0dUi1uAVimSFwIliyg/EA5ybtK8eVcQomrPUrJu9fVqHdVy9Ick7/7QKKXRTFHUPsNcJGqLlOGJiwMkfddNOxmmarxsawtajTfeAE+d3MUzCbv36AE9zmU=
X-Gm-Message-State: AOJu0Yxnr1G2mXJx73ZP2ZUrp6QWNrZvvIsYKUnvAplAWhCQSo6P+Osx
	JqC1Np1U8z6IMK8pyTbkm3dEK72YCkxOA+EdB74xcTTz/GaIul9P8wBvhuNJ
X-Google-Smtp-Source: AGHT+IFG1A/aXSJF1vs3BAnXmRfhA0B3vs71mMEuEDjURn9PVqQkXpJtMGYAvgXIPvupcCdvOEeZ3Q==
X-Received: by 2002:a17:907:d8a:b0:a51:ce92:1e1b with SMTP id go10-20020a1709070d8a00b00a51ce921e1bmr3195308ejc.72.1712583239288;
        Mon, 08 Apr 2024 06:33:59 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id s21-20020a170906355500b00a51da296f66sm1035902eja.41.2024.04.08.06.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 06:33:59 -0700 (PDT)
Date: Mon, 8 Apr 2024 06:33:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: kuba@kernel.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, imitsyanko@quantenna.com,
	geomatsi@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
Message-ID: <ZhPyRHHlVot+a8Xq@gmail.com>
References: <20240405122123.4156104-1-leitao@debian.org>
 <87y19r264m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y19r264m.fsf@kernel.org>

Hello Kalle,

On Fri, Apr 05, 2024 at 06:15:05PM +0300, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the private space to embed their state into
> > net_device.
> >
> > This patch set fixes the problem above for ath10k and ath11k. This also
> > fixes the conversion of qtnfmac driver to the new helper.
> >
> > This patch set depends on a series that is still under review:
> > https://lore.kernel.org/all/20240404114854.2498663-1-leitao@debian.org/#t
> >
> > If it helps, I've pushed the tree to
> > https://github.com/leitao/linux/tree/wireless-dummy
> >
> > PS: Due to lack of hardware, unfortunately all these patches are
> > compiled tested only.
> >
> > Breno Leitao (3):
> >   wifi: qtnfmac: Use netdev dummy allocator helper
> >   wifi: ath10k: allocate dummy net_device dynamically
> >   wifi: ath11k: allocate dummy net_device dynamically
> 
> Thanks for setting up the branch, that makes the testing very easy. I
> now tested the branch using the commit below with ath11k WCN6855 hw2.0
> on an x86 box:
> 
> 5be9a125d8e7 wifi: ath11k: allocate dummy net_device dynamically
> 
> But unfortunately it crashes, the stack trace below. I can easily test
> your branches, just let me know what to test. A direct 'git pull'
> command is the best.

Thanks for the test.

Reading the issue, I am afraid that freeing netdev explicitly
(free_netdev()) might not be the best approach at the exit path.

I would like to try to leverage the ->needs_free_netdev netdev
mechanism to do the clean-up, if that makes sense. I've updated the
ath11k patch, and I am curious if that is what we want.

Would you mind testing a net patch I have, please?

  https://github.com/leitao/linux/tree/wireless-dummy_v2

PS: I didn't updated the other drivers (ath10k, qtnfmac, etc).

Thank you!

