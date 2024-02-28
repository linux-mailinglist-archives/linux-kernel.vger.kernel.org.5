Return-Path: <linux-kernel+bounces-84566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3A86A862
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76803284FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6D2263E;
	Wed, 28 Feb 2024 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNZcFakJ"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028A23749
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102116; cv=none; b=SlubsNWpAzUCctXgZvajg22/gupuuqKJZoD6/QAwavdjp8vqq+Kdkbxq/PgNXbqswmn/u1T/jtzxID31y3Wd5/aMepYeL8VJQ9grBSov8+WX9v+6sQzQmCVGnzGmW7tFDaafGWfVwuU3NaPjHTZ0chx7OhZmp9Wt87o+CXRzZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102116; c=relaxed/simple;
	bh=eq+doyRi95dVt5ktF60b56jBW71LBSSSuonN4nhu8oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYr6iTbnXjknNMJZT/0OT2ByC1oWhBNnh1ysT6C6+7QQVnz+I8a0bnqyr8CSbA0icAe+sn7TTazSvOW1BCBEXaXramYj/TDW1dN3xdxh6gQNv2f6pNNR4IzIoj50Uj2rorJ/28PHW86ayanAfw6Ad5b+ABFOadAO/apvtZZuH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNZcFakJ; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3906919b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709102114; x=1709706914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Lc8F5AVcDlsSeSlXPJ5yXQGz/3wpAQDPwCrkbyIyyc=;
        b=lNZcFakJ6DTvInAhOEwl0GF5+1A1PRQ4zRn4jGiDRu1u6pP8aMLsMvWzYiDY4veEyY
         5Ve6Ug+xI4orNb1aSadht2sii16LlaHdRyFx802sYc4Q/xdgkluFkY4+C94O3t9hS/Nz
         9vZPc6WX7bLm1sD2tN5nKSw6DAwX/D6CMPQp47DRk9PTKgmHcdiRTIdfyhTayvccHqkc
         yJKn00KAUw0WzMjcgkSY8sB88ILQp5T8iQnExkWdZ/tDJ6KnzYLwiLQP5MEVhYXIbk+E
         bq45fVeiSlZbsMbvKjDsH9JnQ/kAmy0k26y9v7V+TVv8LtAtOyYkTpUQ9IgPUTQQr96f
         id/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709102114; x=1709706914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Lc8F5AVcDlsSeSlXPJ5yXQGz/3wpAQDPwCrkbyIyyc=;
        b=v6Evxbi+ZnjDwpt97p4pQhKETFi8Uc6vkaCCiY16B3CenAY67gRP3lmRlDiLSMSTjD
         nWIrcTVCSCCmXind4aSxqjujuhn1w3TGC9GysEmtMicS0FnA5NMGfYMwG5pJYmo467j8
         XOGAugr/Fk3atQokAsyUFNlewltFnV3tJ86FIqIbBcRPx0uu3OBjPo8B4mYfX0KrshaJ
         3Bbq7Btz7UH1nwVzmfLLnfe0/5OB2e4QZl8CpvT6dTo96eNoz9t1120h6jYeEuNVRkky
         IllveeANly1OA8ot8zJACorR9wiYGbMPBjJ75vaIgbfSgbKk6rrTtMn8SqKZlh74OcBQ
         +yyg==
X-Forwarded-Encrypted: i=1; AJvYcCWcP+ELjDLlINcULqQJJSjKgSTkJ0BwXVPejp0H54dzoFplRs2e+kXq1kn8a33bv+alGfLg+LuhWyln3lFKbBOwSz/61IMrX2nPG8Au
X-Gm-Message-State: AOJu0YzHQCEDALtmjmtmHfojSYGR9WRgtswP9M6z+qxgKRJE2iyFsWXQ
	f/IW9eRQ/QyAPsdaN3fbruQyQNHkWyP1s7iL8Csi1fGV88EF4TZ7V6w3Fv3YgE8=
X-Google-Smtp-Source: AGHT+IFFPuZE3jA/EEFb8gwODVORPCrdEpE/XY3KY3p5ZJQ+H28SBXnCoY07Y7TcPPXj1vn7YPDSag==
X-Received: by 2002:a05:6808:14c3:b0:3c1:8412:e9d1 with SMTP id f3-20020a05680814c300b003c18412e9d1mr5307918oiw.31.1709102114175;
        Tue, 27 Feb 2024 22:35:14 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id ey11-20020a056a0038cb00b006e319d8c752sm7100775pfb.150.2024.02.27.22.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 22:35:13 -0800 (PST)
Date: Wed, 28 Feb 2024 12:05:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: dietmar.eggemann@arm.com, marcan@marcan.st, sven@svenpeter.dev,
	alyssa@rosenzweig.io, rafael@kernel.org, xuwei5@hisilicon.com,
	zhanjie9@hisilicon.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com,
	linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix per-policy boost behavior
Message-ID: <20240228063511.rcntpb3dhbbhf7fb@vireshk-i7>
References: <20240227165309.620422-1-quic_sibis@quicinc.com>
 <20240228050703.lixqywrtxravegc6@vireshk-i7>
 <c165dd32-1e51-2fac-38ae-dd7300d36372@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c165dd32-1e51-2fac-38ae-dd7300d36372@quicinc.com>

On 28-02-24, 10:44, Sibi Sankar wrote:
> In the existing code, per-policy flags doesn't have any impact i.e.
> if cpufreq_driver boost is enabled and one or more of the per-policy
> boost is disabled, the cpufreq driver will behave as if boost is
> enabled.

I see. Good catch. The first patch is fine, just explain the problem
properly and mention that no one is checking the policy->boost_enabled
field. It is never read.

> I had to update the policy->boost_enabled value because we seem
> to allow enabling cpufreq_driver.boost_enabled from the driver, but I
> can drop that because it was just for book keeping.

So with cpufreq_driver->boost_enabled at init time, policy's
boost_enabled must be set too. Do that in the core during
initialization of the policy instead.

> I didn't want
> to include redundant info from another mail thread that I referenced in
> the cover letter, but will add more info in the re-spin.

You don't have to, but you need to explain the exact problem in a bit
more detail since it wasn't obvious here.

-- 
viresh

