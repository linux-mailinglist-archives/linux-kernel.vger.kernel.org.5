Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7979FFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbjINJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbjINJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:09:37 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2276B3A89;
        Thu, 14 Sep 2023 02:08:57 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so10622901fa.3;
        Thu, 14 Sep 2023 02:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694682535; x=1695287335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myXNrdTUEfnJ2uywIxDILlGjQxJb0RUxKt0pQrpz5qA=;
        b=lmqSjLo4QTX694lvfaLsxMDWJlGp+M8sbgox0UW4uuRYVGHxD2rHmeM1kmuqsXBQjl
         t+nZ82KZCLJfGNV3fR7nOvHSc3KDT951uVOlsPdDPAd8kAjhffQfXVH3LVp2901AmntY
         xgcdb2kLDCqFwIPwkbSKDVRBDWCLLlNj3LhV+yO0XQh+0SpNxp8om36vRn2pwKsvoORC
         sG1AZGznuKUZHCzkIJuFq3dlvOJ/wEYUWcq1L/w+PvJ+0c0yaKi94M1P386cZs2WVlc0
         G3s9dP8WOCQgVV48XkJ2r6djxS0cjOwHZfzQ8/5KC7Qr/N241qo/WD++VX3MJ5nTqZMt
         SUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682535; x=1695287335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myXNrdTUEfnJ2uywIxDILlGjQxJb0RUxKt0pQrpz5qA=;
        b=iOcmAnBkaOzSLDpqjUfE1kmou8VbFfXfWO8F/nx7U/O4Arc6e0UBi9gRPpOjoHS0xk
         hgbTNxNFnda99Sjiz0HM4Yu4aW3dTvu78+8eIjRhbIbQeZnS2RW0Vl/t3J8AAj3S2HqX
         lsUQuyx3Mv7GF87O2m1olIC58J/HsetX5NZ4ukplT54xaw1bf1tdoS8+7xoSvZelTnJ9
         PdXmWlH86S08cD7OdN3dXLqsQExl8w8XE9+u369stoverdPrqGkEp4MM096cMbrLYTXL
         DN9LjaQiW/k80tnTqR/AUQWTvh30RSc5leDJJcfdvp7o5C/f5yF/2KQ1JN9819Ml06dp
         Koww==
X-Gm-Message-State: AOJu0YwnCaPyMozBD0k1sjj8LyMF8qA2BunV4Xdx6oCMb+AfGUtM1pkZ
        hDy8u5qh1iWM5cBt6W3RmiOESMqO2QRJig==
X-Google-Smtp-Source: AGHT+IFp2fWyTGFQ1Fj84/0q9IqOqinfqhJAJgpqjCg4C+5joAjuLN3cMBtNNAgv69Rv6rPZaNe/pg==
X-Received: by 2002:a2e:9517:0:b0:2be:4d3a:ad6a with SMTP id f23-20020a2e9517000000b002be4d3aad6amr4114996ljh.26.1694682535015;
        Thu, 14 Sep 2023 02:08:55 -0700 (PDT)
Received: from [172.24.134.61] ([193.205.131.2])
        by smtp.gmail.com with ESMTPSA id s24-20020a7bc398000000b003feee8d8011sm4277553wmj.41.2023.09.14.02.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 02:08:54 -0700 (PDT)
Message-ID: <65ec6171-b47e-4d1e-9bd7-a61f2acfb959@gmail.com>
Date:   Thu, 14 Sep 2023 11:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, regressions@lists.linux.dev,
        Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
 <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
 <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
 <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
 <b9f879d5-55b8-401d-b154-8066cb66d20f@amd.com>
 <0522393f-9f0c-4c59-b961-9b8d865a645d@amd.com>
 <CACRpkdamAs=c6YBW2jgQ48kUPHqUGT=b89NSXYYttf0RbnpctQ@mail.gmail.com>
Content-Language: en-US
From:   Luca Pigliacampo <lucapgl2001@gmail.com>
In-Reply-To: <CACRpkdamAs=c6YBW2jgQ48kUPHqUGT=b89NSXYYttf0RbnpctQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 10:43, Linus Walleij wrote:

> On Wed, Sep 13, 2023 at 11:21 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>
>> 2. In better news updating the BIOS fixed the issue in both Linux and
>> Windows, no kernel patches needed.
>>
>> So no further work will be done on this series.
> Is it easy for users to update BIOS? I.e. does
> fwupdmgr update work?
>
> Or does it require flashing special USB drives with FAT filesystems...?
>
> Because I'm not sure all users will do that. Or even be aware that
> they should. In that case detecting the situation and emitting
> a dev_err() telling the user to update their BIOS would be
> desirable I think?
>
> Yours,
> Linus Walleij

sadly it's not convenient,

the only way lenovo offers to update the bios

is an executable to run on windows.


So a user should either have a dual boot

or install windows on an external drive and boot from that,

also the update process might wipe every boot entry beside windows.


I read that some bios updaters also run on freedos, but i didn't try

