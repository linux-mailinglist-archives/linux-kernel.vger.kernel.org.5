Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02775D123
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjGUSOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGUSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:14:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED12D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:14:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991f956fb5aso326722166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689963244; x=1690568044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75/JtxCu43LYB6GLiaKBrQMMBpaIjqrwj9+p02/FvKc=;
        b=nkrs774UH1Pl/wNtwfgvFSAbpvkuol+G+KWmeVr7hPxnEqssXC1jtccBO3ev0P8U1w
         cPq3AoxTy8NXvn0F1jVkDx/T7HPHdjPYkLMIY5IlFmOZ1Fs4H6UyPEewIVjt7Ak9Ge0X
         qM2lFNBWDnWzhLJ2+ChrZEsldBCXRNsTeQfKs5GYDphz3JUfL+QIs31iGfxqvSALeVJm
         ZOMY4Msa6gfCQGMnJw36TWwdLfueb2+2QYug1eZA5a5DF1O2V1lSAcTX7RT365y/KEeG
         SJtURinx0qbwVGUDTaMfKdCQAqjFJdG7ZKXp/BUowQTrPSFbmAzdAv5NQTt1znS1TjWq
         umyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963244; x=1690568044;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75/JtxCu43LYB6GLiaKBrQMMBpaIjqrwj9+p02/FvKc=;
        b=RHhLa4KHXDKa3HlQpsTK/r0qlOlSQlhqIICn3AcuidjsPi2lz6C2y1lxfmHg65R72e
         KG8Xnkk/qQEf9NLFuva3t4Q4r2eaMU25fFm/iSUe0Qj4isUi1PQBldQt3YCfzvo5RST5
         qlAXmCFp9Upi/wW6mtIPBdt/trFO/rPu9FFNXcBFAsQCIlO9Bap4LZG/isL4JEjB15oR
         2z3jPxYOkdNhz69LnAnf0jbcb0pXiOerl5xcoYlssnFC+9k0zSSElAUpWDFBChffNLSr
         w+IUGkDxnsmDpSDq6VsSg3TNsxTc5Mn0bTmxi4+6UKKBgTmtuhly1TWgSYta60sjeA78
         ArKg==
X-Gm-Message-State: ABy/qLY1Tj9LYm/UBjG3Da4ZO3lx0msebYTdeMOSFUteeAguP69dwY2x
        wMZ9cArHeUrDHZcAbCy0dI8=
X-Google-Smtp-Source: APBJJlH9q6O1JtiZc8xcIRepqmbxxuCTS0J2/2B9WZb1DzUEUJ6QF3I7lIMsNz2Hysb03juimTmVNw==
X-Received: by 2002:a17:906:74d6:b0:993:d7f3:f055 with SMTP id z22-20020a17090674d600b00993d7f3f055mr2130197ejl.11.1689963243614;
        Fri, 21 Jul 2023 11:14:03 -0700 (PDT)
Received: from [10.4.145.3] (83.10.92.232.ipv4.supernova.orange.pl. [83.10.92.232])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00997d7aa59fasm2514942ejr.14.2023.07.21.11.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 11:14:03 -0700 (PDT)
Message-ID: <a4d0bf2c-34a2-6c43-92fe-6db1d6c00a44@gmail.com>
Date:   Fri, 21 Jul 2023 20:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
Content-Language: en-GB
To:     Brian Norris <briannorris@chromium.org>
Cc:     Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org,
        robbarnes@google.com, lalithkraj@google.com, rrangel@chromium.org,
        bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev
References: <ZLm3G5G6/gmLZwkn@tora> <ZLooCXV11JCdWOdK@google.com>
 <b1370c4b-7bad-4aac-0fa7-32d6479aa255@gmail.com>
 <CA+ASDXOuJVG7bpXdKMf9nobjJ=qcTiBWVj+TQ3Kpwqct27HSag@mail.gmail.com>
From:   Alicja Michalska <ahplka19@gmail.com>
In-Reply-To: <CA+ASDXOuJVG7bpXdKMf9nobjJ=qcTiBWVj+TQ3Kpwqct27HSag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's understandable :)

I spoke with Matt (MrChromebox). It seems like he tried to upstream 
similar patch to what I suggested here few years ago, but it never got 
merged.
Reason for this is that pre-Skylake machines had different DMI vendor name.

For example, that's my DMI information from ELDRID (Google/Volteer 
baseboard) running MrChromebox's firmware and mainline kernel:

[...]
Vendor: coreboot
Manufacturer: Google
[...]

There's a match for coreboot/GOOGLE, but not for coreboot/Google - which 
is the case for all modern-ish machines made past 2018 (reef, octopus, 
hatch, volteer, brya and so on).

As for the concerns regarding removal of outdated DMIs - it's 
understandable, but mainline doesn't work correctly on stock firmware. 
In order to get mainline Linux running correctly on any ChromeOS device, 
user has to flash firmware that contains our patches.

We currently support over 100 machines, starting with first machines 
that used Coreboot (SandyBridge) up to AlderLake (at the moment). 
Flashing those machines (pre-CR50) is as simple as removing Write 
Protect screw and running MrChromebox's script from ChromeOS shell.

Once that's done, Chromebooks behave in the same exact way as UEFI 
systems (because we're using EDK2 as Coreboot payload in our builds) 
with correct ACPI tables and other numerous fixes that are missing from 
stock firmware.

https://chrultrabook.github.io/docs/docs/getting-started.html

On 21/07/2023 19:28, Brian Norris wrote:
> On Fri, Jul 21, 2023 at 10:16 AM Alicja Michalska <ahplka19@gmail.com> wrote:
>> I've explained the reason behind adding this patch, but we'll go with
>> different approach next time around.
> 
> FWIW, I'm also confused about your first sentence the same way
> Tzung-Bi is. If two people are confused by parts of your description,
> then maybe it needs improvement :)
> 
>> Since we're discussing this, I would like to suggest removal of DMI
>> matches for EOL machines from lines 503...535 (Link, Samus, Peppy, Glimmer).
>>
>> Those machines aren't supported by Google anymore. Patch I suggested
>> will match DMI while running custom firmware.
>>
>> If maintainers are okay with it, I will submit a patch removing DMI
>> matches for stock firmware running on those machines since it's not
>> needed anymore.
> 
> That seems actively harmful. These devices continue to work just fine
> with their stock BIOS, even if Google no longer supports updating the
> Google-built OS. That doesn't mean people can't boot other OS'es
> (e.g., their own ChromiumOS builds; or other Linux distros) on them.
> 
> Brian
