Return-Path: <linux-kernel+bounces-11574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60081E85E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49301F229BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA24F5E3;
	Tue, 26 Dec 2023 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yLETI7l4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AE4F5FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so1201139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 08:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703608078; x=1704212878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xOMGLbsQ9RzM9b4GH1sZi3XCxnyOtKMyWm93wPrQ9NQ=;
        b=yLETI7l4PsCDRf5Kn58dk884r6RxFXdB6JdQwSDmbPwtHCnPXR6qtJHbJlz05xStRT
         /1aU/boBhS0nS1Oc1ZCkVH60u2Yxr4WK5b74wQChUeBbC9rxXIUaHRsOamnDFnbP0PVZ
         I1SxokhleyqbeyKyrXcLfV1cEOToa+uT3eKMYGnKFTaW4Lg7GQin9ZJQYxhpyBldnL+I
         uPUyK4jfNTy8ypegxFkDXDe9vWiWcs2YfgJvIrPYg+Vl/XH4FfSG2r0KJtc4oQutk39k
         0mHK6XfHTfkcItmD/ei9SbXtvCEutER63O4etdtDociYvbeyfxeMaXx6Si86uDhHpXPb
         BjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703608078; x=1704212878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOMGLbsQ9RzM9b4GH1sZi3XCxnyOtKMyWm93wPrQ9NQ=;
        b=eBmawjpa+rv0vMBli7U4tE/Bj7u4tplszkEU9c5yfygOkGDXAqoCW7QWHDtdirwA55
         VxSqgMBeJpcIflteuHBXIDTEwIJV4VJZ9iV45K01ctGT8aL3IT+r+CoFrV8EQB6vK9YO
         Cppd80OSfEdrMIzUzuDfkiJZf3U2U1QYs2t6HpC5cEji8fulJw4j0PNkl2LYIpwOz14K
         rCG6lkpO9eiYysbkzlQvVNw/iH+aIQfYDWN/K0Fep72ywWiduRA2PL5Iiwl4Vrdum9SP
         FrqflS6R5j6JWWqnL7wL00MLgrB1QVTZ/USdNFXNp6/sbWlJr0JT5gZYrKG1levDABli
         Qx8w==
X-Gm-Message-State: AOJu0YwzOIYru/934cIFhL5jdCF6ZqH6PaObDvawx8ipQhjCbsxfDbHZ
	MTGMX6ozYrwy602D29U59YRZ5831j6CGyA==
X-Google-Smtp-Source: AGHT+IEgyg08vkH3r2LNXz77+SvWCKLe1kl8w+wmTxYI0Q2Y3xIjVmbHXTPWx58lZLUgNU4waXN8yQ==
X-Received: by 2002:a6b:6a04:0:b0:7ba:ccbb:7515 with SMTP id x4-20020a6b6a04000000b007baccbb7515mr4749377iog.2.1703608078311;
        Tue, 26 Dec 2023 08:27:58 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x6-20020a056638034600b0046b6f096e3bsm3092448jap.134.2023.12.26.08.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 08:27:57 -0800 (PST)
Message-ID: <4a9913bb-41b0-43c2-b7b7-22472e954a12@kernel.dk>
Date: Tue, 26 Dec 2023 09:27:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix a memory leak in bdev_open_by_dev()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org
References: <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8eaec334781e695810aaa383b55de00ca4ab1352.1703439383.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/23 10:36 AM, Christophe JAILLET wrote:
> If we early exit here, 'handle' needs to be freed, or some memory leaks.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



