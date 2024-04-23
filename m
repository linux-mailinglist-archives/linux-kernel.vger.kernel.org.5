Return-Path: <linux-kernel+bounces-155175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E78AE64A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D81F22068
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BB12C524;
	Tue, 23 Apr 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DvYJ3rNA"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB2290F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875777; cv=none; b=ufXTBLU4BrKwaypjeUubjBd6OPHlKH6oMVKBvn/o3trcrhgpd8XpBG/Q172KmFx6+kEAVCyF5+S0HAK9CWzrTQdsC4lBTZqOdFBCiMWJR1Ck9pJZxxXB2ui3CkWaTCiVVGpAw2TDiLxYwkE+sTSu7WkMR7wuAIaUFl/E1NILtJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875777; c=relaxed/simple;
	bh=kBS+00rn0dPcSUgrOy0bzN/o9u8ih+e/QkeSnrZhINo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=onFKcC5v0zCmzwgXj+yTgdXucr5Zcljm6w1XCc1zD3jyTei1jLVi29bSqLHiv2WdPY9R7OZdhsmmom7Cp+lv9v3+mXEqopaw028yXSN5lrpuQFgfh/EsNkCDO+BZTaWmjrUyXkdoxggxj1Tyf6Enm8xlUARGA0k+eFhCPuEYM6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DvYJ3rNA; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-699320fcbc1so32832746d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713875774; x=1714480574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rp1vCZilhDTRpF22A7l/FKH26XsKR5Ax3W1/+Bf3MV0=;
        b=DvYJ3rNAFXgzJdIMBjVPuAOKkKU0AdrT2EPb8TmAeJV5XP87bG8DJCy1sS32AUEcE0
         ZGx/COUlY/Yv9iXF6YkqSlejFMLDe66VG+bd6KSrv2kj6m5i6UiN5Q3BT3Q3Cgc59/Vo
         0QP808IAjAn1fauB+fJGVeyb+FA/UthFRUdNyDL+kOq5ejLylvzeH0n5R/HDyQeGcdZP
         sQYaUBsrs5AIWXAgm/RULvSFBiBm+UgbpIR2su+AiZS0YXuTZhseNcUPOXPJKHj+3S/Q
         b9hNqu3EUveJRp0l7p+RVCmYGfS9RfwCcNdMwmekUqdvfNRlXpHD9D+g1Fl4HBfeR1UP
         MQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713875774; x=1714480574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rp1vCZilhDTRpF22A7l/FKH26XsKR5Ax3W1/+Bf3MV0=;
        b=ObFx3KRIQ5zV0jg6B2yWXyeRVxKleXh9moyqJDTGXYngG2q/2wbthTmX2faJKuFypQ
         6S7ieCTtUHiJkm2d0mB11HuYaE4LbETfmxEX9tFn8Komq3EHTyScKaCdJsLBf1O83ayx
         lNLEqXAA8YyTznag6bL/sB8uRKTTLV3Q0aJKt83DLbnzgbVdyQhekPZQkCngtAvOm1Md
         9RzS8N+RA1N7oKQXivWKF2PYG67DHSU8mX1JzSx+pyLipon2kYez0SbQ200xxs2N5Jbz
         MtlLHqudm6iZG6HThsSVWi+AHh/oYx1noPqBgg7JEXbpemIRQDcKq+yN8JaV7TPDfTTs
         HNCA==
X-Forwarded-Encrypted: i=1; AJvYcCWliVEmMVYmTuTRbf9ufePYH+PyjsoteMJFoCspa+Mp+z51tgbsNfU51910HPXPmgkAwRfW0e4dhW5UPdoiKvRqB9HUI0Lfs6fzVUnZ
X-Gm-Message-State: AOJu0Ywd3rsNioMbY0kPdqaoxzutH8tsmSCjrzaq0T+D6yD77HOS0HLn
	yWwnKYmH8Ynx7fZlmT2O3d3HWNDgtJ/E3N8N/mVUNfbImWYXfvrErOYxYcyBc1Q=
X-Google-Smtp-Source: AGHT+IHLs2D3cGmmnHWTUSwtoRkNbwIfAKQK3gorK2TJ0i2M3UwxSJcpe4+NF+eQ9QL2KzfKnAuleg==
X-Received: by 2002:a0c:cc0b:0:b0:699:125:8540 with SMTP id r11-20020a0ccc0b000000b0069901258540mr12888684qvk.60.1713875774488;
        Tue, 23 Apr 2024 05:36:14 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id t11-20020a0ce2cb000000b0069b5bb757d0sm5103890qvl.93.2024.04.23.05.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 05:36:13 -0700 (PDT)
Message-ID: <d6f8d978-350d-4867-be4e-beea0c7e467b@linaro.org>
Date: Tue, 23 Apr 2024 07:36:12 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/8] net: ipa: fix two minor ipa_cmd problems
To: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240419151800.2168903-1-elder@linaro.org>
 <20240419151800.2168903-8-elder@linaro.org>
 <3a09d8e47e4c59aa4a42baae5b8a0886925a94a0.camel@redhat.com>
Content-Language: en-US
From: Alex Elder <elder@linaro.org>
In-Reply-To: <3a09d8e47e4c59aa4a42baae5b8a0886925a94a0.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 6:21 AM, Paolo Abeni wrote:
> On Fri, 2024-04-19 at 10:17 -0500, Alex Elder wrote:
>> In "ipa_cmd.h", ipa_cmd_data_valid() is declared, but that function
>> does not exist.  So delete that declaration.
>>
>> Also, for some reason ipa_cmd_init() never gets called.  It isn't
>> really critical--it just validates that some memory offsets and a
>> size can be represented in some register fields, and they won't fail
>> with current data.  Regardless, call the function in ipa_probe().
> 
> That name sounds confusing to me: I expect *init to allocate/set
> something that will need some reverse operation at shutdown/removal.
> What about a possible follow-up renaming the function to
> ipa_cmd_validate() or the like?

In the IPA driver I have several phases of initialization that
occur:
- *_init() is done to initialize anything (like allocating memory
   and looking up DT information) that does not require any access
   to hardware.  Its inverse is *_exit().
- *_config() is done once "primitive" (register-based) access to
   the hardware is needed, where the hardware must be clocked.  Its
   inverse is *_deconfig().
- *_setup() is done after the above, at a point where a higher-level
   command-based (submit/await completion) interface is available.
   That is used for the last steps of setting up the hardware.  Its
   inverse is *_teardown().

You're right, that in this case all this init function does is
validate things.  But at an abstract level, this is the place
in the "IPA command" module where *any* early-stage initialization
takes place.  The caller doesn't "know" that at the moment this
happens to only be validation.  (I don't recall, but this might
previously have done some other things.)

So that's the reasoning behind the name.  Changing it to
ipa_cmd_validate() makes sense too, but wouldn't fit the
pattern used elsewhere.  I'm open to it though; it's just a
design choice.  But unless you're convinced such a change
would really improve the code, I plan to leave it as-is.

> Not blocking the series, I'm applying it.

Thank you very much.

					-Alex


> Thanks,
> 
> Paolo
> 


