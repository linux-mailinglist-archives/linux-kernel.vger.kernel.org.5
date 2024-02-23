Return-Path: <linux-kernel+bounces-78090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE3860EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC261F24B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1105C91E;
	Fri, 23 Feb 2024 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZjQNpvo"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A014F8C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682262; cv=none; b=AhyBCZmG5FLoEX43CuCVsqKV/3Tco5U8veL8LdyTZuafDkvOag0JQIfxh91mmacXUzpECYfV+87MHd12gCdpnqg/87G3h1857eQ2bAIG9VtMujv5VrWANtYIzXhEu08m4hAvaroPhd9NCCdf1sLUeJfPZWSebh4D+uGP4jPVn20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682262; c=relaxed/simple;
	bh=v0l7HTP7lsDPJCnwCBLsqGp+y2UNKtugLO9N2xkevdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6aH4kIiOwT7azDep4BAnD6wjyfa7s1yvNhkFLz8MdYEeAMF2ZbvjU74JsAeFy1ghHe0WU7Wu9TgF5ozSjSekllPkcMSqi27WRbkGsljsKIOqCWZWJC70oRQSoBKjGxp3KXQABBiRe8YltgrapSccNbMmys1mvbJ+cuH56e0oXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZjQNpvo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394b892691so371429f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708682259; x=1709287059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/y/rI+M/5qiVISNkhUYwwY4gRxXJKTqbidyY3f2wE0=;
        b=dZjQNpvo741c6WI3kkW9Pift5Phe9OtpEs0BgP1BJttEQ8vsMS4HELWROU9kj+sJVj
         6rbizHUaiPQ4CGZxIeZyknUF6OUisNqJ9jnaNeraJpQ2roTdpxeNVrjcN7tcWoekUCn2
         KUOYr+t3Lufi0bDLX8N5FzsDNV+znnXgmymeyKHE+77fKQGr4BtpnLZh1l19S7BoAryx
         THPu2RreYc7Kf9gevUAVkzb0e9gapt5iCFOQ31Wo2q+1KQESBOmXoNRA/dLzjamA8NND
         oaqsnc72jbmp82DT+IrFmcMBwP/mrCTmQGDSSZRSllGT9e4kyek3DQiq4JWr0d7keRs/
         bQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708682259; x=1709287059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/y/rI+M/5qiVISNkhUYwwY4gRxXJKTqbidyY3f2wE0=;
        b=FMRL8WTHH6RirEUfGp8P6wLMNmalgPymUXajEilcGAMHSHrt9XQryGwwcwWwsVUF6I
         MFpQypNN10kbOmIRPLiS0ahwjlWHhh26wpbhqaJ16xaWVb9IKzDytEsies0YbMcNt6Ox
         Sxt8mEGfrT/awLwO0WcGS8n29C67+T3++zwsmMq4ffGus4v11waELbgJ6gKLANhqcCZO
         gc77Zy19h4TdztJ3RjQKW7X4ouK3nFxzYir0IUPkjdlRZVKwCaFEFYlvDvsDcKHb1vtJ
         9fqoXNs1EjntuT0rLfcSvT3hnMLDDXYaCS2Hv4+scl5F6SljLRfsqEMHvJa/171hoIwa
         yhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmyRgbLC0EqS9ppmx1znt0h9S3IAW/YOhBUlPrWfypHn+4cBAoafO2IIeicSRGksGfirDplNX/b8S/8fYyOlkKzoj9E1Pz5EiGC2LW
X-Gm-Message-State: AOJu0YzusLWUjP9EIfrx/KVALeTp4z68SIA22dkj+Q2WUT4DzWSPkDt7
	xBIQjULl02ftMPzrLjA0V45xRRjKetMLh26WtQc05QZyza7SUWFKc76NmQiBUEI=
X-Google-Smtp-Source: AGHT+IE6tVWqEE3mCN+25DqhP/CUP5T/jGAansZoun1aHwjyncsoYOjI/jf9FiAzxP2Z7I7QVismBw==
X-Received: by 2002:a5d:6691:0:b0:33d:2567:995c with SMTP id l17-20020a5d6691000000b0033d2567995cmr1215561wru.1.1708682259350;
        Fri, 23 Feb 2024 01:57:39 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b0033d81d9c44esm2313054wrb.70.2024.02.23.01.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 01:57:39 -0800 (PST)
Date: Fri, 23 Feb 2024 12:57:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] orangefs: re-fix sb refcount leak when allocate sb
 info failed.
Message-ID: <32506721-f81b-46d8-b421-d5d2a4b3540a@moroto.mountain>
References: <20240223093639.1794556-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223093639.1794556-1-suhui@nfschina.com>

On Fri, Feb 23, 2024 at 05:36:41PM +0800, Su Hui wrote:
> This problem was previously fixed by commit ac2c63757f4f ("orangefs: Fix sb
> refcount leak when allocate sb info failed.").
> Add a judgement to fix NULL deference problem and also avoid refcount
> leak problem.
> 
> Fixes: 9bf93dcfc453 ("Julia Lawall reported this null pointer dereference, this should fix it.")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> ps: Thanks for Dan's suggestion[1].
> [1]: https://lore.kernel.org/all/c4bf77fb-c289-4f5d-9f20-e0861a543d91@moroto.mountain/

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


