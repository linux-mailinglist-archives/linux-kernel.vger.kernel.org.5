Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482957FAB33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjK0UTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjK0UTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:19:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963341BD;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cba45eeaf6so1280244b3a.1;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116352; x=1701721152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MJbv7/yM8IoZp5rE2NxjWnnGMEZpgKADKLpNiN2nLo=;
        b=hG2Zu5Xsa3LsAV5fEr6PDrEwSaXvQLPcDG3O+anLTeCLStbO9+igKgu0LHdwFbEyzB
         VMnOQwtgEKretAKvYrfCNdUchi5VP2s51Hxx/sgLmBfPYb0XFO2MMQMnTZLO0QIC+g2p
         iEMDK0xKylWsIQIbdZ9eGE02/zlo2yywdL5FbKJn51TY2GSCBktqjnX6uVc5IzyygbNP
         +Ht0UNp05J8MiIAhsN0oJxf9quBf892VwszD5Z+G60Mw/UR2KutdRSBRh0vMlwbPl6Kk
         K7lotIoNsC+SLzY9gx/KJ61xolIgThTeUamF3SWAjiBycAON5WOw7J/LMSNp7IdEN05y
         EDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116352; x=1701721152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MJbv7/yM8IoZp5rE2NxjWnnGMEZpgKADKLpNiN2nLo=;
        b=LPnqfJH6TyWNsl/2Nx8mR/tFj5cN1l3sLvnjHpk7bU8Nan7Fa0Hhqg75nsIYJDtQB6
         BsawsG9NmCgufwVCfMnn1PgNwkZo62/+7oOu35++AdiQ6hRezqv417peI4ePmXWG6Tci
         RuzCQCN0cjLbSpL/q7SGu/AP5jZTKhbP3ZdYHK8ag9y0+thvqiUrfn6TtQqcJ9a+Zp0E
         Wnwu/6z/cti/nLr8sw5eZ6ZuoBDsA65jBH/XJ5iOH2I95s0g8Pup4KVYTO17cQSG0yYv
         OiU9OaV2TSNtJAUY3kGkRjxluM8bb/WENaucr5RDNw3xvVrXfQl+Jrlpe09scKUwcXdD
         rhJw==
X-Gm-Message-State: AOJu0Yxog/MbTCakqSJQzbYUyoZB4i5no0eULfnHPXDP6D2AjGBH56Vr
        Ma+ppnaH0mXG3LRBQdSRx5k=
X-Google-Smtp-Source: AGHT+IGgAthcmJdLcAxnPF1mKTsZQwYQTddihmO/oR2hXQckOBKxsik/6r22n6oSt6f1b7tAAhta1g==
X-Received: by 2002:a05:6a00:3a19:b0:6cb:8347:c8b1 with SMTP id fj25-20020a056a003a1900b006cb8347c8b1mr16610584pfb.1.1701116352000;
        Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b006c341cf08f9sm7780689pfi.140.2023.11.27.12.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 12:19:10 -0800 (PST)
Message-ID: <af489962-705f-4a72-943d-ba3b46d64597@gmail.com>
Date:   Tue, 28 Nov 2023 01:49:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, qiuxu.zhuo@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
 <20231127171435.GCZWTOe+DQSy4kkuKO@fat_crate.local>
 <dfb5b4cd-935c-445b-aaa7-bcce962a143d@gmail.com>
 <20231127183941.GGZWTibScFM4lgbqkG@fat_crate.local>
 <95fc95c8-dac6-4137-a9cd-29f27da64e41@gmail.com>
 <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231127200519.GHZWT2f2x76hMLR91V@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 01:35, Borislav Petkov wrote:
> On Tue, Nov 28, 2023 at 12:23:54AM +0530, Abhinav Singh wrote:
>> Just to be correct this time, I need to put a reason why this needs to
>> be fixed, in the patch itself, right?
> 
> No, the commit message is perfectly fine for that.
> 

Okay, so I guess as of now there is no change needed, so I need not send 
a v2 patch, right?

Thank You,
Abhinav Singh
