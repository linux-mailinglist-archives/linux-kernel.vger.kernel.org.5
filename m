Return-Path: <linux-kernel+bounces-155477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6758AEB21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85422B2235D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090313B7BD;
	Tue, 23 Apr 2024 15:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNNfGft1"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66A13698B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886260; cv=none; b=SJ/AyJdYrUWu5Dwo9l0FB3SZB6GiHNtz8owNFkjLiKhGRq0FknQ3iYyVfceZQ8VJ0rjgpdoaOaQwbnz7PNTF7V/MwVNzHdGsuzQiP+A0bGIz/A37yqSLhp0CquzHHQzMKnpUGGZoDBzD2GD3vGH3qU1zYeevMzUTpTPqRkvRicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886260; c=relaxed/simple;
	bh=NWSeoGq1TEN1U+n1nyMzbI0fbW1qDCiduKMQPey7Iv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xx5bfoNTvRRKaP/nmwoViHe4UJQsy/2J/7OsayFDpDr7Wobl/AYffAfVi5Z62EV8gmIt3LOjbInkybd2eckpjpxtGThcaGgmv+wyqGzYj0JdfyjQAwoJ/37aPXFkvt4LmmECruHING1JjRRd+uwMRI+C+0bE38ik9VjedkeQ+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNNfGft1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso21858855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713886256; x=1714491056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wunMT8BtUYunQ5ZQ9XvrfL95oO+APrTWziOgsDUBArs=;
        b=vNNfGft1kwAmqpanj16khBEdFnVLTnAYJuj5fsvT5N/vT41n42o7cDHHx13InhJ45V
         aV1heUKJB7Bf5DOoXnknm0LvgN+EF2PxbJoKLqkv5qzSGpOvL/SnxEmPfe4RlY6qte5X
         yjiVvohIU08y1C8ocy6IaOWmBJW/dqYNgzcrLTktzO/y5Cq7OXHSN97VbIcuRPzMtOrE
         VOeTLMyxzHdPBPwf7QICV8ViOHXVLs5yeqYqBjtL47g8zGMsw16C0UI/oVyon0GWUiM7
         CtBfja6DYTw5CvMR15jWN/gSmYzo2/STDTIxnZ0NtzF+zN1cOeAmldLOFExD/MyVnGRH
         PSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886256; x=1714491056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wunMT8BtUYunQ5ZQ9XvrfL95oO+APrTWziOgsDUBArs=;
        b=uUtkp4l3GjkSK5sanmE9EiQ7iF3Cnt7ya2F81nQjuf4n/WDjJ421sCklzNR5yc7ifH
         MIT+vVdsSA/J2327oMbOjSdXloMX2wRhUG9OaUSk5jZGT5+lOCThE18gbCs4MrbXq4WX
         LyQfb2fKISqlJMtqpZlHg2+C9qdIGEBX7fgHEaxGWHA12CR+hItUWCLlp9Qzp6GoTpf4
         wvXfT/LOPx6QHTW1VjdWyH/f8T2fSOVCyO8fMbGlx70yD3G21OUj3PXMsJQrgOMew3+v
         Gcg7Q2v+aAQ9cIekypuxrkmRD8+UPpgd8uwgEFoBG4vPuCXQL+twIM8xtSGDmYHb4WZc
         Ntew==
X-Gm-Message-State: AOJu0Yx6Q9dYdbxa8vh3Hrc7VZMRSSjBoQukQkdpyaJESLNVymxeUSro
	NNnqeOu222CJ7ioe8gv2zAt413z/nHFRnH+49+O4HmyCd9wTHj3RB5h6Z4qdaQk=
X-Google-Smtp-Source: AGHT+IHiY2iju4KbgBOmWnX+VMAd7oFJfls98P6TP28t6iV+8wPaeKtS5pYAkfLDbQno8M9mZMyVyg==
X-Received: by 2002:a05:600c:4fce:b0:41a:4819:ebf4 with SMTP id o14-20020a05600c4fce00b0041a4819ebf4mr6383611wmq.39.1713886255729;
        Tue, 23 Apr 2024 08:30:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm24418293wmo.21.2024.04.23.08.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:30:39 -0700 (PDT)
Message-ID: <dc6c32fd-89b2-4494-ac26-588adb3ee578@linaro.org>
Date: Tue, 23 Apr 2024 17:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal/debugfs: Rename
 thermal_debug_update_temp() to thermal_debug_update_trip_stats()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4918025.31r3eYUQgx@kreacher> <2937506.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2937506.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 15:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename thermal_debug_update_temp() to thermal_debug_update_trip_stats()
> which is a better match for the purpose of the function.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


