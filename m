Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094ED77A1E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 20:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHLStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHLStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 14:49:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DE51725;
        Sat, 12 Aug 2023 11:49:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c8so14339395e9.3;
        Sat, 12 Aug 2023 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691866192; x=1692470992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTN1CvlcH9t+nwKcdvlh4dzk/jTUcp/DpsWEKs3HU+Y=;
        b=qf2nsyR2zUOTa1wAh0tyqjbP5xORgsItoYL6zU3bbxjWG21WzBoPW86thfFwrthO78
         NOneeVWaxbtp4x038PQQoOuup7lRbk7xvaWQTYR4R6a94X/i9BlXDb4O7ZZHgBgQbYHJ
         u/smuXkm4lsOPuO1RKSP4ly3tGuMknFgytxyA7+sYNopObeJXgytlMENKp0+qq6tmR0A
         5hP4Ab5W1st5EBSh0VjEZ908m5bUMILTLe/idkm0ocZeDNTaVgUwfJZ6fiQFbID6ybwA
         W6FaBrWk1RHkAgoE/RUatRXkGaHLwX+J/g5jQwhuCaXcmLToExTg3bvTV4rV5FsuDD7A
         VkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691866192; x=1692470992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTN1CvlcH9t+nwKcdvlh4dzk/jTUcp/DpsWEKs3HU+Y=;
        b=jvUGFpT6fAthFoiJPU48K9tnEXl3dRVAmpMBezuPmufPpul1bGaZODlNWV/SkqfeWV
         DN9yh2AkJiZuC1/vaI29cSQGKuV9XLku8nM3sh6YADxd3BnXs4jj/Ircof/GbPD27bHI
         8gwDWQTLhZaa2vO5RyRSKxskI23sIYvRwRM1fJumRA5busmzzlTCCGrAg/ANvu+/Nlt9
         IukwE1jxfQKBJXsbipFxhyF9s/UGV4AGXOlQv7pzCNqRGdl9xTFHnwg3MBVt9vSR8cwU
         YwK9sO+ZJHEiDdfKdFRAn42hZVF58GDdeFYSV7P6axd2PdH3HQEKbz/7tmU4CPgfpMS7
         FEkQ==
X-Gm-Message-State: AOJu0YwRuSm8VvGGUyqLa2sbT8ZPlysWRC7/ByPpAQ0k5q2H1ytSwsJR
        cwaPXh+G8bOnvMf1DnbRFC6Z+IFiAyIJrg==
X-Google-Smtp-Source: AGHT+IGslzcP6wNNQ6BHGVw7rPncJCe8IY/smKZhYPg8nW7jcOen635j4ECFJ4cdTdOjlAOOyZ2FVQ==
X-Received: by 2002:adf:e8d1:0:b0:313:f5f8:b6d2 with SMTP id k17-20020adfe8d1000000b00313f5f8b6d2mr4105835wrn.48.1691866191534;
        Sat, 12 Aug 2023 11:49:51 -0700 (PDT)
Received: from [192.168.0.28] (cable-178-148-234-71.dynamic.sbb.rs. [178.148.234.71])
        by smtp.gmail.com with ESMTPSA id b5-20020aa7c6c5000000b005224d960e66sm3513404eds.96.2023.08.12.11.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 11:49:50 -0700 (PDT)
Message-ID: <932973d5-812b-8bf4-26f0-d167f51f997d@gmail.com>
Date:   Sat, 12 Aug 2023 20:49:49 +0200
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
Content-Language: en-US
From:   Aleksa Savic <savicaleksa83@gmail.com>
In-Reply-To: <0d94544e-59d7-1860-2cc4-1a9130023b2f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-12 01:05:19 GMT+02:00, Guenter Roeck wrote:
> 
> It has a Fixes: tag, so it will be applied to affected stable releases
> automatically, at least if it applies cleanly. I could have added Cc:
> stable@ to make it explicit, but I had pushed it already, and I didn't
> want to rebase the branch just for that.
> 
> Guenter
> 

Didn't know explicit Cc wasn't necessary, thanks.

Aleksa
