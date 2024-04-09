Return-Path: <linux-kernel+bounces-136853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459A89D908
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063A81F22962
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7812C531;
	Tue,  9 Apr 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cy4v+7po"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3112B14A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664959; cv=none; b=B9kH+Sc3EkSOxAHpVXfJwbH3A31hxTgLdbJrPPtA3OzBzueadZOY4xAX2rsbRH/l4XxzeKOQ01+09BSOiTK7Y5CiZUVA9K01+wlNIV4cQVhNt1gjhAFdAl4DxSP5N97TYdxWwqYsxhBB3be+QQQRLG0z/rDefvmgjDn7jimI1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664959; c=relaxed/simple;
	bh=yPd81M+1NfZphw3W4cYk6nOj1ArNbzmhlNz4HC9gqq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGoX31msrbAtJv2HOO4JezJjmSEYAe8T5wt3zi5D4NIdfFdwnmL2jon38D4SQIkL7GEh6RKMlHpLuYool1hy9DcHSw0d6e+NOwwcGPQsKVnVuA+uPSTghWiXIP902nNX9ibcQ3hdZawWi6yh4AkiBqVbZZLqxjzeuz8b6zvFBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cy4v+7po; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51c8274403so328014366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712664956; x=1713269756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2a7zpSCWKKDFCFWBoP14IB+FQzIYEADjjepMzBJTyI=;
        b=Cy4v+7poBRkXZpyAW9PmUxqoOSdRXm5+TD5wylJrAdZAVEtJaZPTt7YzxvRP5TNSKN
         Kv1AoiO1Z1Iw/acNKRUXQAuRJY++yd9HX6iDT5xFuQ7mKv1kX9y7zpqn3yKMRACBKj4q
         vOfeMUjVXRaemIWM8Bz8K4rLOWVgi0xYhH/oaKegZlGTgyWPd+fF2zws3eNhRRub5m4K
         EJUf7mEXlt5wpPP+fx8S3NeZpCOvrghXUCi/7HZPoEPuDHU91Xu/Nx/YLQ81VI45fwOR
         0o1xvkFVM/tgRkrjZm0OV7L9X77RBYd69Mhp391muPnVyqirwntkBXKOHue6WznuST1J
         PmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664956; x=1713269756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2a7zpSCWKKDFCFWBoP14IB+FQzIYEADjjepMzBJTyI=;
        b=mYe9DofsaoqIzjxcddUcrsFllYFbh3EKSww4uL0rhN+eQyUIEZYUXfuf/ohLEmuF6t
         MWfNbHCU8Qs6DX8Z5bpN4Izw4rNOQK7k1Y0vIBVpDWLP9+mUXL5vsc3J/sUdg/U3HSBo
         zRz3INCLjcentD5Jqg9QDUll6YpjH+9npGRVPkf4ns2jd8T5N7Qn/us4bCUNMFP36Uyo
         gcJydicUmIFVQJ8/GG2zGwk81AFf1Tvq839t80Ns4yoY8l0WGVKtaHZBWcCzStNuoFxr
         rSg1aC987iK9dySmfb++1K4l/NoP5UgaYzFbomwnnHEBCiN83u5KXgoUGKrzj8ywCNPZ
         uLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhivwarYKNKWRGb8+F80fqBhBUfRR7eO2ItmP9FBVdCy3rIDvoIRhwGhUq6lFmP+2wl0365UOv7i5uLII79+itCfEYzwWrLxqH7A2Z
X-Gm-Message-State: AOJu0YyREHEN4aGUuzKF4Z8EY9RQcZkd+FaX5KboUE+o3qLGR5CAKyUj
	AVf9de6mSsWUifPhifVQ5Q7YmBDoejcd3diK0X+smLMKNuAiX5D4QppEeRKX1OA=
X-Google-Smtp-Source: AGHT+IFE/zCvPySd/Jt/cqVeIJgBn1agejVAFKR8x0SZSzXrJnJAe+FV3CiGMlIqGDswtrhwFrIX8A==
X-Received: by 2002:a17:907:96a8:b0:a51:904a:e3ca with SMTP id hd40-20020a17090796a800b00a51904ae3camr9982209ejc.30.1712664955960;
        Tue, 09 Apr 2024 05:15:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gv18-20020a170906f11200b00a4e1a9e1ab4sm5632229ejb.157.2024.04.09.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 05:15:55 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:15:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: topcat <bfonseca@ime.usp.br>
Cc: Marc Dietrich <marvin24@gmx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	topcat <bfonseca@ipt.br>, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed spelling mistake
Message-ID: <1204e94a-d061-41eb-984a-86a29991637f@moroto.mountain>
References: <20240409114045.13872-1-bfonseca@ipt.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409114045.13872-1-bfonseca@ipt.br>

1) Fix your From header.  Use your real name like signing a legal
   document.
2) Use the subsystem prefix in the subject
3) Add a commit message
4) Add a Signed-off-by-line
5) Run scripts/checkpatch.pl on your patch

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


