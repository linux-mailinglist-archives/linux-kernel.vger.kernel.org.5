Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3E752A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGMSvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGMSvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:51:03 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AC1BD5;
        Thu, 13 Jul 2023 11:51:03 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a3790a0a48so830589b6e.1;
        Thu, 13 Jul 2023 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689274262; x=1691866262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0SWbPYGf/VHa1Vrek8TS84jAYeRKRYqep/VhZf8G5PQ=;
        b=UHXnNJWWgaeZbH+Im6rfsnEO6+5CNWnj3UtXdTDq5IMfUWlHGIQj8qZm54+qB5OQbo
         og6qpu12lu6nLpbrsjuKuZDwXB1zify8A0M9xlPC35GyEN9icBdB6G60xVWkw/PZ+svR
         dZRQCgv5rI4sxAb/7uJzQxCYAXVWNUpluPGCu8wdpM/D2EU1v+JL+vOBUfNrjZRjcxet
         1rx5wTe3pgXIBQKzXBV4rGCn/DP/4g3tG18jBZRPLdW/eb70HMA6vYEVwgQEqzzXxoVt
         oI+6h5spqAdhb/yF97AgPt2Ebv62BFMLfqdwtYw3OMETn8avGHbztJpTz1v8SpFzbBQz
         MyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689274262; x=1691866262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SWbPYGf/VHa1Vrek8TS84jAYeRKRYqep/VhZf8G5PQ=;
        b=JFm2clQhhMSVXZuEU567hmkod2vw3eckjqfQVusqSGuAzXrLUALvWXLtv8ND6CYXpJ
         jEU3vH4FmZTjoz0RIk2A4QLk2IQiXykfQpRkT+3l9A++Fzc4VKLAnfJa9szOsE/WRWhx
         scEtnj7wnwRXVHq1ySZW93e9RXaGrOLM27OgzIMAcJrU/tWY7IpKjP2uvK1V+EUKxEAE
         yedHwf5wDuPJ11F2zqU4gAMVSQaksK7+cGUeFWIbe33WefnGFk0DkcaYsuKVFsKmr+U4
         4tVJk5U/s/IeZVKL+6J9jfrQ8hAXXjox4QtVbRoWz/VZnvsFGjPGixqEXVj9IkvYScNd
         5AQA==
X-Gm-Message-State: ABy/qLacH3RIOokC7yHmhZF2k4u6ky9plcaNXOsS/862WZcnnxHfMHGd
        n9w+KvjLc7x2BkZOF4DJhhk=
X-Google-Smtp-Source: APBJJlGsZaZS/WeRem6l3voNBw16PU9/3Aa1djVpMcdsJe0OYN0tMH7+t5C7WMbtkERM1UJ4HOxJZQ==
X-Received: by 2002:a05:6808:f09:b0:3a1:d8bc:ff8b with SMTP id m9-20020a0568080f0900b003a1d8bcff8bmr2789761oiw.38.1689274262384;
        Thu, 13 Jul 2023 11:51:02 -0700 (PDT)
Received: from [192.168.0.202] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id k11-20020a54440b000000b003a1ec14d8c6sm3131600oiw.23.2023.07.13.11.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:51:01 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b684a76e-7d22-fece-5358-f459e4a979ff@lwfinger.net>
Date:   Thu, 13 Jul 2023 13:51:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: 7811: Fix memory leak in _r8712_init_xmit_priv
To:     Your Name <namcaov@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20230712205733.29794-1-Larry.Finger@lwfinger.net>
 <ZLA1942ebuVcUT3h@nam-dell>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <ZLA1942ebuVcUT3h@nam-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 12:35, Your Name wrote:
> The allocation was done in a loop. Shouldn't memory from previous loop iterations
> also be freed? And allocation by r8712_xmit_resource_alloc() should be freed too.

Nam,

You are right on both counts. I will prepare version 2.

Larry

