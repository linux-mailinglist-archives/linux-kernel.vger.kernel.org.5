Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCE480D061
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbjLKP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbjLKPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:25:55 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E058DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:26:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b37a2e6314so38891839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702308361; x=1702913161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWtKtTooqeMpDlc+Wc3HJYi5rKqwcyveIaHTGZLWo2U=;
        b=XFxSacEyEU+cbO83aAJvjVOzJAsROTU2XSWLOSGR5gkHLsK0G/buhg56XMCnSk9jZj
         StW6CIIhcdS8IfnQKnEHgoV70wTMY2MLR7AruqpHYfApYgBMPx7unmmIZ/NSSV5JwnCZ
         CuZdmsCohENY95aYkbSrCrUfGnQ7t7W61MNks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308361; x=1702913161;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWtKtTooqeMpDlc+Wc3HJYi5rKqwcyveIaHTGZLWo2U=;
        b=ioF949Q3/ZW4SvSomxZif9BFqn3lpwQ2DGpwUYYJBRoiqffsgvEQEgWNS8tVuDNEK2
         NH41KDgUdAFzGDhx0wbxTOOyHuF9w7ZyxbJrC0+GEp7psMdFlBe40Zi7/21h0oPcp+Ki
         5KffeAHdfU6z7EteGKAzNXqRw6E87YRS/41YR4450vBICztq+m0DyYotdt0t8r4zwqSr
         XalY/+u+bQnLvoURqrg7dz9P2YlVkUL/NOa/hGj9Y9qKINDOP2ya5ZDFMzI6kSrzqdnH
         66iI0sQygWETG3zzcxni0BLvsB7F0f57x1HZkisUh4gel+XUOvxLy9PS6a3qYkvs2SoG
         Fe4Q==
X-Gm-Message-State: AOJu0YwlkyxcJTH8gLjfa0vVrKqfqzlJbSon0jZmOz/QIgL5D+hSUTzn
        BTvrgPMB220XK57zCixbxt8z2BpJzMG5l+CwgC8=
X-Google-Smtp-Source: AGHT+IHW7KNcOy+/8TEDvy5RCulLog3Lb8Xoxe4XFuF1Q+qTDBiwC0dSIhJ5gsCVTD0aDgfFqc/pJw==
X-Received: by 2002:a6b:a0d:0:b0:7b6:f0b4:92aa with SMTP id z13-20020a6b0a0d000000b007b6f0b492aamr7424859ioi.0.1702308361347;
        Mon, 11 Dec 2023 07:26:01 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g17-20020a02c551000000b004647af59c3dsm1962328jaj.16.2023.12.11.07.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:26:00 -0800 (PST)
Message-ID: <3e0ea1fb-e16d-4a63-9991-fde6a146f07d@linuxfoundation.org>
Date:   Mon, 11 Dec 2023 08:26:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes for 6.8
To:     paulmck@kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, WillyTarreauw@lwt.eu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <4208adae-d185-44a6-a564-ec9bc4c6eb2a@t-8ch.de>
 <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <25a20ebe-e5af-4ba7-890a-6a9ab121e184@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 17:02, Paul E. McKenney wrote:
> On Fri, Dec 08, 2023 at 06:09:59PM +0100, Thomas Weißschuh wrote:
>> Hi Paul,
>>
>> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
>>
>>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git/ next
>>
>> for you to fetch changes up to b99c3b15310e7c7cd5f2d843289fe115ab3f8043:
>>
>>    selftests/nolibc: disable coredump via setrlimit (2023-11-26 11:39:52 +0100)
> 
> Thank you!
> 
> I pulled this in and got the following:
> 
> make run:
> 162 test(s): 162 passed,   0 skipped,   0 failed => status: success
> 
> make run-user:
> 162 test(s): 160 passed,   2 skipped,   0 failed => status: warning
> 
> This looks like complete success to me, but please let me know if this
> is not expected behavior on an x86-64 laptop.
> 

Paul,

This is my turn to send the pull request. Would you like
me to take care of it?

thanks,
-- Shuah

