Return-Path: <linux-kernel+bounces-35037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09092838AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAA1C21FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3185A109;
	Tue, 23 Jan 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="08ihOTqm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EBB5A0FF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003335; cv=none; b=r2m5CUG0CWTwceg+d1/EZ97rN2ffh6ob8LspHrzgixcDc2M5ua/brESeXrExPUdH3F3IPRJOqVHqehEyzwANh0u/T0m/3f5HTriA/3tnSPiQChPui20Opn/6DqCfFlRMeDbYK1Xfa2nMwEJ0v0E0uOtZ1lKrya1kCFFiWQP9kN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003335; c=relaxed/simple;
	bh=+8dKFSYTTrQHy5TIeIlpTGOGgvwuQhUn3j2tZwKtHkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIgvh7CJySv05cbPhnVf5U9KcDU/5Pk0fBaYfh/xnCkVgPvCkbv4SKP5fiLphPWdqS188A5mOq7zp1m0Se/D1WPIUKgT22bwRnM3cMCAa69x7Wig2kXMIiSVUaz4XmL7lYode8jg0An4B0Ttn9z57ah7LiRHAEqJ9HqeKLH2IFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=08ihOTqm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-337d05b8942so4714580f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706003332; x=1706608132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PWpS1ytBrOjGWEMxlvh7MGTF7ngPjwR9i+Q5Nc+3fnk=;
        b=08ihOTqmM4KgdQDBvXBAfZwMWTP2zetq1fWyI+15LL7l9la7qS9JN3+EjXU23pQmFz
         XuC3tRQSif0JTdgXDR2TJKGNNUD3r2PG8CipYqZ+AtOpp1LAEG4MYagJGNhf1oeSbWjr
         AerFKeBOS/fEkWt2fV6HeXLe+Scqnne3CNLeysgYKWK+smdHXlCvvzU1/jEn12JClxvk
         748srIisj5jreP6Q7R8P8m56+KTfi8wMeY+usODAU3V1+dhAaQjRfuLOBCvhokbti6nh
         9F70cvz+8gxwQErCB1fL/yGyalcYKKwdhf8aLr+URPxdsfDKW6eFQJis/0feWrVJpKE8
         WKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003332; x=1706608132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWpS1ytBrOjGWEMxlvh7MGTF7ngPjwR9i+Q5Nc+3fnk=;
        b=TcsXjUJV1GN+K3uppcAlwYH00WP7/je1xaJvnlTNjYwoR++BhTMQNw2tZdWSqPdWi/
         yXtndcnv2fDYdfVCSK8dJnXqd8e9CsEyhmML5sHKtD3qb0Wi/INIV6KDsxb7sIbDsg8X
         kc4iD274qOTmE6jpf8dFJjn5jRq88kg/SR0ch/PKXEkS7F67+4892ZFBlbGYsMYSXqBn
         rR291WjXv69n6zKEYdD3scKf76fxhwA2ASpbWesZ6I2kUSGXSJrMiK6yGZVpvd1y7x3k
         sbEni9B0uphBV/CBVRD7pPN1xUssRln7GGFltXgWbitAykzNsAI1DuzIaEesoCnn1ueK
         /uCw==
X-Gm-Message-State: AOJu0YyccQm++R/aFi3sUMSxp8kbqder2XLQKk9cfJJw16L1+MQhQPy5
	QNZIJyWvZY0ZEo2eKiTQZElwKmY1ISNhYVbaRzBOZZXf8UyqodfxIejCqnfzlko=
X-Google-Smtp-Source: AGHT+IHvCLtOAK0Is7t239vQ6RuH0gatFeoMENF8cPRrd/F9biXxtyj5lMGzC/7gQG4TQkAI7tOO2g==
X-Received: by 2002:a7b:cb55:0:b0:40e:4275:5aad with SMTP id v21-20020a7bcb55000000b0040e42755aadmr385765wmj.166.1706003331642;
        Tue, 23 Jan 2024 01:48:51 -0800 (PST)
Received: from ?IPV6:2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31? (2a01cb05945b7e009bdc688723a24f31.ipv6.abo.wanadoo.fr. [2a01:cb05:945b:7e00:9bdc:6887:23a2:4f31])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm45686455wmo.7.2024.01.23.01.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 01:48:51 -0800 (PST)
Message-ID: <b5decdec-f33a-4997-a607-e31290fcd83c@smile.fr>
Date: Tue, 23 Jan 2024 10:48:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: ti-abb: don't use
 devm_platform_ioremap_resource_byname for shared interrupt register
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 tony@atomide.com, lgirdwood@gmail.com, Romain Naour <romain.naour@skf.com>
References: <20240122170442.729374-1-romain.naour@smile.fr>
 <1b2b5afc-308f-48bb-924a-2c29371abfc9@sirena.org.uk>
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <1b2b5afc-308f-48bb-924a-2c29371abfc9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Le 22/01/2024 à 18:30, Mark Brown a écrit :
> On Mon, Jan 22, 2024 at 06:04:42PM +0100, Romain Naour wrote:
> 
>> We can't use devm_platform_ioremap_resource_byname() to remap the
>> interrupt register that can be shared between
>> regulator-abb-{ivahd,dspeve,gpu} drivers instance.
> 
> ...
> 
>> The commit b36c6b1887ff (regulator: ti-abb: Make use of the helper
>> function devm_ioremap related) overlooked the following comment
>> explaining why devm_ioremap() is used in this case:
> 
>> /*
>>  * We may have shared interrupt register offsets which are
>>  * write-1-to-clear between domains ensuring exclusivity.
>>  */
> 
> I have to say that I wouldn't infer from that comment that there is any
> reason why _byname() won't work - one would generally expect that a
> get_resource_by_name() followed by an ioremap() of that resource would
> be equivalent to the combined helper.  Based on the commit log here I
> frankly have no idea what the issue is.  You should also add something
> to the code which makes it clear what the issue is so the same
> conversion isn't performed again, assuming that the fix isn't in the
> helper.

I'm agree with you about the existing comment that is not really crystal clear.

The combined helper introduce a call to devm_request_mem_region() that create a
new busy resource region on PRM_IRQSTATUS_MPU register (0x4ae06010). The first
devm_request_mem_region() call succeed for regulator-abb-ivahd but fail for the
two other regulator-abb-dspeve and regulator-abb-gpu.

Here is the iomem content without this patch:
# cat /proc/iomem | grep -i 4ae06
4ae06010-4ae06013 : 4ae07e34.regulator-abb-ivahd int-address
4ae06014-4ae06017 : 4ae07ddc.regulator-abb-mpu int-address

regulator-abb-dspeve and regulator-abb-gpu are missing due to
devm_request_mem_region() failure (EBUSY)

I don't know how to fix this issue keeping
devm_platform_ioremap_resource_byname() when the same address is used several
time... suggestion welcome.

> 
>>
>> Fixes:
> 
> You're missing the commit here.
> 
>> This partially reverts commit b36c6b1887ffc6b58b556120bfbd511880515247.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

I added such human description above in the commit log but forgot to update this
one, sorry.

Thank you for the review.

Best regards,
Romain


