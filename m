Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1077CF09
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbjHOPWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbjHOPWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:22:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E4210E;
        Tue, 15 Aug 2023 08:22:34 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703a0453fso82929401fa.3;
        Tue, 15 Aug 2023 08:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692112953; x=1692717753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9s7BNPlKwG6jAcyz/QreRIkBhVa6z4e1ov5e1etqgg=;
        b=n0TaKNTlhbYAo7xAJLL29angXA5xrusXd+WmjRzY/8sF1q8mU0aocNLMu3UkSoZE5Z
         JrG0/k1/jWaxdPwzYZiz0OznGSubFHWy5w5GcsXAZj5NMiOQfowq+CQZ9obFx364b3WE
         x86G6RnUsivF4fAEh0XcCxHr6um5p9rlrn+mPahuyZm66IFYC9CL1LvV8uKoXWtlit1J
         pNBbPdSm1FqyICG2AgkwrksZ/JJgEMuKpZlodTOIXDZ6pDDuMWfWrTlMWv86I20Gzx8j
         ULvLqivInj9xO4dEU1odSGnbEFz3PERWRKpYGXYT3J3ZRQfH4UMxnmddyK5Voy+Q+8VH
         fffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692112953; x=1692717753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9s7BNPlKwG6jAcyz/QreRIkBhVa6z4e1ov5e1etqgg=;
        b=hLgtIJBdy9nOTQImMF4mP1x62VLlUKCp4FYYc7cNfJWwzJiK8bIvMvzIijpPrk+N+r
         VQoL3NM1nqXL5Z30WTg+tfWZqEMO7oemrR5xwQ06kpqDqwIHcGeVmTUOLhcdbLLusb1P
         fIaJRmXQYM/Eibt/XbX4GEZ07nuOX+JbiL5fvI7tTgsFRU1aMGGsWKAmEZklGXrkjhXi
         1dw//2IFGgF6HsBSDq1V0YZI51/TPcPjkzjcX38h0pCxpsUxlEcNY6Q8wLY2U6jV3PRI
         Yg6K2hdF/fY1355X6Wrl3q82TMw0ZobiLTtRugTOrQ+g/HQ4InacPAUfFsglMe7DWCjF
         1kmw==
X-Gm-Message-State: AOJu0YxIAhLieq71wF8zElyLieWBtH8jAOPF54Vz6ArtsdJpoT2fIITw
        CZ4EriYQaqCTVE0u6/2lHUY=
X-Google-Smtp-Source: AGHT+IElz+sw5rqGeU2GmJZ1z03ZuFCV4gynO0z4bsAVD5xlm8JN0vOBOPbM7g052dc2c3xuB0iBLg==
X-Received: by 2002:a2e:8ed0:0:b0:2b8:3ff3:cd93 with SMTP id e16-20020a2e8ed0000000b002b83ff3cd93mr8986815ljl.7.1692112952472;
        Tue, 15 Aug 2023 08:22:32 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090655c600b0098748422178sm7122757ejp.56.2023.08.15.08.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 08:22:32 -0700 (PDT)
Message-ID: <35cea1ae-df13-6309-1b00-6ee236118143@gmail.com>
Date:   Tue, 15 Aug 2023 17:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     savicaleksa83@gmail.com, linux-hwmon@vger.kernel.org,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
To:     Guenter Roeck <linux@roeck-us.net>
References: <20230807172004.456968-1-savicaleksa83@gmail.com>
 <c151d464-da26-4c53-ba7a-d16bb8fca949@roeck-us.net>
 <e7bcf401-991c-808c-66df-65664940bf22@gmail.com>
 <0d94544e-59d7-1860-2cc4-1a9130023b2f@roeck-us.net>
 <932973d5-812b-8bf4-26f0-d167f51f997d@gmail.com>
 <b1083bf1-9d28-48f3-a984-38f63ec1fd16@roeck-us.net>
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <b1083bf1-9d28-48f3-a984-38f63ec1fd16@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-14 15:42:19 GMT+02:00, Guenter Roeck wrote:
> On Sat, Aug 12, 2023 at 08:49:49PM +0200, Aleksa Savic wrote:
>> On 2023-08-12 01:05:19 GMT+02:00, Guenter Roeck wrote:
>>>
>>> It has a Fixes: tag, so it will be applied to affected stable releases
>>> automatically, at least if it applies cleanly. I could have added Cc:
>>> stable@ to make it explicit, but I had pushed it already, and I didn't
>>> want to rebase the branch just for that.
>>>
>>> Guenter
>>>
>>
>> Didn't know explicit Cc wasn't necessary, thanks.
>>
> 
> Preferred but not necessary. You should have received an e-mail telling
> you that the patch did not apply to 6.1.y. If you want it applied there,
> send a backport to stable@ with a subject such as [PATCH v6.1] ...
> and backport comments after "---".
> 
> Guenter

Thanks, will do.

Aleksa
