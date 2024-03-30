Return-Path: <linux-kernel+bounces-125586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9185589290D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 04:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C38728339E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C565748E;
	Sat, 30 Mar 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ2NUcoN"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2790D29A1;
	Sat, 30 Mar 2024 03:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711770218; cv=none; b=Puu010zPRWeI6EvBZnHMutcgl7q2eo4zJ4f5haolEEbzIV20W3E6rohCWrzebYXprRUiIiayzo+Dmt6LOxmtQDhUVOdWI+jqMWzprvlhaCBjgNyi6h0n6XKq5izmceSmbBdRtX/QOLKY6puZnPrt8WkJZSPTCq4Ta8YxtFA3iYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711770218; c=relaxed/simple;
	bh=XFlD+5gAK4KUQ3qPYVtDR6zQ2HaNlm3JrOlDrNKiMUs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sacVsu6wx4LlW0jLPT75MYsYgf2Jeo4Ioa5zdFqvE62pMxE28pHbdaJQTWbg/RDfTgpJ5H+bua7zjRjoDCHGDh8Qa9t4HDOI3goRTwFLUQ8C9m+SJFP7VN3f8lRq3ZrW97JuGT1t/1/Se0svUOpvMlnpKbzWAWnZ2gpfHgMVWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ2NUcoN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so38435b3a.2;
        Fri, 29 Mar 2024 20:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711770216; x=1712375016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2feKfhW88psxgCPBubRGMmgAe/J42pUJuc0gWjos4sc=;
        b=TZ2NUcoNBEwa8iBHqh9XNJhwYr2OaZcMkt+jdw/pFimBEZyFnSufUgYtmSPgV/KXYj
         tME8EUu4zxBsSl1s/5dfB8uci2bUgLAS+DA9G95rTfa4bfV93oZYQsXcrtcrANNe5K03
         4DK34VZZzxOLGLwpDbi3hZScINKU8mrG0m1TEseYBJ5GkYAygxwoQ98IHxDfiq0EZVuW
         5QKScTbwIdPUbrddPYM2hR6//WiXvkH2AY0oC758/bT+8HPox7eoI8JCpCSFCmr4GIMm
         UP+84sB/zjgGcevhEwJ6g+DgaORuDEAPYBF3F2YhyW4V2qbkxkLRvv8xSlaeptOCunwm
         vvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711770216; x=1712375016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2feKfhW88psxgCPBubRGMmgAe/J42pUJuc0gWjos4sc=;
        b=jR1gF6hWDmZElo5gCG36LDDnGi9+8gWHCG1HZwMRqMpqC3BgOES6obt49yJ+sKJbS1
         DAI3+INkhBQqVZTkCo6Upy1of4rYyH47Z8bLjiJ0DYCaKnFLXkG43sP1tzUEo9GQfVIq
         jMTRSp/UGWrv0njn8BfXQaN40Mz31rHDhJFFclEQgMJ2jCN/vYWrqvIjhdUrymn0ADBl
         sLxbbaq4lv/gRimogfoB2eiunjmdtSO5o5H2BTMWRRlDOVeDaE2Ti7kGo9UqmiM7IsNY
         ScAbHIZzVLHc9ZjpUIQDzmk1dvs1cEvXYd/ifmla6Ixp5XYgqvEA2ZnLLHYoICVIQfos
         4sRw==
X-Forwarded-Encrypted: i=1; AJvYcCUDEKfgyGP8POQ24OdESLf6rFRm9kCcFOnyhPdQHJz2VKEo/ZI6TN4jp/FFW0X9qEbROd3XrkLYQlmyRItsobR1lIxVP6shuFsQURQKB8zKPT95PJjmmrn4M0+rSnSxlAJXz/nWc8cp
X-Gm-Message-State: AOJu0YxgDRvacJlplNLOTfAvjn0HFCE+FS9lNq7Ba4QS6KpLDQeSF8E2
	g1oNBNhFy6j3kJZQCvl7WPGWrYxmFIxJ7qomXExz9Pr1ThKSXBEL
X-Google-Smtp-Source: AGHT+IHKAizc5e7qDb/e7k5JVrxIGSieVZYpUdI5ErAHy7qmSIJyCDV3g8tT+HE0/xVnhOwAZyF8iw==
X-Received: by 2002:a05:6a20:958e:b0:1a3:6c9e:1e31 with SMTP id iu14-20020a056a20958e00b001a36c9e1e31mr4523300pzb.19.1711770216363;
        Fri, 29 Mar 2024 20:43:36 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:cc2b:c45f:1699:a1c3? ([2600:8802:b00:ba1:cc2b:c45f:1699:a1c3])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b001e0b5f9fb02sm4276888plk.26.2024.03.29.20.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 20:43:35 -0700 (PDT)
Message-ID: <8025c170-e75e-491f-ae22-64abe9c76ad6@gmail.com>
Date: Fri, 29 Mar 2024 20:43:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH v2 2/5] clk: scmi: Add support for state control
 restricted clocks
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com,
 vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com,
 quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com,
 mturquette@baylibre.com, sboyd@kernel.org
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
 <20240325210025.1448717-3-cristian.marussi@arm.com>
Content-Language: en-US
In-Reply-To: <20240325210025.1448717-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2024 14:00, Cristian Marussi wrote:
> Some exposed SCMI Clocks could be marked as non-supporting state changes.
> Configure a clk_ops descriptor which does not provide the state change
> callbacks for such clocks when registering with CLK framework.
> 
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

