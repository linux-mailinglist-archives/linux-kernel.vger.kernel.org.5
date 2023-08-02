Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6D376CDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjHBMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjHBMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:54:52 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C57EFE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:54:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b9c368f4b5so6293705ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690980891; x=1691585691;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTsB5xasCjFSR0Vt+lWlOtsMczEa0Wdrnf1ucGFcWxE=;
        b=Xf119sNQbhMFipzzBrEHVa2TIwq90m3rCVjyTtalSI9XXc0ITaBthyQPibWro7SrsN
         +XLF89GzMPzdR/k7AD6Wh9v4EOy2se6z1xmYJbTh02zimPUdWzC1x/cfFXI367JUMqkW
         yIr9H7HTlitmcJbUsKhjGtl5ty2koAo76qtTvXWf1E/7VnJxb/IA/T1WU/YIy2rWpf+2
         v4HDd6KY29Bujaq4ZXq7hj9T5CeXyZzUdwgpSvVhGQEjbChqRfiJW61CvWt3RIpXmtg9
         7sYeKg7SqWftSGaSfbxAX6dFxENVUdn4cPcfpiynAXSwYvamHj4kJBIIgbS1cnWPlltN
         xdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690980891; x=1691585691;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iTsB5xasCjFSR0Vt+lWlOtsMczEa0Wdrnf1ucGFcWxE=;
        b=dTerK96VF2h5OPMFXcz8uGJYQwmlN/ytfTq6VIxLT4U8IRlIfWmQLknnqbhx1AET9R
         4PNDgFpXQzSUn8sQ/eHbmXy+QUa9Kn8Zu7QycWpym2R8CpeN6OhpbtP8Jaul5r3iCPSp
         0sYBhaZRcOyExp0XcRhQENgmMpAKf5f5mIDBJYG3tsU6vtO/uRThQ+0WSYu1Rt77YDRh
         A86tYtJY721DPbGAnYBbzPFNo9YsXt8N6Wg3sXrLx9gzz9R8C0ETkeau/jJto1GQa7tK
         WeuzryisAvFB8fhYBexX6FdaMtt2AXj2dnARzNHO668303N92g7rj+qVqhXMMU1KSgLz
         F+fQ==
X-Gm-Message-State: ABy/qLauZmnqmHLvfnkywqLRy0EALwaLJFIdvhDto1s/JuDtPri8X6FH
        lp5M8FTyOn7d1Y8X+qf/QbE=
X-Google-Smtp-Source: APBJJlGImue9z1dkkhas+upC+ICC/WevIqT57gUBpMxvtirC3HSxFcUMCJa1ijZYA7nO3DPsM5uaYA==
X-Received: by 2002:a17:902:d481:b0:1b8:3936:7b64 with SMTP id c1-20020a170902d48100b001b839367b64mr19612437plg.1.1690980890698;
        Wed, 02 Aug 2023 05:54:50 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d3c900b001bb7b0a0372sm12296441plb.290.2023.08.02.05.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 05:54:50 -0700 (PDT)
Message-ID: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
Date:   Wed, 2 Aug 2023 19:54:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> How to reproduce:
> 
> Had 24 CPU Alderlake 16GB debian12 system running with default kernel (from makecondig) on 6.5-rc4, exercised with no swap to start with.
> 
> using stress-ng tip commit 0f2ef02e9bc5abb3419c44be056d5fa3c97e0137
> (see https://github.com/ColinIanKing/stress-ng )
> 
> build and run stress-ng for say 60 minutes:
> 
> ./stress-ng --cpu-online 50 --brk 50 --swap 50 --vmstat 1 -t 60m
> 
> Will hang in mm/swapfile.c:718 add_to_avail_list+0x93/0xa0
> 
> See attached file for an image of the console on the hang (I'm trying to get the full stack dump).

See Bugzilla for the full thread and attached console image.

FWIW, I have to forward this bug report to the mailing lists because
Thorsten noted that many developers don't take a look on Bugzilla
(see the BZ thread).

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217738

-- 
An old man doll... just what I always wanted! - Clara
