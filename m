Return-Path: <linux-kernel+bounces-112634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A2887C4B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2FB281CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04D175B1;
	Sun, 24 Mar 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+sp3ErF"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAC7168B9
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277000; cv=none; b=J6UJ1IUSHGDvtaPEDvy2RFW2jOoBBWThTwuXUMBr1701vvM6lK4HcZ/gangUVJ0D5vk71wnbufnJeCbX1rHrK4gLOxdoDn/niEtuZE/vwtJRQbVaRAaG7W57kpU6A7KETc2A4i6/yr3c4XYmaNelSd5LMZt7/U/Gx0kzWy2j/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277000; c=relaxed/simple;
	bh=9MObCN77I7tUZOnnNXSJUXOLNM1PpU+2YR/y22SVpzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFCybdAAOa1id8KBeifdYIf+I9lpXBUHJdimf1P7WqBJtO8xTacYrSq7NZ/QbRvVhZ0Hzr/nekKXo6BLFJKTjWPYydnpe6KVLsAsZKV3nyyz/bZGkNtZ1ax/brjRvKEYbYuIu0xZ+udleiddrbqbmIXshxkOFTu0qXawvRXw+NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+sp3ErF; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-515a86daf09so510229e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711276997; x=1711881797; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ribv/O+whBGnqTci5nPx7uHIdlxoMvUZURqWTthedJw=;
        b=t+sp3ErFqzNFszzBMy6tw6WIgal1gAoHxTi8DSEIS89alD/K1V8uSxLiuHsPubEeH9
         XCB/kWFkmqFsX0PpZpMwWpkSbHW8Glptt0tvlM29pHmaO8niMED1fDuwugxlACvqhdpc
         egPjhfQnuohak0iE9JCZv57zaLcCFGV32ehBUAtQw2d6ZVeGyw5FzT7zqcwGw4DtwT8j
         4GIAsFpu4isbHJiqmT1J/aZOlp+g5x8mgI/5iT782IS8eVQqiljC1RwPAHXz7e0BwC0Y
         6v3fhShEnn2QHb0FhXcXPtXsLIgfE6xlWDp6qsak+xjdBrDX6uh1YCq9NgonLIXgtjcg
         1HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711276997; x=1711881797;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ribv/O+whBGnqTci5nPx7uHIdlxoMvUZURqWTthedJw=;
        b=jjgdd9Vzvv6IlIGHNndWOMjC74zDTJnNMJelYQL9XzMQg/yoHPCdel3ZrRyE8Q0rya
         RzYED4r4jAxdBlNkV+KjoY/gpqSJgB0RwDe+M88uGHCpW4eC2/5nWB3F9y36KsUbU8L2
         zYM1wGeIMEvQ5A/tY1gO1xGU5nUL49KhibQZO1IVfyyvxDosEOZyN5NaLXox8hgaxtZp
         EKBpVkF+PohXifCL80Avbkzl/lTJoDBEyaGwDcbpnl+8gOgbcjZYiiIYGOoMerNnu85x
         gqugKl0GORL7jbBfzTO5pKxbxaq59zNpMdpbom/iIGNVVZxUNzycm/zxRenQ11w0qN6O
         NT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAxyC4MU48aYcyl28WGKij7Re7iJNMK5ZjOehte2P42W/okrSZHQv0bsC4GTCzn+PG5c1DQ/5pGg1TvjFIpL7hjqJf+Sxo5QVDLBoa
X-Gm-Message-State: AOJu0Yyv6Khpio0O3V6PG/ockbeewQxNZG/kHfYwzAVoRzIT2TH5QNIk
	FEHgnyVzd2keiRGezAUkg+2cPXK8vZiGHhwgcgQ8fRLlVLh7OGjNFtlUyGTQCN0=
X-Google-Smtp-Source: AGHT+IG4o6Yn5vUl781OaAZhuvbmnwlLG9/TmJ93NsAHIltWR7Tebhzu896a3DsWYdgcU18bziiJ7g==
X-Received: by 2002:ac2:5b9a:0:b0:512:dfa1:6a1c with SMTP id o26-20020ac25b9a000000b00512dfa16a1cmr3000023lfn.10.1711276996932;
        Sun, 24 Mar 2024 03:43:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f13-20020a056402004d00b005689bfe2688sm1816184edu.39.2024.03.24.03.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 03:43:16 -0700 (PDT)
Date: Sun, 24 Mar 2024 13:43:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, smatch@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <f292facc-8a22-42e1-9a41-5ec8bd665cb7@moroto.mountain>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <08c9f970-3007-461a-b9f9-9ab414024f68@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08c9f970-3007-461a-b9f9-9ab414024f68@web.de>

On Sat, Mar 23, 2024 at 05:56:29PM +0100, Markus Elfring wrote:
> > Automatically cleaned up pointers need to be initialized before exiting
> > their scope.  In this case, they need to be initialized to NULL before
> > any return statement.
> 
> * May we expect that compilers should report that affected variables
>   were only declared here instead of appropriately defined
>   (despite of attempts for scope-based resource management)?
> 

We disabled GCC's check for uninitialized variables a long time ago
because it had too many false positives.

> * Did you extend detection support in the source code analysis tool “Smatch”
>   for a questionable implementation detail?

Yes.  Smatch detects this as an uninitialized variable.

regards,
dan carpenter


