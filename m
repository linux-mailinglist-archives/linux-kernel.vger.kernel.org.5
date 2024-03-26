Return-Path: <linux-kernel+bounces-118316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6E88B7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6DB1F317C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DA128823;
	Tue, 26 Mar 2024 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbYmQTah"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911955788E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421513; cv=none; b=C0iHMsGAWKyxVrDnigTHywF5SwmnCsE1Ix0zy7xqiuLu7+wruiglUd+Ur6KSBz1+aGuYGNh6r4cF3eyYFK/0dLSai55FemhndozhEey6XWftCYrdqDu6otUzpEvd46r6MkAjjWTeNd3+gbKnm/XLf5jRLS8bTgZ0hhasAvNXNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421513; c=relaxed/simple;
	bh=FHSZY05UaAKVZX3qnYgC7wy8iLpuVrMB+fx9JVEbsbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOHGziu/059ZS/cNfaigELTlfPrdXa/GH7LzWFKLuPyc4XBB9wIv1bsQBBeVrBM0WlcmqIgQPAFw8XPb7SlnzI0rwc4Z0sTmCHYsPgC/xoDuc/kiMY2HIFJ4OtNyGXwTMmMKIAl6SsH1SNCG9vGwywrvzjHSo5nx84mnugB0Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbYmQTah; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso31507735ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711421511; x=1712026311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1vdduYlZ8/0jt29VKGia5tGOxMYePg9wOnK6IootjU=;
        b=kbYmQTahCuLTn4qohcTyIh6BLJd7kYoi8P3NLIqmlmBgaTaV1q9/U7tyd97Uk0BOO9
         yeF/tIrIJvtGZqd3DqBdNgm7EHRswWJzLP1ievcgFItqMSY2ca7VBQ6pmDiSGUF2Kxt8
         JLaTOUzE1sQY1Wmsx5V+7QWnjf0nprCHwQZieOIWmlazwzxtj6QT03Bu6NgUeCqUl8Yf
         EuauNRC4A2n+/j8NYHkO61u6OTeX+BJuNFT9BcF7KUhYOAZlhQbpLwBet6mJO9QApY9y
         2RQEzk89S5eG3kvuHzlsgmPYHDT1Uuwo/Iq4HWYXQ85fUzhaytlOlVvpDd8C5bWJQzlp
         rd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711421511; x=1712026311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1vdduYlZ8/0jt29VKGia5tGOxMYePg9wOnK6IootjU=;
        b=f4I4vhFQyFzqDPraKqIWitJdsXDwi80P0F/9ipfp8/kMw+lZnHnWg+ivcU7P+MbNCh
         uxp9ceCs1NhSDL7BJh14lej4I34u/RYs4rqH19R9M9AcT4xVkvhEbPP8vq9xFMEFrT3K
         cA1mWiewZpfl72zcWoIxamdzALOEPPaBYAZXRYnNRT2DjEaBomYZv2g4EEaB+qTFo+5m
         b0sQq8GJlIq799mQnt/FCt6YbPadfe3EAwhSzfjbgI/hu9wlMiC/urkgPhFQhHqxn8Lw
         mqhzhLhNQkLxKORkCVBbf6Ol8Y3TRB1/Ta5rwQijHlezwUzg5dMh35jGowXSWATYdUJr
         Cjkg==
X-Gm-Message-State: AOJu0Yzrwv/yThHJ8SdXuwL/Q5njz1Fq+jSnpucijqIMD4AzZln38qse
	amNcXYq6c6rCvtgRx8hcXlI49DWxyxQ5AmWXiu17pmVnSPBhRUHmo++82+MytBw=
X-Google-Smtp-Source: AGHT+IH4Z6469PmDNsiDlTFJaPLteox9XnFHrhHJCdRAiu3Tv9aI8VbEK6scJgfSJiCo3Dnd8mKFxA==
X-Received: by 2002:a17:902:e8c8:b0:1e0:e9d7:83de with SMTP id v8-20020a170902e8c800b001e0e9d783demr598653plg.12.1711421510637;
        Mon, 25 Mar 2024 19:51:50 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dee4a22c2bsm5512365plh.34.2024.03.25.19.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 19:51:50 -0700 (PDT)
Date: Tue, 26 Mar 2024 08:21:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org, nm@ti.com, linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org, rafael@kernel.org,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	m.szyprowski@samsung.com, mhiramat@kernel.org
Subject: Re: [RESEND][PATCH v2 1/4] OPP: OF: Export dev_opp_pm_calc_power()
 for usage from EM
Message-ID: <20240326025147.qgfl5buiobfqfghj@vireshk-i7>
References: <20240322110850.77086-1-lukasz.luba@arm.com>
 <20240322110850.77086-2-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322110850.77086-2-lukasz.luba@arm.com>

On 22-03-24, 11:08, Lukasz Luba wrote:
> There are device drivers which can modify voltage values for OPPs. It
> could be due to the chip binning and those drivers have specific chip
> knowledge about it. This adjustment can happen after Energy Model is
> registered, thus EM can have stale data about power.
> 
> Export dev_opp_pm_calc_power() which can be used by Energy Model to
> calculate new power with the new voltage for OPPs.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/opp/of.c       | 17 ++++++++++++-----
>  include/linux/pm_opp.h |  8 ++++++++
>  2 files changed, 20 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

