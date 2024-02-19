Return-Path: <linux-kernel+bounces-72132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A9185AFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B634B220B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5056773;
	Mon, 19 Feb 2024 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6bANIrh"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5C54747;
	Mon, 19 Feb 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708385469; cv=none; b=S20o0ItQTRHTGGjsWFwLGy4i3XayDhWyam2+G8e94zr3s8lVf4hlgOY8wv9P5WEbRiklW/ndhxOzmYd+ucP2ETovy7J+5t7FZEW+iyVxw4WMJRW6n6PQ756jl2bLMc64SiWc6OrGvvAzbZABMfEpGNaSFEAF9kf0rmmpviZ0sTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708385469; c=relaxed/simple;
	bh=He+2CQMiu7C8trIymFqca1sZnKxPNyupGRTZ1GRJI4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZwlPWm9vWv53z7ER64WTmbe+ZyKT7lSr+rIo0H58o9xJxKUeUXnbaF7OqYlMK9+wBv42+JNND6SPnUHQg1Dps1gd/iZwTfV/hD+WFmQBbJjO2kepDnCDLRVUJGPtFtRlCBa1RZeV06tNYNiPyq7vd9v9mQnpgJVXcbK/XgzO6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6bANIrh; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59fd69bab3bso347725eaf.2;
        Mon, 19 Feb 2024 15:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708385466; x=1708990266; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gb/w0diK9ydNvrXIy2AQjJ3u1O1a7ARfH3UJAoAQWkE=;
        b=E6bANIrhk4rm+tbzcBYPw5YJIm4An2QHdTMgcZNYGCw+aAn1+RMNK0qVZxlUpBRk0h
         VTUrzu5krTVsjnL1VPyJOxXEMBan7ac0dvTltoepQIl5hMc8AyorRQ0+LOKxl3tq+1Q1
         63TlxBbK7f5Fn373vmVB6Jjltyg9QxRdMcs7TOUPZCqg9b+LNbYV49O9yZ2JJS/y6pUX
         HbKuz7Z4vc8ZprArJ+OewgwW1MZ8LdRk73hGDt4h70q6N67nIY6f1psaSs9LH5vbp12D
         R/NSy46tcnPWFadPjlcXQ2jirMd6NBNxN6NJBNzpc1Lklwg6rAp6tDjLvGD+jH10RDSx
         8ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708385466; x=1708990266;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gb/w0diK9ydNvrXIy2AQjJ3u1O1a7ARfH3UJAoAQWkE=;
        b=tLTncgBjlCKSVzb0hVJEAyqiBSw9vndMUDPjZycniY2Fh4KsGBQ+NYB8RQxGHsnPtK
         DrOjWE7OH66gNKnYgvGnuhTQbZynEGSUf+D02GKZqL9tke1J4wLsEEI2ua6B+TsLX6aK
         HaYTWtWaMLsQ5cSTeC6/DDIau4xfF5y3CcKBoKBKcMazSegEYr9YOju3/QQO+9BZqkxB
         PvY2jaAOrz6oi+EFBm/kDH8+ERL1Lcryh6CVxJDvu9s1fZ0f9i1T5DKaV5TjNBsN35B9
         JPRTZsJ3XleP7pwY/SyfLPI0P+jYzr334iAYgPc7893qXkKXl9nSIsoGxzJfHPgj8Xxb
         Lceg==
X-Forwarded-Encrypted: i=1; AJvYcCWLJyWmlrFGa/gDeyAjijmcFNf0/OoaqoY7UNmJ8COcjWR8KGOiQ4Un/eA1HKst6tHCUlOFyt98poO+Z8g7XvOvwg1eGeS14TIHrEz0bFqawF1vLwB+ubSIgD2i1J8jsO0IBp1NucM3BdRIygc=
X-Gm-Message-State: AOJu0YyZ+qTDGR+rbj3+l/yr2oLxcC634A0tmyRpgu9lY80QW1fESq28
	CzeAc9HZSty9juXNFKeh5EoLbnFHUvigeVSCGvawrqdcqa2GckP6
