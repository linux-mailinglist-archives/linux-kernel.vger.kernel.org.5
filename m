Return-Path: <linux-kernel+bounces-98595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC4877C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED94F2822AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA1B29CFD;
	Mon, 11 Mar 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Y0QbU0"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C517578;
	Mon, 11 Mar 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148515; cv=none; b=Da5nInxzfpBrRh/8Hvnje1hycxCCrjZRn3i3EfthvbttTw5RvN33UdxFeH3gVDIqHlYJcC+Wu8uPETHkjjEeAp2FXAw8YXlLT9NdLfBqcARYqPhMjnozITKaTNB6JtEmGW24chsXWj7o0x6BYUsYkJKbzHQt2675a8a83qJYlJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148515; c=relaxed/simple;
	bh=rguz1TbWj7waSq9k6cTHsDuJxtVExG1UCcqMJ6lcxCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxtrD+I5W1RjPzjLCXUUsOZ9ZwkdLc4SaJg6wwy4F0eGchDhRh+a9+GQL4gX/CyERPgDpFFBVhpDqvI1aVNqH4y3ab0jy5Vs3+OUBO+/gPowKg/hePfWnZiHZCtGi7SSrgnzLcVCCbiMrAQFJwgY0jgXgAdgUMCW9LdAwv53UIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6Y0QbU0; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512e39226efso3957574e87.0;
        Mon, 11 Mar 2024 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148511; x=1710753311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVfC7dWRDVEdwYmburdeFeTuR7MqSLqjlM27oJ2hlUQ=;
        b=D6Y0QbU07E7yCmqG/5e4yuhGGdCeIhaqry0dpFsxkGlVbRiaZegx21awdUYiFSU9Xd
         gB/+GGERM0h8h5E86l1A22QhnKGfuBzaD1LTiAZshZXzqrQ8VAyz7oP2FH//4MiESRPj
         jlernuh/bdNR8yCx+wpeE9QUuLdr650gN7PtuzfTM2E4HmPe8mGHFi8TD8tsk28ZwCQj
         23nqMjzwzxq73nsqWNIC2s2POdtM41/ZqItIBs/HyFTs04d0Cpn3t8ykUaRnyMBitNeJ
         4fSjEgXPvKTzxey8UrqoAnxspwgzRDi+9B9h2tRNSaSGcGJ5hde4gceY7LHXz68zMM2N
         RGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148511; x=1710753311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVfC7dWRDVEdwYmburdeFeTuR7MqSLqjlM27oJ2hlUQ=;
        b=R0VGTKolPZkvUCD0m534ugPE+cOotARblIWqPkBZLng7QHG/8Fp4024rATvoo3Eqsb
         ZNKS9QDsvUrV4yODgkKXlVcp2qA69fmKSPxnZk9EHfBjw6/qtiW1OA2KEjHceivKKnBf
         JwtEyHbIcFuTF9tKr4ZW4V71qnar8aUxevCBgMB3iJfJCkk3ovAvu3l4cmML9q+42EZJ
         Npjm3FTiBOdj3HbPk8UFjC5u09qGhT8EIL17pEMdfA5lNNPuPpjfpg71nNYIDfmYWJdx
         O7DpR23mdF5k4HnUVxIYFMlzcn5cz0FdhW6a/VQPU8d+i3ZKKGHjqeG5ldSxhTYTu4wN
         UwCg==
X-Forwarded-Encrypted: i=1; AJvYcCWRj0fzJZ+/bDqaUneWKatjeSMpHPunxY4lvll+lUGYqxgKBShs8qtOzSChEFeYOfY/RmvbAMbOSRwTjNJrkQBM3lrraOfNOt7HgX4xzpq9ttHOsvezZjUgHw8yEMirD1hVfMsLT1Kq8j65Gab+p9B1CvyPlRejUhKcqPnmVVxYnUc7jw==
X-Gm-Message-State: AOJu0YzG/4Lqzo+k8E9XUSebth62ox+jOYhEfYtidPkXUKPKmI0K0mpH
	MX30hiQbI/nZttGNfeT42ZwUD3NKyWw48aMv9mXcP7z6SjQG8Lji
