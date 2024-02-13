Return-Path: <linux-kernel+bounces-63112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7000852B14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088E41C21D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087118AE8;
	Tue, 13 Feb 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gt1EpKSe"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87B4224D2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812804; cv=none; b=bDZ4MuMgLeBDbWSq7z0emwDLpSCX6rFpFeSskJj6xUBqOIKmbZvcWfh1J8L5hhslILJ63+hDmtKj/p5DMbkME1rBILF+Tn5hfQfCK3t3XKpViWXUOOjPM3XR2JMuc4vi8y1SXD8sQyB7P2dveXgn9/TieWXYFtCA7CWHo1emW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812804; c=relaxed/simple;
	bh=AU2vMbcPBoPGMezuBVaBZOgLEbV3i+mUFWNBFEj0I8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcPCzq+12CxyKzdJOSyJp8+qc340WfEHcRrb6bQykRVJfNY5GDTFZcF6lA/G5QNRp09Lux08oKMaTZrk4qujmbLY2Ww8/eAfSKgvYYMbHGS+xuLjdi03Rk/0RkusgSSEuThnF/PXee98/bBGqMyzoXwjx4IsDLdR3FPFdJ+AO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gt1EpKSe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b4e6972f6so2157130f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707812801; x=1708417601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yt8OEsnV2/t6o3bQYdJsUNyb66Zbj5OvLC5Be7YQ91U=;
        b=Gt1EpKSeR69cP93R5W9woRqcplKgtiCT0yQ5kN/2AVjUwTGkQngeFsmX4lmVqxThKb
         EcJBijDhN/a+5WyC7vvtDaAuXCcUKU4dIsdFRm+Pupv3C3Pf1JjPlyHnTdnNMY4VtfpB
         xV3f8X0vJmBdmUdaUsNmmQ3UhpUGpl/2/GTuePGM0Nu9TQuC4gx9f77ia3elocluB2e/
         HTNp8WfzmR8IJkcQvtxxMszOgciTJ8okYVlF2KC/ZGOXuO30dBvMDBi8WjxHvqya7BeC
         p7EqO8cHbchsSQEPcFzOvQVOBNKtSwuWqxi2FgM1sr36Abs8+YRZxGsTkh0jo7eq4zrO
         VnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707812801; x=1708417601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt8OEsnV2/t6o3bQYdJsUNyb66Zbj5OvLC5Be7YQ91U=;
        b=rtC+jgd8meZVrZO6s21FLN/JCkTFfS+3o34cmAE2lCAzR+801ns8TiRIt9R97Fqf2V
         OzCBP+RvWTITGUQ8zrjLQoYHTUzmpQgaMRzpm6OgmKcfmooIF23/UOi1dkxKEHbpdqIr
         CRsGfuVXDzJZZa6FhlV9xv3jB3fvodJLBrwI1V7zdIpcze76CaA1HSaeIupKuAAmUGv1
         yif7WXaSx1b26BlBhiUiso9EwnCiyB7eCbG4jhPRZAzmR6jks4RTFvUlD5BjQq4ZJVbY
         0OLR3Yg1kX1DN4suGFtJ7pKC6lvB/WtKZ3qO5u6IfelAr5hmZGUsJAf2wKU/snGD8vY5
         sISQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvWNemA2sLwqXduDCjwsYyRMO98F0nQ2wtSiugMbxStp/64AclZYhLPlw1gjp9VaPcBdex6Rb/xYmsOlf1q8Jcyk1n5Tx1Qa6XiYWm
X-Gm-Message-State: AOJu0YxxjZW85WuAAsMypPpIZ1PetQeF5l7YkOz2oXWueDD6g/wjKTJ6
	2MmNHrN30t+jp3PQBU6Sj55VuPrf6oEdz4kBMuAZIg0eztviYhZ44x91RhFV+98=
X-Google-Smtp-Source: AGHT+IE6OUGMcogQyW0XBmBrEdPGiYrKBLV5abFqeD0G1KnUVwRe0AAxv25YaC0S05SjTIBjZH3JXA==
X-Received: by 2002:adf:f4d0:0:b0:33b:4382:c50 with SMTP id h16-20020adff4d0000000b0033b43820c50mr5649006wrp.26.1707812800815;
        Tue, 13 Feb 2024 00:26:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtAjT64GmWQpyv3hCLbSMV5N1RUq8Hs7hhwctTbekc2NvzNMwyPi189+B84CuyPCJUWeldPTVd6lvNKxrTz06eVbDtccrOEe1yqkS2q8qzyepBbY9hsiZIWrBmW5I02hIAx9AHEjrmFYK0uDYCX6/NsEOlgOFN+bIJA4C9K1npWG5rxvzJm4nMisSaQh7ZVUIZRV1IADsbpdmLGKf4apiWUNbAJF+5r5TWXUjXdlIyEQiNamADYNzY7g0xnBCq41o119U+EAlXI5uEfpZ3/XDgsCHJWAaK6KrcKxJpI2byccQqjvbtBcwqN/Se3q6mtUbnGKetLp8UHz0xE7ZKUIFmnC4C1mEtkhZXH5l4hYD67gvjOlctlSV5QIWmDjTfTc7/Z6iYYrf29yXWBeMKvwgvj+QLuD7usni2rhA63cYZ8o5b3NMCBeISJiMC02+bKWu4Mqwnhk0dUunQOKdcs8F+TVsoKJ5R/iaoJxKBHG1sM44cse77KXDYoiXQZpY8ZTduYMR70sxF5AiPkn0E/DJia/WHX1YtUgX9+kNW6sI3tw2qEzuv5c2n1bdwFBeFcnRvM6MlUNFEM6aEGb0=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id l21-20020adfa395000000b0033b3ceda5dbsm8933060wrb.44.2024.02.13.00.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 00:26:40 -0800 (PST)
Message-ID: <feab0ab8-9c34-41f4-a013-e66e0c74048b@linaro.org>
Date: Tue, 13 Feb 2024 09:26:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] dt-bindings: media: s5p-mfc: Remove s5p-mfc.txt
 binding
To: Aakarsh Jain <aakarsh.jain@samsung.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: m.szyprowski@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-samsung-soc@vger.kernel.org, andi@etezian.org, gost.dev@samsung.com,
 alim.akhtar@samsung.com, pankaj.dubey@samsung.com
References: <CGME20240213045739epcas5p49f28920efda3cb80351b1fcae580b21e@epcas5p4.samsung.com>
 <20240213045733.63876-1-aakarsh.jain@samsung.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240213045733.63876-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 05:57, Aakarsh Jain wrote:
> commit "538af6e5856b" which convert s5p-mfc bindings to

Nothing improved here, that's still not correct commit reference. Drop
the quotes and look at submitting patches how this is supposed to be
done. It's explicitly documented.


> json-schema is already merged. Remove "s5p-mfc.txt" file.
> 
> Fixes: 538af6e5856b ("dt-bindings: media: s5p-mfc: convert
> bindings to json-schema")

Don't break tags.

> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> changelog:

> index e69de29bb2d1..000000000000

Best regards,
Krzysztof


