Return-Path: <linux-kernel+bounces-160187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F508B3A59
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235F31F2447E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83414884C;
	Fri, 26 Apr 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+9UVhLq"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AC14533D;
	Fri, 26 Apr 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142856; cv=none; b=jlbcVS/DAD/Vdotzucj4hj9tyaKV3WD6sw15q6sFcbBHH/SMj6uIdm7m0vtTf4fD/vzX1Yy/iLl5thb39Loz8Bz2fekm6pX1Zzr3JrRGJcu2VH7AycHyD8t1A01ttq2wukCi9DSaw2RFgBy5hX8hupugcmqkvbYPcWbUuxoZp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142856; c=relaxed/simple;
	bh=WChWKfVSRr4sAD+JAYWF7dKNc3cWoPuqEPOa0h33mAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJXKfuHawVIleDwWpQVQDhBeEvgcXmRFInt6BUEzxrRhcAKT7O006p1kary/ij7HuuP6G0IXzeNm7b1lz8SKMe9lxbkkytmZ2U57PnVOFjFsxWjttmtvH/0FE5ycRf50+bJdbpZeDWZQ1pGRT78muRXJfuU53a9y7H8/1pUnqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+9UVhLq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e86d56b3bcso20365805ad.1;
        Fri, 26 Apr 2024 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142854; x=1714747654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxLObEhnyQXMbb7EJHoFbdNmA9PMbFHPQxoSP+h7pjI=;
        b=R+9UVhLqYMk8ecEK975if/kIWZpTxBeIwJGawds3W5m2x3FG6cpkknLWXbW426N9gx
         d1ksRKeUEJz9iEMgjd9omDpAfR93nL9JhQT6IH9xo0aM65kTLDe6F1hzpSAkM9zsBoyL
         Lt/CmC5MtXJ7+jA/xTqbT3Tat9O87LbyDuxT6LpMcWwlxBULjudWBiL1j6eV0Klg3T5f
         WFYteBfgem0s/0vOOsFHk0wUIbJS6f53J9cEvaxy1HhA9afAQrQmsLgXPJsSmOX+uDkR
         Mn4FKENP9eA9ecXGWYQugdLCajiGRbGeE25vQlg681b8m/dcIIpzkQeNAqDngTszzbF9
         y2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142854; x=1714747654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxLObEhnyQXMbb7EJHoFbdNmA9PMbFHPQxoSP+h7pjI=;
        b=xToyYNvfz27mIv/CNwLjZNdCI6cVqaAh7qnbgVbHePd3hdTeSr8guShus4DqdHbbAq
         RviGt4TfDX/mBeJyOLtsyVphHsh9anLUHbuJffOF/A6NLG6Ro+h05eRfqVrqdCS8Krg2
         0Qg0/z1wuaRi5AFyYu0YDLboYUOEMASYIikkjdhJwqdeQIvfyoDL8aM6V3XybGPQVYDP
         g6cw7xE4IvlQ+3Srd2ztYktbFlltGMj/cebE81bkIcpllp1Y5SKWnuxwK430or/uKi2U
         zdQUyU0Sup4h2b9Kdt8w4n9Xiurtd5NDS1SvYl59vNmRux0vKjjbTjYIhG/1zsaZCDGV
         MqEg==
X-Forwarded-Encrypted: i=1; AJvYcCURMGPN1G32co0WmqapSHbOQMCMQzEwGvkRApsoh1LI7RgFTRVtEFDLDy9WZX+UtngEeWRszBPWQebr31bjcncN1cwscug6OIAd+QnMLhwhj/xd52VrbHTqLd/9TmyRv3dKhOC8gm8h
X-Gm-Message-State: AOJu0Yx67T3cPHdKcSqHHez4qrS1mqM4kh0099plrygZvInfXROIBxKW
	s0sNbGjp52nCvNy+A9aB46mj2U7ARyp7P0egksp4Kz662HRcpEw2
X-Google-Smtp-Source: AGHT+IGVzCCLgd/gTDeQUMOMhwbRj35viRjmadUHYXkLruDzELq38l0EOgMq6hR6dwgRabBVX9jc1Q==
X-Received: by 2002:a17:902:d48d:b0:1e2:d4da:6c72 with SMTP id c13-20020a170902d48d00b001e2d4da6c72mr3582025plg.0.1714142854400;
        Fri, 26 Apr 2024 07:47:34 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:ca6d:d464:fc91:de0a? ([2402:e280:214c:86:ca6d:d464:fc91:de0a])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b001e27557050dsm15619977plx.178.2024.04.26.07.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:47:33 -0700 (PDT)
Message-ID: <559deef5-d437-4802-b3ec-78caab87355f@gmail.com>
Date: Fri, 26 Apr 2024 20:17:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 linux-next] usb:typec:mux: remove indentation for
 common path
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240424172716.3407-1-prosunofficial@gmail.com>
 <ZiosKjYjMG3my5FY@kuha.fi.intel.com>
 <5326cb96-e736-4455-abcf-921576b15be7@gmail.com>
 <ZiukxoDxkLsIVG+Q@kuha.fi.intel.com>
Content-Language: en-US
From: sundar <prosunofficial@gmail.com>
In-Reply-To: <ZiukxoDxkLsIVG+Q@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/04/24 18:27, Heikki Krogerus wrote:
> On Thu, Apr 25, 2024 at 08:15:04PM +0530, sundar wrote:
>> On 25/04/24 15:40, Heikki Krogerus wrote:
>>> On Wed, Apr 24, 2024 at 10:57:16PM +0530, sundar wrote:
>>>> Nitpick, Mostly common path will not be indented.  so rewritten this
>>>> function to check device_node pointer is null and removed common path
>>>> indentation.
>>>>
>>>> Signed-off-by: sundar <prosunofficial@gmail.com>
>>>
>>> I don't think that is your full name, or is it?
>>>
>>> thanks,
>>>
>> Hi Heikki,
>>
>> Sundar is my full name.
>> Previously, I wrote my name in caps.after changing to small,  conflict
>> arises.now I fixed it.
> 
> 
> You need to use your real, full name - what ever your name is in your
> passport. I find it a bit hard to believe you don't have a family (or
> given?) name.
> 
> Your email returns couple of commits where you're name is "R SUNDAR".
> What does the "R" stand for?
> 
> thanks,
> 
Hi Heikki,

ok, so it will be R Sundar. I will change and send updated patch.
R is first letter of father's name.

sorry for inconvenience.

Regards,
Sundar.

