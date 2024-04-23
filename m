Return-Path: <linux-kernel+bounces-155546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAFF8AF3CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BE3282EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389D13D254;
	Tue, 23 Apr 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjLlekDd"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4613CA99
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889341; cv=none; b=DsEhyvLilo585M4kcnDS/9wZ2stsfmTvF6QoeRxPKE5go9R3rNy6MxWtmKgAyTrLcJqz3UdZSSe5wEqqVvO9HNgtUllGc30K7Yfp0fC5pQtvow2kPo0M918vHgdQoqyID73Wa7TKLF9wkCw2qJgbdLTtKTNxTbx+BALMhayik4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889341; c=relaxed/simple;
	bh=zO79EE5lca96y5tk1jBN2RNddNarlFD6LibZvjCWZN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqzsWJ7FMb4dVkaauWIV2HV6HWaZqY2z4R4ALdoXx3gR91OPvp1KL1H+OJ67S0FBxUJF8xguJx8V3kFLRgDFbEdQggTYU7UhjaPxwbotb+1IxZ4MZDJA+qsNkjeBk3CcGj1fz/EXIR9xtCMzUn8pePWJYyy2RRr0GggMaM2VPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjLlekDd; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518b9527c60so6848438e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889337; x=1714494137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rryQLukNGX6bltbPu3dT4IMJ7VdkGWG4t49Lq/kGVaM=;
        b=VjLlekDdLPh3AoMfFCjl7qtwNdQsBLEeD1eFpRAqxuiqwgvYAO4S3NR9hGfu8NPqXa
         S15rXRJ0MIGEWxkpM0S3SwSXq+mbFPPRKk4KxeACIA1R6dVhZJV+ih4KXGPhzyk8CpZW
         MJuqLZAhlYvg4TSe9GEGX3EvHH9yiAC4UFGeXcDY2tsGPQ1iY5CVvVu1Ad4MnkcdksIx
         lCobJZiTeTacDMPJtB7tvQ0DR7+FIcDhN6AnUo5otGLIDzaP44DVAuOTEsMIi2kx3l4G
         L5D6+sTUCQq2UUusriZtRvLihrwHr4TnjHcPzUyYiqtbO0ID581fFn2UZrpQF2ymvNwm
         yTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889337; x=1714494137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rryQLukNGX6bltbPu3dT4IMJ7VdkGWG4t49Lq/kGVaM=;
        b=uBRko5fcjjF+NEPGqg1H4mCVx7KlJDFDxcEGJjf6OzbSyGTDHaPR4sHhvNeLuczmse
         e4K9mEVnJyzjdEXx494svth/Z76RxCXw/af1pdTwia7A1oA9tu20ukcEgGXhj3MCWvD/
         jnIs0aom7nmFRBt5O0NxnqCBHix7UqjTX2YB8dv1jOfkOvZviULRGQ6Wu2ISl7EfOF0m
         1K1+tdAldeEydX/rsbHIbbYBalPfeP/oPXQpRqtX+s54egrRlMv+G5/1Qx+PhOSNDqxw
         6JnsTNRt/XVVeN7pcmIP8mFSoLsM0jWYk7l2qQSIOoNww20kcVrszZmj1AvZkBo15CRR
         RgJg==
X-Forwarded-Encrypted: i=1; AJvYcCVzlg/sdJ7iM/AzgzE069QvUxWYYbwWz1H7Mv4ZdUvDiFJ81AVo8eF84Y5h0qKiEDW/TtUfsjwcs9JuaOSfidGSyI3L9JedF7D0qDYv
X-Gm-Message-State: AOJu0YxFAbcv03IVQuy0VN7vW2pZb6DsGCU1xghYUigExDj1siMNexIf
	H99hWGV586XbKc/W3LuX5jCm9wQtUB6hEWQ1jQyr/M1LkDAmelw6+ZhJiwAlJgc=
X-Google-Smtp-Source: AGHT+IH3nmHnEwYavp+3AF85hgClGpBGLwqG5/uE47MnsvBC78Cj0bT1r9wjIUlQwfxrbFen9V+3jQ==
X-Received: by 2002:ac2:4143:0:b0:515:a8c9:6e99 with SMTP id c3-20020ac24143000000b00515a8c96e99mr26825lfi.5.1713889337192;
        Tue, 23 Apr 2024 09:22:17 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u21-20020ac24c35000000b0051b246caaddsm745480lfq.259.2024.04.23.09.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:22:16 -0700 (PDT)
Message-ID: <808243c7-bc27-46d8-8dc6-ce7932931e01@linaro.org>
Date: Tue, 23 Apr 2024 18:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: dma: Drop unused QCom hidma binding
To: "Rob Herring (Arm)" <robh@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423161413.481670-1-robh@kernel.org>
 <20240423161413.481670-2-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240423161413.481670-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 18:14, Rob Herring (Arm) wrote:
> The QCom hidma binding was used on a defunct QCom server platform which
> mainly used ACPI. DT support in the Linux driver has been broken since
> 2018, so it seems this binding is unused and can be dropped.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

