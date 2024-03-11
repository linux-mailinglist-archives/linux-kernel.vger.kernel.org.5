Return-Path: <linux-kernel+bounces-98461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A695877A75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DBAB2143B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADCB8820;
	Mon, 11 Mar 2024 04:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUuReWxJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA77489
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710132650; cv=none; b=ORiSL4A+jqpmh8sf27rjivyzGPt/QTQC63AEKLRUBxWFmgZa3pUJJQ5pL8wKdoowe7Bx8KGDx+GG83aRMVOX5uWFowGT0H+dcoJCux+C2sX1GQwtNZopNp/aewY4RTgedRO3Auwd4siO4Plb0jwg0y+bO5Tyc5pPiYXRRalwAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710132650; c=relaxed/simple;
	bh=x/uzfXxOzbqKSd67PBuy83Et2SEuvF/AVOWHtH5UYWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFnftvlwRbBudEvxveX0kQpPUZVuG4BMkr4azlnTvhVJr2PqcWAf8Knm/ulJgNCpAnYn4JqNrGb3jezTQcr7ZvZ6wFn4h4SJ64mIcULYI/UvvF90+HYFaCDRK+c/QD3FVhO4doRpKF3RUI7FsD2apKtVLuaxyvkSy4+FEhqodPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EUuReWxJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dd10a37d68so33025965ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710132648; x=1710737448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1/vyyb7UixM+MEvW9AsLcC8YOFSA6iDMoo7vUn6seo=;
        b=EUuReWxJKlbMsZrvH43PpeDcO3bhy7s4tyvJ1bivV+M8Cj0WyvkkacvlLhP9ml4Yk2
         QP5aSbivsMM90HwvGbYKTPF/1d5MAplBP8KL525TeV3e29gq80a2HEcWmyPc2p5elrl6
         3nXBAjDXio424qm5+Yl58A5ut7Br66syHBNNqGiJHqCUJD1ZwcpTnJbrAfBQGEwM1nIG
         QD7kQeXpP9LzlfM0G7TPe4I6V1KhYwVCafpaRJnZx4rzgZB7UH9q2kIT4/+FmxV74IVD
         T/CMQZrWc33k3peybKymV2oaT4dRmxuXKNCfV8THXSv8a2C22LMSBr0QvVgQ3afBZahZ
         ySgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710132648; x=1710737448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1/vyyb7UixM+MEvW9AsLcC8YOFSA6iDMoo7vUn6seo=;
        b=GJqBcVJQOdxxRW3s+DDRKjXCN8bEhq1L4LxCjIQfj66mIy7hQXc/KIrLQrNDbEWUTs
         spQh/bOTGkAaxB4O/mF3PAiyUCRAsTrnYi3HMgN96R4Ocw77BrXZFmJPGo8O2+o4lBds
         jid/BQR8lX676zdc0N6Ssjqao1BwRqv94HT2P1wGqgKBUhjQM8kwNTLK/Zk+GNj+zvdJ
         jkclg2UIuwIUDodqIHLq9jG28IU5DZudcTLiC0HJZQ/BZEMajgVB6q1GSsavcKzopkFY
         iGvnu31dUtKl6ZJI4WKA1vWJDQN0cXs0HtEBeqNlnhJN4Y8UI4O6xWW/dWdKv9UVuB9X
         SAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4kPUY9ZqNyjFBqxTTnT+y+QJ5vfr3o0zZPMEjHCtTB0ZscEfevoazkofEMoKHsjCfzOH3agewLrSw4DChOkIXwgEZkRKbNI7cgBJQ
X-Gm-Message-State: AOJu0YxVl3nCdsoemw0d7U0H7F4yqBOQL1nDk99nRTb77UuH+65toG11
	uew9hyoa6Cbywr75cmP/H8i2u7izfady5sUTVzLbSIKkIGlvEdh4khAv2KGeVVI=
X-Google-Smtp-Source: AGHT+IFaFumoYymXG0elFv9QWhPYx1mJ45zKOvRlcg+v0XYxM1IGW4kDZhWUjELeGZppoh4j4XYmZg==
X-Received: by 2002:a17:902:ef8d:b0:1dd:6296:1709 with SMTP id iz13-20020a170902ef8d00b001dd62961709mr4639033plb.63.1710132648326;
        Sun, 10 Mar 2024 21:50:48 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001d8be6d1ec4sm3591966plh.39.2024.03.10.21.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 21:50:47 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:20:44 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: dietmar.eggemann@arm.com, rafael@kernel.org, xuwei5@hisilicon.com,
	zhanjie9@hisilicon.com, sudeep.holla@arm.com,
	cristian.marussi@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_rgottimu@quicinc.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: Fix per-policy boost behavior on SoCs using
 cpufreq_boost_set_sw
Message-ID: <20240311045044.7vvzbsx5nqs5a2lr@vireshk-i7>
References: <20240308103630.383371-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308103630.383371-1-quic_sibis@quicinc.com>

On 08-03-24, 16:06, Sibi Sankar wrote:
> +		/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
> +		if (cpufreq_driver->boost_enabled)
> +			policy->boost_enabled = policy_has_boost_freq(policy) ? true : false;

Can be written as:

policy->boost_enabled = cpufreq_boost_enabled() && policy_has_boost_freq(policy);

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

