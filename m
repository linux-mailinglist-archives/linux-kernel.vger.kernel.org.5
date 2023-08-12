Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487F8779BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 02:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjHLAhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 20:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjHLAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:37:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61830DB;
        Fri, 11 Aug 2023 17:37:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc7e65ea44so18026215ad.1;
        Fri, 11 Aug 2023 17:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691800639; x=1692405439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hnrRd/R02fQYg+94kLBuqcTRTMHc/nyXMwR+7vVJzE=;
        b=bXGME/VnAhZ8KAFRJqURgr58wU1UFxudSdq5RSyB5iFuLGY2RCW5j8LG70u/plcHDc
         HhM1Lg91jSSVx7BWyFfgj+I6FKkqbLrLcFoE40Wwmarh5kt0NDqaIzJ68hVnsp91RNqK
         zgHXuiRllWUpFCt5hlcNGCTYtv8Px96RyqPwCNmloPfwJ5FyBefdUDZB0WSxAYsWsBVl
         yaUI0wnL1iI2lFZH9afLc0PPZyx5yUFNBG30L74M6Wc2CI22UrNRPUEYdkCSdr3I0vSI
         BiaNZ11VTs1B7majBqq9zmjoTsQf8i/evvGP7eDkknKVTCDfJmgCHjptrd7Xyd4alAew
         uCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691800639; x=1692405439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hnrRd/R02fQYg+94kLBuqcTRTMHc/nyXMwR+7vVJzE=;
        b=YvbdGqhB9Ll+a6MYfug6oc03IrJUypM1PASzYOrS22yb0ZWSO7ucPHBu2hE2QEBpdw
         iRxw+Om+1BzdMZy3HyDsAtBqAOdvNleyGmUbQDlWCX/IaasN/WFOmRER/uJ60WGx6cjq
         KxzPtvucmtt2GebbmAqtZOYXIU1W9pI6z92NOxObz2vibMzx9d4v5/K5HyOoB3Cs+hoz
         Sp+SbIAdHvfCb2xbTgdoCe0fopUXeABwAmq+fiwnM6tNTjSz8N08NnzEu2JqGEwzytNI
         gUT6Sou74eqId2UxWnTLa4A18A3KdJ62uo6vUt1wvDedDbAFg7Dg/o+LnKFIa6DvO6gs
         viIA==
X-Gm-Message-State: AOJu0YxWJM/gJXAyFWDkb+PBGIYnJ+nc+NwbAY3c1Ok+/hCrPLNz72cX
        YE6HzGrIe7T4kmFKzCCms9g=
X-Google-Smtp-Source: AGHT+IF1l458p3X2DhORC8kVWhvjB7DIfvMMCpgVBoGyYkzNM8HIxzCMaa8FlTRqAwGGIEg4rv3duA==
X-Received: by 2002:a17:902:db10:b0:1bc:3908:14d with SMTP id m16-20020a170902db1000b001bc3908014dmr8638530plx.2.1691800639416;
        Fri, 11 Aug 2023 17:37:19 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902788300b001bbd8cf6b57sm4537164pll.230.2023.08.11.17.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:37:19 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        minhuadotchen@gmail.com, rdunlap@infradead.org, src.res@email.cn
Subject: Re: [PATCH 2/2] docs: sparse: convert TW sparse.txt into sparse.rst
Date:   Sat, 12 Aug 2023 08:37:15 +0800
Message-Id: <20230812003715.7551-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87a5uxxqf3.fsf@meer.lwn.net>
References: <87a5uxxqf3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

>> Follow Randy's advice [1] to move
>> Documentation/translations/zh_TW/dev-tools/sparse.txt
>> to
>> Documentation/translations/zh_TW/dev-tools/sparse.rst
>>
>> [1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@inf=
>radead.org/
>
>So the right way to do this would be to simply say something like
>"Convert sparse.txt to RST", then add a Suggested-by: tag to credit
>Randy.=20

Got it, I will submit v2 with this subject and add Suggested-by: tag
to credit Randy.

>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>> ---
>>  .../dev-tools/{sparse.txt =3D> sparse.rst}      | 31 ++++++-------------
>>  1 file changed, 10 insertions(+), 21 deletions(-)
>>  rename Documentation/translations/zh_TW/dev-tools/{sparse.txt =3D> spars=
>e.rst} (71%)
>
>You're not adding this new document to a toctree anywhere; that will add
>a warning and this file won't be a part of the docs build.

I will fix this in v2.

>> diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Docu=
>mentation/translations/zh_TW/dev-tools/sparse.rst
>> similarity index 71%
>> rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
>> rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
>> index 6d2d088b1060..2f632f6ce8e8 100644
>> --- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
>> +++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
>> @@ -1,33 +1,22 @@
>> -=EF=BB=BFChinese translated version of Documentation/dev-tools/sparse.rst
>> -
>> -If you have any comment or update to the content, please contact the
>> -original document maintainer directly.  However, if you have a problem
>> -communicating in English you can also ask the Chinese maintainer for
>> -help.  Contact the Chinese maintainer if this translation is outdated
>> -or if there is a problem with the translation.
>> +=EF=BB=BFCopyright 2004 Linus Torvalds
>> +Copyright 2004 Pavel Machek <pavel@ucw.cz>
>> +Copyright 2006 Bob Copeland <me@bobcopeland.com>
>>=20=20
>> -Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
>
>So you are removing a fair amount of text here, much of which I cannot
>read.  Why are you doing that?  In any case, that would appear to be a
>change that is independent of the format conversion, and should thus be
>in its own patch.

The text I removed is replaced by '.. include:: ../disclaimer-zh_TW.rst'.
I will keep the original text and change it in another change.

thanks,
Min-Hua

>
>Thanks,
>
>jon
>
