Return-Path: <linux-kernel+bounces-46502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D148440A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D196C28673C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03E7BB17;
	Wed, 31 Jan 2024 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ug81Kn3m"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD397BB10
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707976; cv=none; b=KkdEk3rwsZ3jISIJM+9a7vlekdWXBd56Zffq5nVjE7CQhp6eFY7ZmoYSMJhFjXBlxbpnNzLQC7xD7z6xxSHVSDy0+r2z7MFjQYJu5pIti2orflVwrEeYdRAMPiMstlXQwWE7kobN/K4loUjvYnVY6aE1SlblKYOnA5vqdSj8Uns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707976; c=relaxed/simple;
	bh=zAnNr9f6EmoAz49vJ3ph9RDjsla4lEvcoYoCJsE1DYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5VzRCHB5logXw5/p+/GbSqZKPEZv/X4//fLxK8KKBnlY7D9p5Tv9zF0F4VHuuVk2qqSpKS8PMrQFlm2457f/6UPl2xJqXqzsVCgkR3JrQwKsE2XbJL7+jmnIElCn8OTBXE5yoram3/tis+MAm/WMRwkbnIbc+ejaQcbbCye7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ug81Kn3m; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so62041041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706707972; x=1707312772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GD3HiXuK4cEfHe+tHuxBmXdCEARhIh+HrI+THCyTci0=;
        b=ug81Kn3mn5vyzBWmdUz+sW1/OoTzVxGU91rpwPeqU09lrBpVdBTAcnpKgE6Hb3R2Dv
         wz/mVu5Vhr7+fdCMwg/wknDSVNO4K+39yUFSWrSvAIvMJwWXln9IzOfyrj9dLianImxq
         UIAGHUuegojzPWfaX99aN816S00qsX3yspJDsr52x5w/ZM6YBv8XwDWOwMakBafkaPWc
         tOHVzProvPt4F2DiMLANov54UHaVLeXCT8jeWczh1TlFBy2dH0iSaE5qjXx9jxCBAM8+
         COGsFvv0+lrvnEllNzA82Co4lCaiHCOzE5dNLo0ZStGXfKWmSQhcmpdsptSvt0hGgjcV
         v35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707972; x=1707312772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GD3HiXuK4cEfHe+tHuxBmXdCEARhIh+HrI+THCyTci0=;
        b=UyLFPg8ZF0kZumX/ZeKZedxuTOFtcFOWkvGjQ/JR25RiD3zIaxkVAQyAyHxXX9fvcp
         hY1WYY1Zshi/YblUbh6G5/uBDa8cexQh1Qtvpys+KKnMbBsxuY63tS1h44ZIsjq8W1FU
         4HQ/nDqmaQwxLkcWRUsamExr4HC88Z/bUVBR9MA2UfKki9pdhvtrqQm/Iaq9qAM1jsHh
         /C6JsvssBN9NMYolJ5scSsOVPMEy4EMBj+yYorl2iz10i0act6390NpRMRceehMqiuo4
         tBvCvRp0lN37enH+iEhTM81mcH20QpugrPKsJHaUcoyq2+EKxHV79fYjcftb8KX8gA+f
         Sezg==
X-Gm-Message-State: AOJu0YyDkr33lMcmwXr/WaF5sJYXV85WTOYY3VNHRTFeoYkefkJ8DOGd
	BuvUkKUA4eV5TrEsLEUqRvydRLm+ZUOXR5sncDTrNTLodPTOVa5VRsMX4mMunXE=
