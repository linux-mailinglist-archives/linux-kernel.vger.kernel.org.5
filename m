Return-Path: <linux-kernel+bounces-48873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D4B846294
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27B51C21BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFECE3D0A4;
	Thu,  1 Feb 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgzTVDGY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1583CF4E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822776; cv=none; b=Eu/xThoRfecmP+qS8Skkqr6aPCctEJwwR3h1HAZaMDBnsY2qQge+fe9YDXnNg1avJ/PQx65S6YR8O+nPPmoV9OlcsKNazyGxYHR+DmhjixBNYUoYWDrfmGOIz/oSyP2EfwTOa5b6l7gz+pvJpuZXcSmZy0Rf0450C80jSTjPTT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822776; c=relaxed/simple;
	bh=kyLxo6TGPZDJDcAI2B9MWkRbt2XMPH+DJdnd0HGE1MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlEAKH5++VjzKJMlkZyj/Ljp9Yb205RvEhRklArqpy4D/tF0yBbLAB1pUm24AXdr5vfoe7TpzbEjoD28ON+rbLspnBbeBOV7JD/9p+GKuEQXvxez9KCf9XObi3xRo2NOpN1/djUkYpDx3N1vqYA9RiZ4noUYY6qJtYw1emjz8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgzTVDGY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a27e7b70152so50377966b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706822772; x=1707427572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7f9qLraBLFZhOBsDxwtZQBfVd7xbQqebYyH4fsFrFIk=;
        b=fgzTVDGYEkM2BSlIob4VZW+O1ByDQTh7RarQSGtY/9bRYckSboxexYBEzrEkp91GNS
         lEAlx8wffgq0/aPXboQp+ixXiB6aHnV3wozyGvhoHqHPqd1//PLOXgaYlNjaaNIKp5H3
         8Q7PpeyZkHsK35jXnOOBegmMXwtG8I+iqpjWvVsUsD/Cwxt+sNDYMij682N8QnMYDdD1
         kfu8+gbzerqbwXGWkHtVyohSkcEDEVG5UGGI0kQ2FxTP7rtgXUJBlrldxtK2l+lEiQQ6
         Q3vGwtlmHf/cbf9Q+20DiLFYgTHbvEjk6LDTRDM6Hrq71L+M/EjTMmrmPMCjUICWFx9n
         Cx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706822772; x=1707427572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7f9qLraBLFZhOBsDxwtZQBfVd7xbQqebYyH4fsFrFIk=;
        b=lKrgvrLO0XBYJedvcWSiKzThdGoCrA8C27vn3HhrjFgAtW3zhrzxrKOMhtX1YRwvLu
         m70pIVRlFtk2f8YIXNV8d+alXGg5EbvfNTvzJfEsjsFGX5QDZLxgA2pILcvQYgdK1Uqy
         yiA/1HGB1WyWdUD3ovMr2Cljclf0z/vARGuoJtJZZDHyPHzX3bkwkxdF0UQTBzvQtw7k
         f1maEjihyVp/ogY6gw7cW7ZfwNKBXIVqbDQLEVZvslokILN1fmal+3s4RyajZuC3L2K1
         aJncnrARzIwyndQ0/kSyFkj/SgiCiBHIXqrhWRfk3LZY7b5enKP8CkCiC2r5ioC7Y2C2
         aBrg==
X-Gm-Message-State: AOJu0YxRhyPiyjS7x5xoAyR5sSA5QaWNMVD5ijSqIb7ByX9sLzi9lREQ
	WSUL7j5ouaktTnD7LwbKNqzoDO084QEem8i0EQ8prknSAloAwItiDmjzj4fx
X-Google-Smtp-Source: AGHT+IGtErNt1JMCYExZLK7GGdgcG2hTg5npEPEOsDXL+5cpaH/r6q/LlfrK2jRWtHOKJeHqRCJcUg==
X-Received: by 2002:a17:907:72c5:b0:a36:f2f1:c706 with SMTP id du5-20020a17090772c500b00a36f2f1c706mr531698ejc.3.1706822772225;
        Thu, 01 Feb 2024 13:26:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMPFkP/8uOJR+zA/8LqmCAwIuPdSimr/F4Juh9GHyC8cvedUUFxO+uK9YPDRY/UEnkjy9lguzijLu5gZTEO0ustz/SS1BxAbycbwOTOp1JkQREBm7BYbAVXhpZyH8nT6izmbXi3dfzoTb4ecYsKPTsotQriZRvw5jqDVCe+xaqkYqyz9iISaFyGVeNT0+hhOp3DEr2hTGCQn5WHUWz6PmDMMP8mVDqBU00L7921GY=
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id jy13-20020a170907762d00b00a2b1a20e662sm182218ejc.34.2024.02.01.13.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 13:26:11 -0800 (PST)
Message-ID: <ed534ce9-2102-415c-a5c4-e2d7d09b5e81@gmail.com>
Date: Thu, 1 Feb 2024 22:26:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Staging: rtl8723bs: checkpatch fixes for
 rtw_mlme.c
Content-Language: en-US
To: Meir Elisha <meir6264@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>, Ruan Jinjie <ruanjinjie@huawei.com>,
 Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240201140459.438479-1-meir6264@Gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240201140459.438479-1-meir6264@Gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 15:04, Meir Elisha wrote:
> Checkpatch fix series for rtw_mlme.c
> 
> ---
> Changes in v2:
>   - Remove dead code
>   - Fix comment in _rtw_join_timeout_handler()
> 
> Meir Elisha (4):
>    Staging: rtl8723bs: Remove unnecessary braces
>    Staging: rtl8723bs: Remove extra spaces
>    Staging: rtl8723bs: Fix block comments warning
>    Staging: rtl8723bs: fix else after break warning
> 
>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 227 ++++++++--------------
>   1 file changed, 81 insertions(+), 146 deletions(-)
> 

Hi Meir,

please keep the emailaddess send from and the Signed-off-by emailaddress 
exactly the same. The difference is the
"G" of gmail. One time it is upper case and one time lower case.

The changelog for the coverletter is good but the changelog for each 
patch is missing. There the "---" are missing with chagelog.

Please use more unique descriptions for your patches. "Remove extra 
spaces" can be an issue for hundred of times in a driver.
Look into accepted patches of the git for better examples.

I think the maintainer will not like your patch description. He will 
typically respond with:

- You did not specify a description of why the patch is needed, or
   possibly, any description at all, in the email body.  Please read the
   section entitled "The canonical patch format" in the kernel file,
   Documentation/process/submitting-patches.rst for what is needed in
   order to properly describe the change.

Very important here is the why and not to describe what you did.
Look into accepted patches of the git for better examples.

Thanks for your support.

Bye Philipp

