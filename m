Return-Path: <linux-kernel+bounces-32943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4546836257
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138511C27124
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B93A8EE;
	Mon, 22 Jan 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="LZL5F5+Q"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD593A8EF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923731; cv=none; b=fWBSLe/+PtTKC3uIk793ivnL/IfkxEhNMCyqaDCAwuwgAX1SG8qs/dKGJlv7F3r7Hj9FWI5a4QOeWWTXgHeoYqk6LnJhHXwDH1Qb+HWaI9H5UD5K6H/sZyTMtXT/NCNSyEOn/9b/njPswGkrRlgdYTQjpne8nYlA8HkNt6yAflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923731; c=relaxed/simple;
	bh=p8mFBioFSGMpFI4+0O/7h3p0pouf1wuljSCA6Wdtdqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AclxLd7EIfK5vLKbG5WHjyHI5iTVXuz0uG+R9uhMlzxjtxkcWaAzMuBbS0h4Av3QzEd3NQxtOaYTmwn3eu4x6x5Y3n8Weh9Qj7NlkVTBBtIXL9oabS5zpLrO5VYpjl4nMedZCZjpnalVCJUSlfANL8PmhdQnQ+Skk2ADXbWPNO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=LZL5F5+Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d746ce7d13so7872745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1705923729; x=1706528529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOrKcZx9j959hh2gsjvnZOBiSVynu6VguYs2Gb1PKY=;
        b=LZL5F5+QvXPWdw/enW6IvEEtLbPQpRRd0XQU4Phx0UgEsHm82PQ9uyUN1UMuxP7F4u
         bd4vNgXSDg+g6GK/9AYJ0omvwzGvo6RiWbXJjoRbnDIcVsqwboamm9a1vEHUty/OjTnk
         awW1PnzKCZvRB3Qx4yQWObPn7dPMSK2IFwhquoItXiRo1h+ISo0LH3duRthNJahzhgG+
         JK0LJnEYtz+xIYI9cWIYk8bH4rHRP8s3PpiMuvJsgnpWDiS1Kfifl7laZ3IkzlioQisO
         o21ydjj3AhtpEV228HazvPsXSs9+lygNOkd0GnNWMbaPaa85TlIfh7sVCieKxVvSVWEH
         pUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705923729; x=1706528529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDOrKcZx9j959hh2gsjvnZOBiSVynu6VguYs2Gb1PKY=;
        b=vHfXb2WcAC8oykt+8AwtwYJ4u+h6tnXRuOSPBiTg0v3g8ssDsqJ/40eTrPGPQh6X4/
         IS09r4xSsiS9YdgwidiJAfUiUcI1S0fS4WCOwzAdop1rksy+OG1jKwcGYU561eBT8aVh
         1UlFvfM9v1GCTcT6/9i0tMv7pm5UvZkbaUzutP4wyfnyF+XpNCiGHPP/AaArt8SFm/uG
         vuZvxK3kA0FnScsRW0tzYZaveHEyomUVxJc0rMEZMdkEfS0l+x48pc8cJ5DAHPqbcWZH
         HxHYmec9b76VC0vMla14ihgsddtas/2uKMYnfHlBI0nzB248HfiRTo8Jo9V2R9ruP2Jm
         8fjg==
X-Gm-Message-State: AOJu0Yz5lD2+e0NLrTSqMZ7kIgnHLpsAkj5q/GzAiYHGjjXslsftPt9J
	1RzCCl+QV+sfeYPbd1k9C3m0a3rf1quF4X29qTzTflv87+qBxUS8OshGUWazXB0=
X-Google-Smtp-Source: AGHT+IFhauUxxcHWbRP/G/p+sHBK4ur8LGeSOIoPsyifnQIW/64VbzUo2FKyq+InMqk8yhcKMGyIvw==
X-Received: by 2002:a17:902:a3c7:b0:1d7:1211:afaf with SMTP id q7-20020a170902a3c700b001d71211afafmr3996722plb.138.1705923729229;
        Mon, 22 Jan 2024 03:42:09 -0800 (PST)
Received: from [192.168.20.11] ([180.150.112.156])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902694800b001d46274b533sm7035450plt.138.2024.01.22.03.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:42:08 -0800 (PST)
Message-ID: <3be58246-1a39-45f9-981f-7ada71868a4b@tweaklogic.com>
Date: Mon, 22 Jan 2024 22:12:00 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: anshulusr@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
 javier.carrasco.cruz@gmail.com, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
 matt@ranostay.sg, mazziesaccount@gmail.com, robh+dt@kernel.org,
 stefan.windfeldt-prytz@axis.com
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
 <Za0TpiKjDD27Vh_x@smile.fi.intel.com>
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <Za0TpiKjDD27Vh_x@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/1/24 23:22, Andy Shevchenko wrote:
> On Sun, Jan 21, 2024 at 10:22:50AM +0100, Christophe JAILLET wrote:

> Seems like entire conditional here is not needed as it's implied in the max().
> And max() should take both signed or unsigned types, different types might have
> a side effect.
Ok, understood.
> 
>>> +	/*
>>> +	 * Whichever is greater - integration time period or
>>> +	 * sampling period.
>>> +	 */
>>> +	delay = max(intg_time,
>>> +		    apds9306_repeat_rate_period[repeat_rate_idx]);
> 
Thanks for the review.

Regards,
Subhajit Ghosh

