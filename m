Return-Path: <linux-kernel+bounces-80959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A2866E65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4233286BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDA5F57A;
	Mon, 26 Feb 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAZ3BPD5"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADF5F552;
	Mon, 26 Feb 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937290; cv=none; b=RKXqQPcyNztOqP7XzeJmwd5jBkM1oa4eTf/wcF44mHj/kPB3quwyRWJx39E7J3HFQiYQz08JlA39I8WkDDn0A4NIgsoNFXWyuyUlweU1f2IZ7Ih1/oPDZaB+X05UlodFBeBscP7OKG4fnByRUbhaNlUzw+KfS4ivc2sQxuGHWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937290; c=relaxed/simple;
	bh=b+AFtU65+Jqde/aSOUkjfFwLLT8TYBdxvpCg0K8KsRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxXLdCEDgO/H+1a9LJN+BsERnPdN+xOE09QAyZUEXthlgyz2EuXe1q+xFjR61g4vG3WVqfAQNfkBAUX5JOxeOOrlK8TdtJMBSwAJJrpW1dEf6+TfSqehq/d9xdc2Rrwp5KsQhI4P8/b3vKkfNzrs4KJIYZ71c+8VxtJGh3N029s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAZ3BPD5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so481660266b.0;
        Mon, 26 Feb 2024 00:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708937287; x=1709542087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+AFtU65+Jqde/aSOUkjfFwLLT8TYBdxvpCg0K8KsRk=;
        b=AAZ3BPD55azu4UM5HhG+ByQs37NnvvKAOllVaJAG89sJP0hVaf/S1Db+eJ2Vo6x01K
         d6WGaXjWdkEJcYXDlTCZ+NSK+p2ImTzqqu1YGr+KRTM5FdiGxu11RfPDZHTkQr2HfRNp
         wNU5PcrQJG9X4XmtWUs4pv6i8wk3+/96LDQKuuKAbelk5gB966ezADVmIV18Jsp/oDZ1
         xJFkAJYLmpCHsGt9EAnFf0bDCbzPOGNL1ns7oyl+RVdABxCLSiw1uz/GcvnlxnvkKDcF
         lpbnklYrH3OGqGJK+jUioKWofqaKascIfb8rKlBWSdJv6d/t1tytgYwh0UtEajbPp1tk
         jiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937287; x=1709542087;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+AFtU65+Jqde/aSOUkjfFwLLT8TYBdxvpCg0K8KsRk=;
        b=vLLJXlR9yMBU5xOuWy8IgXvq6O3Z4cF7ZZ9dfWwyPi8AfMRXy9hxaI06EYdAb7mvHt
         JKBYaq5bRF+PhbjtHo4hGJ/raf9He0Uf/Mb6iPTcKq1Qnuby8RhNVNqmiGv3Yo3gS6qu
         nOYuj3EfoKTmzGovTom6iUwciY6GqgaiICI8v7Xuq3PzkHrdS8ch+Tjizn5ANKln77fc
         UyhgcLgfJu6HyDyfJEsaYXdMHdGYIixsQXkiAqPnb4d4sU3BC0WxXkniuRClxgEsSjEf
         DF+2FNEDpLyRhzD1hL9R1J73oxvbKa9/qDZrfbzMd6cwTzsSNw7KooFm5DiovQMRPGQi
         P5Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXT1x8e6NwVCJ0dWBjeBwdJWBD3pcWvftxAfq3Gtpr9OzfOYWbDizPAakX8dp9B1kwlzUMQ8d6AgMoNV+EqeBlcD+CweIJ9T12uqzSXi2Q6yjX/7ezxuxLktu6jOq3SA/m6u93iCTtgkg==
X-Gm-Message-State: AOJu0Yxw9ymc1/FyOBR7gUnYGFha3hLSP46uJ05OsOTqKO57dmEoVUeK
	kHYDxJ/KGSLmIo9bCXAhucncFH908gg86AaBwl6863rNkBaXZgPe
X-Google-Smtp-Source: AGHT+IGcDEV/RkM4wbXJ8uHIz3UxH0XnxntHvFl6I6peJPGrYRSEItcnUliN5ydfKQ+ymSV77vGd7g==
X-Received: by 2002:a17:907:9950:b0:a3e:bd4e:c87e with SMTP id kl16-20020a170907995000b00a3ebd4ec87emr4135330ejc.36.1708937287216;
        Mon, 26 Feb 2024 00:48:07 -0800 (PST)
Received: from [147.251.42.107] (laomedon.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id ov5-20020a170906fc0500b00a3ee5c19ee5sm2199408ejb.109.2024.02.26.00.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 00:48:06 -0800 (PST)
Message-ID: <48f94af1-3969-4021-84f7-5822bd92b38e@gmail.com>
Date: Mon, 26 Feb 2024 09:48:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFQ] dm-integrity: Add a lazy commit mode for journal
To: =?UTF-8?Q?Wei=C3=9F=2C_Simone?= <Simone.Weiss@elektrobit.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>
Cc: "song@kernel.org" <song@kernel.org>,
 "Tomerius, Kai" <Kai.Tomerius@elektrobit.com>,
 "simone.p.weiss@posteo.net" <simone.p.weiss@posteo.net>,
 "agk@redhat.com" <agk@redhat.com>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yukuai3@huawei.com" <yukuai3@huawei.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "snitzer@kernel.org" <snitzer@kernel.org>
References: <20240209192542.449367-1-simone.weiss@elektrobit.com>
 <8a485b9-6dbb-78c-9a84-ed3ba65d9cb3@redhat.com>
 <3e5a2087667333bb88135a6b6f9620201989605f.camel@elektrobit.com>
 <9788e2a-8a61-3c76-e11e-a3f23b4d90c8@redhat.com>
 <a0ff2007f08b7a55e3aa58f1cac2b9314559f598.camel@elektrobit.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <a0ff2007f08b7a55e3aa58f1cac2b9314559f598.camel@elektrobit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 7:47 AM, Weiß, Simone wrote:
..
> I can do it this way for sure as well. Another point still in my mind is the
> superblock: I would like to get rid of the build time switch and carry
> information about lazy commits enabled in the superblock. As there is J, B, D
> and R as mode already, a new mode L or such could be added. I will work on this
> and also take a look at stuff like dmsetup to check if something would be needed
> there. If there are further points for now on anyone's mind, please tell.

Just FYI: I do not think you need to add anything to dmsetup, but integritysetup
(part of the cryptsetup project) needs to understand new metadata and dm-integrity
table options.

And I guess it needs to add a new option to use the new mode.

Perhaps it is best to create an issue for cryptsetup to discuss it, but it will not
be merged until the kernel code is on the way to mainline.

Milan


