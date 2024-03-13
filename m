Return-Path: <linux-kernel+bounces-101124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A1387A2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8B21F22D36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11412E5E;
	Wed, 13 Mar 2024 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVc544xo"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E110A1D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710308359; cv=none; b=JAhggPQDQw4/uPVuAkYpkM/fHb9531IYdoImCpJecgEAD1lNrzzTvgvD23YHRTBHiXAPbvnp5HpnBS7X5y5QOh08oqVrfA7VMg+nmekcPd0/A+ftYsU/r6rfVAUlLdHe1/h1xEwwSgnbNmOnD8QpYd4De9/jeIsb6mAHrLNwVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710308359; c=relaxed/simple;
	bh=qv9E0ryVzOnQqUuvfK/MZ3ePXhFc9C6pWJ33POv+pnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgBaomZsfv1V7Emc87GKanTQPptYnPKxdBQLptYlxHvsEuRr2KNAYc0X4e5zwI9/8YNxrtNiWXVisBA0MOEZmLiRGB7uv8TOQX65JqEhKcjZFZmj/WhbsTX04TBOHQs6T7bEUZAG2DP5NT0eoSTSq3zU9udY0RN/csfwRe2pOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVc544xo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a45ba1f8e89so686843266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710308355; x=1710913155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSWceIUzISd19ErGqmK4nWkvRpe4eyaho/RKTDtrGmc=;
        b=EVc544xoeqN98Epj3hVaNPWwm3ye2HgaLuPkR0/yGmZIxFg409003kOp/yQ+NV8WI2
         W4g881JbChsf471QcRyMXSVvpktuz20hU2+se5giLx/fHEnl8cJHlNKVId+9Fd9sHUEP
         Lg9yRdivacbJZaQp363EVrIf3GLGEk7uRR6PNmASD4gVsscngm8KDpj8MhgcWMo6AWEQ
         wI3qHHUTKJK7wvK9zw/CkPG1/FT+8bqbaan7/AqWjn91S6vEcUedIMMvAbH0xtvkF1ep
         9+Jr8bOWMlNtiKGbpoxwhTLTo1K45OShZyt4sNhY5eR+DeSpKX7mOmbWU3Chl09Bsmwm
         N4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710308355; x=1710913155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSWceIUzISd19ErGqmK4nWkvRpe4eyaho/RKTDtrGmc=;
        b=S1dYWsiCJoBlObVvdvWy+Jp95nmt9UenXzzMaQC99afKb/DKhANgQQWvLd1atokUcD
         MkeQ7DCFHkFVuDL6WIDvpShUjFAae+tDOc1uVZ+jjXcFnMC8rlw6ptg+YT7Reh+JthWK
         uuArysuE68wDvp63D7bfbITppxcAQc08pCpPqQWUm4wAf986lU/lw5vcjMgAEiixt0gX
         xELp8m6wOfhy+KPHCpK/JrOz/l92PzE6VlnoTm+2Ytrg+8SzcyovyiP7aVHQLWhsgzy4
         yXoF8j2pmouWM+Sdac2Psb0HLjTAjk9CO4+meJWBnKEGyr+jshvziNRzHm2f6Z/7+qfm
         Xt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4x+kilxGzqyoCKmR2FW3iSUOBRT2FUpKP1b9GiS5PDML9mBhqiKC4WdMeXq+RO8/6yfBIyA4ReCpnvvzBUzGB+4rqnnQ0GWr63UJw
X-Gm-Message-State: AOJu0YxNRhbOYW29QENjdlfoVZPvbe/fiTcDaqV4c6aSGw0BUeJteKdJ
	NfrCOvciOoxbstdVHhdCf+h128UBv3ezPLPQ2xEikDOW5IQN65HA2JVQSHXvRGM=
X-Google-Smtp-Source: AGHT+IHIl2MZeMkBVrLJIRHhVpuSEJV9aPJOnnzBZz3010xMAZ4WjFN325JjVYWACAPKVHCN6Hpa3Q==
X-Received: by 2002:a17:906:bf47:b0:a46:22a3:4798 with SMTP id ps7-20020a170906bf4700b00a4622a34798mr5890684ejb.46.1710308354976;
        Tue, 12 Mar 2024 22:39:14 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id zh16-20020a170906881000b00a44d01aff81sm4525776ejb.97.2024.03.12.22.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 22:39:14 -0700 (PDT)
Date: Wed, 13 Mar 2024 08:39:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v4] staging: wlan-ng: Rename 'foo' to 'rc' in p80211conv.c
Message-ID: <f6f5e779-4881-4fcd-b162-8a8dde514b2c@moroto.mountain>
References: <ZfEvTF7qwYZORGsY@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfEvTF7qwYZORGsY@MOLeToid>

On Wed, Mar 13, 2024 at 05:45:00AM +0100, Felix N. Kimbu wrote:
> Rename identifier 'foo' to 'rc' in skb_p80211_to_ether() and
> skb_ether_to_p80211() to match the common kernel coding style.
> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


