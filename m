Return-Path: <linux-kernel+bounces-139115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9589FEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE621C21F99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B717F371;
	Wed, 10 Apr 2024 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMKZbyfU"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E248917966E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770770; cv=none; b=PGADFOO2k5AJtqje4M7d/Gvg1YW1nKfH7XEYEwx2epcwEbULiLe6/eAWOiS8sL0qLT2+dmghvN6Z3we8D5qxX7PF4sgVHblEdUvsx9CeYOejFpQ49EqAoySy3lAMwTlRgcoUWOIU+cBOrcBHANYaZQFwDML6zHU9UxyC3NDkU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770770; c=relaxed/simple;
	bh=Ae78iTX5Gi1u5H/iJKMp5ReYCFnEnOmbK4zUk7vZlRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XZ5YuCMfotjkP0Lt0nPEcJurEPQOc+xGAFI2318ZlZNQGhitL6+D7M5lcNhFVlGbHM5EcZ6YZXdgZaOzun3lqgAQ75n+dXO537/btpk5YMAXhhfcOnPSYsSHBTUBJM361PXXg2BifdnthX4NMdRvtg/T0Eoyf7mIFfdsa+WZPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FMKZbyfU; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d895138ce6so43835261fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712770767; x=1713375567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOAAOfk0ZAGGudRLQ06zTrFZTJcS2I7LIhPpzIE377o=;
        b=FMKZbyfUimS4Qn6LXKkGbxPJLlV4ma27fDnrC3oxGwYCaDd/S+yXf92+FqUKW6CAa7
         aOc6bSvxhhKISAWndU/f5MUsM7HruJrsXiB9UoMSgIaGpyAlcCsbvclf5atAYa0H7teq
         ysJJ290L5lOI5amAEneftF2DZ62yGZIfXLYslg3H7woWb3hDy9XFvUjjW3jFkZa2nYIA
         JXDGmmnxwjVbBIGRiIsBwgYIPPKi5E5ZWufT0m7gNdHkd9UFKklXO3IblC9/lvXTlFcx
         +ZOkyFlMJ5jol9gwcYTmHo29b6WE8Yn/4MMr4j7wSk8ZP3dgDZIFu5Vpp2I1Z4X+BvpP
         XtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770767; x=1713375567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOAAOfk0ZAGGudRLQ06zTrFZTJcS2I7LIhPpzIE377o=;
        b=udbfKxstx3OVF/tSeFdsYRz1cVy4xKDbQGaAInup+D3VBOWHzfiucEHjnmbJqtbGuf
         ij+nSRwa/+s/aymTZ7/U4BVYx/zKwU+xVH19aQfi7tbX65A1A+yq2cJThowVkRFEOa42
         YRpREbHINPVXFo3zKp9tqk56d3acxCqlaOOXGzFxNTde8/re37DYQ5U9IZtvj9qvmq7O
         xSGzqg2x5srqnPylYCx8phgXL2gbCCmnJlIkgxXN7AiFMLLSWYjT9wcNNfEkHBQKZbzL
         iAXPa1gtW4c0Dzw2QJKZeZ8MhD2B64dSLv5poGy6wMxyvO3ld1kOmPGx28COnfN/wfrr
         uE6A==
X-Forwarded-Encrypted: i=1; AJvYcCXbTz13nsjB46JM/aA2vCNNFQ0Vib02Y799afj5pwdgqvQ83xs51T1iOSiPTyaoN3k10uh62yK+UNdQNeF5o1o6riuNh1qiNzIWE9iA
X-Gm-Message-State: AOJu0YxDpNPkznG2hszGr5nljdpfS1JQ3thTqTSyCMRA/1uHL3qYPM74
	UQeC83qEr7g2/KEvePy+CDlwKE4mXzO4fqaZydD+86+WG+EyL3WID90g3McpxCo=
X-Google-Smtp-Source: AGHT+IEnBHkuJvI8my1nrxHO1p3O+X/dhW375UqupB/NAf+4Eoc6qRo9EwzliQKAnTU1wYxD4MgzVQ==
X-Received: by 2002:a2e:8859:0:b0:2d8:71d4:4bb3 with SMTP id z25-20020a2e8859000000b002d871d44bb3mr2393711ljj.26.1712770767037;
        Wed, 10 Apr 2024 10:39:27 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o10-20020a2e9b4a000000b002d71b89f93bsm1905763ljj.27.2024.04.10.10.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:39:26 -0700 (PDT)
Message-ID: <301f5ec7-e616-4352-9f80-e5cb51a46782@linaro.org>
Date: Wed, 10 Apr 2024 19:39:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: vqmmc-ipq4019: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240410172615.255424-1-krzk@kernel.org>
 <20240410172615.255424-2-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410172615.255424-2-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 19:26, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

