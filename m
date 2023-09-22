Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEED07AB039
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjIVLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjIVLJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:09:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757EAAC;
        Fri, 22 Sep 2023 04:09:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1414809a12.2;
        Fri, 22 Sep 2023 04:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695380948; x=1695985748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdhW5ZmgkkMXcQqSV8OZhLWTgesihtREKwvty/DX1/A=;
        b=HEHyHp+Kzsqy9E9G9HTFG7zQOBSNoeBnRUFqlHMFjktxY/o0QrRgCitpxQTbYD4XqN
         ndu84qih6pa/mdmh7HnmuG3v/zMelpU0C3jnSo3coj9/vkJvI23QnY3k9udhLuWkmPWT
         1QturYOCkLSDvBtpgzWwWCXCN7td1alKZJPR82vTQyCls4nI5GYTsxQ1MqheWCcok48f
         u15C99xZV7VUUVMwaBce6y7v8fXqkJmITqt6K82UkWKZsvg5Tf21hWbdmM4h/EevqGv1
         BUxzkr0NhdciZGLAF5Y7fgiyT9sgsSqZ8boz7we74a09LfG+6uW4LPzQSIjg/nuuNQvG
         YpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695380948; x=1695985748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdhW5ZmgkkMXcQqSV8OZhLWTgesihtREKwvty/DX1/A=;
        b=PGSHIOCUqQWUlueOSnQL6ufU4i7madXHxQy/PGvdcaLlEJbgztQkg/3Jx8Lf/jyAMn
         Nso2LUH+PJsp74MFL6Rq6XzUeGDrkfpFHszAmhcbADC+NLZfviR8Nmiot59hR7XRcP/f
         mTbbFcTeeAcdmL8ezcHxrt3R+n2USjqb1Xjah5989zMTF87eNT3c6SkYOKwMFko1Cnp+
         2110JGc605fJBnqeDkC9W06j07MZhxKMEEyW+xIPuKoJWj0WqzHV1r7QFckNbmAXJ+w4
         OuNddt9459Ci1MFoUgRNFdFWHmfBMnajxLClnRbi+lca/ghZHIlekBm9J8eKqm+tkk8G
         G/PQ==
X-Gm-Message-State: AOJu0YxU/3cIVAB7pkTd1Uhd+FR2fISFwB3lJSZU59tJW5ozp5IFqC3H
        55A5UW97X9/n7kiUX/0UatA=
X-Google-Smtp-Source: AGHT+IF9FbMEYzQFU0lHgOYWASfkHSHMN0ogg0RkFd7Q9Toczyt8nskYuzVLw8/uzWQIAxMrHK/iFQ==
X-Received: by 2002:a05:6a21:81a9:b0:15d:c274:2eb1 with SMTP id pd41-20020a056a2181a900b0015dc2742eb1mr1017324pzb.10.1695380947827;
        Fri, 22 Sep 2023 04:09:07 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090a800100b00276b60aa43bsm4634734pjn.17.2023.09.22.04.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 04:09:07 -0700 (PDT)
Message-ID: <c0ea6ee9-92c2-4e9e-b896-d079b6150bbc@gmail.com>
Date:   Fri, 22 Sep 2023 18:09:00 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Martin Zaharinov <micron10@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        patchwork-bot+netdevbpf@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        kuba+netdrv@kernel.org, dsahern@gmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Wangyang Guo <wangyang.guo@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <A416E134-BFAA-45FE-9061-9545F6DCC246@gmail.com>
 <CANn89iKXxyAQG-N+mdhNA8H+LEf=OK+goMFxYCV6yU1BpE=Xvw@mail.gmail.com>
 <BB129799-E196-428C-909D-721670DD5E21@gmail.com> <ZQqOJOa_qTwz_k0V@debian.me>
 <94BC75CD-A34A-4FED-A2EA-C18A28512230@gmail.com>
 <CANn89iKvv7F9G8AbYTEu7wca_SDHEp4GVTOEWk7_Yq0KFJrWgw@mail.gmail.com>
 <CANn89iJCJhJ=RWqPGkdbPoXhoa1W9ovi0s1t4242vsz-1=0WLw@mail.gmail.com>
 <85F1F301-BECA-4210-A81F-12CAEEC85FD7@gmail.com>
 <be58d429-90d1-42ff-a36b-da318db6ee68@gmail.com>
 <6A98504D-DB99-42A5-A829-B81739822CB2@gmail.com> <ZQ0EtyRxjzQTrPNd@debian.me>
 <bab8164c-f74f-44fe-ac3e-c078d30ab1e4@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <bab8164c-f74f-44fe-ac3e-c078d30ab1e4@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 16:50, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 22.09.23 05:06, Bagas Sanjaya wrote:
>> [To Thorsten: I'm unsure if the reporter do the bisection and suddenly he found
>> the culprit commit. Should I add it to regzbot?
> 
> For now: no, things are too confusing and without knowing the culprit I
> guess nobody will look into this unless we are extremely lucky.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

