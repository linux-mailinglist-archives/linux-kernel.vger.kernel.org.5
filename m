Return-Path: <linux-kernel+bounces-5798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4478F818F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13D51F21C28
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898DB38FB3;
	Tue, 19 Dec 2023 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEH9GO5a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951A38DEB;
	Tue, 19 Dec 2023 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2345aaeb05so369040666b.0;
        Tue, 19 Dec 2023 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009799; x=1703614599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPjNNGRVl834dbVMwON3kgyUWofS8voa+GRP3e8W41E=;
        b=IEH9GO5aL7DPJsrs2OsQJaghz8X5mncDVchLdX1/jCcyf5GTQ8AnLNZAgn+BwaKXpi
         bMEwQWDU1Idms+GBuMcvWNLVDAso48J3/QLQ/N5sSbwKDZTh/knjcSjvIJgosgzTvK5g
         ArEhN0WOPrbhfGmOm9YzT3kA0zGQlzco3Nb01jtu1UFOWTGMFnzfzq/xWoD1Snk1GWyt
         uJBRtYmLJyCNx72dm7/LeY17qLaq3rLTJJRuy0XPY2MfMWrzuxS5wbQq8E1XARdpLZKO
         RG5yVXhw/7EPc6EWqLO8xHrvwJ9UIJ2HngGetHI6HHY2v238pP8lLUIY7VYCRTwC9DvV
         VWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009799; x=1703614599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPjNNGRVl834dbVMwON3kgyUWofS8voa+GRP3e8W41E=;
        b=RGnBJ08f0PNKzmJT88q2PsnT5gDb0gta6E/HQpyfszmJoRvA6eM4KkSYeY9EevPq5Q
         J6dgiRasc2s/lbYumHu/kt3wRAUA0hu7Oc4E3kPouv9zc8yQMaWMlIHxMwWu+TX2LduM
         q2JiqQWEJSusz9hQF17lIzSZ3RJECLGgj0O7Q5cWGOwB9LJ2gq2Vq4NrNxTkDTQfEm/J
         13dqhezXhDi1IdzBhnWVAotdUeXjYIlY6aksMGXBgty5faP6+dekGtZ6DzxFbNLTwbh5
         s8U6sja7+4CkIorav0ewBMmbQZeNg2e9VJYwQ0oQlghei+8qhBDrsTAyQZQSTAe6N4o+
         e1kg==
X-Gm-Message-State: AOJu0Yw8z0doUELDnbatR46qKldwk1nrN7ommLH+5aO9Q14mVytSBvPC
	/TRvrNgSJo+ljl6LXhetWeU=
X-Google-Smtp-Source: AGHT+IEV+DYh2x5q129WtIIGrMyHM5JcnCzXLNDYXZfxxn9D5eLuxUTi3tapArS0fRpHMnXkfNXkDA==
X-Received: by 2002:a17:906:7481:b0:a23:1c51:40a6 with SMTP id e1-20020a170906748100b00a231c5140a6mr3630903ejl.104.1703009799151;
        Tue, 19 Dec 2023 10:16:39 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id vv8-20020a170907a68800b00a1d2b0d4500sm15648822ejc.168.2023.12.19.10.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 10:16:38 -0800 (PST)
Message-ID: <1b5d4c36-9963-476c-8edf-e807beceda80@gmail.com>
Date: Tue, 19 Dec 2023 19:16:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] nvmem: u-boot-env: use more nvmem subsystem
 helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231219174025.15228-1-zajec5@gmail.com>
 <20231219174025.15228-3-zajec5@gmail.com>
 <2023121929-salami-pessimist-c943@gregkh>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <2023121929-salami-pessimist-c943@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.12.2023 19:13, Greg Kroah-Hartman wrote:
> On Tue, Dec 19, 2023 at 06:40:23PM +0100, Rafał Miłecki wrote:
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> 1. Use nvmem_dev_size() and nvmem_device_read() to make this driver less
>>     mtd dependent
>> 2. Use nvmem_add_one_cell() to simplify adding NVMEM cells
> 
> Shouldn't this be 2 different patches?

I used to maintainers complaining my patches are too small and not the
other way ;) I think it happened two or three times with mtd subsys.

Sure, I can split it.

