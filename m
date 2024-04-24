Return-Path: <linux-kernel+bounces-156505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51E8B037E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AABB2854C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F70158204;
	Wed, 24 Apr 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C93l+A/i"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88AC43AB4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945269; cv=none; b=qQcckdAXNPn8PxuDQs4LG+Ypjsf53x1PG/W2ukY0rOqFwgaJ/chC7tpzwvJlQEI00vxe9p0SbwgMCgmvJJyZwNR2/SfylW1LqwpkBFcDwbCA3c6Ei+tWVri3r5Q+WrEfs818IyxMiAap1GxmvXTDCXOTfwKd9DMT0YTGPnmojwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945269; c=relaxed/simple;
	bh=r25OLeguN4K1eHEelpNuj6AN7zkojxM0EofLkdAbtFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8WxiL7y0pUYkVyi/t56dE0d0DrCewfBMFj0diXpsLBVAumJ5Tvm0B+zB6Gb70ZBxl/2XOd2qS25LjWV6Zyz0iH4+pni8Zinj1LM+mpwAjahG1S63XwtGd7g3XfYGaWLectPMByZJh611ASJamZffCUg5Fdljlu6JLzeGh/EqOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C93l+A/i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a5b68eceeso23526535e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713945266; x=1714550066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myyoINEtifDPjTf6aBdAezFxWZgIXfzRzt4GnDTHFGE=;
        b=C93l+A/i1VBKhZPguYbOZJAhuG6kyORNsBpp/qGAZpAAd2WxYyVxlYLCaPyPBqf/nq
         suNByXc7cX2WxgciLQFa1i/Y+ejnGZmhq8nH2RL29QmkNrK1thVq67FTjK6XPTErC8j2
         t4fK3uHZ26Yj8f2vWiSRo8QB/ckiQf6lA6pzRYBVLJkcTVI7uy2gn9ZjDGJD8kBDjsy8
         5y/RSytRQFDAicusNvfbo89t+BiVCncHwVrlPr3g1earGTx6PKbEO60KCFvuexRYH5ws
         XIeTJOOJAKE+E0SCn1Iu2WjIEluOhxN+5wgu8CcN1ZGcP8FY6+Ny3nF99fzYZ4kbf0As
         /+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945266; x=1714550066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myyoINEtifDPjTf6aBdAezFxWZgIXfzRzt4GnDTHFGE=;
        b=fK+k03FVzSl6pHzq+CtqfsvOp20rOfdgWEMcecgfTaUvsUzjsDwd+1nycvWqPmgOUf
         4GWNXSnijoTu2lG0R+FloQ/TR18QzjnGWlroHt8vCUn4mpjRiN0c+r3sTAuGfD80iBPA
         d6xGQFlxbTBvm6bchQzpvBxraGYRZQHUOgMWoneDUjyeTodKzxCcWMexuxOiXGE4xpcQ
         ZAI58lngz5Zdl4uhU6uCzd7jokzrPopyLnvUBSB5uWjEJgT7kuyRwnPWd+FJ0c9RxSPz
         K2ij1H54Q8gR5/GkDcZBHeUQJPQOsp5jCCdj46s4uROfL3oywzQkP66HcIhAhUWGxhJK
         Kfew==
X-Gm-Message-State: AOJu0YzdbSowI0ARaJlAYQgSmrWfcxDP8SnqJWsngfdjPZm5WdCgqew/
	NycsjAiJPK4Iu7+Phx1Utv65kemKlGTHdQ+SqaBA4zLltcMLo43YRIt9xhfhfoo=
X-Google-Smtp-Source: AGHT+IEtSjCdcL4qwBEISb3Sd1YNtbbBrcgO00iMUi4ITRKcY4v2ExdRL+3YQLmx4jnbmd5Bvz7SNg==
X-Received: by 2002:a05:600c:4448:b0:41b:f95:f772 with SMTP id v8-20020a05600c444800b0041b0f95f772mr431558wmn.1.1713945266179;
        Wed, 24 Apr 2024 00:54:26 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c511400b0041a49b10a13sm10614777wms.11.2024.04.24.00.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:54:25 -0700 (PDT)
Message-ID: <9ca49056-6617-4ce7-b064-a8c07b23a6ae@linaro.org>
Date: Wed, 24 Apr 2024 09:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/16] thermal: gov_step_wise: Use .manage() callback
 instead of .throttle()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13515747.uLZWGnKmhe@kreacher> <2628456.Lt9SDvczpP@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2628456.Lt9SDvczpP@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/04/2024 18:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make the Step-Wise governor use the new .manage() callback instead of
> .throttle().
> 
> Even though using .throttle() is not particularly problematic for the
> Step-Wise governor, using .manage() instead still allows it to reduce
> overhead by updating all of the colling devices once after setting
> target values for all of the thermal instances.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


