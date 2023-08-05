Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834387711A3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHETAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHETA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:00:29 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C7A128;
        Sat,  5 Aug 2023 12:00:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2b60731so19927935ad.2;
        Sat, 05 Aug 2023 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691262027; x=1691866827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5i+3GUOehI1kx9icGwBFn2H2FxOQ/JAgsfd8DRO3ekM=;
        b=FuKfTAejBPNyESnw/w1ERYDc1mKWNtVPBXxsV9WqJT4A9EqT98imtSOnOdnn+EKUZZ
         C+6UwHI5Qb8b6rNbWQjNE+e/ErPNW95/i/d7NMk7B8hymuNp4BcdCeVeMz0J6kKwO/bO
         80gNlrZaD2phyJ5VyelYKTQL7VEZSzrAOHs4N4B561flTLxPwVdTKoiuWmTw1zACIMuB
         3xesniE581tA8LxOiB3TDmoN1OQ4g5ZZHJjKnUTXe1j7wPL0XXjwTrq/0UpOGe6od9wE
         L4ahV7LP0aFR0ap9pquv1hfBkdsN+T2VgbcA/r6QaoSVGqUci7c/ObcHsBtC6iTM4LAk
         +/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691262027; x=1691866827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i+3GUOehI1kx9icGwBFn2H2FxOQ/JAgsfd8DRO3ekM=;
        b=OO4p1nlQ2UHHjGN7zTnE4JTdB7/GGSYHWJfB+WLStd+qzlMtloE9Ok9NAE+i1Zsv8T
         W2w52bPxwgSuDM52LnqUMMCmbRQiiGCuY0hnsrhk43OpzLxAuRwnzPnWmPFfTAskFE3j
         DQQoMZxYo87jZZZC3I00OGTlw+mVvJRzl2GgnDoqnGCKGs+Z6ACuwxkrCi4V4YD+XGoI
         7AcDXkgoe0tbtM0Y9xzLcbNWDhxE40NfKYOquyLuwkDO6OFTBGXFmyYP9Pp166OjtPDT
         sLRbk6xbfwHK/bROGVlJ9aHWyePwNgT1Qdftmz0DWIvFW+77sHtUZ3YytEJ9ch7WETYO
         mSCw==
X-Gm-Message-State: AOJu0Ywh19ooRDXzybXbeSPpYBKk/fpWU7C6KU6GjZOoPheSTejn3Y6S
        xZusbJjcsYMKD5KsHGDKK18=
X-Google-Smtp-Source: AGHT+IEdsQP1z4KFkNarF886E/9q/EQ15BmwF6o/5gDAFHiZchqSAJQSKz0AVuU7ELIXMFcsU7qRYg==
X-Received: by 2002:a17:903:2352:b0:1b8:b433:7fa with SMTP id c18-20020a170903235200b001b8b43307famr4323159plh.13.1691262027243;
        Sat, 05 Aug 2023 12:00:27 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.241.198])
        by smtp.gmail.com with ESMTPSA id kg14-20020a170903060e00b001b9ff5aa2e7sm3816215plb.239.2023.08.05.12.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 12:00:26 -0700 (PDT)
Message-ID: <9ff945e6-c963-41d2-9df2-542d83ada519@gmail.com>
Date:   Sun, 6 Aug 2023 00:30:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org, masahiroy@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com,
        linux-kbuild@vger.kernel.org
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
 <2023080434-verbose-value-1200@gregkh>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <2023080434-verbose-value-1200@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/23 19:36, Greg KH wrote:
> On Fri, Jun 23, 2023 at 08:23:58PM +0530, Shreenidhi Shedi wrote:
>> Currently Makefile.modinst does three tasks on each module built:
>> - Install modules
>> - Sign modules
>> - Compress modules
>>
>> All the above tasks happen from a single place.
>>
>> This patch divides this task further and uses a different makefile for
>> each task.
>> Signing module logic is completely refactored and everything happens
>> from a shell script now.
>>
>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
>> ---
>>   scripts/Makefile.compress |  53 ++++++++++++++++++
>>   scripts/Makefile.install  |  66 +++++++++++++++++++++++
>>   scripts/Makefile.modinst  | 111 +++-----------------------------------
>>   scripts/Makefile.sign     |  37 +++++++++++++
>>   scripts/signfile.sh       |  24 +++++++++
>>   5 files changed, 186 insertions(+), 105 deletions(-)
>>   create mode 100644 scripts/Makefile.compress
>>   create mode 100644 scripts/Makefile.install
>>   create mode 100644 scripts/Makefile.sign
>>   create mode 100755 scripts/signfile.sh
> 
> As you are touching the build process, you should always cc: the proper
> mailing list, and the KBUILD maintainer.  Please do so for this series,
> as that is the proper tree for this to go through.
> 
> thanks,
> 
> greg k-h

Thanks for the inputs Greg.

CC-ing linux-kbuild@vger.kernel.org as suggested.

-- 
Shedi

