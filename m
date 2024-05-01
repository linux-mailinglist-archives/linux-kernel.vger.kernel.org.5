Return-Path: <linux-kernel+bounces-165305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A648B8AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158DA1F232A9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265012DDB3;
	Wed,  1 May 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQfY/NH6"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EB12DDA2
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569253; cv=none; b=iioGOLcnvlt83Lb7PDiz7gJ9m7Y8lJn/2/FyGInWNaO3daVETNsEqBPAdXw7ZD30wcyljhnppZapOwFJJwJa7aw7lkRoVzdOwn+W1cUgoURVw8pBNcZJsjFZiIzsDbhhgvtpv6WIdQbQ0idPXUy5fNurz/hiAzkp2TVSt0ZOU2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569253; c=relaxed/simple;
	bh=jEgju86kkZEUEWsLIY6KhIUfB0Ro+wi3O82aVd7+8K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvExtnEX8y1CQ1T87h/G1piTk5a1N/ytfm7nnlzVxRf+YdLVRbyvlPpQPqy5qHclk74u6yNeiuTeyVzg2zUu86qkH1LXB7VtlT6ZKSkgXMb9LU5mR+LdE1EhE2fUcsKaOL+b7c7Fn8j6wCAUQUoyCrh+ie9txvgBv533Cv8O1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQfY/NH6; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so10475357a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714569250; x=1715174050; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cAEo938B55svTFKi87S7P75nYRID5Y30PIP36kBSdrs=;
        b=QQfY/NH6GEG5DLl+vgk8XzCtLNPzCS+c58hlbJ1WckXlKrPRKT8srqyVfrRbyW1Rq2
         bGGVj1x3e8zpUlpxZcCuNPh/sNc7zRLBmjhPDp+e3biFzRD15cCWPjZXqOrDYbWQspxY
         GnPfueuNq9pkUqyWXSKTs2tVjix9oJoioWOBNTvl1To3MAFw937eytX+SZa+HkX4zXrc
         J8xdBS2WpMT9WJJ9JV8w51I7FW0lno1aLqGAdOTboHwIWfIVoLxn2g/cbyFV1cpTPwrc
         qeY59hFXT+BX2vFrb+F2K3BWwglQxZfcz6kgURFk4GwKuooGhdB197zfg1+M+JtDxAxD
         ejRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569250; x=1715174050;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAEo938B55svTFKi87S7P75nYRID5Y30PIP36kBSdrs=;
        b=wQCNDMsua9j1pKx0HjtdV37fRfMPLHMOUlCwhAjLzP2XZtl4GxfczLRnN73AufKOwA
         NbaHHJbcRdnb3v1nQZ3hA32wef4oC6tJIgx0pmDgpD0GvGpK8129r3yt8DaF3CukMTFQ
         +y9l57pQQ6Cu3uOQ6LZPdoH6BE++u7m2VSV/Mc7ncuXW6gtOGGZGS3U4kGUI4I3vTekk
         tbAoiOGUUlNS38XDLh8KDgDFFU0kQFJqdrD5u8wv2W5ptJLIO2hGZQIeX2msDd6jzVaa
         NutdlO9w0YHnIuL49l42Xtm7SA7PWYVKLMCsI5TudXITJjBNnnrMMTeCv/3gjI9t0bRW
         J3yA==
X-Forwarded-Encrypted: i=1; AJvYcCVkn4Rwwb08kGMjG78CVJtEXVEEjxVJOWqlvTnbsyb1qptmJBf/2dPCVEs/b4su+GYz4qF7wMgUlAx4c9Ou8AWU4uQqee8RHvP4UYl6
X-Gm-Message-State: AOJu0YxUKpoCEUF+wRbxPCvDnh1IiHERT6CPb0OBCNp9P5OPyB4wRdg1
	lsCiNlRU9HkzE1vPK2ne3q0l4Z/DbovWJsqjpnw5msFPpaz+8oua8s03Og0Rj50=
X-Google-Smtp-Source: AGHT+IHiS0OX7HJtlx1wK1J1hPxkGTBoUFdyOaKFMQMeW3Iz5o6HbKJVjNgIFb7CMb2XqnqMB/oEMg==
X-Received: by 2002:a50:d701:0:b0:56c:522f:53e1 with SMTP id t1-20020a50d701000000b0056c522f53e1mr2256165edi.17.1714569249690;
        Wed, 01 May 2024 06:14:09 -0700 (PDT)
Received: from [192.168.114.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id b17-20020a056402139100b00572047bf766sm11353468edv.51.2024.05.01.06.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 06:14:09 -0700 (PDT)
Message-ID: <cb55130c-5332-4904-87d0-5fce4d4e1f19@linaro.org>
Date: Wed, 1 May 2024 15:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom: uefisecapp: Allow on sc8180x Primus and
 Flex 5G
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240430-uefisecapp-allowlist-sc8180x-v1-1-1a626ea9c5f1@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240430-uefisecapp-allowlist-sc8180x-v1-1-1a626ea9c5f1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.05.2024 4:33 AM, Bjorn Andersson wrote:
> From: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> Testing indicates that qseecom and uefisecapp are working on both the
> SC8180X Primus and Lenovo Flex 5G, providing EFI variable access.
> 
> Add the two to the allow list.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

