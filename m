Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1514777A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHJOSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjHJOSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:18:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBC125;
        Thu, 10 Aug 2023 07:18:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso565752a91.0;
        Thu, 10 Aug 2023 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691677113; x=1692281913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ton7upj4EzEtC/CGoqmP056/FRqWJ9mTnKI+9e40N0=;
        b=GIWQhvnGaYPZU+xnO6aSJfNOCRLLSq5PfjzuP9TILvtPpIzXRYXFwG8NiX/2OkXNKH
         zJsit8J2dTgTI6MWKSiJJx5MaxKqo0mw+fPfkiAbDmz/sOKSICZmEmYjCyA6992qz/oP
         8J3AFz+q7IBSn2FXzmFK/1te+gufNAX4aGsnya/DFsml6paMUNpwt6XkECEfzaM4yh5A
         lu26j+JtAmWMLOOd/gFrR/7cd7PEGzgpIMZ51ZcZBafkB/2tz1gn6xohBkLfQ9vzUN2C
         kFCodbC/qxSJTKWTrg3Pr8HHKRB5yUJR1G04Psfrd55/A+62bpDlFxBXsCNVWMcV+ahM
         TOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691677113; x=1692281913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ton7upj4EzEtC/CGoqmP056/FRqWJ9mTnKI+9e40N0=;
        b=JTdPNIimeZHUWHG4GcWSW9m+ymQ74xWJ7q2C5hqr0vhRrEFQtasgERL2e6MrLcEfEq
         UzcGfL0A+an43lmfsLHlhl+7S0MeFtc7XP9mhg++lNN3CEPuU+jQ2+FYtkazuiL3ML6v
         02uBExUGqO/Jkf5g1AC0ZPOZG1Q27Yg+ERjkXa/FCDkQbFYAavAHdqwqkdKdBE7BL6Tz
         WjZNwobDuMsPsAj9VB8nKIf+Xpn5HEMBn4/tJjm3nhTrkMHUym0t4ODrSmMNRWK0LAum
         1cVVf9AvBe2Zaygk1U+Mjx7fbnkR/nsl2dOAKmrhmobRgfAF7ICKAUGKIUFvDnwQNn5q
         No/g==
X-Gm-Message-State: AOJu0YxUEefaVhp0wjXk+MpXFneUONOTfj9qn47+7PBaqWJcyv5NRgEh
        pE/o9Dq0jWnkZLJ6yQH+dR4=
X-Google-Smtp-Source: AGHT+IGSFVwzenWIyUpQ6JUC6obtbwujmz8qQ8dA/9VsWzrZJBbF+I3FTqNyNZiaDRB2r2hHbw5DPQ==
X-Received: by 2002:a17:90a:7609:b0:268:c569:f2af with SMTP id s9-20020a17090a760900b00268c569f2afmr1916988pjk.7.1691677113287;
        Thu, 10 Aug 2023 07:18:33 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id ji22-20020a170903325600b001b830d8bc40sm1822713plb.74.2023.08.10.07.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 07:18:32 -0700 (PDT)
Message-ID: <6bff248f-64ae-2512-ccbd-661ccdfe6542@gmail.com>
Date:   Thu, 10 Aug 2023 21:18:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: wireless: ralink: rt2x00: "foo* bar" should be "foo
 *bar"
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>, stf_xl@wp.pl,
        helmut.schaa@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_316424AFC531C5F050C0203FDBA08E84F907@qq.com>
 <18520fa625b8a901314c65bb8e557091@208suo.com>
 <36e36d94e81da4342283aac471fb5a7bd3eb9f65.camel@sipsolutions.net>
 <bed853f70773496902b5676e568922edbf487dfb.camel@sipsolutions.net>
 <ZNRHCBbvEPtq-cE7@debian.me>
 <5fcffcebca2ef9b8c276e5f4b4464d888649a70b.camel@sipsolutions.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <5fcffcebca2ef9b8c276e5f4b4464d888649a70b.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 13:53, Johannes Berg wrote:
> On Thu, 2023-08-10 at 09:10 +0700, Bagas Sanjaya wrote:
>>> And the email address doesn't even work, only about two weeks after you
>>> sent this patch?
>>>
>>>   hanyu001@208suo.com
>>>     host mx1.qiye.aliyun.com [47.246.146.58]
>>>     SMTP error from remote mail server after RCPT TO:<hanyu001@208suo.com>:
>>>     554 RCPT (hanyu001@208suo.com) dosn't exist
>>>
>>
>> No wonder why @208suo.com people ignore reviews from mailing list - their
>> addresses are send-only without real mailboxes...
>>
>> BTW, how can you get above error message? I'm curious.
> 
> That was just the error message I got back from my mail server,
> presumably now that you actually tried emailing them, you also got one.
> 

Ack, I also got above delivery failure notification, hence removing
Yu Han from address list.

> I'm beginning to think we should just block that whole domain until
> someone there is actually willing to _interact_, not just throw
> (garbage!) patches over the fence.
> 

Ack too! I'm leaning towards blocking for sanity of myself and
mailing lists. IMO, we should have done the same against @cdjrlc.com
addresses when they sent spelling fixes that are 50-50 correct but
they also ignored change-requested reviews.

Thanks!

-- 
An old man doll... just what I always wanted! - Clara

