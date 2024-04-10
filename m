Return-Path: <linux-kernel+bounces-139149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C289FF24
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8411C233F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA88E17F372;
	Wed, 10 Apr 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qgXzQd7l"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58A17B4FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771541; cv=none; b=Dp2p/qKweW+2+9D9GArCRyu+6B38Qefh+RLVTzx/Ei4BkNuX03E3Joa9Ude/3zRDywRtziia6AQvuYgoLBPbmyc9GfuoiP5JukbGn9i7jJ36lfT3etMIDqOZlBJHYDiZ3dazIwjto8jQbPh7YP7WEi0UJw9XDp+bFmEbR1UmYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771541; c=relaxed/simple;
	bh=Lfmagm0VU/ENSbzyTlDC4+jjVBPt67IIy9krA8RAvHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HGRhzRLtIDL59jeo1dIAIFlDL019GOCZIiLKgL/NZOWowkc4Gf0xGzp6WG+gpo+9OX8ibig5LeV6mI6zNtbrORmVbJeWXFB8pjhhuVKYJ9eX2/yc0iIYkThLGACPQaaDmvQoHPrFDs0Sue3EIc7iDMgQFZFdRfvr8EyxLexGkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qgXzQd7l; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d3776334so7642621e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771538; x=1713376338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JL57b8mZR+eGT4B7pLnLps2t76k3zBdlXlsnrQHptw=;
        b=qgXzQd7lLiRBhQnoMxJPPDbUCiyuGr8aYLG/neU70Z38MadG7YrkclYwLJaTImRdAu
         eJ/NepsjN4ocHPjzdCUdljhK8iI02qKpENtmfdSsjIOOsSE8/48MOT2u58BTdzErVzT+
         L+MJNE36+ZnuevfGY9rsprtZFShtRCLalYpRyg4bT80PdiqbV+hV64kngQUG3tlihkF4
         FMcSOw+dB536zOSJ3t4osi2gLV9mKKloj6uvSInewPlaTnLJPMudrpWZotvtp2qHlIbW
         sOPiLDlWtIHxVvfEouiOfmmNKWproXEOd9g1p3b1kjZsw65taMbnJkjOsmtlBAlon/rN
         3auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771538; x=1713376338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/JL57b8mZR+eGT4B7pLnLps2t76k3zBdlXlsnrQHptw=;
        b=VHXAnjiK5aVK6VKhB/2Wibw6knH2E5L40EMCuONsAge8saeNs0uvMysxxaLLeaA+4G
         PacsK9IgZMf0zwDgTp3j9Ath0l1525Bemzo2NA6cO7nnaj5BzY6nud5U68uDj/fA7lEo
         ZKonOkYk7iftH16Rqe7/QCj+5QTgTVgjJx440Y5wkJYrkGS9roA9RT0O2ERmcat6sllF
         lHhz4ABMtyOftNsl47pfgung1kN0q/OFpqjg3zI/8XWfKJLbUrCDlrrN/6zr2v1T6R8Z
         Ye5mkPX7lCTCvbxsH+qDLisCbA7dFD0doE26rmWIq5VfFwQou7u/rpjCz92ZZmJGoRrQ
         RiKA==
X-Forwarded-Encrypted: i=1; AJvYcCVwmXOYYcfs0qxFzOrjQ1hag6xcsqGAkjoLD6FhVATR3Wc5KXjhsorotTUAViwF9lMqJfzkHEvYG/dG8cKmYhDxqD3jNUEX5CCdUvrB
X-Gm-Message-State: AOJu0Yxr6CF8fECl3+QTssiIHzAGUvjpzRCTdiRQqAzN2hudQJe5sOzv
	Ryj2nfpD9yC4CAaIp1F/Tz/iLz8BkfBOE38q1Vnn+yy9Mvks+GtGHUNfHFLJWwU=
X-Google-Smtp-Source: AGHT+IGyvTFRBvbpgzMy5Z3pW9YsMbWGdgBzXAu6U2+ci9OErZcBCoTcJlAyYiknD6FJK5MgHZOmpw==
X-Received: by 2002:ac2:5a09:0:b0:516:9f03:6a9b with SMTP id q9-20020ac25a09000000b005169f036a9bmr2225221lfn.4.1712771537783;
        Wed, 10 Apr 2024 10:52:17 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t18-20020ac24c12000000b005158558022bsm1909780lfq.288.2024.04.10.10.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:52:17 -0700 (PDT)
Message-ID: <66a122ae-0a5e-45f3-b572-c741c828cca3@linaro.org>
Date: Wed, 10 Apr 2024 19:52:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom-ctrl: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20240410170129.248361-1-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410170129.248361-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 19:01, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