X-Google-Smtp-Source: AGHT+IF9BcQoQLLpHtF0e37ZBQTx1DJ5KD7KbcJ7irjGDUuJqjlydGfnwUtZ+Q152Mw6uXTpfNY+2w==
X-Received: by 2002:ac2:484a:0:b0:513:3741:7357 with SMTP id 10-20020ac2484a000000b0051337417357mr3957581lfy.56.1710148511259;
        Mon, 11 Mar 2024 02:15:11 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b005139c3c584bsm951164lfs.241.2024.03.11.02.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 02:15:11 -0700 (PDT)
Message-ID: <02e2210d-9164-431e-8fe2-226cb1aa2d48@gmail.com>
Date: Mon, 11 Mar 2024 11:15:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] Support ROHM BU27034 ALS sensor
Content-Language: en-US, en-GB
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 linux-iio@vger.kernel.org, Shreeya Patel <shreeya.patel@collabora.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Paul Gazzillo <paul@pgazz.com>, Rob Herring <robh+dt@kernel.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1680263956.git.mazziesaccount@gmail.com>
 <ff8d6d14-6b48-4347-8525-e05eeb9721ff@gmail.com>
 <20240309175056.3862630f@jic23-huawei>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240309175056.3862630f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 19:50, Jonathan Cameron wrote:
> On Mon, 4 Mar 2024 14:38:38 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

>> I just found out that the BU27034 sensor which was developed when I
>> wrote this driver had some "manufacturing issues"... The full model
>> number was BU27034NUC. The has been cancelled, and, as far as I know, no
>> significant number of those were manufactured.
> 
> ouch. We all have some cancelled products in our history!
> When that happens I usually go eat cake and moan at anyone standing
> near by.

I like that approach :) Luckily, this was just a sensor. It was much 
more painful back in the Nokia when some of the BTS variants were 
cancelled. It flushed 'man years' of work instead of 'man months' :)

> At least this seems like there will be some direct use of
> the work done (sometimes you just have to list the things learnt along
> the way).

Yes! It wasn't all wasted effort!

>> One thing that has _not_ changed though is the part-id :rolleyes:
> 
> *sigh* Not even a version number?

No.

> Even unreleased / prototype parts should have
> different IDs if anything in the interface changed.

..tell me about it... Well, I tried to send feedback - but I am not 
convinced this is not happening again. I think I could fill a book with 
feedback which has had not been listened in the past - but who knows, 
occasionally feedback also works. So, we can keep trying. :)

>> My preferred approach would be to convert the in-tree bu27034 driver to
>> support this new variant. I think it makes sense because:
>> - (I expect) the amount of code to review will be much smaller this way
>>     than it would be if current driver was completely removed, and new one
>>     submitted.
>> - This change will not break existing users as there should not be such
>>     (judging the statement that the original BU27034NUC was cancelled
>>     before it was sold "en masse").
>>
>> It sure is possible to drop the existing driver and submit a new one
>> too, but I think it will be quite a bit more work with no strong benefits.
> 
> Agreed, modify the existing driver. Just needs a clear statement in
> patch descriptions that the original part is not expected to be in the wild.

ack.

>> I expect the rest of the information to be shared to me during the next
>> couple of days, and I hope I can start testing the driver immediately
>> when I get the HW.
>>
>> My question is, do you prefer the changes to be sent as one "support
>> BU27034ANUC patch, of would you rather see changes splitted to pieces
>> like: "adapt lux calculation to support BU27034ANUC", "remove obsolete
>> DATA2 channel", "remove unsupported gains"...? Furthermore, the DT
>> compatible was just rohm,bu27034 and did not include the ending "nuc".
> 
> Separate patches preferred for each feature / type of change. Mostly
> they'll hopefully be trivial to review.

I've drafted most of the changes and it seems they are more or less 
trivial. I've not yet received the hardware so the changes are 100% 
untested though.

>> Should that compatible be removed and a new one with "anuc"-suffix be
>> added to denote the new sensor?
> 
> Yes. The binding patch in particular will need a really clear statement
> that we believe there are none in products in the wild.

ack.

>> I am truly sorry for all the unnecessary reviewing and maintenance work
>> you guys did. I can assure you I didn't go through it for fun either -
>> even if the coding was fun :) I guess even the "upstream early" process
>> has it's weaknesses...
> 
> True enough. It's always 'interesting' to not know if / when a product
> you've upstreamed code for will launch.

Indeed. Almost as interesting as having patches for a new product in 
your "to be sent" - folder for 3 years waiting for the product to launch 
to get permission to send the patches... Don't we all love maintaining 
off-tree patches when we have that creeping feeling the patches will 
never be allowed to be sent...? Asking for a friend :rolleyes:

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


