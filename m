Return-Path: <linux-kernel+bounces-46132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F904843B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA87B1F2AD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42C166B4E;
	Wed, 31 Jan 2024 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CFxCHpR0"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503260885
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706693227; cv=none; b=tL46o7EvQLrbWKQ7B/A2re/Y++5I1jAI+aIhJyAjds95mHx6nD/Gd1ZmMAryiToAtZBFcnFXzxLBPxrtMDo2w2TllvZ3Lp0RbCynphbosZHBI0Z7CBToWLVutXJWeP/R5nSW+EcuNJPr4NDHW3Q7Lx2TSfHgcaAnQLiHfrYIAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706693227; c=relaxed/simple;
	bh=rhQA2FmHrcqOgIeZU5cWjN5fprAbJktRS3V/E4b4y1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb/eYHNSCWW8RogLlUobhPJh2uK1miACtXlZHp1dzo8uz8XE+Se5zA0LLvRYcfZR0Dfyga386eEH+IM0E7qUa0q4+NU5aMlernmsPW7tc2tQtOYcm2HldvJHlaQsll6+U3dBos7YA6lwvQVY8uG3Nq2YGyMb0uat5REfAHkvMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CFxCHpR0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so25474995e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706693221; x=1707298021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhQA2FmHrcqOgIeZU5cWjN5fprAbJktRS3V/E4b4y1A=;
        b=CFxCHpR0Gy4y6zIBtPbB+i4FP/E9Z6TwhoOTB8IirWV8DBB6foH1xwP3o7c3xWhX/N
         081dqK8wvoJP3v2OfIHr3fEF9Z/e1WSDSj9IOqlBbGfCqtXe1gl3cu7uBdYVacykwnhC
         fdj05hzCNJX86yDHZWOoVT0rO/cPLJA4nvcLtDstgB24THeiAeHpFxGQGxWIj96EXoj2
         4QAYmAS0qDThmi7HpW0dL6G5WUnxrmevsPZ65PNKh6ohQAdbdyd6FBDroBhdjyp9j89m
         OeSAPAvrrOFHBCB0iV2FlTOWFMMqKVWgN6TfpLmEatQYc+wfwrYm+lzYf7XfSqFsiQbp
         LP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706693221; x=1707298021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhQA2FmHrcqOgIeZU5cWjN5fprAbJktRS3V/E4b4y1A=;
        b=S164Aa5w0TkaJr8iH7woBkjeoyLUJPur7LpG/IfWONdwrxmB+jx9dMRIaHTYPCzsSo
         pyMpez7U7bbHu7Wd4IFBiH+OgXdnrb35Mf00tUpof0mjnfq5qNS1qDP2NAnE5QVfzbc+
         PCmVDN+2TI7xztZO0GY0bV9ta+vgAndE5YeM9U1bshQxMlVcpapicOtgPNtSDxKT1xos
         PEkALSzlX6ZhTJvXe2I6uww8oa9vgoa0vFkYkN6wn7s7yYmxME9j7J2ViTJwsquwaKQP
         YpW174JHVyPV6m1km+HxzNpIzPe7MegRqj6DtOEF50x+6BqCUSRIGg9vSXTKTFastwpz
         6K8A==
X-Gm-Message-State: AOJu0YypD64BbaxKdkE/ezfAcB6awfAUnoDGqTR5cgdMPy5YA0tuBcxj
	1pB/F347YLWuGOnDXTjTsa8+9O6wWRlo1vTB24TFLnbVLQ98DaqjVJlg0KkQV1jPbWLGH0OUHyT
	9tWXP8Q==
X-Google-Smtp-Source: AGHT+IGRRU5Pkx39uGUu28oj9/gaWzncSIVqDC3xzYrWceMVa99AVP2h25/ptA1pz23ucLvApAPdYA==
X-Received: by 2002:a05:600c:1c9c:b0:40e:88be:ec58 with SMTP id k28-20020a05600c1c9c00b0040e88beec58mr798750wms.31.1706693221528;
        Wed, 31 Jan 2024 01:27:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2ER2OHY7bbFbK6Op6OW6Igh0mvGMHsBVflZyjYPwUJCKu9nujqqSipHb4+tme3E9poFp5bgt8JO3nPOUJFsB4esGj12OKeWwaGp95irFcBMdNwqcT1OJfq6UGNq4QTSAyCybIauV5FJmeVk2DAZHbQDv92xfL5FAljDjQEPX95jNOpQtu2C/RIiZD+vInKlyPEOvwdgz1rEXmRTf8Z9j13sS6kt/PScTKOlNXtqGKmwsfIujOcbl3Fto94w2GpFpZFUQ=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u10-20020a056000038a00b0033b07e4cadbsm282109wrf.115.2024.01.31.01.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:27:01 -0800 (PST)
Date: Wed, 31 Jan 2024 10:26:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv4: Simplify the allocation of slab
 caches in inet_initpeers
Message-ID: <ZboSYW2NxmQhNrEG@nanopsycho>
References: <20240130092255.73078-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092255.73078-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:22:55AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

