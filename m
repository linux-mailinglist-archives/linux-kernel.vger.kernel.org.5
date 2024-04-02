Return-Path: <linux-kernel+bounces-128185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398589574E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60451F2701E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1E1353F5;
	Tue,  2 Apr 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6ywg7Ug"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0512E1E4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068888; cv=none; b=g94XOG6GcjehLCdXjpBy4ZcxB/SmjMYilgSD/gpFUxRBjkR+s6OUlwr6cZPiSvyCgDsPXWRSLYxLFwAoYuDSULmjraS6BN+uNo/YLg3HkDWuzXE3aEp5Wcem9atJQWLh2oV/iVvUKqlQrWu3pO7dC5StnbgP10Q4dXbnkX/OTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068888; c=relaxed/simple;
	bh=Ysma0vtrKLoIbWF37iKgt+8c9Ss2llY5FZIHQtgdOOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDAhKHeq5NEUgvFxPdWpzooVRyAU5yT4/gGvqGk58GJpT6cAomcR49dqw11r24FIKATkbuw8Po1Dp8w6ve6cmlF5ZtPQZssZX78THAjDhW9dVAJE4yBBhpvl3SFDTyI4vhe7A7qe8c6nWJdZJsVdpabK78UIVxNPVMGlx8tR6ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d6ywg7Ug; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6082537a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068885; x=1712673685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E5xk+LWhRuGKsMpuDT0N5nt2ortkrtCLkgmGoaXyqzo=;
        b=d6ywg7UgR7id6OIKSR0bVXnRLL+YMuWkgyeuBrsT23MLn/i6yQfQOeMNbBJXPi6M6n
         +BppbNnkSqkPKfUYpCjQh63wDorUCtBzEtrVod569tiOfOmBcmjyUdkP8eotfgUtKUhD
         76/qwWSk0CNZO1UwsEJtJbvG5l0QsPS8Z2kgwUeVWVhZW7J1yAj1xnCQSZ9YFlMPeae6
         +V6s6KDaHhOkhlRpUbiPxzSWBOutN9jmsobWrZptybkGcgl9Wo4AbGD3GKxA5hnxOWs0
         jmMtXiHCXQGF6jepXR4DYqV0ybsiuQAosJqKHfWnv826kdeH5yv299a+M7hT3FaHlOcv
         7PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068885; x=1712673685;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5xk+LWhRuGKsMpuDT0N5nt2ortkrtCLkgmGoaXyqzo=;
        b=Gl/bT1zG1EOvZdvgMCG2JkB9VzKrdt5IZ9vo4kdA7s0mxBd64J5flEXVHucBBHS4pt
         2+ygc0r02stbWeOK+/PS4wvSWlt8x39eX45ucAXUA8J7FwXyR/+LvauSs/IJ3FAJ+TNs
         +YUDyEKJ3AEw9I/i3kGP7y+IhpJw+03EkiP5gMYJ/0txryUnqm4C8n5MQaJzhVcfgy+1
         t4aHspZCpRK84vOW7a93WHF4NbmPAx6jYejaSc/E4Qnqw+4chgQkPilvyv7iAvM84ZWG
         YezgEWLBrBlfOzO1L7OtlhW40kiIEiYJtZbVvWJ/uC9Z9W+Cd0M4YZBq0YTP+i2JJykY
         1aWA==
X-Forwarded-Encrypted: i=1; AJvYcCVw05oOCvxLP36UlxcDRT5xIagUauXrMkgxGhnj9q20Elr5vz7306Kl3YZAn71/NxK0j2fFfF7b/ieLTtIOQY+IJqyIrPWCT4Mqsze0
X-Gm-Message-State: AOJu0YzjlCNl8l2ZWzxslCO4LOE0Jy+gsNLdx6PkjxN5RsSzGY9XxJEz
	GRvpcWGcn4DYFfGZHDLB7ue9I6mzKe/cg4xiM4WzNLnZRyDuY79iVNhFwyc/oxA=
X-Google-Smtp-Source: AGHT+IE52rZCE7S0rVzKYptWwvsEDBxrBOh9UmHeApO6rUfnDxMuc6Q8QrROSvwy+dMnxjfS55UbYg==
X-Received: by 2002:a05:6402:2351:b0:56d:f9dc:c82f with SMTP id r17-20020a056402235100b0056df9dcc82fmr513223eda.14.1712068885664;
        Tue, 02 Apr 2024 07:41:25 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b0056bdec673c3sm7012729edo.38.2024.04.02.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:41:24 -0700 (PDT)
Message-ID: <4dbb42f2-072f-422d-b716-7d9a20606a49@linaro.org>
Date: Tue, 2 Apr 2024 16:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] arm64: dts: qcom: sm8150-hdk: rename Type-C HS
 endpoints
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-9-604dce3ad103@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240401-typec-fix-sm8250-v3-9-604dce3ad103@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.04.2024 10:33 PM, Dmitry Baryshkov wrote:
> Follow other Qualcomm platforms and rename pm8150b_role_switch_in to
> pm8150_hs_in. Corresponding port is described as HS port rather than
> role switching.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

