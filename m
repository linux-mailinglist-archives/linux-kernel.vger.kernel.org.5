Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E4791A45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353179AbjIDPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbjIDPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:06:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D98E6A;
        Mon,  4 Sep 2023 08:05:58 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so112346e87.0;
        Mon, 04 Sep 2023 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693839956; x=1694444756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+acTzGByTLofF9KOT2foqN1JjhesUR0PHzzKgg9AhiA=;
        b=Cw0XwXYrvyymSnmRSznBzi3KBKVFQ8cpPz6aNIhW1E8xziexeT0vjZ+VZ61ypQx4y4
         2LzFfUP0AdEDQq/hku1BPsu9lIPd8PJT1fiuepvma5jANemtsM4726OBgUl33yByQdXV
         qYPMC+K3QDGR/p1OzzHWwERjCGauZHjwBmJs5tku7kL5iPo78CdZ53FGRFzeJ3Q4aGra
         /5wZlnti95TYDOgzP4jgT6n2ROyXIYZdXvT5yYNkZ91Y4e01/tqmTvLFE2ldltPb7UBu
         9ahTzBNAFZeoV4h/IqBopi7HVS++y/mc/RbgUKVR7k8qVGef9kD7avkeBqcBSjtyL4gy
         z1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693839956; x=1694444756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+acTzGByTLofF9KOT2foqN1JjhesUR0PHzzKgg9AhiA=;
        b=W+PMyzGEEsHrtbR6F8hp3q6iXYebb3PTo+IHtxa7HPOEFO0Cv/JXY8ucAJ4VSYCvtn
         X0e3P0ySlZN61wmzxiuXrzZrr0mb9+VURp9OCduZjBCN2nsu+iu1b6aO18R1HnUUqqxX
         Y2u5AttVBeIIcjqzvcJtzI1r4GxqSHfoOHBAWq+Ww3B4ROT/ayPZu4schF/ZY3yBi8wk
         Vb3M/9PhigCoU7sSrgZKkGl8hiDWWzf/tt9s3NKG0aljIYskj4InDD8cMrY0W4jNNvTd
         aRA9lk6x3WBsFJx0rtbJLwIO8y8vKirVQ0X9PkOyON4xdFQ25hEYFVhCqgQRU86Zu9dL
         wz2w==
X-Gm-Message-State: AOJu0Ywm72SqG5DbQzK0w15dQI61eA92USh/JtOO2/mVOlUd0ah0v+u1
        fX1kgcOdZ+3U5LlvYkJQdlE=
X-Google-Smtp-Source: AGHT+IE1qMmDVcIiUewEPY+74JKOpupd3qUwZ3PpKYiCnMEmd/xY3dtMTFUw7seZlGt8TptDJSFvHw==
X-Received: by 2002:a05:6512:a92:b0:4f8:6831:fd70 with SMTP id m18-20020a0565120a9200b004f86831fd70mr3750538lfu.3.1693839956049;
        Mon, 04 Sep 2023 08:05:56 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id b25-20020a056512025900b004fbb69d8791sm1760362lfo.79.2023.09.04.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:05:55 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 17:05:53 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>, paulmck@kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPXyUTteVxXtqiEo@pc636>
References: <CA+FbhJOSfqcb3=ecL-y=13j81b1Ts13wHpzBSURyCRQUvd2NWQ@mail.gmail.com>
 <c054b588-b029-4380-9ec5-4ae50ee37d08@paulmck-laptop>
 <CA+FbhJO1FbOvP=GmUse-r8Yma1tSv6iqppDhz9Ut1JKpjN49qQ@mail.gmail.com>
 <CA+FbhJPOkV4Xa7ZJ4QF2y_-5i24F+TkhByr=LzMPt9iy9EshSQ@mail.gmail.com>
 <4009a6e0-198c-4f25-8e34-4774dcd8c537@paulmck-laptop>
 <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
 <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
 <ZPW+KJCIAvFzZHl8@pc636>
 <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FbhJPNZ-E3e7WBH_jAvi3Rn-2gV4TVk9S9qmheXkqXw+Sakg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     Could you please clarify some items:
> 
>     1.
>     <snip>
>     if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
>             debug_rcu_bhead_unqueue(bnode);
>             rcu_lock_acquire(&rcu_callback_map);
>     <snip>
> 
>     Do you see this warning? I mean the one that is in the if()?
> 
> 
> Hi! From my limited understanding, the warning points to that snippet: [  
>  7.108424] WARNING: CPU: 13 PID: 338 at kernel/rcu/tree.c:2952
> kvfree_rcu_bulk+0x13b/0x160
> 
OK. Since you have a compiled vmlinux. Just to be sure, could you please
perform below steps:

<snip>
urezki@pc638:~/data/raid0/coding/linux.git$ gdb ./vmlinux
GNU gdb (Debian 10.1-1.7) 10.1.90.20210103-git
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./vmlinux...
(gdb) l *kvfree_rcu_bulk+0x13b
<snip>

and post the output here?

>
> I also don't get that warning any longer in my experiments when overwriting /
> kernel/rcu/tree.c with the file from 6.4.14.
>  
The 6.4 does not have such warnings, therefore you do not see it :)

> 
>     2. Please provide a full .config file.
>     3. Could you please also to be more specific how to reproduce a boot delay
>     and the warning you see?
>     4. Please provide your full dmesg.
> 
> 
> The boot delay and warnings happen with both my self-compiled 6.5.1 and the
> CachyOS default Kernel 6.5.0-2. Reproducing is as simple as booting into that
> system and open up dmesg after the task bar eventually shows up (which takes 10
> - 20 seconds longer than normal). The warning goes away when overwriting /
> kernel/rcu/tree.c with the file from 6.4.14. But the slow boot, task bar and
> the shutdown/reboot problem remained. Journalctl signals some failures with
> powerdevil that do not happen with the older Kernel installed.
> 
Let's focus on your own self compiled kernel. As for the 6.5.1 kernel,
could you please point your SHA1 so i can take a vanilla kernel and base
my testing on exactly the same baseline?


> I've attached the files to this mail for convenience. 
> 
Appreciate and thank you for the help!

--
Uladzislau Rezki
