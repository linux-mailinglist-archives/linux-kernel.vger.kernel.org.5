Return-Path: <linux-kernel+bounces-76778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1A785FC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AD34286298
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604C14F9DB;
	Thu, 22 Feb 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4mgHzoY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52EA14A0BD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615944; cv=none; b=GRrj5GZVpZjRnjvqUflmX+vG8rmqKR5nK2LTfrzhAeOyaSBHlU/kj5oFQyeCCZ0A6Uxk5EEdbuHXLUC5gm1MlSbB7f7SpXa9SPdj1L7IUdEq9X1HrrO+ROR5JNTQBTIOEZubQU0Bwj0+ZE1TfIotAcOAPhudpoztSJvHOV9kWGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615944; c=relaxed/simple;
	bh=HZutNOEuozUmilTycsHTvraIH3r8+SypP+r2VRMcm40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Obi8Ar1C30oOmSlOHs0P4A+grcDGdVyhHmlBVwNvNiUQqPtO01LQljqAusGFzGh2/qsa66DmAmPfqcnsuMkTqKGftgY0SZMCZtqBZITVdJKyyPybfd4RHi0jrVANZ9j+2ntLqAZ6uz2rkNw4pEQzstTPeA8pi8YZ4jBNSUNScG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4mgHzoY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4128fe4b8c8so435235e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708615940; x=1709220740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=s4mgHzoYRJTs6oIl/CU+su+3ti314XJjJ8DBd9P2fX2lDHNWu1bPc8E4czizspP1ob
         Bh97ATikC26VrwpCHTfoV21EGyYgTIsffTuDHU1e0pnd8dEGIhM7NkVXOn04LbXdlzZF
         t4kTwuK1HCAMllWowhner2tm8/9av9bXvTPiCRSILn5xySkPs80HYKh3Jh/0GiOFHT8T
         F120R8vTh032xNb+6MJycxtvkvLTKNJgwDAJaJ1LZNtr+13iCDMXPPXqt+mUfnSJ1BpH
         MLwDlUE308xSoFlcGcrJptebxAVmcdxUVjto++7wQZ5G8pgnXMS4yZZaOjmTk3B6NZIu
         TdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615940; x=1709220740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=KgRHyZ+gM0H4n9uh6uIqVTF12pAsuLDGO49jyLXHnDx2zl3eefqMleYe5+GnlUlush
         1uCfyERvneOt7rHvMuCL2AuNyOG0stRopu8Ty0ygdbG+KW8KuAgTdtX8LB8Mkwvk/vcY
         20ZYlVLR6Mu+nOFWsTIDfkahtXv1GeUsmkagpj+f2vxv4emaIxQHT1ov73ygTJzloLtd
         AF0RC+i10rCEPkNp+gIoyNgp4YmM9F5+7cv3yoRquExdZbM9Qz11bHUdNnaApYEoqL3P
         b94FeNzaL0eqAJmNaApLU8fpCZvAouftQB3orZYJkueQ/rb8kFVAa8m3ZfG/RMPGlIlR
         W69w==
X-Forwarded-Encrypted: i=1; AJvYcCVPsBZ8anFkRT9ikK3Q3GLd/gvbWMOZLD9O46tqNKdXmerx4Zq3TKFeJL0T9DWYs49HXuoj/TkD1ZZPoPXgwbEOdgG/V+LG848R/wX9
X-Gm-Message-State: AOJu0YywZZa3l0f25822W1D9bV8hBQaH3sd/H7RT1IgBGZvBSRlWAlCP
	mmAc3ADxIL2YW583CSoRrPzs+Rqoj7tFSNx+UAifQXjFYhZx28kVl+QwkAlrset7WXOJH6MlXBC
	l
X-Google-Smtp-Source: AGHT+IHFWn61+J9PBn0aK/tovKHOYNTYZTMeCP4cG4kdpItzeBRLIBT4km0f7vWmhkKsGRxrN0UJVw==
X-Received: by 2002:a7b:cd8a:0:b0:412:a6b:d572 with SMTP id y10-20020a7bcd8a000000b004120a6bd572mr15081272wmj.34.1708615940264;
        Thu, 22 Feb 2024 07:32:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:32:19 -0800 (PST)
Message-ID: <04f0a492-aad2-43f9-a3d2-fe60b50caefb@linaro.org>
Date: Thu, 22 Feb 2024 16:32:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] thermal: imx: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <3790563.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3790563.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the imx thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


