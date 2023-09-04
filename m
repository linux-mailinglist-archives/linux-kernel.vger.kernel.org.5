Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D322791BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbjIDQx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjIDQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:53:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE3CC5;
        Mon,  4 Sep 2023 09:53:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b974031aeaso27514361fa.0;
        Mon, 04 Sep 2023 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693846430; x=1694451230; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tabLz2qlILUUiJwdP7M/Z8VGI+/MqtB6WYxoDuen/JM=;
        b=Ad+FLJZpHtsZ7cx1/O906Vhfooe6C+u2qPQoARRuOKeCEBaesblScNweHaoPD2BCLg
         wtSBgAn5lMTtgQdZnqA87hcuhF9RuSKzUBqPyCRmLLUsJZJo07qusD92PJSHFReLhss4
         9N/wTe1c0Q2ccnWv7jFRApb4Cw27Xoj5Y68IbTuOp/JtJyppwTleWT+8K2rkk1/DUF8D
         S+GhKQ76X1mpn9oc+yrqkzUey9+z6e9MNMt+g7IV3YAO0Yc6NH9MlAuzVj362NjfGsRW
         RCB4HS/HpzIzplUTDxFOBdrUeV/XDldVmj1Cp6BfjfXZ78xhfRu3TheIFAopYEkCY8nG
         QF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693846430; x=1694451230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tabLz2qlILUUiJwdP7M/Z8VGI+/MqtB6WYxoDuen/JM=;
        b=B1Tm+32RAaGE4yW1ZO4X2FcL0bUhYxG/zdbDF6zjtYFbYRyfSe9HKR+Pf1Val/yuRY
         YBcjyaE9rqjNuMyvzIWfA8y7O2ABq78JIUHPKr8TYJcTOSn7BlaU4btmGY3JJpPvfuyk
         jBtwpcePZ5iaMT4aIH8iWl8GyA/plTPLFjNG+amMKXQsaXaRVAvSy+aIAFzwljbwvxGF
         Yzt1kJcy66KKgr46mnyrabligyoWRJu8tDPBUBOvb6Oh2ouN4HMV03qpssnvP/siYzU1
         r3EMKseb1vJhx2cy9ScEc0AwQ80J1fgmnlzeCGtNx88pLDP8ownn2nhXAgFZND75csfu
         achQ==
X-Gm-Message-State: AOJu0Yy9gyFu+p3YK4Mo5KeojHCH2n3ref4DCqpJh8mbStxK/1jxUA1x
        teZzuCxJhWviH0BHDbNqXbUX+/wT4T8=
X-Google-Smtp-Source: AGHT+IEpqtsasNYqPkHkwNrhu90q7GeSVQEOz4fGwqZM7IEzf6yH1Ym7bKtpe8LHoCY1IlaX7SW4sA==
X-Received: by 2002:a2e:740b:0:b0:2b6:d6e1:a191 with SMTP id p11-20020a2e740b000000b002b6d6e1a191mr6990277ljc.23.1693846429800;
        Mon, 04 Sep 2023 09:53:49 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id w15-20020a2e300f000000b002b6ce8b0dd6sm2250014ljw.75.2023.09.04.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 09:53:49 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 18:53:46 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPYLmm3ih7u95l1a@pc636>
References: <CA+FbhJO1FbOvP=GmUse-r8Yma1tSv6iqppDhz9Ut1JKpjN49qQ@mail.gmail.com>
 <CA+FbhJPOkV4Xa7ZJ4QF2y_-5i24F+TkhByr=LzMPt9iy9EshSQ@mail.gmail.com>
 <4009a6e0-198c-4f25-8e34-4774dcd8c537@paulmck-laptop>
 <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
 <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
 <ZPW+KJCIAvFzZHl8@pc636>
 <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
 <ZPXyUTteVxXtqiEo@pc636>
 <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FbhJMr6LzmOpVNkYyiSERAsNEqqvQwQ7SwJK=CmwvV9d2Z-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>     >     Could you please clarify some items:
>     >
>     >     1.
>     >     <snip>
>     >     if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap)))
>     {
>     >             debug_rcu_bhead_unqueue(bnode);
>     >             rcu_lock_acquire(&rcu_callback_map);
>     >     <snip>
>     >
>     >     Do you see this warning? I mean the one that is in the if()?
>     >
>     >
>     > Hi! From my limited understanding, the warning points to that snippet: [
>      
>     >  7.108424] WARNING: CPU: 13 PID: 338 at kernel/rcu/tree.c:2952
>     > kvfree_rcu_bulk+0x13b/0x160
>     >
>     OK. Since you have a compiled vmlinux. Just to be sure, could you please
>     perform below steps:
> 
>     <snip>
>     urezki@pc638:~/data/raid0/coding/linux.git$ gdb ./vmlinux
>     GNU gdb (Debian 10.1-1.7) 10.1.90.20210103-git
>     Copyright (C) 2021 Free Software Foundation, Inc.
>     License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/
>     gpl.html>
>     This is free software: you are free to change and redistribute it.
>     There is NO WARRANTY, to the extent permitted by law.
>     Type "show copying" and "show warranty" for details.
>     This GDB was configured as "x86_64-linux-gnu".
>     Type "show configuration" for configuration details.
>     For bug reporting instructions, please see:
>     <https://www.gnu.org/software/gdb/bugs/>.
>     Find the GDB manual and other documentation resources online at:
>         <http://www.gnu.org/software/gdb/documentation/>.
> 
>     For help, type "help".
>     Type "apropos word" to search for commands related to "word"...
>     Reading symbols from ./vmlinux...
>     (gdb) l *kvfree_rcu_bulk+0x13b
>     <snip>
> 
>     and post the output here?
> 
> 
> I guess that is with my self-compiled 6.5.1 installed, right? I might come back
> to this task with the asked data later, but as that machine is used in
> production for daily tasks this might take a couple of days.
> 
Yes, please.

> 
> I don't have an SHA1 but you can take the vanilla 6.5.1 kernel and apply all
> seven 0001-*.patch files from my repo that are available here: https://
> github.com/ms178/archpkgbuilds/tree/main/packages/linux-cachyos to get it into
> the same state.
>
Sounds good. I will try my best to reproduce it locally with set of
extra patches + your .config + 6.5.1 kernel.

Thank you for the help to debug it!

--
Uladzislau Rezki
