Return-Path: <linux-kernel+bounces-156616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C1A8B05AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25671C23B49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9E158DC9;
	Wed, 24 Apr 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x93+mF6v"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78D158DAC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950101; cv=none; b=F2miAjzotC9GVehF2RwNLWP//TgwfKRF/I6rUnt6vmN/TcodHqOMJkFNXHapoC5ss80jbo98lzQelg+UHnQsgjmlE14fWRIKmgXvW1HiHHx1Jm5gomQSPFvI7ZbDlUTzY/iaj935LDOtKrN8nhjcPyQHmUNzfgK0jAs2iazL7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950101; c=relaxed/simple;
	bh=r8/8rUljBFL5uy21qYnpw+9WCvbmX6HKzPwVvP5HhE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH4iDI+oPR9LQ4rIRc4ZQpFcDLXp8Lu9KhcbUX08OjvIIGR8lyUbhpyw5ErDLdrNjnbmZjbu0BBziQ5H/rkYrxTISQpoWh6f9YELMUa6xD4JSud67FxIME/lLzgOU8mI/YeUyKNeCAiNEyPvOVA5IokJ6jEcKri4HxIJ6zoLj5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x93+mF6v; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2db17e8767cso84745211fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950098; x=1714554898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NooyyRf4E8zJBxfzPXqF1R/V22BGn4ie5pOTp1AGeg8=;
        b=x93+mF6vAOUryHz8PFWITdeeXyoQ57JLRq7nQWgu6nX2y5FI8I5muX3Zs+1cc96dMN
         Q2JmW+KGSgNVqb5W+Q3D044JXSnkNSuACnz7AsfCAi/ZYPQiXqwWst6crNHAq4RRiFGA
         k3oS4ATtVd/xM9vc6b5p1867O2MPuPFGnq/0z8HIepyBPbbtS0XlGWMqChuJGfmBrF2a
         Jzja8tEf7QsA539P+38YVIEQ6eVrzyCtdtK/mfysfyEGmkF+fQ27HRwNIUsXpY6u5SvL
         grBleQPLJ322fZAwxOkSkC35ektd3sOdANUouk64T9vfdFw8BjbjP4vPH1Hy5yaj14tL
         VcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950098; x=1714554898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NooyyRf4E8zJBxfzPXqF1R/V22BGn4ie5pOTp1AGeg8=;
        b=BWb4v6aqVNDymZ+YVl3rHpdLvzcT7QXkvyK4v7lmWafhSgP2062JuXDVn0A5SndYfL
         HYzS4V5hJx3ZiDztqOtcTACdawIlAdWJ0ww+WCWkNxLoqAkPefPbgMJ9ikQ6BBS3QhDm
         PuRzc/ZW0rmxDCXbBb2ICi5kxGgyYt1B2XsoKDRPsEOL8APqXFaUKX5anL399q6Nw5R4
         lZqeot7nm0T+0PZ00Q66dRIflRK6t+jLUkbnueNZAd7MytckCakUSB2jUd7pH63wXgLF
         OHOpBjgjBXgV0smwIhv5mKilh0D7o/IGYmoMwQIeB2gOdkhPNNXwH0xqOmElbT/8QhNG
         3CRw==
X-Forwarded-Encrypted: i=1; AJvYcCWLNdvYP/vuRfGTyeBBAOrv+zFWc6fEU1Uhc/+0WYfVKJK6/wjsYsbzuP09AttcvRAeq3M14fqCb5lB/tQzhUwpob9dHWYe1CDwrOiS
X-Gm-Message-State: AOJu0Yz9f286zqUefqO5vb2fzWWgRlA33yg7rrMaXcptgaYYHY8Ou2Kd
	CkJZepjRsMaqkLQFZx1MEP0u9Z/iXpbEhK508GkQgCdNPhfuu7nKSLctHnkfx5Q=
X-Google-Smtp-Source: AGHT+IHPjVkFD1fyW4SC/czA4LlNzOrQt3ZbtnCgnujN2A091L774ba/AnGg3Pj5wvDYnAl86nSCgw==
X-Received: by 2002:a05:651c:1043:b0:2d4:54f2:c409 with SMTP id x3-20020a05651c104300b002d454f2c409mr1089507ljm.38.1713950097610;
        Wed, 24 Apr 2024 02:14:57 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b00418f72d9027sm21018608wmq.18.2024.04.24.02.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:14:56 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:14:55 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
Message-ID: <ZijNj7DzL9e01Vnt@mai.linaro.org>
References: <13515747.uLZWGnKmhe@kreacher>
 <15186663.tv2OnDr8pf@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15186663.tv2OnDr8pf@kreacher>

On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notifying user space about trip points that have not been crossed is
> not particuarly useful, so modity the User Space governor to use the
> .trip_crossed() callback, which is only invoked for trips that have been
> crossed, instead of .throttle() that is invoked for all trips in a
> thermal zone every time the zone is updated.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I would also consider removing this governor which is pointless now that we
have the netlink notification mechanism


