Return-Path: <linux-kernel+bounces-153971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F268AD575
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ADCB23FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6B155722;
	Mon, 22 Apr 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XymXSrcR"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7541553BA;
	Mon, 22 Apr 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816000; cv=none; b=cP7KK95MApGAd5XBy23IUbWrXZPvgzZoxIS+RDZTi9oZzeJ23k+CFsYw7xzekSyMa7jwrnCHszGAzjEAB5HaI0xkDpqv04ziou5o7qI0tobmkIIbCoTtI0z0od1mcwUInmd8twO1M2k3iTqP+LDdtrF6Gz4rH/UXmA7rQpLJS2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816000; c=relaxed/simple;
	bh=s4rZxG6EhzbT+B0YqIfnFCntNAReygYdG1olWDxRC14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnOQG5yJF8vg+BPAMWXfmm09htS2JhBfTFXCL8I0yG6WIK6eHGFEcqZLDink28v5S02GeRQsI0z2RUL30rkT5FdoeUKyJDjSPX7hCSYg34gguo3MxbtbkGzXbhL+0892sM1dh/TJ6tJIDGawfZomL3FhSkdAATPDTXUf3kyh2fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XymXSrcR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3352707a12.2;
        Mon, 22 Apr 2024 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713815998; x=1714420798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyXakcfzyETRyWM2oOoDThxZWSTDPMOaYMT0ORxfs4Y=;
        b=XymXSrcRoapO2FeD7k/TzRS3QFWTmLAtnFLt5w/ReIr42c1wCRlHIY7JAZ5yaI9Vg4
         PYAwVM4kZBljQELjj02ugk1O0FUQ72vM96qbne2ZISHVnryf/k8Ky9EeB3cFKBDgh8Ut
         ONhMg1nw9zh8rTSWp2QQZ3vxUhXlCnyOLLA7+WKJ+DB1O2LvwNUt2MSH038ZwwwytznE
         P9IGvP21MC6Nc5A3LAhskcJEtKpTsia5MX96STj+O4L+w3onE0tm23K8tFufLTnx9zWE
         4OEFkU93rlBOWjoOnq5Rbd/oJ9fwsuSQooDdEGY2TSwu35d4UQAQ3LWJCHIVQIlDC0VN
         Tjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815998; x=1714420798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyXakcfzyETRyWM2oOoDThxZWSTDPMOaYMT0ORxfs4Y=;
        b=suCOq7HcjkqX6t/M+3D3coezn+IF4FoiXiLsC2G8SZoFB6YBV3YXIlRrNMvsJJ+5+x
         oOGPCG5XNKEQoMf9+y6S3XGSUr3fpP0bSTiRs4FE2tGJGwEifOcL9HB29V9slkgP7oZN
         QJ22H5w9nZeEJkxSnnSjNHhs8wbR+5Djy8peRHq5Uu8STFr2e/fYLw622yLooG/ixcm2
         2l60YmvBY9m/0jSvglqgb9TllnUN53rDY0M4zptLRwoyA81X7Qaq7+FHDGhRU7gLoM6n
         eZRIhmxHfVzGhQLsKfQTBS3M9ZD9+F58C94Y8qznDBKXGvlS4YGZXGZEBnSiP/XZub8Y
         jpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlKDiQ/FFLj4dzGUtbc9GLdRYGkYThjQDEmvsQvhf7GWlSvOCYUZ0WOxfqL7asJ6RkspKKIbSz2vOXSW0Vui84kscAHpMmMsoRpQ==
X-Gm-Message-State: AOJu0YwobQ/GwVT5sZTJJ0MLCnW/Ri/QPP8vyrNuUap60fUr4hM7xYRH
	bHFG/OHHcwByJoWGz45SFdC6ADn9atSL65W9d1je2GjuZiUVl9NluUvpWssD
X-Google-Smtp-Source: AGHT+IGlp8iUG3D3uE1/+/YHeh2DTnek49sNvbNGBWBTDrNBpE69rs6JW6wmGySIFRlAw9iYyKTZZg==
X-Received: by 2002:a05:6a20:9759:b0:1a7:5402:8a92 with SMTP id hs25-20020a056a20975900b001a754028a92mr9489461pzc.31.1713815997611;
        Mon, 22 Apr 2024 12:59:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id fb22-20020a056a002d9600b006eceaccaec9sm8182253pfb.131.2024.04.22.12.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 12:59:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 22 Apr 2024 09:59:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the workqueues tree
Message-ID: <ZibBu_BIC9fgcWJj@slm.duckdns.org>
References: <20240130133748.7c30d71f@canb.auug.org.au>
 <20240422094816.09cbdcc2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422094816.09cbdcc2@canb.auug.org.au>

On Mon, Apr 22, 2024 at 09:48:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 30 Jan 2024 13:37:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > 
> > After merging the workqueues tree, today's linux-next build (htmldocs)
> > produced this warning:
> > 
> > Documentation/core-api/workqueue:761: include/linux/workqueue.h:476: WARNING: Inline literal start-string without end-string.
> > 
> > Introduced by commit
> > 
> >   5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> 
> I am still seeing the above warning.

Oops, sorry about missing that. Will fix.

Thanks.

-- 
tejun

