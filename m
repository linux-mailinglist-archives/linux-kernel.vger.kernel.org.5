Return-Path: <linux-kernel+bounces-132650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57878997C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B74283D03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D051465B5;
	Fri,  5 Apr 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2q+Ygvu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585DA1465A5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712305603; cv=none; b=SVqOdifIqZZOhTBpn9IydGkgWBOfbDJLSQf+jrB0/r1PURF4nzqNMOkmX3eMYfCUWJ49/u7Dyyyb6yRbIB3Uwlgwzp/gLXn0GX5YUJ7lcjgjkXcVO1BbqieaSj1/s9jXPIECLHxd4bPYLK6n2Y/G//iulpnbsO8EswL1JPaaBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712305603; c=relaxed/simple;
	bh=L3+wBybU/jlATwmfU1ei974S+uS9/ZbUPBAkmJxl36Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ia9JJkzUdtDen5TpPl6DxJZIRrBhLvhD9ja+5L263QCkP39EfOUS6Ls3ScdZBj+ERF18oY8V6X1S7RoS8JxfCELkpwLsaUUwxRmb3w2nS6vVJm/SnqWhWbpu0zB+Q3hPwgcaEyZxYwQ/9En7U5G6jRtjIB5qztze1EmYsYpF+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w2q+Ygvu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4162fe73594so2614905e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712305600; x=1712910400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yMjODkcesgwF+DXMkkxfajgQj8hEAB2u1kWBMt4YYhk=;
        b=w2q+YgvuP4wH5mxYf18z27IELilPV/Hi7B7zX52WBQ5ynamySMYnwG726cxxtIS+l/
         6ULSYmSrYCXKOF2tJZE/1+s9nmnkumTiHSBXs+oNVizBKlV+wy1IuEhvKC956cx5T55L
         dfcd5ebZFQcnCPX/bitir+SoszM9AGNIi2UpPdpdDcYPoVovMzCo3woafpEzlHGceqgA
         dIEOaLmMDQogQguPZJM4yaRbHy26olTVnDUunPpuaRFuZXc3uWFJRky4b7PezGnurli9
         YvULVBKovgJSEFWCVhUM/U7/EWfBetMF0ec4oXf+F6L+6NBOYruaTr92j780VFg2mTUk
         nE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712305600; x=1712910400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMjODkcesgwF+DXMkkxfajgQj8hEAB2u1kWBMt4YYhk=;
        b=Et1CL4a0eGPpcZK/+2Dm817JfKiR/y108lpMxTTxdSnaeb9gVaGdZWvj3EVktSQ6Oo
         yMyqs4ML1gr2uVFotC9JyaqLqEHlbr38bCUnfsXdRycN1LayAih4ZV6kI6yR4ieJJHzo
         R0cSpNAk5oWKyqkT7UWSVtq91aa2iYsGvD26YXexppTc/DT8kBlsYPpaHLh0yDkX3qsx
         nw68x7wwALw++2xZXIw14NcWvAPzXa46hKYKF+vk3jTbCWvX6kZCICgJEeEGTyuFSFBD
         a9dYWR9vTYw2YNaamkoMEn1xFtk/EJ6l5ex+2OK08u785P2I67sFrG4JuIqzZvomI3xU
         /Krw==
X-Gm-Message-State: AOJu0Ywg2+G2Hdr6zLpSkyhI43KzEIQryjPT5NU7Ieh6owQdPf/f9SLe
	HyjO4QVc4OXWLIdbj1Bn5bb/pYBjk+Mx2jD2Dyv8c/EUbOFpUDf5+n/Hl20IS6g=
X-Google-Smtp-Source: AGHT+IEAq5BdFMSMX/Ole/iMCesB1OKC5AMXlen0BR/i7xf2nNdPFCeW9dVpnVYgKxCCzFVBTSndOA==
X-Received: by 2002:a05:600c:3d98:b0:416:1c9f:4b9a with SMTP id bi24-20020a05600c3d9800b004161c9f4b9amr550749wmb.38.1712305599630;
        Fri, 05 Apr 2024 01:26:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u22-20020a05600c139600b004162b4c6366sm2064107wmf.20.2024.04.05.01.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 01:26:39 -0700 (PDT)
Message-ID: <feec4f19-4d47-40a2-b921-c027d4379e65@linaro.org>
Date: Fri, 5 Apr 2024 10:26:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] thermal: core: Make struct thermal_zone_device
 definition internal
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <4558251.LvFx2qVVIh@kreacher> <13485814.uLZWGnKmhe@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13485814.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/2024 20:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the definitions of struct thermal_trip_desc and struct
> thermal_zone_device to an internal header file in the thermal core,
> as they don't need to be accessible to any code other than the thermal
> core and so they don't need to be present in a global header.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


