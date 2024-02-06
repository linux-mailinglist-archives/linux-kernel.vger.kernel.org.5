Return-Path: <linux-kernel+bounces-55332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD2E84BB3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1DDB29B74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DDA8F4E;
	Tue,  6 Feb 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj96XATx"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A78F6E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237816; cv=none; b=jAopgNinRFq1MvB8d77bdQytW8p3E0xUUJ5OQvzGSo4Rv19owE6k5CJQ52ITVXkEcyXe8tlrq7UhpyS+ZkoTs6UcsQc425EkQzYb6IBivNjtGRYsZYB10S86tCLLS2Nkzh4n47pCiER29ypWPxyEA4jXM7MOLoGcb6H8xH8IrdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237816; c=relaxed/simple;
	bh=VOLjXF5uAfLij2hReDqHpAIxnciGhuC2Dkl6LJteXfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lAtLymGmOHL3z54T9vSDWQScbIL0dbDaogjsZdiKMLXDMVka1afRu+J7RxO6xjKP6GLFiJ6ziMkb9mxFxsLCovlL3SoRx8ldSiUEQ7A5NG9PlXVR/yiUf0+CzqbrYlfe8FxUsE/KLdBlGModKLXqctYK7IBLUJPi0jwGnunPT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj96XATx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7858a469aso43206765ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707237814; x=1707842614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bootBaRXZfJhCL9dqvms1LoTw8m7QAtAyMTQDgZlz+4=;
        b=Dj96XATxAreOs/2Y1fIYicAFjcsKxOaW7Is03Bx/U3hkPPkB2CGZX3amJFa/Lw0jGz
         wshbLATnWYMzWFlzKs0qcK/TOHzZXagmOWaU3msnOKUVOb3I3q29a9jn7MS/9iV+kNO+
         2RVA3aBV5+xXXpda5iuoWYx7RFi8gvi5BEXzqRlISMiry1t0UYE+wfoe01RV4hdZKql0
         3E3hc5nZ5bFrr6PwL6azJk7l0UGOvC1TG3lbRND0fhCHC+UqRvXyWXi+acXEtwkJ4RIG
         EKwxWt8KVjR4YoHekzGViC4XZ8Udmswl0ikC6sIeHK233jAmY9U35YcPWRoS21YfNWGP
         wYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237814; x=1707842614;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bootBaRXZfJhCL9dqvms1LoTw8m7QAtAyMTQDgZlz+4=;
        b=O4usr6eaPjl6IlRY06uE/9JL6UVp6p/QsyPQw6Bu9M+Yt+21mf/oyOt3xqYcttZPPx
         YmUiIWTwf/L1ywg1WxXBT+hfMzW092kbrC/n4CBho6A5LIxfGK2+h2QbtxciocXCsvWU
         mNntZfI8m2lR/0O5hfTrfuLOr9AqLaqZVFglfk4dtOQ6i3pHxyghf76DD0bApN1bO5wJ
         mq88xC2Zq3BFuvDNvqg8QO++GeLLRJxTpY+LXcIJ0SLkW8ieR0n/Lxdhw8z3LWBeHv1Z
         eZyXJRq9CVub8WmntAzdSXOkH3d580RUAZ6ITx6C2+6Ao4Kaa0E0FhLUmexBGQiSChUs
         658Q==
X-Gm-Message-State: AOJu0YwSTlVizSNTVsbtAicq4fl2QjmBtoZyFmtSZJ2vszpOpVmY7bJT
	+JY8iu9NPmBgFSvg5O1AgrApOYanxB1b6oBsbHwm4aXK3OUEzlOGP+rPmHv3
X-Google-Smtp-Source: AGHT+IGjFxI6/4AkJalf6cTMn6s8YQQYgXC8a8O0EAHRSDsmpuyuK1M9IyjPrATVBY/w1XRLkEcOIQ==
X-Received: by 2002:a17:903:192:b0:1d9:9735:ed6c with SMTP id z18-20020a170903019200b001d99735ed6cmr2261604plg.14.1707237814126;
        Tue, 06 Feb 2024 08:43:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWy3568jBz8KVWOSEMwxuua2ERIJEgprcl5gXtpPezPqC+wW44/kIm/fgUfd2NnBnilOHzZPWmgE2L5Aq+0BY9oPsp8EXBurNWhm7HTZRCVNsarNRlfPMcrxl49ADilnhxXxoNmyOg9HgXoK9VAmy720aLVsC/Ae/QX
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi14-20020a170902fcce00b001d8fe502661sm2109470plb.19.2024.02.06.08.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 08:43:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1bf36657-0169-4d10-960f-ba01dba0411b@roeck-us.net>
Date: Tue, 6 Feb 2024 08:43:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regmap: kunit: fix raw noinc write test wrapping
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240206151004.1636761-2-ben.wolsieffer@hefring.com>
 <ZcJSc595GcjDC4QK@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcJSc595GcjDC4QK@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/6/24 07:38, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 10:10:05AM -0500, Ben Wolsieffer wrote:
>> The raw noinc write test places a known value in the register following
>> the noinc register to verify that it is not disturbed by the noinc
>> write. This test ensures this value is distinct by adding 100 to the
>> second element of the noinc write data.
>>
>> The regmap registers are 16-bit, while the test value is stored in an
>> unsigned int. Therefore, adding 100 may cause the register to wrap while
>> the test value does not, causing the test to fail. This patch fixes this
>> by changing val_test and val_last from unsigned int to u16.
> 
> Ah, that'd do it!  I wonder why Guenter is seeing this with much greater
> frequency than I am, I have managed to reproduce a few times this
> afternoon but very rarely.  Guenter, does this fix the issues you're
> seeing?


Give me a bit. It takes ~2 hours for a complete test run.

I am not surprised that you didn't see the problem easily. I am running
more than 500 boot tests on each release, and only saw it in four of them
when testing v6.8-rc3. So I'd expect a "hit" rate of about 1%.

Thanks,
Guenter


