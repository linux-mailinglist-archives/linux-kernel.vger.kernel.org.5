Return-Path: <linux-kernel+bounces-146236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82D8A6288
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B2B1C20AA4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A6364AB;
	Tue, 16 Apr 2024 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJjtLljZ"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90F79C4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242759; cv=none; b=nzpkH+34sMoMyIzlteJYlJAIcvMO1frgAbkXZm6h4gzjBLFEArZzsIsRXAkytI2sBUTuYJGzvGd82Gsl1S0CpGP2Ahd+aXjLnSh3qccbG4Ta9pNeaawqn113bKOr70vc9TkDgS2mTPlVVBb2g7NTgbNiVDvnLREZMAwUCOdYlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242759; c=relaxed/simple;
	bh=QKB+fts9+FSOSdB9lddQnPbhqERI/yOafNkOO10c0Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctZqVJOb7/2QkjG9CPQZC70RLfgiybKDAQsoKlnI5vWlO/a09CJY6uwKImGjGIytGHfK7XFm5IdP6UlqfURCxFlTZQlJp7TfvFyYHDKy+D++uJUG6FL+UWCo4B/5ukD0FIVRYYbKLxBMrIReDHDtvYwc9DZamOJwPwFVzENWtrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJjtLljZ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d094bc2244so45479191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713242755; x=1713847555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKB+fts9+FSOSdB9lddQnPbhqERI/yOafNkOO10c0Jc=;
        b=NJjtLljZjtOkR9lapv1wWTXavwLdNSLNO/o5BTNc7KJ9fD49JBXxNYfb84tGBDfCON
         r9JDlJTA1pMR6co1ed/6TjIx6vtpsQxumH1cNUe37X9HVljCzKL7u6xr1KCDxgn0rDre
         oDLrGFRKUA74QNt2HwGDcpUapIlcKVxKIpvTGTQTHKroid620rCuT9WL5aRDtfwSq3nv
         VNmOHhNgXlyjv2Uj4Ag+7f6fSM8VAzvIkmLEB1VIciXOk/HjOWYvzSHdlREw5aLxJRrW
         Idyf2+6Qncxxhg7sy/tBlgcAfn2YuVofgxBDpuKVhMq8WC+Zhl6TqH1Q9SRZOGOIwMIU
         fRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713242755; x=1713847555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKB+fts9+FSOSdB9lddQnPbhqERI/yOafNkOO10c0Jc=;
        b=ijOshNIWicVp2BqufpNCh70pcdVudlBwGJqXNoxoM/fNye5EVGD/wOfSROwk7IDvO0
         6s2dZ9Z3p8On8Ao4bHx5IVZavdDMDBJHAIIpSMecbk6CUDqKqF/ep9tb1akGJj+ME+Rt
         XCZUKohE2mlhPUWHZLj+she3Im5vQtw8lwB7ZOi+GyUFelIc6kvymGBETatSA1139asb
         hF2Nzvd0LVYfC/MFT6hEy9U1+TotWJoObcm3/QIrruJeHX8wMeLwhaB/M1ylp1VSizqq
         2JF+7Uwb3f/gg5zYd7sBpN2AblOsY2nkjCPHa+6f33PDnkcZ+HZVvkAGJr0a/q9AINh1
         X3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCW+9Y0rezw8e6E5zakX6Kh93qlpuB+PlzsnhFye/nLWef4Q5ilLnZeMjnxhFOiWh1syEz9DWzlpjV17zYyrbf7Mk9yQOPJMYRzkFWBZ
X-Gm-Message-State: AOJu0YwBo2s3wyWm2NQ5ztXR7HjbUWMJbrZk+Dhu7nqwQG1HweanJcTF
	H6/FTnsjRFsntBuE2WNLg6QejhgADqMdIwLlzp22C0xAoxzmjCpOP6mEaJ6rtM1D0SfvrZ7qmDa
	I
X-Google-Smtp-Source: AGHT+IGVCkk+bcdkhwjYIyaGOu3n5uDE8fKeovKRVpv0oYfV/HU33/rsUXCy5MMVPlmhCYZr+JWPPg==
X-Received: by 2002:a05:651c:546:b0:2d8:9537:6d37 with SMTP id q6-20020a05651c054600b002d895376d37mr9825139ljp.21.1713242755412;
        Mon, 15 Apr 2024 21:45:55 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.35])
        by smtp.gmail.com with ESMTPSA id he8-20020a05600c540800b00416a08788a5sm21697294wmb.27.2024.04.15.21.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 21:45:55 -0700 (PDT)
Message-ID: <e3c9352a-a770-4952-b15f-bd307aa284c5@linaro.org>
Date: Tue, 16 Apr 2024 05:45:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] mtd: spi-nor: Remove support for Xilinx S3AN
 flashes
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20240412134405.381832-1-mwalle@kernel.org>
 <20240412134405.381832-2-mwalle@kernel.org>
 <7b2fc5cb-d1ab-4e9d-b955-b88698322057@linaro.org>
 <D0I76PPKBWF9.X2XFZAO5OE7S@kernel.org> <mafs0a5lu8x5y.fsf@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <mafs0a5lu8x5y.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/24 16:26, Pratyush Yadav wrote:
> Also, I think we should let this patch cook in linux-next for some time
> before merging to give people a chance to complain if we break
> something. Since now there isn't much time left until the SPI NOR pull
> request goes out (around 2 weeks I reckon), it would probably make sense
> to merge it in the next cycle.

sounds good to me!

