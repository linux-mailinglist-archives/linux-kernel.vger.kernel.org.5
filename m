Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888067EFF56
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjKRLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKRLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:46:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2FFD6C;
        Sat, 18 Nov 2023 03:45:59 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c2139492d9so590808a12.0;
        Sat, 18 Nov 2023 03:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700307959; x=1700912759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ClOeeApXVOwVcbEnxEFMvGO2pvgQp5Himl1NoA2ock=;
        b=gi8cPpn1ogc2CqfzBiFS3lO6jHrmrwz6AmnFb7/jFUMc2HSGiemMBKPxyOE1ByDq/w
         dWx8L3QKmqVe7ORGSSRA5g4x+2+Aw9naeqg2K4Z/ylx+sXRsis/1/Wk6mgXu6RVWVN1G
         MOp9R35P45B8AZile7CcnWuWlI/KU5PEXmi0mrOMK3+oTSQwYBgNDepCDCgFJPwPZ/W9
         EDtZQeV9VnkSAnc0zqUAlFvJ7MjDx3gjYOqltCdGcmtOyoR1Khir6Mm6SKWDmDAw2Hkr
         FYYmsrDUBHgZ+xFTwFga2Nvbt8I4ZLnBZ3JQJnKREV1NgH4cRZ3uouQkdogKKyG2vrxS
         gV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307959; x=1700912759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ClOeeApXVOwVcbEnxEFMvGO2pvgQp5Himl1NoA2ock=;
        b=jexigBRDt/+jl3mGGt8Mv8A3oCjgoD4W4/m0cNoG1xyfr9bov6AGi/YIHntwkFJfWD
         FJcZ4Do4fJkJEh8k10OunB7QhfxBmEaQQs6dgfizeUxKVYCg5td2vnlMVBgCizTfT8Ui
         bvbomHqMKGGKmt/C3WQW6EMqLazWNNZFhgAn4BpDkHGhRcbqPaUyldGOsSF42gHWbuUJ
         H3HZoOf12ywsN8PFfUhgRFTsyDc2Oo+C5gI5+XkBymHfYzJSqnTU8FRM1Lu28ALP0qNw
         /ti51mmywG5NjImY9TR+fEwvKJ8txuhwbifqSdsPxcgBlfjPsnqk10Jo2IGeoW4hi+Ih
         D4Lg==
X-Gm-Message-State: AOJu0Ywc+HvhEb/CXVQsdWzgn70yFFi2o209QH0wEmFYTPfJgXVvaV8X
        DuWbGla0L5328ZZznvshHNH+7ecPm39BtQ==
X-Google-Smtp-Source: AGHT+IF239EKCsD002yLOVEG0ZDBK9eReb2LpXMCWSV0k3fyn49qURFrQhKuZNxxAIc6N51gNXyM4g==
X-Received: by 2002:a17:903:50d:b0:1ca:dee1:4d1a with SMTP id jn13-20020a170903050d00b001cadee14d1amr2030846plb.25.1700307958228;
        Sat, 18 Nov 2023 03:45:58 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x11-20020a1709028ecb00b001cc51680695sm2842304plo.259.2023.11.18.03.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 03:45:57 -0800 (PST)
Message-ID: <06648cde-e8d9-42d0-a8ef-15c9a9b8850a@gmail.com>
Date:   Sat, 18 Nov 2023 18:45:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: Fix indentation and some other warnings
Content-Language: en-US
To:     Charalampos Mitrodimas <charmitro@posteo.net>,
        Sebastian Reichel <sre@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        qinyu <qinyu32@huawei.com>, Nick Alcock <nick.alcock@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Ian Molton <spyro@f2s.com>,
        Szabolcs Gyurko <szabolcs.gyurko@tlt.hu>,
        Anton Vorontsov <cbou@mail.ru>
Cc:     Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231117230658.65809-1-charmitro@posteo.net>
 <ZVf48PWBpvKULeXT@archie.me> <CX1VDFVCGNKO.3JX5QY0LZQ51B@beast>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CX1VDFVCGNKO.3JX5QY0LZQ51B@beast>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/23 17:36, Charalampos Mitrodimas wrote:
> Hi Bagas,
> 
> On Sat Nov 18, 2023 at 1:36 AM EET, Bagas Sanjaya wrote:
>> On Fri, Nov 17, 2023 at 11:06:58PM +0000, Charalampos Mitrodimas wrote:
>>> These were mentioned by checkpatch:
>>> 	Errors:
>>> 		(1) code indent should use tabs where possible
>>> 		(2) switch and case should be at the same indent
>>> 	Warnings:
>>> 		(1) quoted string split across lines
>>> 		(2) Missing a blank line after declarations
>>>
>>> Based on this comment from "include/linux/module.h", modules with
>>> multiple authors should use multiple MODULE_AUTHOR() statements.
>>> 	/*
>>> 	 * Author(s), use "Name <email>" or just "Name", for multiple
>>> 	 * authors use multiple MODULE_AUTHOR() statements/lines.
>>> 	 */
>>> 	#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)
>>
>> Shouldn't MODULE_AUTHOR fix be separate patch?
> 
> Sorry, I should have mentioned in the commit that the warnings "quoted
> string split across lines" pertained to the MODULE_AUTHOR line. 
> 
> In the commit message I'm just clarifying why I used multiple
> MODULE_AUTHOR statements.
> 
> Should I send a v2 patch with a revised commit description?
> 

OK but as separate patch.

-- 
An old man doll... just what I always wanted! - Clara

