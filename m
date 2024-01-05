Return-Path: <linux-kernel+bounces-17764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99591825236
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF55A1C23106
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AD25572;
	Fri,  5 Jan 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4n0J9fo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B313A250E9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d4a2526a7eso9319275ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704450962; x=1705055762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYVk8A2W+FUtJ8Xy1Wnlgo/2i74l4ok4AKaqwgOLkgQ=;
        b=B4n0J9fo8Ijo8Pif/PrLgphBQxS+cnNkdD0yjCVLLWzjSL+MgVnsRRGSPrLje1yc4O
         Vk3bTc7kkFjGWcuXHeVM5Hk6HNo63tUGjxmfsr9/g0AdsiFeAtZhYQ74ai/i7zpWlyfX
         s+vazXxvZTmYnhx/NF2wqbuXRDMfWUl7xIoeJGVtyKZ7hhou0mltw1sUIj99fagILEUj
         cVn6lr7/M8y0ufeamZYHPuH+quR1j1nJFBWOPtaNKMn625Dg1G1+WZCQLNJi9fVGbNFf
         Yl70CMhxLmtleVgriNhbymQKCQZuRDjQWyNEdU//udzx7/4K/i4T0qHYZ91Eo5fCBtOR
         zBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450962; x=1705055762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYVk8A2W+FUtJ8Xy1Wnlgo/2i74l4ok4AKaqwgOLkgQ=;
        b=Q9JFKS8GDNm0p16ZZ/OMQXD6DXD20pZ+86FKo/zf4q2uw3rxG08mwKTP/1gMGT3t50
         VqX4/OY08YGAElcftZub799x12E99IjClUVbdlvhujGjGIZDKtdHPsvjfdAL66IhzqXW
         4dkGQbI5TY4XUf9s6WcwA2pYl7OCg+8Ce5YBwLHCyvUZgZcUj41xVx0JGh5BJPKhOsLo
         wGklJN4a0AEf6USfxewMlAzIylzU8CWZzI2Anpcfoju688H9q2M8DVCowZZDOeyRGWIc
         cs25Kvp65u2KAB2wNHqFSFKKLi5ACuhXdzCEMakZJg3NdlrX0BG959JVRiQ50ObUbN3V
         uaMQ==
X-Gm-Message-State: AOJu0YwqX2UGE9ndgcoahwz2/xlv2TCllVG8ZP7XIpVgf/84EfEtgtJX
	yDNTOItCJ8T/z8iP6P2rLYwMyk1wKUaJrw==
X-Google-Smtp-Source: AGHT+IHoKcEtt38NlGK00XipqMe2SBKo1AhufkFFOv92P9hxGY8Eq/awqID3GPMUNAoD8jAAyAXh8Q==
X-Received: by 2002:a17:903:1c4:b0:1d4:2732:5cfb with SMTP id e4-20020a17090301c400b001d427325cfbmr1971565plh.100.1704450962074;
        Fri, 05 Jan 2024 02:36:02 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902d5cd00b001d08bbcf78bsm1103069plh.74.2024.01.05.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 02:36:01 -0800 (PST)
Date: Fri, 5 Jan 2024 16:05:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>, Nishanth Menon <nm@ti.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-tegra@vger.kernel.org,
	Avri Altman <avri.altman@wdc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] OPP: Remove the unused argument to config_clks_t
Message-ID: <20240105103559.jj4vbo4fnhodayvx@vireshk-i7>
References: <f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org>
 <64ee255e-9a5a-405e-b342-e91c55bd95ce@kernel.org>
 <d994e6c3-f69e-4910-b699-65cb3ab6c72b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d994e6c3-f69e-4910-b699-65cb3ab6c72b@kernel.org>

On 04-01-24, 13:56, Konrad Dybcio wrote:
> 
> 
> On 4.01.2024 13:53, Konrad Dybcio wrote:
> > 
> > On 3.01.2024 11:48, Viresh Kumar wrote:
> >> The OPP core needs to take care of a special case, where the OPPs aren't
> >> available for a device, but in order to keep the same unified interface
> >> for the driver, the same OPP core API must take care of performing a
> >> simple clk_set_rate() for the device.
> >>
> >> This required the extra argument, but that is used only within the OPP
> >> core and the drivers don't need to take care of that.
> >>
> >> Simplify the external API and handle it differently within the OPP core.
> >>
> >> This shouldn't result in any functional change.
> > Hi, so this apparently breaks serial on Qualcomm platforms using
> > "qcom,geni-debug-uart".. I'm seeing garbage on the console, likely
> > meaning that ratesetting wasn't done.
> 
> +CC Bjorn, Dmitry
> 
> Probably also worth noting it only happens when an OPP table is present
> in the device tree.

Found the issue. Dropped the patch for now. Not sure if there is a
clean way of handling it right now.

-- 
viresh

