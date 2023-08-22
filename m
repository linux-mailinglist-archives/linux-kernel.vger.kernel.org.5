Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0E783BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjHVIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHVIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:21:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF2193;
        Tue, 22 Aug 2023 01:21:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bf7423ef3eso12925055ad.3;
        Tue, 22 Aug 2023 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692692487; x=1693297287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uI5wJ9ct8HbAPvV5fuCcTfn2AV2BtXUESKYHqH+gEZw=;
        b=dmmVzhodRiHBaiBk2cTWwNeLD5MFk3SlNyeOdRVp3rZLKMfD3iSVt1Z6Du4MoEAu3C
         VJRu+oVvutrc4I7CGNZZZPshYchrQO4wmwV7Y3suUfneMzz8yD1QkqG1lI5b++7A7aa+
         orSuAMiMZyqXA+lQN97vF1/nTbmZ+5BDyC+LJ7Nvcd98oZCs6xmsoJmX/eIFZYP2jNLG
         dKPM7tFQ7cJwC09BldNmZYtjNIch3mStTE313G3Keq55TIq+GYAcp1DUIYU0c0Evb0K0
         vCFOYBZWYTnQdh+EYHzUVnUVIu7dcUwZRts1P1r45drWpWDNjQxyoo0WL2xDG0TG/BiK
         X+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692692487; x=1693297287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uI5wJ9ct8HbAPvV5fuCcTfn2AV2BtXUESKYHqH+gEZw=;
        b=ODv1ZdLFqDlZxHqD7TQupFAUhzM//KPJ4sw7UzOHAgTyUq8cvzdd2REdA9IDBj4/wQ
         lG8PRFKR/OGY981faVj30xG4AAKOsenn091hGJojYImgA/0eICjQs/jiQQlVXa3MdzoW
         B6IV3Rp4f3GuwFHtKYBZ6PSTYpBbOZ1lsp7DaAgWu0CXbzFQPbHOhL84Kx9hO+v7jfGw
         /cGeCnmdys9LZU9Peb8a5glDJlVXSKsAUpphY5wjK9fsrLDsjv6zbuQfLanqwdacAr5l
         Uq4O6Mrx/mM+0tgvU7k7pxZaYTp9dzHEA0QNfYCQl5RfQ9ASM0CEmdn8GVzr2QSupg3Q
         Qshg==
X-Gm-Message-State: AOJu0YwGDI6yIrg305CHOfTNb+4g0OjB1t4yjSEff1J5ylzsIsBUCwc6
        UUDbcL6vTkpiiV9l/oUBhGI=
X-Google-Smtp-Source: AGHT+IGkJqTPjxCrrWnjEwUbe4lmC/X6ykOLRTrv5yzolm6JCwBcEWYWVYQI6N7/AQ/ohx6Hz0hmcg==
X-Received: by 2002:a17:903:25d4:b0:1bc:2c83:f770 with SMTP id jc20-20020a17090325d400b001bc2c83f770mr6068989plb.45.1692692486623;
        Tue, 22 Aug 2023 01:21:26 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b001bbb8d5166bsm8358202pll.123.2023.08.22.01.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 01:21:26 -0700 (PDT)
Message-ID: <89c53213-cb9b-7a8c-bc9c-92cabfdbba4d@gmail.com>
Date:   Tue, 22 Aug 2023 15:21:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Fwd: Qualcomm NFA725A on T14s AMD Gen3: Bluetooth: hci0: Failed
 to send headers (or body or access otp area)
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        =?UTF-8?Q?Fran=c3=a7ois_Armand?= <fanf42@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ath11k <ath11k@lists.infradead.org>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <a669d2d5-fee8-5841-eb5f-b7d047d3cdb2@gmail.com>
 <87il99j8dh.fsf@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <87il99j8dh.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 12:02, Kalle Valo wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
>> Hi,
>>
>> I notice a bug report on Bugzilla [1]. Quoting from it:
>>
>>> Hello,
>>>
>>> (Sorry by advance if it's not the correct place to discuss that, but
>>> I tried other place like my distro kernel forum
>>> (https://bbs.archlinux.org/viewtopic.php?id=286929), interactive
>>> chat, etc and nobody was able to help).
>>>
>>> [1] == Short summary ==
>>>
>>> I have a lenovo T14S AMD Gen 3 with a *Qualcomm NFA725A* Wi-Fi card
>>> (which is actually reported by lspci as QCNFA765) and bluetooth
>>> never worked on it, failing to load the rampatch with "failed to
>>> send header" or "failed to send body" or "Failed to access otp area
>>> (-71)".
>>>
>>> Other people reports bluetooth as working
>>> (https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3)
>>> and a work friend has a T16 AMD gen1 which seems to have exactly the
>>> same chipset and work flowlessly. So perhaps it's an hardware issue,
>>> but I don't know how to qualify it if so.
>>>
>>> => How can this be further qualified/debuged/workarounded?
>>>
>>> Any help, even RTFM pointing to corresponding manuals would be very
>>> much appreciated.
> 
> This looks like a bluetooth bug so not related to ath11k (which is a
> Wi-Fi driver).
> 

Oops, I really can't guess which driver is the culprit in this case unless
the reporter also attaches lsmod output. To François: Can you show
lsmod list as requested?

Also Cc: bluetooth people.

-- 
An old man doll... just what I always wanted! - Clara

