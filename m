Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1DA800747
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377996AbjLAJjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378047AbjLAJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:38:59 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A79C12B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:39:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so16949265e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701423543; x=1702028343; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jC3/MuCtGjepod8Zkfcj95KcJ99A6m3gq/BQ2t/6ZL4=;
        b=iGyUHwETdWNYzY8Zfu300PY2PStD5FxNBr5dz/jjSUPRMRfDpONJiQp5/pKf/P4Glg
         4mWd8mcwZcZxajpqhnMOOjXc0YsMw3/tARKVBc38sDKkvX7DiE287rDs8hOZdcuaQ60R
         LlRqxzvz3LsbZGULZyreqYKthB+4SMCUktfFxLGRoBcNet5m/EyTveYfOrUxjPHkIdZH
         BKuJCFkZfVphA9crns/Xz0nqPk3RcPgmq8ir1N5SwWi7BdUIeJAocQFEc9rXnW/aLJid
         ITwzWg/M63zxN3DGqNcHCeB+HmeH5CVMXGnzCKJ2fPWuM8431j91c40BRWscmUUWykes
         SFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423543; x=1702028343;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC3/MuCtGjepod8Zkfcj95KcJ99A6m3gq/BQ2t/6ZL4=;
        b=Nr98n4Xza+CrC3zg/r7l4h55OpMaXen8yypZfwKvJdivckMQSF4vY3jY11R06GoEVo
         IBSEPFXM065TG4FRAeJq+0fsC6j6xIm7miLcBswA1tPOOR3t8pTGqIAE70X7ykA2pZnq
         j/JeYgQCiJUKV9hbIsvEslrsRDbxvmnvDnRXmI4dVolS9jZp31XOnaIsTlpzHXBHM2CH
         PsVNWjVYSLhe2ISlgHSRIthzx/56sPaxiVjL/DlPnLsUrQZ3oBVek/rUXYyhgLJGSlig
         hPGAxas771VmSt4lk4kpdRGaje5fyr4nZAoAzXI0dUjvokebZ65coGktirQGDkms4q7O
         8LEA==
X-Gm-Message-State: AOJu0Yyp4LMzRZdPbIf/mJe0IkgrHBSF/79w7kGKJjcUoQKmCto3ZvNC
        fY3qG1EzDeQNnk7NUN90P6ddRA==
X-Google-Smtp-Source: AGHT+IGGFG211CMQAO0FD6H20iz2R22iotO1esAB+JYQVA/jB2mqxb3nBclo8HnFNxnodjtaPjDieg==
X-Received: by 2002:a7b:cc82:0:b0:40b:5e22:97f with SMTP id p2-20020a7bcc82000000b0040b5e22097fmr369829wma.110.1701423543053;
        Fri, 01 Dec 2023 01:39:03 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id bd22-20020a05600c1f1600b004090798d29csm4877947wmb.15.2023.12.01.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:39:02 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Fri, 1 Dec 2023 10:39:01 +0100
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, ulf.hansson@linaro.org,
        CLoehle@hyperstone.com, adrian.hunter@intel.com,
        jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com,
        asuk4.q@gmail.com, yangyingliang@huawei.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <ZWmptatt60if9GBH@trax>
References: <20231201091034.936441-1-jorge@foundries.io>
 <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaMnphBxvqpmvNG_72O02Umny3qdxfyrKdA4BsDwZmtfg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/23 10:28:52, Linus Walleij wrote:
> Hi Jorge,
>
> thanks for your patch!
>
> On Fri, Dec 1, 2023 at 10:10 AM Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> > When RPMB was converted to a character device, it added support for
> > multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> > to a character device").
> >
> > One of the changes in this commit was transforming the variable
> > target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
> >
> > This inadvertedly regressed the validation check done in
> > mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
> >
> > This commit fixes that regression.
> >
> > Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
>
> My bug :/
> Shouldn't we also add Cc: stable@vger.kernel.org?

ack, will do.

>
>
> > +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         int ret = 0;
> >
> > -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> > +       if (part_type & mask == mask) {
>
> That looks complex, can't we just:
>
> if (part_type & EXT_CSD_PART_CONFIG_ACC_RPMB)?

I chose to mention the mask nature of the field for clarity - just in
case - but I'd much rather do your suggestion. So will do :)

>
> > +       const unsigned int mask = EXT_CSD_PART_CONFIG_ACC_RPMB;
> >         int ret = 0;
> >
> > -       if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
> > +       if (part_type & mask == mask) {
>
> Dito here.

yep

>
> Yours,
> Linus Walleij

thanks !
