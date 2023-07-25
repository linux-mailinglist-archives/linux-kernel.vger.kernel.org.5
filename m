Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B907609DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjGYFyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjGYFxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:53:52 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1781BEE;
        Mon, 24 Jul 2023 22:53:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2878142b3a.0;
        Mon, 24 Jul 2023 22:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690264424; x=1690869224;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W7S+2aJSoBjeMVJrCzXjHRFtcR7Wfeu3VZj7Bqt42VI=;
        b=GbFG7x+C8dFgsdUUcmRmrzp0DtjCn9WTfPdErIgb8DFeVZQAPPoRuqD/9ONNxCuMfS
         y+y8bos3rSDFYYgwun/pNW0F0CC8KSXGhAjEapZT8Quwa6BHL7hDHSW/DcP6kl7HbgUA
         rB94bw3sSpdDk1piua79zbMCxw4OVsLzRxaOBZpYrx08fE/3YA4i195d9hv+ZFdYWQ8e
         0H4s1qEruQvLvf0Cr4t5RGNuOdUzzME1BKW8RXVEYkF4bTuB7h8CwnNIUKgHFs0Waqr8
         UVT7aKCsW/pkTlB0XNqgAaxL4J00Nghkhv6F9Cw0naOGP99aNN60E+AYCRORK8YWVY0a
         JtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264424; x=1690869224;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7S+2aJSoBjeMVJrCzXjHRFtcR7Wfeu3VZj7Bqt42VI=;
        b=hGPrTX+NQFQ9CVyM9yiFyuFAJUk+MBqisQdrLiuLyKp+8h1J/eld9Q54YUuzQh/BJC
         1Izxsy9/TDKziM6XUfdD7PVyQhigwLBdNb6k+2WpRKCfD5q7PYBptSUWDvf8NKsluxK+
         wiUMSS/8iNGjb5zKUCcdHmfw0hDjcROagyI15wXRMj9jVeDFVtKu0WH9yYyuzy4zlCob
         sKoL+0J561HGmndNb7hCRGewIsTv9WUX8WgYJsoFOQYGWGg49XKRxNXMyK1ELtoeIB43
         rhkNweiaujMouaIhgj0lKaue/08X74UqFqdeW2uObIdnpujN7TkH0PNxDE456u0d1MMJ
         eahw==
X-Gm-Message-State: ABy/qLZ6Z+HeSP4zbV115GhF8hn/08Zcb6wI1ki93mYsZZ+bLRpOmB5R
        PwX0EP6zT0Lm9U1dOyxE5Kk=
X-Google-Smtp-Source: APBJJlGqutAEygo9+NWsVTICuXatmhcaOec39ta6l6gzqeHsUNjWONldt6u4DK3Z8FyNf5UT5mRbpg==
X-Received: by 2002:a05:6a00:150e:b0:686:6d87:1cd with SMTP id q14-20020a056a00150e00b006866d8701cdmr8304652pfu.5.1690264424466;
        Mon, 24 Jul 2023 22:53:44 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b30-20020a63715e000000b0056393238571sm6360084pgn.50.2023.07.24.22.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 22:53:43 -0700 (PDT)
Message-ID: <04a714d0-ceab-6287-c9fa-2450284d1caf@gmail.com>
Date:   Tue, 25 Jul 2023 12:53:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Kernel 6.4.4 breaks Elan Touchpad 1206
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Verot <verot.wrongdoer713@simplelogin.com>
Cc:     Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
References: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
In-Reply-To: <42bc8e02-5ee0-f1c8-610e-e16391e54ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 07:00, Bagas Sanjaya wrote:
> #regzbot introduced: 7b63a88bb62ba2 https://bugzilla.kernel.org/show_bug.cgi?id=217701
> #regzbot title: OOB protocol access fix breaks Elan Touchpad 1206
> 

Looks like the wrong culprit (see [1]), thus:

#regzbot introduced: v6.1..v6.4

Thanks.

[1]: https://lore.kernel.org/linux-input/ZL8S2%2FUjprk4KgzT@google.com/

-- 
An old man doll... just what I always wanted! - Clara

