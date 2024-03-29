Return-Path: <linux-kernel+bounces-125343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6E389245C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D10284F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B7613956C;
	Fri, 29 Mar 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuzZrdPn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447171E893;
	Fri, 29 Mar 2024 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741143; cv=none; b=N+twxni0JW1S2WONBV7uxhpK2U67Ka2CpCIi6KztVTZ6zLPsAnMK4CXo6aHIMInT9bGoYxIz0DiFzpvgw2O0Xlm3nszWM3At5iY7hOlC/nOU4lk2N1p0BHUK1JGbhmMpFb2C2uidVOfb0A3MOgD79/Y0S7DSXcXXpb4ShYpg0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741143; c=relaxed/simple;
	bh=wSB7X6CdTUWKKiKpXypnRNMqXkfS9aaSpZFlc2ToL18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bvu+u1Ih9p2z2d9nAC+5qqRBEtOETCt2vVJTdfFTp4rM49Vq2fUFZg7hjiqWtVGQguBO/czbCv5vgepcOKNsO4g6lgmzqzqSl2uCTgLi3pWYHbGHEu43D2MRuZ6xca/TqWz/wxHtzDEoZEWddAExCO5o/jUmVC6J+6D8h+hKxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuzZrdPn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4154464f150so11362035e9.0;
        Fri, 29 Mar 2024 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711741141; x=1712345941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gyvJa28tEZj4J+N9+Nm6NWKKDqYmD65rg3x6weXC2w=;
        b=IuzZrdPnbVjYrRmHc91+wOmkJBr0rPJPf8ZOEAOzdnRMemAuuGUeo8VYihA0COv6Cq
         44bwJhideegf8CpXyIOOkGqu9HhlaibZNv/wHJ46vUZIZQQTY65838FkQ41apXuEbTCe
         JqekXxILK08CKgmUealN+kTZ87vhNqCLXyJgYWQNLmWm9xoQ8Kq0eszAK9Q/C4+2UnSQ
         Y673x3i2LN/eEfVROfWeUHbRR3yLyAZxyqTfMLorjgRJVhaZ6AMWCjerC7eD9MXOFeRN
         EmbUK7XSJE4u+WQe5DgF4hJPq+t4zyQfYDKQKsuVgUHNsENa610zUdIKV3raG4+aeLJm
         rWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711741141; x=1712345941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gyvJa28tEZj4J+N9+Nm6NWKKDqYmD65rg3x6weXC2w=;
        b=tKtMwUPLA1hdKjyqZA30EKfGotSCtVTNUJiWqtADgePdTwEO0vfGLMJopvGCxCNkHB
         Z0S+V/7jAMKd2CvME/EVEHOpzVzzrknp7GiebUqOna7i5KQTM1gsfg7iGZoU74udY6Q6
         2w8fs44p4L4jN5lIQLzcxeo4b3gsn0GuHNT9yrUv0VxkdP8LG+PSv4LGitD0bQB75WKq
         pCOtL8UR9k7vj3l1AZx5SC8u1+OEcZY9KZi1N2cRDTZbstLP7sluTsjL2gt5DHPaYKZp
         9p5IRPi6Lyz9WngPDboG04GHT3dx1tZnu7+18iJYt+YUJ7os69EyJTr/oYBV99GHfx5U
         mamA==
X-Forwarded-Encrypted: i=1; AJvYcCURW7cWs554D0MLPch3EtIczyZC2xOGKZppAsAmtH+EifTwl7omfAqGjAfYZ17WiLPiXm7p+YSxSojJpPJc259UlWvkP4rOJE/Nct/jNVz735cZa5xtmAzMmuXfERWY4EfHEfngohgJxb4wPw==
X-Gm-Message-State: AOJu0Yw3tmhYpeqKbSBDfM2AYWZKz0uil+eNkNtwSClKLGHtbnOBaS1L
	Wxg09GaN/qTW1gRR3KVMBbzgp/hpKi00be2j8T4XcMPP2elzWo99
X-Google-Smtp-Source: AGHT+IG10lQFIOImBLBD41zMRXhhu9cohhiJEff+GDmy229Zo6LdaVmWzU2lUFMswpnlw9rsedNXiw==
X-Received: by 2002:a05:600c:3ca1:b0:414:96d8:bc48 with SMTP id bg33-20020a05600c3ca100b0041496d8bc48mr2491616wmb.20.1711741140441;
        Fri, 29 Mar 2024 12:39:00 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b004154853f778sm5152221wmo.48.2024.03.29.12.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:38:59 -0700 (PDT)
Message-ID: <9b1e5ea0-bb32-4c42-b2e9-204bde31b905@gmail.com>
Date: Fri, 29 Mar 2024 20:38:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325100359.17001-1-brgl@bgdev.pl>
 <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
 <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
 <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
 <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=MdoSPuedbGhy4toDEkw0vSzESDz2bXGpyt_=R4hqXW+Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/29/24 8:26 PM, Bartosz Golaszewski wrote:
> On Fri, 29 Mar 2024 at 20:22, Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
>>>
>>> Both with and without SHM bridge?
>>
>> With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
>> works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
>> still get stuck at boot (regardless of the fix). I think that's
>> happening even before anything efivar related should come up.
>>
> 
> This is on X13s? I will get one in 3 weeks. Can you get the bootlog
> somehow? Does the laptop have any serial console?

Surface Pro X (sc8180x), but it should be similar enough to the X13s in
that regard. At least from what people with access to the X13s told me,
the qseecom stuff seems to behave the same.

Unfortunately I don't have a direct serial console. Best I have is
USB-serial, but it's not even getting there. I'll have to try and see if
I can get some more info on the screen.

Best regards,
Max

