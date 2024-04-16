Return-Path: <linux-kernel+bounces-147074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A98A6F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B0B23CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2760A12FF64;
	Tue, 16 Apr 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJnfgvXY"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAD12F5A6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279441; cv=none; b=k8k7vn74tltH8oWIfb962urD/wSmzexjms+q6Zf7F4ivQX1PCV0UZakGyRwfo8qWD/qWyTxbAJ0VX3CFU6Tnh9QILRattf52GRpiD38cq8oLV5vu3Rv429BOuFACRGfhiMBRxgK3lBPVQnbD8fNxZa+RZEYMMBKRIzXP7xI7Lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279441; c=relaxed/simple;
	bh=FrbIB/Z1SqzQ5A58Zqk4S74k2lIPrqfaXr5V7n8jcz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxtxuvN0jzOKOO8ACKcKF1g5Yj6pvsJcvzVqRH+RBsyfu8L0nAj+Knpk3s3YHwPKIyG5b+TqaPPm8vOmw8vj8baKG4LwnLlUAgP3QsdTLoUHleMeXC+6IdusnI1gTjbcBnzMqwZkmfm1mAeZF+7Tr12y6axhReokyul0eZ0Vhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJnfgvXY; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2da88833109so32606461fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713279438; x=1713884238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Or5aD0vHhofq4hU9WI0SfKr5R6BUi9ScTzvy6tmm1s4=;
        b=nJnfgvXYS2KiiYDk3B4MOcAJV6Vr6/Ewz6Q1ng1pT1foFIkEd2WO69nl5dENFiWmr2
         JjGAmnjvYK/HEyzPEn+iBFU8PZMIW5kJvjnXRuah/SwCFhRCcP0qDF2uQAaPDsYujQda
         lPV1yGhoUChQB9oMDtyvwS9ouWnzrHK4fNyJgcdYmyjIMmMyoKI00NYtP24N7gqmqeYM
         H3YmLQr4V/UFy/zVGzdcqEVwsWXrKdApyjG7FAkbp2rgHSWBxgA1ZsLLzGzSxrgTmFQT
         uLkQAYE1WDqqz4uPOHyULhyh5cHn8rSaLNtHznIoDYYIHqf11ymUt5H5vsa3PWJ/vNgR
         6AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279438; x=1713884238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Or5aD0vHhofq4hU9WI0SfKr5R6BUi9ScTzvy6tmm1s4=;
        b=SLwhsH6uE90uJh6je0k2dhtI3M0AkU9daIS2ZueTnOSVzt2hSxsLce/hYm+t5Qlaoi
         gt8821RSJGg4a+3Dr6buJ5fVrNGYwwprzdCVTtcOp951xRwQz1beagupqLkbvhSdVbXr
         A/WiFhwjjsCbi1OdzHQBdRObeEPJNhiFWX0D7CVVumRrV6BgDjsiAYyQWueyoK43dp6d
         JHfi/8hxqZMD5a84PYRt75TdfPMxflHSi7tCjoVTw4+U7lP9+eQ7rNMqPlHGViIoWMy8
         R6nSpe4bOXlzqO6aQQsS8Ro8OiYkub0R5WrHUOj+2r3j1pOzn4S/3oq24Y5C2vUDokcJ
         3OHA==
X-Forwarded-Encrypted: i=1; AJvYcCU5lI0JxgLQnWisUPXoimwE9gN52XC1O+RMXpxqEVr/oQz07cJOn2MJVk8+Qt4I/AbIwiUcbGCbFa7FB7FZvnkJgz9TIuV4JtZ9FzKA
X-Gm-Message-State: AOJu0YzAik5N1ut0+a03xTpgogRrsgFRiFupHhFUA0E3p/0MpdQk3pYX
	hSPJPXMtnaLvWDgRFjDD/H1Ps+C26Cv6gpRaCVvJPEKLi7W6b0XMrYLIYwiIH2k=
X-Google-Smtp-Source: AGHT+IGhqmzkNdrX2UMlDS36AtNuOAiCapJDE/OBBjeoP4TRH2M/KqKJkejU4T3zaLkL6u2UP2FCAg==
X-Received: by 2002:a2e:700e:0:b0:2d8:9fd7:859a with SMTP id l14-20020a2e700e000000b002d89fd7859amr8397471ljc.34.1713279438013;
        Tue, 16 Apr 2024 07:57:18 -0700 (PDT)
Received: from [172.30.205.49] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o21-20020a2e90d5000000b002d86641176esm1571846ljg.32.2024.04.16.07.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 07:57:17 -0700 (PDT)
Message-ID: <66cd0d96-7576-4f70-b4da-b8d518253763@linaro.org>
Date: Tue, 16 Apr 2024 16:57:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] usb: typec: altmode: add low level altmode
 configuration helper
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-2-890db00877ac@linaro.org>
 <c129b349-dfaa-4b10-9b8c-6098d04b9373@linaro.org>
 <CAA8EJpqH2_ENE6am=m9dtwk_+_Vbc4pZG9=Y_4-b-p0fKQ4sBg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpqH2_ENE6am=m9dtwk_+_Vbc4pZG9=Y_4-b-p0fKQ4sBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/16/24 16:48, Dmitry Baryshkov wrote:
> On Tue, 16 Apr 2024 at 17:32, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 4/16/24 04:20, Dmitry Baryshkov wrote:
>>> In some obscure cases (Qualcomm PMIC Glink) altmode is completely
>>> handled by the firmware. Linux does not get proper partner altmode info.
>>> Instead we get the notification once the altmode is negotiated and
>>> entered (or left). However even in such a case the driver has to switch
>>> board components (muxes, switches and retimers) according to the altmode
>>> selected by the hardware.
>>>
>>> We can not use existing typec_altmode_enter() / typec_altmode_exit() /
>>> typec_altmode_notify() functions in such a case, since there is no
>>> corresponding partner's altmode instance.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>
>> Should this now be called from e.g. typec_almode_notify to limit
>> duplication?
> 
> typec_altmode_notify works only if there is an altmode->partner (which
> we don't have with pmic-glink).

Yes and this seems to be an excerpt from these functions, should they
now drop that code and call this function instead, so as not to have
it in the tree twice?

Konrad

