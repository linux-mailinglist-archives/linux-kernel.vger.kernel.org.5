Return-Path: <linux-kernel+bounces-133904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440C289AA90
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C951C211EB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386A32189;
	Sat,  6 Apr 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJsSGMX6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E82C6B6
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712402106; cv=none; b=aysjR/TB+8QVkeynwp9jHEbXyUWzL0YllSDCkO/zU0RtMgWg/hPXcyzwIsRSsdn1slrJewcthiUbLyyGlGNcoBPaQIu2AOfwuEfe9Ya+4Gjf0A+trOLHgeC607V3hiFteVuhkqwN7kaHNEjDHwrwE9Tbgvfl+YL0zUqQ9mv82dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712402106; c=relaxed/simple;
	bh=eq9GLD/Fr9Nx8VeylYdiVCEtk0zgvv0BP5Q8CYgka3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6tvn6Rclb0JHO294QHCPs1SAtwRC2SQYAkcwe5V5TtdJxY+zIjZv5oVKXrJ8kKgbWS0uI3dHQkaMh+iI1LxvZU2jOswWf4m+m2PzZrupjtCyCyUXtOhC2uCmL479YCHJ88m4ngBEL7LMhd4wqVnv+ix6a/n/s/LjqX+4qL6Dq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJsSGMX6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51a7d4466bso158851266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712402103; x=1713006903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DONNxQj7uQAuULZLUQYBWYz3WYb2USiS2+mB35Mhs78=;
        b=IJsSGMX60oH52ADTHTZBsBpTOI5Ar9QFqnVIv5ECRxsbbb5kwwaufEMjoa+fywcLcP
         YCIDa9gMTOSR/T1ArLinQC1wxVIVCaNYmwlQ3mmS1vqIAw4RM9dCPa3LVLgcqYtpviYj
         v/jnhTaXg9dnP9F9LTc7kEK8iPNNT0qnKwOUQirk7180eodA8fS1P4Ep3QW+4jSVlWmO
         IAiBF/MWUbQhLOLTwXWFgrjsX64Vl5qgqwMdEmrmQ685arL0j9+SbIVkPCVdM0HlQT94
         dko4dEB9AIaSi20hJotOHUesKqeN+eDEtzM/lHIvbj7V+zZv7DmPrBLRhdLlU5BdUj8e
         5dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712402103; x=1713006903;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DONNxQj7uQAuULZLUQYBWYz3WYb2USiS2+mB35Mhs78=;
        b=HZVxb1Vpn4duCB9N6lR8c7T1fCcDl0WdlyShdUveg4BrVuWEZz1+KFYSjOhB0VjreM
         lwE+2q7S2ezSqwjNWf5feXOOBiQZGFtxz7EbBKSpPnLcLPd255uxM/S/EsZYalL3a8uV
         zgkwLt9OlEywkfRJJgXseNL8nEV6Mhj/WE/pm8Umc01yWjR+EXOAc9nF+JH6ODEWPAIU
         LsVC0/NGy5ino1wWvVYeKY3vQAJRmJhDfa10vB190bjHMYtlfMmJliQfUOLFA+jUih++
         02VDCuikeiJtDmHkLCug0e9sscY72pLjcYnV1ARn0unnJCCJxpoyanU0s5r7l7DQh19+
         WnHA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEDYGSjNwupZEU+newDvO0BvgAS8gD9hEGOzn007ZY/8J01ukN/o27GsC5uOfcfvson9L0VfqgA1d3CMRY6rHGksv6WproU9iFuxe
X-Gm-Message-State: AOJu0Yyp4kqUG+ZpOO5HMzG2neCHajX0dYPbyCGCuWv0NfCIXQ7c2V55
	0xctq1VV2majAlcTtIsAbL6DIpEvv4POJNJbQvDKjKXEKINRl3X4B5KqpPvOraI=