X-Google-Smtp-Source: AGHT+IGR/K8IAK5umjO3RXbLjrbA3DrekFZjWZ7wfP4OZ8e2cTEPT7ZiUtbZYfCBngZCJKL0oP/13w==
X-Received: by 2002:a05:6358:5716:b0:17a:e876:1148 with SMTP id a22-20020a056358571600b0017ae8761148mr19859876rwf.12.1708385466278;
        Mon, 19 Feb 2024 15:31:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 203-20020a6302d4000000b005dc832ed816sm5290271pgc.59.2024.02.19.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:31:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Feb 2024 15:31:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mean and variance: More tests
Message-ID: <065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, May 25, 2023 at 10:22:25PM -0400, Kent Overstreet wrote:
> Add some more tests that test conventional and weighted mean
> simultaneously, and with a table of values that represents events that
> we'll be using this to look for so we can verify-by-eyeball that the
> output looks sane.

[...]

> +/* Test behaviour with a single outlier, then back to steady state: */
> +static void mean_and_variance_test_1(struct kunit *test)
> +{
> +	s64 d[]			= { 100, 10, 10, 10, 10, 10, 10 };
> +	s64 mean[]		= {  22, 21, 20, 19, 18, 17, 16 };
> +	s64 stddev[]		= {  32, 29, 28, 27, 26, 25, 24 };
> +	s64 weighted_mean[]	= {  32, 27, 22, 19, 17, 15, 14 };
> +	s64 weighted_stddev[]	= {  38, 35, 31, 27, 24, 21, 18 };
> +
> +	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> +			d, mean, stddev, weighted_mean, weighted_stddev);
> +}
> +
> +static void mean_and_variance_test_2(struct kunit *test)
> +{
> +	s64 d[]			= { 100, 10, 10, 10, 10, 10, 10 };
> +	s64 mean[]		= {  10, 10, 10, 10, 10, 10, 10 };
> +	s64 stddev[]		= {   9,  9,  9,  9,  9,  9,  9 };
> +	s64 weighted_mean[]	= {  32, 27, 22, 19, 17, 15, 14 };
> +	s64 weighted_stddev[]	= {  38, 35, 31, 27, 24, 21, 18 };
> +
> +	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> +			d, mean, stddev, weighted_mean, weighted_stddev);
> +}
> +
> +/* Test behaviour where we switch from one steady state to another: */
> +static void mean_and_variance_test_3(struct kunit *test)
> +{
> +	s64 d[]			= { 100, 100, 100, 100, 100 };
> +	s64 mean[]		= {  22,  32,  40,  46,  50 };
> +	s64 stddev[]		= {  32,  39,  42,  44,  45 };
> +	s64 weighted_mean[]	= {  32,  49,  61,  71,  78 };
> +	s64 weighted_stddev[]	= {  38,  44,  44,  41,  38 };
> +
> +	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> +			d, mean, stddev, weighted_mean, weighted_stddev);
> +}
> +
> +static void mean_and_variance_test_4(struct kunit *test)
> +{
> +	s64 d[]			= { 100, 100, 100, 100, 100 };
> +	s64 mean[]		= {  10,  11,  12,  13,  14 };
> +	s64 stddev[]		= {   9,  13,  15,  17,  19 };
> +	s64 weighted_mean[]	= {  32,  49,  61,  71,  78 };
> +	s64 weighted_stddev[]	= {  38,  44,  44,  41,  38 };
> +
> +	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
> +			d, mean, stddev, weighted_mean, weighted_stddev);
>  }

Tests 2 and 4 fail for me, and I fail to see how they could ever pass,
given that the input parameters of test 2 are identical to those of test 1,
and the input parameters of test 4 are identical to those of test 3,
but the expected results for mean[] and stddev[] tests are different.

What am I missing ?

Thanks,
Guenter

