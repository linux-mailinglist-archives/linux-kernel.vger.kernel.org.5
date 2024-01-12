Return-Path: <linux-kernel+bounces-25096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3082C7ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92068286166
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6AD199C7;
	Fri, 12 Jan 2024 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKcOP0gA"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DFA19441
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e636fd3d2so13904515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705101712; x=1705706512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC8mtm1TlFW9DFESezgL/8iynrL8GjEwcVQmn91Rdks=;
        b=FKcOP0gAtqtlISM9MgV24bEjZu63LoZt62x39Ig5XJfMZVRhCdhnZNd0sqzKF+jPJa
         zgC/g8PR64DdMLvwKSWG10QuJjXF/iMJ2hkOEmEeNRzLzgvGiwxoXNb8wOPX1HwkQ157
         sOSf+lHTgHWrWwWz2+47dzOShFOr4Zb4I1C7dlGXKYm6iM0hWAs+2shxOK/gly0fneCX
         7osy9ECBj+0NNDqE/IW/Hj8+OOl/nftlK4i1cal8WV2ZPKFLzn+WYYAiU0oMxhlvw1KK
         Bo1VQCIoD7KohJOxynOJmSW23cFJqsXEnHEiXOhrebzlqyT7eoRygmZtDC90wW7yZ6eC
         Pr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705101712; x=1705706512;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IC8mtm1TlFW9DFESezgL/8iynrL8GjEwcVQmn91Rdks=;
        b=QU7FUCEz+3Tja8XmPB7Q0hkgKNdFA9wy1yTtUebVcy1gpcN0ua9i1ZKgpNljmIH7bJ
         S079dLX7wUl+GX+uDlNxxH7WgJn2O4uDRxfdJd1V6WH5egF14XmErZO61XfVE0iFsdMR
         Hpn7s/uy+SyrpMxbuupsodK/sXhDJmVRnqUiAkiQtDT9GcTnJoWpvfDiMDh7Yum2FOlE
         FHOIyQe7cvOXMBzfIZg2j8DtltPdzZErM2ckkO+tKGnfRlwso6LAO+tOHzdErzcdqlb6
         k+nGXg7/TE5QwcxKuxqirvJLQVnIu51HnkeBpQEOiLU9yizUsNNIVvHSJQxDinhZAp0f
         mADg==
X-Gm-Message-State: AOJu0YwrC1q9myLpXXNWZTE+jC6L+2NRDR6BfpiDw5Kg1B5jY5qhPbuO
	71KZ6/t8gajQTb/ihIbt0cmCFMiGuHzWFA==
X-Google-Smtp-Source: AGHT+IGIJIeLRHLW9oe50D2fPwgY8ABdpkgxLo1DwyCB8mIAi+38N4kmqLDbIoxRtUwB9ItoQr2SSw==
X-Received: by 2002:a05:600c:5385:b0:40e:46d9:cb52 with SMTP id hg5-20020a05600c538500b0040e46d9cb52mr1037169wmb.19.1705101712547;
        Fri, 12 Jan 2024 15:21:52 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id p16-20020aa7cc90000000b00558a7d36956sm2063226edt.0.2024.01.12.15.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 15:21:52 -0800 (PST)
Message-ID: <45e9b5aa-13ec-44c0-8cf8-a4d24d470928@linaro.org>
Date: Sat, 13 Jan 2024 00:21:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: geni-se: Add M_TX_FIFO_NOT_EMPTY bit
 definition
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Stephen Boyd <swboyd@chromium.org>,
 linux-serial@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240112150307.1.I7dc0993c1e758a1efedd651e7e1670deb1b430fb@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.01.2024 00:03, Douglas Anderson wrote:
> According to the docs I have, bit 21 of the status register is
> asserted when the FIFO is _not_ empty. Add the definition.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Looks like.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

