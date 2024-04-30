Return-Path: <linux-kernel+bounces-163699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B18B6E75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F130B281F9F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99380129A6A;
	Tue, 30 Apr 2024 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEsXZYcX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B71292C4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469712; cv=none; b=m1Yy4xgPC2XHgUNFAT6OVSsSWPwY9he69s1kwYKhDImW09LhE1QvKQhESj0IalH5Gt7EVlJ13PIyTr4wYY0MZCJviLSLyxyxU/YzDgemVj0zsmtbBFlYbmCDOUK946qUhH2Rgk3/iuwcLmTRZDp0dn0m6ap0xHRlHCMVem8ng7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469712; c=relaxed/simple;
	bh=33Rf/Q4mTFg6RFxJXUQRTedJL85dYQMlT1EZbJvAyVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q448bvDSnq8Mt9rffbzPcRR1heCMZQW6IAecY3k/rlFhab35RJzXBGkMtIawbsvSY1xFK2fCc/SxHe5bureqXw2mJ3lt1tO1mwnBTRXEYHMhTD9KMJbe/+DP6QWB3iQa6iBtjjbxpCm8+h9fVdSwmd6YslmuDqk/T4WzyjUSVlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZEsXZYcX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so5846188a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714469709; x=1715074509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UFWY8WyxTQuDSnMUxmwZ+xKlaTZIMKhbGsma4qMFXW8=;
        b=ZEsXZYcXhsABzG5kgJTEpncSDyhYDZFK4vPwFrJtJ5SDRR99a3w/+9NwWHoiNse+iJ
         9NVAPHTpQ7unvKw4W8DLuY0a5BsPlFli8I9qT8XABpJwXcv7ozAPIunpWjHP6l5zEKtq
         M6ZSOqCHuDjZOI2dWeHxW8hRBFlOOmwNfNs91de+HjfdON93fAvvDpOGlJiUrf60skw7
         4Kc1ltP3ysIeM78dyYDRhQNgGX9odnxPd+J0/Bb9BWaxm1belooMpPPeWHXLFQ89DZXZ
         yrBGTFXIP+8pMLPaocAty3FbwLRXEhRzQDBTL3a0eB1tUz+lj7z3rzR7LofZMteYd/J8
         SamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714469709; x=1715074509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFWY8WyxTQuDSnMUxmwZ+xKlaTZIMKhbGsma4qMFXW8=;
        b=iGPUK3YZai3weEPez0gzZZJBQmwIi6cSXA9cIVmywuZzw4htyfAw0urXoO5HKeLJdS
         QhuY2BmNcCHb8uNRMPfKOIwmTovNuybuxgBSTEFfEd0JLrAijOrDniweYuMpE9WN3qV4
         8tZJC3HICFO0UKsW4KB0ocASxBUfeQz16Kcj9wI76c5Mn0jvpHpq0JDP9qrOG+fylfZV
         amfnlPYHD57GQLZF5oSq103VbHT6OfC6IR4ISwR9MYI82aEzwyq6urWg6o4YHkjjpOn9
         42yC/3fEBwtr1Ejl/1QG6fvfHEJTtEZAt8gzJLXAb6OguN3TEx6uNZar1B8NUd+ZWEGP
         FcDA==
X-Forwarded-Encrypted: i=1; AJvYcCUlqXYDV0jPvfCa3cxAD6ofl7uEzY6b+EKop4PLOkvqm7i77E4DQ0qiE9RyqyCtdfxvcERPYXFCyg/uIY+OBL3UtImMau0eoQURs0Fx
X-Gm-Message-State: AOJu0Yx5pEA0a9ythb+Gj4jnNoda3e+yzHPDKzTNy0aHAU/egTBrkt70
	2s1Dfr/E4IKgBUpbNUH+AVtCnq0u/TWfgiVZASM6K+LieSQgMWIXdH45mPdT5qg=
X-Google-Smtp-Source: AGHT+IGQ5mHTU0GeSSAkpA5ls5tDFBW9rpenf0FLkkWpvWtNY28H9NW/kN+GT1fncjSiqRer26+e8g==
X-Received: by 2002:a17:906:27c9:b0:a58:828b:a4a6 with SMTP id k9-20020a17090627c900b00a58828ba4a6mr10953414ejc.73.1714469709588;
        Tue, 30 Apr 2024 02:35:09 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906d19b00b00a5557bc8920sm14904511ejz.54.2024.04.30.02.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:35:09 -0700 (PDT)
Message-ID: <a9474c95-eb30-4fa4-92c8-fdda67a1590f@linaro.org>
Date: Tue, 30 Apr 2024 11:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] arm64: dts: qcom: sm8350: move USB graph to the SoC
 dtsi
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240429-usb-link-dtsi-v1-0-87c341b55cdf@linaro.org>
 <20240429-usb-link-dtsi-v1-2-87c341b55cdf@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240429-usb-link-dtsi-v1-2-87c341b55cdf@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.04.2024 2:43 PM, Dmitry Baryshkov wrote:
> Move the graph connection between USB host, USB SS PHY and DP port to
> the SoC dtsi file. They are linked in hardware in this way.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

