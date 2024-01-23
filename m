Return-Path: <linux-kernel+bounces-34748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6D838716
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257262827B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38F84E1D7;
	Tue, 23 Jan 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXJDkejz"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353A4F20B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990008; cv=none; b=lynUoPwZuEMbUerwXgFY5+/ReeijcelaQAq5HTd+55VbmukEOXyckbqUPdzhCy+i7sdsubW1IQa28y6BhjaH/OzKifykkuGCGTAw+jiFlMVhc2Nu0XHqRlLjCK6D/F+l5RqbqUARkKCSp/CRsTzDuCY46ZqwFYN/CqLJ99uqRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990008; c=relaxed/simple;
	bh=T4q6Sos/5XPEHqzYjmwsu0Dp48aHhx68Cm+I4CUBH0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIG5TRmze/R0sazJtFGVtcy3+FDI1iRJzkAKyyB3rjnpeAZ42/njTQKK5+bh7J76V3dQXHAHtTMmAWTRvyRRiL7teASewNIp1NXU8TpUAOPnE34JoSMNCebXSAL0zSN+gHXyvDAL/On37YwxHXK5FIEIs/VQ8CeXTHeyHZ2jhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BXJDkejz; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5986d902ae6so2278226eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990004; x=1706594804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDHsih41QhHdQq0FnZ41+qAtDYu4tobNnucMLu+mtEc=;
        b=BXJDkejzrKiDUTkoEAo6LLXQmJU2em23LK3lCcUqHN84QUwBjwo/zleQCx+xKXqiCR
         THAi/Er6WNCDndmkBF8CMMo5XrlvkaNwtu4sgBcJVxEAGSac1txQ+46mNtqsAhUDSWiz
         D07VM2Qw+SfR7RQ5avSuKjug+HcnWQTJddvkVm3IquZj0GCHRwmXInRYULv1tZTW5/dH
         5btq6Y6EvbwsBqKPBXAWulyLuvH8dnyU+yCPTXllIXqfHBnmOsnY8+GmlIPoeqQ9ZfuC
         XWWQOlm4aBOwRyRX8UeX//Cp2Mqm5yZFtd09oEHuRwaSaVCXks2e+LgK/PuaCKF3CQcv
         z5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990004; x=1706594804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDHsih41QhHdQq0FnZ41+qAtDYu4tobNnucMLu+mtEc=;
        b=kOfyr/VpWpYq1DIcC5fRX+JLAqlbt0knVn/EGWjDjtDTCOvfqzPNp+KH/WtSLaKeck
         +mHW3M5xIHWCulW67AxvFXm3EdkDbGJO0YF4ij/3XP02QkmC2Dtm++2Jqq2oTxW1N7xT
         MRUSi0FRrOf6RiGnswkhGHhJ6tRlYQFzE0HblzzIwZGkbid0ZZ2JqLBk+qSxzyFsGYHE
         XDjN+Q3Gel7SVV+BW69YeAsLrTMHoBYW0PJve0Zrk/JZJm4mX/xi1/Vl5Qd/6JX0mNle
         wTlC6RepF0azJ+K+pr8VCIkdVnh6tdsh5t0jCPsIYrsoyAxNiwuhL+3Kqb0wbHRLVy1r
         sGPw==
X-Gm-Message-State: AOJu0YxWz9l2fRvSs47npDHTBszE1IVtZbFepwUBbf7g0g8iT0s5Q+k+
	Dj31yGyrrnIt62s+23Mkd3pzUy9VtsA4D/rRJphpNKWyuvwgVIcqj5CR9AwMYng=
X-Google-Smtp-Source: AGHT+IHVcvmqk7JJCvw2qP+ZR34MAkZSZ1sPIGmyhTAV6YQKNGqB100KNSxmn5GNnYDiSXxZUAa4Ig==
X-Received: by 2002:a05:6358:719:b0:176:6184:d5b0 with SMTP id e25-20020a056358071900b001766184d5b0mr1672221rwj.9.1705990004316;
        Mon, 22 Jan 2024 22:06:44 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b006dd7f773c67sm207626pfg.167.2024.01.22.22.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:06:43 -0800 (PST)
Date: Tue, 23 Jan 2024 11:36:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: tianyu2 <tianyu2@kernelsoft.com>
Cc: rafael@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6: use regmap to read ocotp register
Message-ID: <20240123060641.gtqghndtja2m6rzu@vireshk-i7>
References: <20240109114521.518195-1-tianyu2@kernelsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109114521.518195-1-tianyu2@kernelsoft.com>

On 09-01-24, 19:45, tianyu2 wrote:
> Reading the ocotp register directly is unsafe and will cause the system
> to hang if its clock is not turned on in CCM. The regmap interface has
> clk enabled, which can solve this problem.
> 
> Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 45 +++++++++++----------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)

Applied. Thanks.

-- 
viresh

