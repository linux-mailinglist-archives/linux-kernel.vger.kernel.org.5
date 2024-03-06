Return-Path: <linux-kernel+bounces-93345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DED872E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB56A1C231F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0118049;
	Wed,  6 Mar 2024 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNVbIEb+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A41AACB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702681; cv=none; b=FuvQfA9oWccGeUjVkc1LddcvO3Z9T7tQUdgsg34pb3Hi3VtPtV91+B9DnF70ZpdOYAO/tjVYSDgpzM65cEk9dL62sg8sKfB+bksGNO7J+Kgwgy5edatCqIGUN7q1N5UgV6cGSiXo/EYLV5ZVXVkp0Uu+r2UMKGbSdY3wQaGgfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702681; c=relaxed/simple;
	bh=ZT9hOjcjWi/oD/L3FfqkAn4tAL+bjQNxT2iPUwDZBs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvXYdSsgtB+L4j9lOjEyHBP6FhazXhGM/MHr8YcoSrScqv/vxYxSSQ0ES+RwXGXAzbw/i+1jq60huAArYeyllEM26+hmlFbr5bSfjQl+83RJFfalO17lBw7wjoHsUZpDEEha7syyFc5RdXwVAVAm5eWoeWfxSQxKAPrLpTJAhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNVbIEb+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc9222b337so63394845ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709702680; x=1710307480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qA7H43N6+SGTqrqdgH+ITMwNnXCpkc32RIfzdkvT6jQ=;
        b=kNVbIEb+lL4OKHeIj0YLNXnglvV++5AM48+q7tBf9uCuZlpsxRmbDD6OvyTGW/pIHo
         eAqNvSbWucCkqxGtiblz4+6zyEcPHaGfk7IYSo3tEqAUuQ3n0hN9GikvMH7II2P4FpB0
         ClBqOE06zdFZrfKyDXSLjckaDanEnULDjx4z6G5T3F6VRp+h54JkKxNRrfcsMJCQdcL/
         WF9F0B/B6yDbpHl7TU6WkeAItEYaktPs6kaCjaldD7Mk4nFvy5ooomk0WQpc4pUg5o32
         lh8B9rwFC8cuqInEYcqnjVA5LOPwMMs5woNRKeauBtnCjUf2arQhgsIDOLwl2kPL+SqL
         KdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702680; x=1710307480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qA7H43N6+SGTqrqdgH+ITMwNnXCpkc32RIfzdkvT6jQ=;
        b=AAVCZ9803c7USNVLokhhbu8eN+H1AWTW2bnErsNBYhd497W53KVG9uyEmWze9ZAJW6
         MkoDu065ElUP9ATimcgJtj/wZ6D1Vd/N3tNEMRcRVc7a8UIZ3S2gkoy5URVBMVnNCu+J
         VyMYInL9mHMhu2mo2PlGVEKW6o0ibeeHSLouV4P9VcJr+QeSrKdFQh5J61jdor3eAfcL
         5iq6lSvlHQ9LHlU4iDw+0Gf3/TUBr4f48tN/WGy4frl9Z2QSwCpKrREzRcjzoQkNDXG1
         /D4LZW61POA3t5utxceaWba3ITcFeKEPzOsBdFPTWgRDAKkn3CHzyLu0gyIbu+JRuAwG
         pTGg==
X-Forwarded-Encrypted: i=1; AJvYcCVcNJc2al55bxeQfSbIokvXjxzuzIQg6Lhsia40+FEd2jJhi7wPzMq8Fx93UuzpLI6xggOo/b7SGj+op+G4u+9JESukCxiqQC+KYRe/
X-Gm-Message-State: AOJu0YwaGflom4bKvcIgcn/ceK7ewTfa1Qc1a1tme35ok2nsx3VhuP0G
	cjvMNyfWzjN98/Vu8L8ctB85n3fLk6Izk8Svq1JwEhEqCf0eH8rzfcVVCDmyjzk=
X-Google-Smtp-Source: AGHT+IH0ZyDRTolzKPKAbXqYCjmXgWdRFTovIIC084UoGculvfaBHZdEk6w9URrLSn0hJFvAnhtpFw==
X-Received: by 2002:a17:902:d2d2:b0:1db:b8f9:ea69 with SMTP id n18-20020a170902d2d200b001dbb8f9ea69mr5203253plc.34.1709702679590;
        Tue, 05 Mar 2024 21:24:39 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001dca3951a39sm11536234plc.81.2024.03.05.21.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:24:39 -0800 (PST)
Date: Wed, 6 Mar 2024 10:54:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3]  scmi-cpufreq: Set transition_delay_us
Message-ID: <20240306052436.rt5uqkakrgfcleew@vireshk-i7>
References: <20240222135702.2005635-1-pierre.gondois@arm.com>
 <20240304070058.kfqg3ypssn5x6k7s@vireshk-i7>
 <ZeWzs_g6FvQlHQN7@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeWzs_g6FvQlHQN7@bogus>

On 04-03-24, 11:42, Sudeep Holla wrote:
> On Mon, Mar 04, 2024 at 12:30:58PM +0530, Viresh Kumar wrote:
> > On 22-02-24, 14:56, Pierre Gondois wrote:
> > > policy's fields definitions:
> > > `transition_delay_us`:
> > > The minimum amount of time between two consecutive freq. requests
> > > for one policy.
> > > `transition_latency`:
> > > Delta between freq. change request and effective freq. change on
> > > the hardware.
> > >
> > > cpufreq_policy_transition_delay_us() uses the `transition_delay_us`
> > > value if available. Otherwise a value is induced from the policy's
> > > `transition_latency`.
> > >
> > > The scmi-cpufreq driver doesn't populate the `transition_delay_us`.
> > > Values matching the definition are available through the SCMI
> > > specification.
> > > Add support to fetch these values and use them in the scmi-cpufreq
> > > driver.
> >
> > How do we merge this series ? I can only pick the last commit.
> 
> I have sent my PR for v6.9 already and was deferring this to v6.10
> The changes look good to me. If it doesn't conflict much with -next
> SCMI content, then I am happy to ack and you can take all of them
> together. Otherwise we can revisit strategy at -rc1. Thoughts ?

Applied. Thanks.

-- 
viresh

