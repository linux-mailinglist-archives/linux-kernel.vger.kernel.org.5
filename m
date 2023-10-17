Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8D27CBAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJQGT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjJQGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:19:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097BF0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:19:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9c14313eb1cso63814066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697523591; x=1698128391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBTFzOZUm33JicBd54NiMc5LyGvqTjPU5461OiFS0cA=;
        b=PaiBu1b5HFH6ULKmjg7LSghUPxwNoZLNfbLtdHWLfcju3Sb5ynoPC3aB/F1eBdiHjz
         9Keht4sXNaM0jvjDq1db2kQ8al63tXGHsw5g5RldpA2U0il2BJLRRVt98u3soMl7uiyM
         8UdMJ1uGdqsROBLFc3MWS4KjZYCiSMDFFD6lTI/mgOvOrvf1LuGg51sbbw51Z9dTVizQ
         eEKWagKC0uXbHlloUlp8VazjFBXOF/nP2xJ2rokaxa2isWDG2Wumjszg1KycDwK8ODeP
         A/WZszmy6Slh42Inifxz/QsUqxZzSZEwkTaxitd8ZDlP6EAy9xp7hJKLMcjVygl+Gj8x
         xQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697523591; x=1698128391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBTFzOZUm33JicBd54NiMc5LyGvqTjPU5461OiFS0cA=;
        b=WkJYC6Mo15iRwA4XHbLjz1i8q5EH5YT/rVMdhNQFrTGLZ0dND7+OsNQgJPNAvqpjOK
         fsih8DyoHXBf5kAPlpPeenSuOWIk7APwNIFFz9N6EKHFH29f0l2nryDJVRAmwWDMiOwC
         E2Wh0ZXYxjJVd55W7Lyk5xH1cxsiswhgMfsKqyP5TNFPPdAQzt8xFa6+dOVlIhH2h5or
         GH6IFUHn0kdhSzmGFmej9xO9i4PA3KiobgSVZV4f/FfieZ9Co9f4QjWUEGZi9EKUIeue
         Eyd2I5V0YKj4UEvOc5/x6/QNxp1m6/7HilDhicoM2+fOoPoKU5B66mMXHMYG2sPV5gF0
         7oYA==
X-Gm-Message-State: AOJu0YyyJBwsIrk1hQwFRgnnyGpEEFmNzalSNM53ZtF4i3hJLbdaYdUb
        8yLQ7rQuQvI1ir3XBKWKEWD4Ypk6bh0=
X-Google-Smtp-Source: AGHT+IGRvXAWIeFFF+cl54Cxh1CELKVXCCwn+KlvhhO2eJEOrA1kX4Jvjy4ihoENtdDerksriPn6ng==
X-Received: by 2002:a17:907:6d1e:b0:9c4:4b20:44b0 with SMTP id sa30-20020a1709076d1e00b009c44b2044b0mr835694ejc.1.1697523590615;
        Mon, 16 Oct 2023 23:19:50 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b009b27d4153c0sm587208ejp.178.2023.10.16.23.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 23:19:50 -0700 (PDT)
Message-ID: <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
Date:   Tue, 17 Oct 2023 08:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr
 and byBBPreEDRSSI
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1697495597.git.gilbertadikankwu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 00:58, Gilbert Adikankwu wrote:
> Make the variable names adhere to Linux kernel coding style and mute
> checkpatch.pl errors.
> 
> Gilbert Adikankwu (4):
>    staging: vt6655: Rename variable bUpdateBBVGA
>    staging: vt6655: Rename variable byCurrentCh
>    staging: vt6655: Rename variable byCurPwr
>    staging: vt6655: Rename variable byBBPreEDRSSI
> 
>   drivers/staging/vt6655/baseband.c    |  2 +-
>   drivers/staging/vt6655/channel.c     | 18 +++++++++---------
>   drivers/staging/vt6655/device.h      |  8 ++++----
>   drivers/staging/vt6655/device_main.c |  8 ++++----
>   drivers/staging/vt6655/dpc.c         |  2 +-
>   drivers/staging/vt6655/rf.c          |  4 ++--
>   6 files changed, 21 insertions(+), 21 deletions(-)
> 

Hi,

-       if (priv->byCurrentCh == ch->hw_value)
+       if (priv->current_ch == ch->hw_value)^M
                 return ret;

ERROR: DOS line endings

What does the "^M" at the end of the new line?
Did you run checkpatch on your patches?

Thanks

Bye

Philipp



