Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E57DF66D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbjKBPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjKBPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:31:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479FFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:31:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28023eadc70so1058843a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1698939100; x=1699543900; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ib4yvHo7VS2tnCRMUgFpWE1vpp3pfAzlCEHF8XEGA=;
        b=J6svxlE4ZPERbIrT15InCvxx4TG7Zge1d9Vym02tE1R3FRAIURj31jfeTNhkW19qf+
         fSY/V38wE0nEOfMzL643RqZabULL+e002DKAzfNiWDXck9+haamYMw7Txc4IKprdyu+o
         5QrxfvVb3+hnAD2kUzkgKr3s+AHMTbJA3sZ+eLR4Qaxwx7A4ilgW4cj4CRQLxwrC78dJ
         iJjdj0sPqLiFejW82bMVnQtENBBeeqJLaPqDZ5hCdKZdHp7RgDd5RW3QhRVnDBIpyi3J
         eGHEIeuLkqeC+ICQJoe0n1Mrb2Pu7aIq3u2WrWjKqJgZmaHgxTIvMV1weF27BU6OOdVr
         Xflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939100; x=1699543900;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6ib4yvHo7VS2tnCRMUgFpWE1vpp3pfAzlCEHF8XEGA=;
        b=U1vb5bowzQkbWZEHLVQoR0ktOrhASwe9ebO3izt9OLRKVhsgBxz5X/6BcKIuTTkvAi
         F9TALJerF948qPUD1nFd2Z4ffARshnkjTSDv/Dos6JGkV1vWlyLss95f2oUVgcLjuCaD
         fKfaboqRnjMY7ZQdHpmgXf8ukRiRAE2BWVPKwlF7O9YCYNauw4V4SfbBitYgerYs5DGM
         8bDkPnGkHDBgynyXkq48MJSaSHIWnf7AL3Y1wUpQB8ytV3dPVhu382ddTp9hAUVbOcAH
         f1UTTqGEqz3VRsRWZ+webQpT13K4VmVi6XSrsNAzRo+89dC4J4u00Ca4U/qASCChndTn
         +4zw==
X-Gm-Message-State: AOJu0YxFZ19q+GeDFldfYilaGcV99Uqn7zSYtzoKWnjPYHoFh85fwPHm
        XAWT2NbouZkUeGa3fu5z4JWg/A==
X-Google-Smtp-Source: AGHT+IHJXTfLZgDDiW7WFmdbor5KZ9hsSkujLZ5FIlzWrp7lswZQB6A9G/zHp38CnK/oUxENK/0fFA==
X-Received: by 2002:a17:90b:d8a:b0:27d:882f:e6c5 with SMTP id bg10-20020a17090b0d8a00b0027d882fe6c5mr15773419pjb.9.1698939100289;
        Thu, 02 Nov 2023 08:31:40 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aad9600b0027d0a60b9c9sm45227pjq.28.2023.11.02.08.31.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2023 08:31:39 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Peng Liu'" <pngliu@hotmail.com>,
        "'Wyes Karny'" <wyes.karny@amd.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liupeng17@lenovo.com>, <lenb@kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <TYCP286MB214616F6AE3E088C5D781A2EC6C8A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM> <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB21465F970BF56AAE5D0CEB72C6A1A@TYCP286MB2146.JPNP286.PROD.OUTLOOK.COM>
Subject: RE: [PATCH] tools/power turbostat: Fix Bzy_MHz calculation equation
Date:   Thu, 2 Nov 2023 08:31:40 -0700
Message-ID: <002801da0da1$adb83fc0$0928bf40$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG3BHz+VfofbgYKyoMXwr1Kb5XJSwLFIQsTsJcLg0A=
Content-Language: en-ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng and Wyes,

Just for your information about your recent "ping"s about your turbostat =
patches:

Please be aware that there is rarely any reply. There tends to be about =
2 turbostat updates released per year. Your patches are in patchworks =
[1], as are some others, including an old one of mine from 2023.04.03
Eventually there will be an update, and hopefully it will include all =
our patches.

[1] =
https://patchwork.kernel.org/project/linux-pm/list/?series=3D&submitter=3D=
&state=3D&q=3D&archive=3D&delegate=3D107

... Doug

On 2023.10.29 08:12 Peng Liu wrote:

> Ping
>
> On 2023/10/7 13:46, Peng Liu wrote:
>> From: Peng Liu <liupeng17@lenovo.com>
>>
>> To calculate Bzy_MHz, TSC_delta should multiply APERF_delta instead
>> of dividing it.
>>
>> Signed-off-by: Peng Liu <liupeng17@lenovo.com>
>> ---
>>   tools/power/x86/turbostat/turbostat.8 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/x86/turbostat/turbostat.8 =
b/tools/power/x86/turbostat/turbostat.8
>> index 8f08c3fd498d..1ba6340d3b3d 100644
>> --- a/tools/power/x86/turbostat/turbostat.8
>> +++ b/tools/power/x86/turbostat/turbostat.8
>> @@ -370,7 +370,7 @@ below the processor's base frequency.
>>  =20
>>   Busy% =3D MPERF_delta/TSC_delta
>>  =20
>> -Bzy_MHz =3D TSC_delta/APERF_delta/MPERF_delta/measurement_interval
>> +Bzy_MHz =3D TSC_delta*APERF_delta/MPERF_delta/measurement_interval
>>  =20
>>   Note that these calculations depend on TSC_delta, so they
>>   are not reliable during intervals when TSC_MHz is not running at =
the base frequency.

