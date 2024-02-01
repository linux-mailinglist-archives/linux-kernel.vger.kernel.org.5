Return-Path: <linux-kernel+bounces-48278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081BE845980
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8931C29952
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2A15D47D;
	Thu,  1 Feb 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d1sKTZQc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB335D479
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796115; cv=none; b=Q4Gu8a1Wu622l12w1dhYZyr1Mxccf21V/jgI69akpDfGTOQlghxgyV4JhGt5ov33ty5sg0FNOLYxrcFt965rlrjf8y6Q8hKqkUY6rZJ/b61pP39DLrTQKxob4cf55tQX57tiArzDOrjN4wvPuAwQB6VQgXblNUXvo/1WV5zS9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796115; c=relaxed/simple;
	bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbCfaFEAh4i/YjUtW8OhFWKPRhWLPcc1Szt630DAVdcG5OYwr1i1SK/M+COv4dMRmex4C6xU5bwogUQOdMsGSCtwS9eOzvd3zNksaRGuGRpdG1l0r2UsL2xxhXYil82SiTGjKAWl34S6aHs45FYx9VosEfBnQzBvQYm+dU1rwWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d1sKTZQc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-510e0d700c6so1074223e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706796111; x=1707400911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
        b=d1sKTZQc2gejwXWVy98BoRcKXeL41FYhyEuTg52qCm7aFDIHlzsDw30Mpq9T0gwmIM
         E4OxVEbzIX+orj2FOEsPranw0Q32c4BOfJ1J7nvsCq7Hbn5usxPMJszWsI0Rn4Yju9FR
         0e1XOcXm0pwG/CafdofiJmTuqI93jVZkq+owJlJKPUWlRKxpDoavhGbI3xNU164RVfZb
         b93fbzumUmKjBFcj2mIMM2xKL8TdwSObEBsZarMuudEEi75smvB1Hwg9sm/Vegb7DDh9
         4TWqiWLLUPU6bHQ4dxEnKptvPqPk/f6a54ZoPITGz2TWDEx9HcZX6oB0zEJ50lX275vz
         4FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796111; x=1707400911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
        b=IoP4ApNWOEulwIPvN1SWw2tKLG+DyFtGHRtGgL3YcvkYywTo2M1mXnQgRwa/pOnEUl
         I2juVAk0PBwYincLJJElFk2lH66e+mtiCiYUOhluBJeRUxU+iiM2GwwSrOgY1FvLLUwW
         Rfsy5iyo6w88OveI3lYQkcKXIKWCkzNNT7rZvzgBx63Co4tF8hnecdJgUIJ+lf+gw+7O
         VPmX9Vr8ZZ82Za/a429QbTrIYdMdtFc/OlCyzLXuXsnPjL4QZlfFQmMKuTfA7qnkoECr
         uZMuZtAWpFx9LXU+nrgljcjC2LNUP47SOOT3jWxoCK2D6ThKcnvgnEuvSWf+9jpUFwOA
         Q0Mw==
X-Gm-Message-State: AOJu0Yw+QnU5RyMGV0I/aQKi3DA4VbZoyjF2EIFtb09fW4B8OXMjJmZs
	TvhKMfzBjGuwv6C9VRF+XkabnlIzQ2ct5kP9xMz6yI39lbzm67vnFRc729wF1F8zA6HLHL8sA9e
	mtKs=
X-Google-Smtp-Source: AGHT+IG9TMHzKkmn1MLR1nInbrtFVlsDxHGMGq2QfUrOTwbaE4ygUkEUKBLaWl1pYF85hpICE28dmQ==
X-Received: by 2002:a19:644b:0:b0:510:1bbc:96bb with SMTP id b11-20020a19644b000000b005101bbc96bbmr1735662lfj.24.1706796110872;
        Thu, 01 Feb 2024 06:01:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMUxcq+7ehGQMeOzDkjytYLdEGh+MFJsN5LN+Wo6HUMb8mpckZqVVBQZcZjn46Siy4LaYqrUr5sKwXzK41prZddw6UddEgcDb/pO6bgMZyHzUtuU/vh7XDX03QV+/ltap6yQ8jkrY9cBahHEyZyjuggDddkRxBi3hGPk2Qor9c//vjtd7MQHxijx5QmjX/iHl2Lxli8tfKKF3h56esd8ouQa7/6LZYJPqI113ZZLQPgXCO8wMA9lSsweVD2u3fuE7aKBrYV5ViKmdUbd/EC4tp2jc8HiIOm7CgBeRV5uDtLuJs1ftucK8EZvb9XhGEvSIuGdKLAEGqT0zW3sIVVARhARQ9+rAhzn+Y4zghcp0FjWcckXdOAXR7BPRUlFKCVoHT04W4CEYL4QN4SVKVw+CWXPUIyTj4cA==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4406076wmb.20.2024.02.01.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:01:50 -0800 (PST)
Date: Thu, 1 Feb 2024 15:01:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
Message-ID: <ZbukS3j_cS57FmZ9@nanopsycho>
References: <20240201124714.3053525-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201124714.3053525-1-alexious@zju.edu.cn>

Thu, Feb 01, 2024 at 01:47:13PM CET, alexious@zju.edu.cn wrote:
>When qmem_alloc and pfvf->hw_ops->sq_aq_init fails, sq->sg should be
>freed to prevent memleak.
>
>Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
>Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Acked-by: Jiri Pirko <jiri@nvidia.com>

