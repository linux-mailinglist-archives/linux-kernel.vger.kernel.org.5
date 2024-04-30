Return-Path: <linux-kernel+bounces-163689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7188B6E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA381C22D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4C128370;
	Tue, 30 Apr 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eRF+cqcD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B561292DB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469232; cv=none; b=Rr5FUBqCSqnedw0pwfEWAWOpYyoxnuZL4DMVyZYTjG7wLRaXJFZzIYqO4bMaQmYqItFo/5gjDWuztagIbLzwp8GQWciNI5CYRYCkUXgh8LLFHEq1vqgqyQ3lcXmSbv1YamuWC+WDYd0DtDezFPH8FD4dxnF7ScT7tqPZtZiXdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469232; c=relaxed/simple;
	bh=xAjHBhW5G9x0pVHnYlKzO2XdfWKpzJvrtWMvXKHGP44=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aWIDZK+g3UkN41HA6N88bRzOtlvwLF3yfawq6Pvw0eQ6bO/HV39Hv5gKpYJ3pTV6lzI/A2/f5CC6EuDeI4G+lqkYowkeeNsgqQ9InsdnVNrHe+him9erepvpeYFaZ8J5P4vkbbu31ck7ywvx70Hhb1eVPg7SflZLtwytFKyM2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eRF+cqcD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso5960305e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1714469229; x=1715074029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HisHiVQGKfq5Qf2qSm14t1Am2lK9Nhtd7sYyAIDnp7s=;
        b=eRF+cqcD/74yq/aDqDIvUqdRTVzm78B7pff+7+c5K9eLTh6dyK87EZ6tCvTfdQQy8o
         9bbh+k7G13aYxs9W8o0U571aODJWXVgVdoL/v6NpFx1xyGRS9CneZukGFtv6r2/MFjmt
         LFvsqSClcYX44j3zmORqDzKwTfL5dpZGGbaZrjkvmaPPcKW7I0JE+nzJbVCFBVSqlNU3
         lwTDxY1OX8SZLq8QPDSWvFi6Ww+DsvBpsL5kuhlbsH6zYSJlwVVm+8hOIbaflx7TFnJw
         bo19XPEPQjivHEPbfvkMwiBjJaB4OGvC8q74xXWOxDn6Y7C+adM/dEReDWIz/eB/c8cs
         KWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714469229; x=1715074029;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HisHiVQGKfq5Qf2qSm14t1Am2lK9Nhtd7sYyAIDnp7s=;
        b=P92uwvToVqmkWUPhtCfE5dB4KkeA2P95+QdtnJU2lB1W8II7Lk/EElAE8GTIRP58zN
         3fjLqTEx4A3b5R/ZOxHdN7Gepzkydfn1D3nsY+dBCYpGqp8CgGpGU6q2/IRayTwoglDM
         EIz9FZoNgrst3vGEQ0rL3e94gLJmJ9aD4kMxO1BY0zgWKEqToNayqULXVkmqTgaFKQSY
         0z3+PiOxhAJJUudB+5JVPbAt2pz5y9G3pePcYvK+de4tgwlB3V7+fM1DBdE+xyL1ictW
         JzhX7+hdEXI18tSTP4SBE8Et+mxQC4Aa+9CmbcNIK1Oml34WpzTyLQEb76FFxLTDhVO5
         EyRA==
X-Forwarded-Encrypted: i=1; AJvYcCW0UIoOp5o0DnBHuMbclLMAws7yJb0eU3VMQ0XVj6W2DQwcCxLhrHm4NxbQ2w83iMNlN93GmIRNAbomhmnLPN4TcQa/ALY5vhH4IZxm
X-Gm-Message-State: AOJu0Yxo8ofbiGiQ6faHWbdesNdLB89Y8RQ+ngBo70ibwQViRVR+9X18
	EL8AOkJvKRWgvnYPAl4NOdQAlFaXwvt7S7iQg/qhwDY4oJj7wED5kfybFfKexPw=
X-Google-Smtp-Source: AGHT+IF4mXAeWBqtm2dKYVvycB6lOTk+pmfqmDMR+Chfi6wfJeprlJ9UpCscbn4gZdES6ULMXWrEBg==
X-Received: by 2002:ac2:58d8:0:b0:51d:1239:21e8 with SMTP id u24-20020ac258d8000000b0051d123921e8mr5818763lfo.37.1714469228919;
        Tue, 30 Apr 2024 02:27:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id y22-20020a0565123f1600b0051b64136e0esm2818510lfa.52.2024.04.30.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:27:08 -0700 (PDT)
Message-ID: <6f1ed4ca-617e-4618-a868-44de47aa3974@tuxon.dev>
Date: Tue, 30 Apr 2024 12:27:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Hien Huynh <hien.huynh.px@renesas.com>
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
 <h2fhduxr5bv3m7vkxl2ga6pqkkv5mlzpwgk2q6lfsnz3l63ckk@pyzj2vt4jkfw>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <h2fhduxr5bv3m7vkxl2ga6pqkkv5mlzpwgk2q6lfsnz3l63ckk@pyzj2vt4jkfw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 30.04.2024 12:10, Wolfram Sang wrote:
> Hi Claudiu,
> 
> On Wed, Apr 10, 2024 at 04:54:16PM +0300, Claudiu Beznea wrote:
>> For development purpose, renesas_sdhi_probe() could be called w/
>> dma_ops = NULL to force the usage of PIO mode. In this case the
>> renesas_sdhi_enable_dma() will not be called before transferring data.
>>
>> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
>> call from renesas_sdhi_probe() will configure SDBUF by calling the
>> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
>> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
>> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>>
>> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
>> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
>> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
> 
> So, I tried to find a place where we would need only one call to
> renesas_sdhi_sdbuf_width() but I also couldn't find a sweet spot. So,
> this approach seems also best to me.
> 
>> +
>> +			/*
>> +			 * In case the controller works in PIO mode the SDBUF
>> +			 * needs to be set as its reset value is zero.
>> +			 */
> 
> But I think we can shorten the above comment to something like:
> 
> 			/* Ensure default value for this driver */
>> +			renesas_sdhi_sdbuf_width(host, 16);
> 
> D'accord?

Ok! I'm going to prepare a new version to change the comment.

Thank you,
Claudiu Beznea

> 
> Happy hacking,
> 
>    Wolfram
> 

