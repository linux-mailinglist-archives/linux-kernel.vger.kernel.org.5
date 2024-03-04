Return-Path: <linux-kernel+bounces-90474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C036386FFBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AF61C22877
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC738395;
	Mon,  4 Mar 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVlrbSZ1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE47374FC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550226; cv=none; b=rt+v2fzKkM45n5fNwAx81bVzKuUNqKv+ODNS0N2LzLwN78EwzKxnBjSjz45cL03eSxbU/TOUmF142IrPwvneKmSldsxJIpBd8Ag4dXfbLKi+dBuVLazzdg2di6ZgOsm1eXe+Q8ltLL40IH0Y188VDrpsvAKmKDJCDDaoNsplSmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550226; c=relaxed/simple;
	bh=Cgn+AbUmEAUkw7Gtthr0yt0NYWx7rqcOh+VRv3isIy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNDDhcob0b9PxJXJE4AQf9Cf0Bq1FYAhcnatC1WUo+l/O1Oa0rBkZlE2LSA2ZnJ1wJThkMNNKBqggj9S8aRguohzc74BonlprihHok3uD5tyMiySfPR+VfJ6nwPpnxNrTkUCiRTUYKt2C7L4Ds2erDtC3Qvp/egjEhethWXIBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVlrbSZ1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so2421692b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709550225; x=1710155025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRCimQwiaMy/3k7Ta7kTx3HHC9SAus7Ndnzb5kkMHD0=;
        b=UVlrbSZ1O3X16VEi1JHckwrjDdm0LX+xFXgz8nGoPIa1DpQH9KaZ1n3LOXwR0APPP0
         G52Oul5bQr0PYx4Y/6gIe9dTqiHjH12B0FpwgddBVXiwwHhqzBVSMbw0ZPxdhkNQhsa7
         pAg99heaozZG93DiFfHgTfsg7ntxBrR0Lhaoub/wIiAkoCK4RWKLdkHid+oXdpwv7PIH
         5GA5XHLJ2y4hKluvN2tDUsL0lsVwNf+TCJpLNXb73sQL/OOGiVM/1zOejJ/xcDhM8vvV
         lS8sSYSVFVwE/Frpd4Cd7vzpL71MMYMj349parDCc19Wi6Ka0JkglUQar/JlS70nqFXj
         f1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550225; x=1710155025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRCimQwiaMy/3k7Ta7kTx3HHC9SAus7Ndnzb5kkMHD0=;
        b=NNsXSQ2H1cVWii0Ykk5gUSi4Nm++acAs0KDGjZ4w2JThy7A4ckYxpMGuz00197VMhE
         oN/27XsiCcElh4ekYWZXPeEzy9xdy/QpWai7Czdkndx4cqq67lZY5G8R5xMkurcFmA1J
         /oYL2MFsVfZ7WgyTj1GN5UGrhiXoNulW248nMIG5S33PQ4w4segn9Faj1f3vgOnNXIIa
         iGKs71tjZPNs/avbTCH6uTjl0s5dAg0m0PErO/l/KR6WSMon5RbV+YRtPWgfq8fa8LcW
         eIKJxbih4CqGcWMD/47pljM35k4QHszyfupOKCRN9BwZzHBvoozggZMfQ2dbfy/3mG6P
         PN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL0nBfRCeeGFSkYL5rGtwcRfKr6wpx6T7vN42J1tkyiAnvyDvNBJ+AnMMDiOK3svGCVlbBSRiC6+1I56RY/cfgGXV3OE8irkhE2skV
X-Gm-Message-State: AOJu0Yx8RoM0F58b5B2ZMViiWQ5nRk0YNpG7ZMQUkphpyYK01d569vgq
	n3b1sIFKogrtWxOjf1/ZB0GBL3QemQnXaFfSl/L6RW6lJwfhyjwXnh1vdWJHOsI=
X-Google-Smtp-Source: AGHT+IFHnmY9rsYiBuXaQPJyCeTKsOqjxrv1/2WHgvsre2aqcSomXoz0h9mLcg2wzjoF7OHK2UyQ7g==
X-Received: by 2002:a05:6a00:852:b0:6e6:24d0:a171 with SMTP id q18-20020a056a00085200b006e624d0a171mr2452853pfk.27.1709550224498;
        Mon, 04 Mar 2024 03:03:44 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id w189-20020a6262c6000000b006e629bd793esm923045pfb.108.2024.03.04.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:03:44 -0800 (PST)
Date: Mon, 4 Mar 2024 16:33:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V2 3/3] cpufreq: scmi: Enable boost support
Message-ID: <20240304110341.vd6w4mbcq6uwrpif@vireshk-i7>
References: <20240227173434.650334-1-quic_sibis@quicinc.com>
 <20240227173434.650334-4-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227173434.650334-4-quic_sibis@quicinc.com>

On 27-02-24, 23:04, Sibi Sankar wrote:
> +	priv->policy = policy;

Did I miss applying something ? Dropped the commit now.

drivers/cpufreq/scmi-cpufreq.c:272:6: error: ‘struct scmi_data’ has no member named ‘policy’

-- 
viresh

