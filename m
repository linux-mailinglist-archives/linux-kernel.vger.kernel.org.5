Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4779162C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352780AbjIDLX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIDLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:23:28 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C53E3;
        Mon,  4 Sep 2023 04:23:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso20015221fa.1;
        Mon, 04 Sep 2023 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693826603; x=1694431403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Liz9t2y8kMyac8WrHU0EbvT2SNGaI14ZySkV/W8tHOo=;
        b=JFgdyKOZWxsHIN5VfKUhogqYUYBhvIp08DH09uwit9Ke09JXkHjgYBp6CGTHrriTsy
         Duf9PkrhDvVpl/p0R9NBXCiLFrzCBudYjsrVYbBlSk6XjLXWg3iKXjcQuds0I/WlMJ48
         YjsnaJEpWDhXGyz7B5BJ15horcJDYSKYawyE7gWPV8eYIbMcPsbpfQhrsK/1ZytmSE1e
         by+XWdoyMF+GA+W3heXUYgoDBeDXLBO03EUHAwdG1B2Vp2PgdYCnkBZgFrdrs3FlwYQD
         niwABj4Hw3mppMLYR1LTIFp5PfguSfW1KGYIGs9Y0unRfpY05yPCHNrvWNF+ZFY3ZTJo
         NIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693826603; x=1694431403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Liz9t2y8kMyac8WrHU0EbvT2SNGaI14ZySkV/W8tHOo=;
        b=X/cXvVrG31vir5MB8aX3uAPwLid7kGuLtCVSFgxTLE3c/eav1Y48q8oFeYd1HNbwPH
         G+fPh16lcRfplWtP6GouU1hC7b5DkzXq1h4Ns6xebDxvwYSgPhKeyhggfEL8alr2mY+E
         bwLhWcmZuCIkzWxK7zld7XzWnka1Le8k+FwcFycNRKOKSdRcXja8xPcyXkqIqHQ6nkDX
         XmVq3AlC4PtQJLXPCH5cQE92PmBKMku3emrRZuKhAvg+WrTYizaDrQqm6oIfX+e3j1aT
         virCbcvP8dUhOKXbLgBvYc28oqeN2wwUlRteIYgfpUAMnarxPUO1bC/2hxJRlgN8DnAo
         bdhQ==
X-Gm-Message-State: AOJu0Yz96p9kI+CLVdd/Ol6dXTXVzbq9DRYrhWU9fe0P99oPD8kVZePp
        3Zjhpfp61mse3NFVDrsPZqI=
X-Google-Smtp-Source: AGHT+IGz6u/80HiJAHtUXSIYqaI6QzU9P/sYCWl5cB7NCsiUJMXTwclIa4re1KmwRi18FBaWaw09gw==
X-Received: by 2002:a2e:9646:0:b0:2bc:e856:6208 with SMTP id z6-20020a2e9646000000b002bce8566208mr6577764ljh.33.1693826602799;
        Mon, 04 Sep 2023 04:23:22 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id a30-20020a05651c211e00b002b9ead74535sm2065747ljq.15.2023.09.04.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 04:23:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 13:23:20 +0200
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     paulmck@kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZPW+KJCIAvFzZHl8@pc636>
References: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
 <bbbb0bdf-553e-4fde-90d6-446e920b357e@paulmck-laptop>
 <CA+FbhJOSfqcb3=ecL-y=13j81b1Ts13wHpzBSURyCRQUvd2NWQ@mail.gmail.com>
 <c054b588-b029-4380-9ec5-4ae50ee37d08@paulmck-laptop>
 <CA+FbhJO1FbOvP=GmUse-r8Yma1tSv6iqppDhz9Ut1JKpjN49qQ@mail.gmail.com>
 <CA+FbhJPOkV4Xa7ZJ4QF2y_-5i24F+TkhByr=LzMPt9iy9EshSQ@mail.gmail.com>
 <4009a6e0-198c-4f25-8e34-4774dcd8c537@paulmck-laptop>
 <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
 <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
 <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+FbhJPtmFG2vKNXWr67Tuh-4HUi8n81PmKxwftv9iK1a3On-A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Marcus.

> 
>     Apologies.
> 
>     I want you to follow the advice I gave you in my earlier email, the one
>     with Message-ID c054b588-b029-4380-9ec5-4ae50ee37d08@paulmck-laptop.
>     I would give you a URL, but you seem to have dropped the public email
>     lists.  I have added them back.
> 
> 
> Sorry, I've overlooked that previous mail. I've now tried CONFIG_RCU_LAZY=n and
> also reduced the amount of extra-patches and extra-flags to a bare minimum. It
> didn't help though. The slow boot is still there and shutdown/reboot also
> didn't seem to work again (while the trace went away by overwriting /kernel/rcu
> /tree.c with the file from 6.4.14). I am also not subscribed to the LKML, so my
> E-Mails won't reach the list anyway. Unfortunately Zhang Qiang doesn't seem to
> work for Intel any longer as my previous mail did not reach him either. I hope
> the reported issues will be fixed eventually, I'll stay away from 6.5 for some
> time.
> 
Could you please clarify some items:

1.
<snip>
if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
	debug_rcu_bhead_unqueue(bnode);
	rcu_lock_acquire(&rcu_callback_map);
<snip>

Do you see this warning? I mean the one that is in the if()?

2. Please provide a full .config file.
3. Could you please also to be more specific how to reproduce a boot delay and the warning you see?
4. Please provide your full dmesg.

Thank you in advance!

--
Uladzislau Rezki
