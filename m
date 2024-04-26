Return-Path: <linux-kernel+bounces-159965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F598B36DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF671F22F43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C46145B14;
	Fri, 26 Apr 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTIOmvUH"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDD145B09
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133117; cv=none; b=ISCDT8Um7Y8m+4py6sRxSojpt6zteCU/HpqzCahRhBEM/dvSLXMBv+YANUVKolE6kiJgR61Icbq15w60kDhoa/FQkIxCg+RI8lmnFWRRUT7ReD3qLSGBHJ+1Td6uIerWHnrXS87sRYREEUBT2o28N/eGjuUOurZF7LJRJmz1Qkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133117; c=relaxed/simple;
	bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxCkNDYpK8JjiDopSf/2S1GaLJbQqPjO37I963ZEmwv5fPAlcX0AWWW82R4iQa79C5Fle+6zrhnD6eoNm8RidOVU8P39teuK95sLvyJQPl8jSuFwitvERhd/Mi/VybuB1qzElAMXA+7s2PfFC1FO+GscaPS8mEAjzoPWu+8Mbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iTIOmvUH; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa20adda1dso1336950eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714133115; x=1714737915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
        b=iTIOmvUHJwGmk0Z4Y67dF+vraktLEezx8e1tGLUDNgYP1TzGcnBrghKndnoXerwpyV
         lYhC4ewd6o/Yw/rlOgyrhuNHA53bGaHFoAw/QMB7jISgEqyYcBNeFyfdfKcwLttIM+q4
         EUZ/3YSvOWVJ0pVaahVWWvu8qJ32zxlJ4jJDKRFenMvJtuHWCv5/1/kejdjSkaQGvR40
         aR//dOCvs5pKfCMqDykmYoge7BPUtln0IdK7kPvz/a/CjqsltP0UE/1yorAwsQ+TNoKD
         oyKQnKFbTygXJxsEPtsONfMPatglVsfsiTUtkERUhxFrhhUcr8aYAk3YTZ2ivdIFH2QZ
         iRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714133115; x=1714737915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1E79nEG2G0/aOYL7SjrP43Oau3fXMrL0uYYhXjNjkE=;
        b=kUU41uBNupjfQWvZkDahWLrhfvbnP3xUrbmGq0Gx+gwI+WwstP791Iw8PmRDk9oso4
         AtjiC6Jrb390mPSeOrN8BbqeCwVhCaoVcGZAUZ5NVHTjkLgQY4ldc+d5jEnCN5368G6i
         qhuJ52fEbBeCNAJO9xeBydWw0dgbljluaXCQecbf1S7DfrIX1UTU4EDa+h+DebEzET9Y
         M+foEoQYFD4j8T9To6/8iBqszUgNCcUtELlTGc7h834l1Hmda2XXPplExtzt/aOPu/Ma
         cHVnRNkgYZ5bPs4t2ti6Va2HBw905D8L/96iylLYtPZqLnhMj7Nw1flPMQeKSlfMUc74
         w2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1denwCcguE8lwZf/1idKDNltZSyNo0kHqYmK91SgNlZ1SkkG89mSMlvsosYIRbH2Xlp7yg8azkYnezJCQecjUmdwCap8HTKej7o5r
X-Gm-Message-State: AOJu0YxNytk4sievjADXN8utNPa3LaNNboS3UmME0XvawUk9INAdjRQ9
	9/4fkm/vTCfYKPu4/h9wiS1xw57xjqZMVAmTgcgrBzq7nEdxpDNpMZMojlPRajakiBT4g+bfgmt
	mM6/OWVQWZr7vu7JIL+GUCtghx8YAmPCw5yBQdQ==
X-Google-Smtp-Source: AGHT+IGca8B9KX/Ii5lYQ3b9rLayT5KL2kDMlLOYI4c8cu6nOAGG3+yCexdUphLn8bJqAkemhCy6Xdc55amdXVXO+4M=
X-Received: by 2002:a4a:abc5:0:b0:5aa:4d23:9114 with SMTP id
 o5-20020a4aabc5000000b005aa4d239114mr3138536oon.3.1714133115172; Fri, 26 Apr
 2024 05:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426092444.825735-1-slark_xiao@163.com>
In-Reply-To: <20240426092444.825735-1-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Fri, 26 Apr 2024 14:04:39 +0200
Message-ID: <CAMZdPi-VNEUJK+AUcyCXii5in6OLfKjxrNM1KHwQf=9QV_cqJA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: wwan: Fix missing net device name for error
 message print
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hariprasad Kelam <hkelam@marvell.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, 26 Apr 2024 at 11:25, Slark Xiao <slark_xiao@163.com> wrote:
>
> In my local, I got an error print in dmesg like below:
> "sequence number glitch prev=487 curr=0"
> After checking, it belongs to mhi_wwan_mbim.c. Refer to the usage
> of this net_err_ratelimited() API in other files, I think we
> should add net device name print before message context.
>
> Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")

This is more a cosmetic change than a bugfix, you should target net-next IMO.
Also as said in another feedback, the commit message does not match the change,
since you're not printing the device name.

