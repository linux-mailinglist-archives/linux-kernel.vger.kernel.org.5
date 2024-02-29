Return-Path: <linux-kernel+bounces-86315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB77186C3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A23CC281C85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2550255;
	Thu, 29 Feb 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tXm03ix3"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD74CDE5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195946; cv=none; b=G66msMlLlNhwq0CFiSt0/6eJWbUVoR83+20nK0pZlbjE1+IN4gLNLUYV/fugvCZNAUQDBmpcJpvmAGL72Ky+5kcI/qBLbRJGqjbO0lQXk2qnhgT6pwAjqs0/06N6xPJYdBnlv4nYylU93f1+ll5T+9aoC/DqhOewLxwfke1cGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195946; c=relaxed/simple;
	bh=9tSHEvQMFBzRFfVEDs6bbwPzSHU8bneViUjVwImV6oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzA1+wBJl4d/DJiuJJ9XjpdAEUpQRO4IfXtP4ncvxadQQOABaFaYjERjX2+QofGSLF0S8IOatzBVB0YIgs68oWD3HnYkFk8I+tcXONSwOragtmMlSRH5758/7hxFjP5FNsYTMf4GuOdFm19P0NAsVvnVt6rk/DfEjhvPjMfZids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tXm03ix3; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so81809366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709195942; x=1709800742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj+4ZLkxm8U146iTfNW2/inDJv8KHlXL+ERpBTpUwsg=;
        b=tXm03ix3TTLAh1+L9BUKBE6i3LetuN3Fmzn2n9S97LlsG4viHYYVmMlJXybe7C2mDD
         yNxLSvD8Cs5on20V+hKTJKEzAwz6VLVoj2WQY3catzBoYSuq9K+jdryG0JvQyvz4P1pT
         49EJqjYS38hXssuCJee/CbSlPcfvDSl/877fJVSFkOF6P8WYU5j9ZuYvVBc58RQIlqRH
         3OeaJtmZKOCqcJ3Y0EI5cRi3CSvDgxcKnrjN3rDmABYH5KP4lNI+RDSv93LU7tCT1SvD
         oBEHSPUaSj1+hJOqFze8QbiejePy67nkh7a2LfokQk5hYfDOHCeieDKY+N9ekm+aaVFn
         nD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709195942; x=1709800742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj+4ZLkxm8U146iTfNW2/inDJv8KHlXL+ERpBTpUwsg=;
        b=o13gnwHdkFqHpa9mA0nxRfGnS9uErSgHH0HkKeChkHexviDk45mpTWg3wR4rSM3cee
         oV3pN42HmU7nmjpPJAbuyIS5RkmEvePqLnPADkwsQicv4HjhIgSeTRwWgKUAIYQgRTXR
         QVwoRG9YyBtoSe+/ptTeV+4QRU1hYGESUP1j/ZbXORPlGGav/YkwWkyDcqYUVmzzUC/q
         5qrbDQ0PVAo2SGMYwMwTGNoN24Gl7lWSyOlXZpFBxSK+w8+w/sqeoMA9+TFzS/dqe7Rc
         t9vVdOFIMM2ccnn3uWEMzAgcf4Nm14JHnMmlyeQdM7qZdDUgw8hWkx5W1LzKBsJriy3E
         gYGg==
X-Gm-Message-State: AOJu0YxfI4GNOYnhbHoXDN304T/0a9dyLVGiF5UtXMuZggvrtHpd9zTJ
	UV0XkEZlp3pUuWxVW16UjmPw2s7D+MEpxaPYIZNxJeETm2fyohLQazkFmnGsT7I=
X-Google-Smtp-Source: AGHT+IE77Y4/4q7h17RymUYlINs7aUt8WUi8P3mNwbqmG+XQZeXHHrqU7cVZx2KXYQHHzn6Sj1n+pg==
X-Received: by 2002:a17:906:d0d9:b0:a3f:b5d1:7174 with SMTP id bq25-20020a170906d0d900b00a3fb5d17174mr1019019ejb.3.1709195942469;
        Thu, 29 Feb 2024 00:39:02 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00a4411a2c151sm438850ejc.122.2024.02.29.00.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:39:01 -0800 (PST)
Date: Thu, 29 Feb 2024 09:39:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Shiming Cheng =?utf-8?B?KOaIkOivl+aYjik=?= <Shiming.Cheng@mediatek.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net v3] ipv6:flush ipv6 route cache when rule is changed
Message-ID: <ZeBCpOAiQ_-DKEKi@nanopsycho>
References: <c9fe5b133393efd179c54f3d7bed78d16b14e4ab.camel@mediatek.com>
 <Zd9WU1bpoOlR9de7@nanopsycho>
 <5a422630db12a06a4e8d064d9dd2c7402a4bbe07.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a422630db12a06a4e8d064d9dd2c7402a4bbe07.camel@mediatek.com>

Thu, Feb 29, 2024 at 09:24:54AM CET, Lena.Wang@mediatek.com wrote:
>On Wed, 2024-02-28 at 16:50 +0100, Jiri Pirko wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  Wed, Feb 28, 2024 at 04:38:56PM CET, Lena.Wang@mediatek.com wrote:
>> >From: Shiming Cheng <shiming.cheng@mediatek.com>
>> >
>> >When rule policy is changed, ipv6 socket cache is not refreshed.
>> >The sock's skb still uses a outdated route cache and was sent to
>> >a wrong interface.
>> >
>> >To avoid this error we should update fib node's version when
>> >rule is changed. Then skb's route will be reroute checked as
>> >route cache version is already different with fib node version.
>> >The route cache is refreshed to match the latest rule.
>> >
>> >Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
>> >Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>> 
>> 1) You are still missing Fixes tags, I don't know what to say.
>I am sorry for the confuse. My previous change log of fix tag is a
>wrong description for "PATCH net v2".
>
>Current patch doesn't fix previous commit. It is more like missing
>flush since the first commit 101367c2f8c4 of creating fib6_rules.c. Is
>it OK to add this fix or omit fix tag?

No, the "Fixes" tag needs to be present. In this case, it looks like:
Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
Is the appropriate one. Isn't it?

>
>> 2) Re patch subject:
>>    "ipv6:flush ipv6 route cache when rule is changed"
>>    Could it be:
>>    "ipv6: fib6_rules: flush route cache when rule is changed"
>>    ? please.
>Yes, I will update later in v4.
>
>> 3) Could you please honor the 24h hours resubmission rule:
>> 
>https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr
>> 
>OK. I will follow the rule later.
>
>> pw-bot: cr

