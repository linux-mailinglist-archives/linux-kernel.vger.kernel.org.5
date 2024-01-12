Return-Path: <linux-kernel+bounces-25043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D482C697
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1651C226EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7E168D7;
	Fri, 12 Jan 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6KjqJWp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272C168CC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705094542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nRuGhT7kIsJLThEtYm0oJmjhX2VA2ieJGjRJm0NCXqc=;
	b=g6KjqJWp7TBHyR92V2qvFWJxIIBfBkykMLnrwtRx/qEVGMesGR9O+qbs5dEBurxnklCSs2
	MX/BrDewlXKheoPoVzj/ABBmjQlv7UZ3Frsov4AjxlupN9Q6HYEq4Ej3rVQ8qqGdlRRxO2
	qj1OMFzTW+eLFWWFC0vBwm0fXg2p2OA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-0hRzcLzHPnuG2-5ekmACHA-1; Fri, 12 Jan 2024 16:22:21 -0500
X-MC-Unique: 0hRzcLzHPnuG2-5ekmACHA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-555e8b639abso4398561a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705094540; x=1705699340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRuGhT7kIsJLThEtYm0oJmjhX2VA2ieJGjRJm0NCXqc=;
        b=c1EgNttGtzJP91OHU1DQcar/AAtLypdS5sSoAcTy0WTPJkxU/pKhEAVDHuvqUvhTJY
         SkVFPSkOqaDds7CNW1C1z/rG9tTJ0C4HT3Y+K07/uOly/JZLGgAWYtBdwOkVxk8DouGt
         4wWjX1M9RCI3WTV02LU3HbloU5Lj3ZxLfHl4bHOx75f7zm7cB48/iEyIMglBuSb7AIS3
         BybpkfIb30VscsvPZRpII148uozdPPTLO61GFNsrvOmm2JhAGXz55bTle7Tyv7rMFVY+
         y0zEXZUkGeSiRH/YKjsy7gq2rcvGFk8z5Q6Qz6aD6BbT9YeU6wVrPbuE28mzbkhY9K49
         GluQ==
X-Gm-Message-State: AOJu0YyQ7G3OJaA1+JYelx46b/qWZifgmisVPGdUG+FPbZ9pjz2YhvUw
	1O3gpf/N/MtgEh+T//YK6LNWVwLzyxm0mCoYvHkn4HPANLnLO5ypAU9H8u7qyQoD22oAJj8dQzp
	P/ZLhLOlXx+xoE8Ld5d1UhZXBqzhxpLGu
X-Received: by 2002:aa7:d88c:0:b0:558:8f41:7e0c with SMTP id u12-20020aa7d88c000000b005588f417e0cmr971388edq.68.1705094539964;
        Fri, 12 Jan 2024 13:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF81pfUihzztRPx0/Fcbcy9xu/DuoUvtuC0Ug2SbT7Ig5qGZvGwGyMkR3GCVQjWJNPvP0DABQ==
X-Received: by 2002:aa7:d88c:0:b0:558:8f41:7e0c with SMTP id u12-20020aa7d88c000000b005588f417e0cmr971384edq.68.1705094539640;
        Fri, 12 Jan 2024 13:22:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cfc7000000b00557075b4499sm2219064edy.58.2024.01.12.13.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 13:22:18 -0800 (PST)
Message-ID: <1bf30a4c-943a-4e01-bbe2-a26d8701f21b@redhat.com>
Date: Fri, 12 Jan 2024 22:22:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A quick "Regression tracking: state of the union early 2024" from
 my side
To: Greg KH <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <7613e402-894a-4d38-8cef-7263630c1c57@leemhuis.info>
 <2024011243-aorta-defraud-7950@gregkh>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2024011243-aorta-defraud-7950@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/12/24 21:16, Greg KH wrote:
> On Wed, Jan 10, 2024 at 08:22:39AM +0100, Thorsten Leemhuis wrote:
>> ## The long story short
>>
>> I'm not really happy with my performance wrt to my regression tracking
>> efforts during the last year. To counter that, I've already shifted my
>> focus somewhat ~in October. With the new year I will shift it some more.
>> Top-priority will be "make regzbot more useful for kernel subsystem
>> maintainers" from now on. My tracking efforts of course will continue,
>> but everything except regressions in the current and the previous
>> mainline cycle might not see much attention from my side. This
>> refocusing also means that I won't work much on resolving some
>> ambiguities around "how regressions are supposed to be handled" which
>> lead to tension quite a few times. But all that should be for the best
>> in the long term.
> 
> While you might be "too close" to the details to feel like this past
> year was not good with regards to "performance", I'd like to counter
> that and say I have been immensely happy with the work you did last
> year.  The tracking and pushing on people to get regressions addressed
> and merged is thankless (as you well know), but vital to our project in
> order to keep our users happy.
> 
> So don't beat yourself up at all, you're doing a great job.

I was planning on sending a similar reply. But Greg has said
it so well that all I can say is that I fully agree with what
Greg wrote.

Thorsten thank you for all your efforts over the last year.

Regards,

Hans



