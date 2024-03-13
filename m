Return-Path: <linux-kernel+bounces-102480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0A87B2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A0528D64B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7451C30;
	Wed, 13 Mar 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv14OMTm"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76E4D133;
	Wed, 13 Mar 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360781; cv=none; b=PrSLHrP9zcDxo/vw8mZ3b9QORhj8ND0tzXv/ykX36sVxFzLL/NLio82UKW4u+ugUxeI2r54kH71IFZ4Fct3DzT77bZl8Ib2Q1zn+reCgHYnskBlo5hirBxm2A7S4+DrcAPdhT/yOsvSoifOyyKNnqzm8rgXwgb6tREs5FipEXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360781; c=relaxed/simple;
	bh=xEydpAbl+UnNX21HEQRz8uun/LLyMM3kGBycf29Y6jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+ifM4XD823FAHhGS1B7r1kMx0qOxGqiRSQNbZpGOOJgpGDW0TL5K7ldqwnIuzaMIsiFDGxH6PWIVjGxiPmPPxPDF+om8OfJyJ8VjhSktENV36CGJJkMFDb/zEcyklLTWS2KaGEz6ajq0Ri4KLzhmr4JvknecWN+q1gK0BMSyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dv14OMTm; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e530b53bb5so120204a34.0;
        Wed, 13 Mar 2024 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710360779; x=1710965579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcoUVHgwLLkW5HjqhzTOaCJXpQUFZkJrmtPUv2eDI9M=;
        b=Dv14OMTmaXITEX8wgbeLHhN99do6Iiz6P0G3xfFBgIm5/ADUF5HBe/FyHnU+hJREbD
         2rUuJ3oc6Xx0ETfY/FGEeUkeH0GedgzffAeGeoreUohfjbhId9ev6h620kYimD2UGal8
         GDKpEHWJ2W9abzo2gi2Igy9S1Fa6YwcMH8tI5Istew4Ytd+Ihjm/4F09bEE+QlTrqlwQ
         chtSX/r4uGUbGsMTx9gj3LP1EyB1eXt0kY6m8wPk5ALBHuRllJTiB0s0bkWzFGfBEeSc
         fnTR/6fVLHS9MSLBza11phtpROXA0tk+u0Tyn49euR1E7dETNLNLOo6M7fukKhVdfvHS
         8ZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710360779; x=1710965579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcoUVHgwLLkW5HjqhzTOaCJXpQUFZkJrmtPUv2eDI9M=;
        b=Hmkm8J7TkQuSwpDM43tkLjyE7jrOv18GN+oPeInlUgXo22n9SI/Tb0cD20TmLtGE31
         ovY7gyS+WpaPRkeyRMySpL8otO9oeHRclbsxjWcHce3acmqC9OD6CzxCXVvelucQdnNB
         DdsblcwY6QCbpYvYS0JPRYL7PzbOc1wf+Ai0apNNvxezConjU2enb6qg1MCFjqBrAb9j
         z3XpVLpHazi3+dRdkKljrnhB8Z+uFBXXGyDAY63Pp7XMJEdEcN7zmJbZiFiCcdtiCylw
         fbCFC5gzoPkRUXO+c167Ydvadwh9Vti46hFtmQl0SOfJxK7YSa44LNmwGjxeF+8l459/
         82nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQRgiH28zU4JF8GsVrReA8Sb9mfqeXNQuHcbrXYaLJH+jcLgWeRGl7+j1OhRhvhi0jz8AAznp/dGxhli8lIQQ0vsAknpsfXgrNpONlY0g0pF30hklcZLhvf9Cx4yMW1/A80n3voadfj1qpff6vJfAwpn7OEd5dISUEiSt1PZqE+gc7uEjlMkItxT3mWJKJjQuyYhAxNGcnL+LpmpPl2qNW+nIYn2TOT6ANryU/XbVH0K3LWM0eannirX9wFd3112jDM5V5aj3RpEtfRolvdOtrzOwITj8TytV2mfA=
X-Gm-Message-State: AOJu0YzBzHdCfQp36v4ASL71vv1B18LIks2veks7Yvkc0Rh7cInZbqp9
	Qc4ecpjKvwVrXGwNPf7s1zuVbczq2EN7PgIGa++nPYgPXpW+7AcdtGmpDKKMmkA=
X-Google-Smtp-Source: AGHT+IFSK8EKQA4YLa1BW2O3gR/c6PoFXPU5Py2EL9IBEyYIERWPhz76GtYioIywO8cwI62nqsu0ow==
X-Received: by 2002:a05:6870:f14e:b0:221:8fd9:284c with SMTP id l14-20020a056870f14e00b002218fd9284cmr4587256oac.1.1710360778906;
        Wed, 13 Mar 2024 13:12:58 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x2-20020a0ce0c2000000b00690d36c64d2sm3341355qvk.53.2024.03.13.13.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 13:12:58 -0700 (PDT)
Message-ID: <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
Date: Wed, 13 Mar 2024 13:12:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Content-Language: en-US
To: Eric Biggers <ebiggers@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Karel Balej
 <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
 alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com,
 herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
 mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, iwd@lists.linux.dev
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
 <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <20240313194423.GA1111@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 12:44 PM, Eric Biggers wrote:
> On Wed, Mar 13, 2024 at 10:26:06AM -0700, James Prestwood wrote:
>> Hi,
>>
>> On 3/13/24 1:56 AM, Johannes Berg wrote:
>>> Not sure why you're CC'ing the world, but I guess adding a few more
>>> doesn't hurt ...
>>>
>>> On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>>>>    and I use iwd
>>> This is your problem, the wireless stack in the kernel doesn't use any
>>> kernel crypto code for 802.1X.
>> Yes, the wireless stack has zero bearing on the issue. I think that's what
>> you meant by "problem".
>>
>> IWD has used the kernel crypto API forever which was abruptly broken, that
>> is the problem.
>>
>> The original commit says it was to remove support for sha1 signed kernel
>> modules, but it did more than that and broke the keyctl API.
>>
> Which specific API is iwd using that is relevant here?
> I cloned https://kernel.googlesource.com/pub/scm/network/wireless/iwd
> and grepped for keyctl and AF_ALG, but there are no matches.

IWD uses ELL for its crypto, which uses the AF_ALG API:

https://git.kernel.org/pub/scm/libs/ell/ell.git/

I believe the failure is when calling:

KEYCTL_PKEY_QUERY enc="x962" hash="sha1"

 From logs Michael posted on the IWD list, the ELL API that fails is:

l_key_get_info (ell.git/ell/key.c:416)

Thanks,

James

>
> - Eric