X-Google-Smtp-Source: AGHT+IFmhOqioI3wPuT7TO2RF6Oxh7ss/KR6H6iYPPSMUnS2VHvo7AsuwON5XCyKJ+wdWEQzJE2hgg==
X-Received: by 2002:a2e:9b59:0:b0:2cd:fafe:1893 with SMTP id o25-20020a2e9b59000000b002cdfafe1893mr1258216ljj.4.1706707972336;
        Wed, 31 Jan 2024 05:32:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMBMaxzlMYTfU+rYu2ywEhR12S2ex+VYQfqAsZx/u5qtl1rd79sTPX3HitBlBpFIUxg1aGnE63ZCyUKnaO/AkqH+Jen7+vGvuBsUA2/WXYOrh/xrcqp+QTZiJmWHow7x+9pIFvWHaCI5xYQp56yZgxzPdiONcUUGQGfDTULM+Z1OHa45t/vvZ+L6IypqO7yJ7756A2BeBZpP+AjwnhrXC0fM2qC/Z6uvDkCBjnTIovprDKvOK4EOJLhuetZskrnLU/t7eUpVGo+9LgWAkNZ3mpMYHt6XemDZ3js+sXs4QvPijANh/gSBj1T4ngH0CvCOhlwVeyGB7li0AnZuzMpiGLF0LfvtQ5sE5x3Lr5NSDHKBHivGfx84nd9z+Iczs8haMehu4B+L1dIS3bZccS/S+gE7i3xnc2iIsQxpjrL4kxc6jU3LogeUCCqQVOBDF/DNvjk8IBdw4PP/msx7p0vun9b5YeYpv+KYV0vSYmmhO4GZmOn9LCNbmpMfhofa/spRQvA7+M4FQhI543MxVcnE+YtWbAit2v2DMX51xPBn+EyZrF1x9b6e8sCQD2bcSBA16lLmR02MsjSWnMRuM6CkoKGQZWIeU/5OIF6lp+ioQzsis1q+nJInLv5P8VHTiVC5Y5sRzOjjKxwRMsl9bshOfQP0KYL3txePXoCkUboPhmDwIL7iLMDTr+kapCV2+vK03ub7rKeqU7tWSpQh7hnr6gqAXIfeyat4Qe3EZI1eGBZTkQ2oI9VskSS9OeGG86G/sbpt/zhjuRfKWGw5rnlR8GbkJDbOCJpP1JLJrI8ScKBibFfSrKLzWLcN1WzB47F1EMWA5pGxA5VcRM1Zs=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id q7-20020a056402248700b0055c83efc9b5sm5825225eda.62.2024.01.31.05.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 05:32:51 -0800 (PST)
Message-ID: <5ef64082-0b44-4bb2-bd4c-654c96f4a9bb@linaro.org>
Date: Wed, 31 Jan 2024 14:32:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Sean Anderson <sean.anderson@seco.com>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
 <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
 <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/01/2024 14:17, Linus Walleij wrote:
> On Wed, Jan 31, 2024 at 10:37 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> [Me]
>>> reset -> virtual "gpio" -> many physical gpios[0..n]
>>
>> This is a different problem: it supports many users enabling the same
>> GPIO (in Krzysztof's patch it's one but could be more if needed) but -
>> unlike the broken NONEXCLUSIVE GPIOs in GPIOLIB - it counts the number
>> of users and doesn't disable the GPIO for as long as there's at least
>> one.
> 
> I don't know if the NONEXCLUSIVE stuff is broken, if you mean reference
> counting isn't working on them, then that is by design because they were
> invented for regulators and such use cases that do their own reference
> counting. It's also used for hacks where people need to look up a desc in
> a second spot, (perhaps we can fix those better).
> 
> As I say in commit b0ce7b29bfcd090ddba476f45a75ec0a797b048a
> "This solution with a special flag is not entirely elegant and should ideally
> be replaced by something more careful as this makes it possible for
> several consumers to enable/disable the same GPIO line to the left
> and right without any consistency."
> 
> I think for regulators (which is the vast majority using it) it isn't broken
> because the regulator reference counting is working.
> 
> So if we solve that problem for reset, we probably should put it in
> drivers/gpio/* somewhere so we can reuse the same solution for
> regulators and get rid of NONEXCLUSIVE altogether I think?
> 
> The NONEXCLUSIVE stuff was prompted by converting regulators to
> gpio descriptors, so it was for the greater good one can say. Or the
> lesser evil :( my judgement can be questioned here.

I discussed the non-exclusive GPIOs with Bartosz quite a lot, who was
Cced since beginning of this patchset, because that was my first
approach, which was rejected:

https://lore.kernel.org/all/b7aeda24-d638-45b7-8e30-80d287f498f8@sirena.org.uk/

The non-exclusive GPIO was made explicitly for regulators, so it is
working fine there, but it is broken everywhere else, where the drivers
do not handle it in sane way as regulator core does.

To make it working, either GPIO should be enable-count-aware, to which
Bartosz was opposing with talks with me, or the subsystem should mimic
regulators approach. In some way, my patchset is the second way here -
reset framework subsystem being aware of shared GPIO and handles the
enable-count, even though it is not using non-exclusive flag.

Best regards,
Krzysztof