X-Google-Smtp-Source: AGHT+IHIP2TD6NZIKJknZxo/HK7lAmS6lZJlAEVTPT1kVzEMKnHv0iL5lNMbEASAZFkJbTSuG6aRVQ==
X-Received: by 2002:a17:906:c104:b0:a51:aad5:8c62 with SMTP id do4-20020a170906c10400b00a51aad58c62mr2990777ejc.60.1712402102721;
        Sat, 06 Apr 2024 04:15:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170907761a00b00a474c3c2f9dsm1907127ejc.38.2024.04.06.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Apr 2024 04:15:02 -0700 (PDT)
Message-ID: <d8ca9e63-7033-43f0-9a43-304b1a7ded42@linaro.org>
Date: Sat, 6 Apr 2024 13:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Johan Hovold <johan@kernel.org>, Krishna Kurapati
 <quic_kriskura@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
 quic_jackp@quicinc.com, Johan Hovold <johan+linaro@kernel.org>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
 <20240404051229.3082902-3-quic_kriskura@quicinc.com>
 <Zg5VDnbaaBXJyRjV@hovoldconsulting.com>
 <f16e1280-8f7e-40a7-ab45-9acaeb3e90cb@linaro.org>
 <2024040455-sitting-dictator-170c@gregkh>
 <Zg9THGBRuppfw4y+@hu-bjorande-lv.qualcomm.com>
 <2024040558-undercut-sandbar-7ffc@gregkh>
 <ZhBQhvieHGtMOSEz@hu-bjorande-lv.qualcomm.com>
 <CAA8EJpr94_uCHoJyQd2uQyZ35xXixPPMHPVGXciZn+GftUUjnA@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpr94_uCHoJyQd2uQyZ35xXixPPMHPVGXciZn+GftUUjnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 22:36, Dmitry Baryshkov wrote:
>>>>>
>>>>> Also get those internal reviewers to sign-off on the commits and have
>>>>> that show up when you post them next.  That way they are also
>>>>> responsible for this patchset, it's not fair that they are making you do
>>>>> all the work here :)
>>>>>
>>>>
>>>> I like this idea and I'm open to us changing our way of handling this.
>>>>
>>>> But unless such internal review brings significant input to the
>>>> development I'd say a s-o-b would take the credit from the actual
>>>> author.
>>>
>>> It does not do that at all.  It provides proof that someone else has
>>> reviewed it and agrees with it.  Think of it as a "path of blame" for
>>> when things go bad (i.e. there is a bug in the submission.)  Putting
>>> your name on it makes you take responsibility if that happens.
>>>
>>
>> Right, this is why I like your idea.
>>
>> But as s-o-b either builds a trail of who handled the patch, or reflects
>> that it was co-authored by multiple people, I don't think either one
>> properly reflects reality.
>>
>>>> We've discussed a few times about carrying Reviewed-by et al from the
>>>> internal reviews, but as maintainer I dislike this because I'd have no
>>>> way to know if a r-b on vN means the patch was reviewed, or if it was
>>>> just "accidentally" carried from v(N-1).
>>>> But it might be worth this risk, is this something you think would be
>>>> appropriate?
>>>
>>> For some companies we REQUIRE this to happen due to low-quality
>>> submissions and waste of reviewer's time.  Based on the track record
>>> here for some of these patchsets, hopefully it doesn't become a
>>> requirement for this company as well :)
>>>
>>
>> Interesting, I was under the impression that we (maintainers) didn't
>> want such internally originating tags.
> 
> But why? It just means that the patch has been reviewed. In some rare
> cases we explicitly ask a developer to have all the patches reviewed
> before sending them upstream. In such a case having an R-B tag
> fulfills the expectation of the maintainer: it shows that another
> engineer has reviewed the patch.

Wait, there are two types of internal reviews.

Automatic, +1 from Gerrit or from whatever internal processes require,
which are not useful because these internal reviewers do not actually
review. I have seen a lot of such and I complain. It's easy to spot them
- a patchset consisting of few patches, including trivial ones, all of
them carrying one more more review tags. Even fixing a typo: reviewed
tag. Plus then you see that quality of the patchset is actually poor.

Another are real reviews done internally. If they are real, I find them
useful.

Best regards,
Krzysztof


