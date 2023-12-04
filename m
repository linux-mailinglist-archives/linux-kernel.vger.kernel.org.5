Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3C7802BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjLDGiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 01:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 01:38:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CEAC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 22:38:16 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a18f732dc83so693775766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 22:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701671895; x=1702276695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYkuRI2m7gXvcv1On4oJWW4OK0PwVwiAqFsMBy1aG3o=;
        b=h6a8PXszrmg3L4ElqLwAoznyyl5RPzAE7wih55eePsRW6kosdZkO3+lU6VoDcVRTeY
         UGHNF7eH8HU77UZRWy+SiBOs6eeydc7e34RAjus/evP6jH8QM8Kgh5chvJyUoBtIt1pS
         qBzL/aloQaa0yt5NdFf2aSc0xCYUC762mG1tkCCplIrlaexd7xynhboq60aLxGXCgv5V
         z0n3gGQbwY5xbxl9fb1tAT0Fbu8LsVwibMBKg2pVbeLMMT9+KuMoLHzGENK2CcN4Oy1T
         xNc+u6uHWy2NBAIfa7bhsP+5MuNWFK3FeIVLWiDAY2sFnfGfMfMXcYbES/1sp7ZowOWK
         QY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701671895; x=1702276695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYkuRI2m7gXvcv1On4oJWW4OK0PwVwiAqFsMBy1aG3o=;
        b=crZkVfAZYj9P++KScYF70Mxqfjcze3A2cr0th2YXo8b+mB2fAGjiuTeQrcs4tTeB9H
         vYndG8R+wpCBjECtMVO29H7qvNFW/N/n8AsUJ1yluuY2jRH9JVm1WvM/dul3M8lMpv7R
         PJjFnXBk4r5Zip6TE1Ex6dZDzyUGIzgS1t1T2UTT6Nk3vHvXf/IwKGWSXW1xuLbx4+Ar
         +fgB8N3Cyva7MT6YKOq14jnucQ7ABPUTfso+D3nsFkTTk+RajXDYhQlcrCS5RsXcbuxm
         1MfvKiXWvejhU3LCh43rfoFxPzN8NzHRe1UcnYRnuVh5hip5XlBRTcNnPul+lwJw50il
         21tw==
X-Gm-Message-State: AOJu0YztcFGRpsZ1XInTXoDAeUzZ80PVi7vOFfLEMr/93ttGGCm9XNE7
        hRPEuc7aUyzCyqjHWuzh7oo=
X-Google-Smtp-Source: AGHT+IG2Dnzu8wpudFdNimHjIwtnoLtfFrOKx2kVghmCSKdW92/o+Is4OyJwD3zNKDLmhR9iZkt35A==
X-Received: by 2002:a17:907:2443:b0:a19:a409:37d7 with SMTP id yw3-20020a170907244300b00a19a40937d7mr1350485ejb.48.1701671895028;
        Sun, 03 Dec 2023 22:38:15 -0800 (PST)
Received: from [192.168.2.2] (dsl51B7D2F9.fixip.t-online.hu. [81.183.210.249])
        by smtp.gmail.com with ESMTPSA id kg6-20020a17090776e600b009bf7a4d591csm4965910ejc.11.2023.12.03.22.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 22:38:14 -0800 (PST)
Message-ID: <c825b030-1520-426e-a6ad-7df0c276b3ea@gmail.com>
Date:   Mon, 4 Dec 2023 07:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] egalax_ts_serial: Fix potential buffer overflow
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        zboszormenyi@sicom.com, kernel test robot <lkp@intel.com>
References: <202312021646.cwwvptuB-lkp@intel.com>
 <20231203090600.85890-1-zboszor@gmail.com> <ZWzHv7X1UKgJJYTy@google.com>
Content-Language: en-US
From:   =?UTF-8?B?QsO2c3rDtnJtw6lueWkgWm9sdMOhbg==?= <zboszor@gmail.com>
In-Reply-To: <ZWzHv7X1UKgJJYTy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023. 12. 03. 19:35 keltezéssel, Dmitry Torokhov írta:
> Hi Zoltán,
>
> On Sun, Dec 03, 2023 at 10:06:00AM +0100, Zoltán Böszörményi wrote:
>> @@ -42,7 +42,7 @@ struct egalax {
>>   	struct serio *serio;
>>   	int idx;
>>   	u8 data[EGALAX_FORMAT_MAX_LENGTH];
>> -	char phys[32];
>> +	char phys[NAME_MAX];
> This simply wastes 200+ bytes for no good reason. It is perfectly fine
> to truncate phys string (which does not happen in practice).

Okay, I modified the phys[] array to just be 40 bytes.
That's not that wasteful and still avoids the warning.

I noticed that other TS drivers emit the same warning.

>
> If you feel strongly about it then maybe use devm_kasprintf() to
> allocate the needed buffer.
>
> Thanks.
>

