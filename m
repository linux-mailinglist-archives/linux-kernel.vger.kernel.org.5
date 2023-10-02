Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038A77B5352
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjJBMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbjJBMfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:35:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFEAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:35:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso13752a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696250134; x=1696854934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=869N3vyS+ZVqQWUeBDSfQ2c9Aluwujb0eSJXyHR6CZo=;
        b=Ol/yd40cSac5ZaQVXI0ud0SZKWeHIT6vtlBXG33DRpbJzuuYhLOtuV/7+d/anrBdpu
         pSJpIC0WbaeJBMaakVizVc5n+6Gsqi72GTNbhunBHuUByLQpmkL/cARDPi4/jMfARQdi
         HYOhM3ZqzUHTNdoqSTzz5jcRent8/SjHBT0VDKTRR5TzMX3g3XdsdpZi4AZQI/hoIzix
         bCldQu8W4ar4oDFIJID3yh3Cp3J4hNwnX77ac9OV8gzwszbMHTMrwT4JKeaDgIBcTmpk
         +M2zbMghtwHZqUl6d64SVXPYhalXrh/t8B0XDqQVVcbDC4+ccmMAVMl5KnQtX2w8rx6Q
         npuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250134; x=1696854934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=869N3vyS+ZVqQWUeBDSfQ2c9Aluwujb0eSJXyHR6CZo=;
        b=oU061UngzXKc5eq6xRnBrV3I8WNJPB3DEnCrM2NyubERDAD3D24bK5bdPteXGDX5sq
         hMTCt7ntExfCqNg1PNW0cB4t71VMVtPUXrhODGH6nd9qyC3zB5H+on4eaR7twvNQtoEn
         AgDVYcGfKJ8M5qNVCHcxXxzU9AYBeGNz5VWWXK3jdQHeWDS8cROJ9PDc3iPfxFkcClkf
         6d5485jkDsgBnKe63T/H6fgWf7m2DQnFlzYvypP7Tpg+qwgS1tgBWPReCgP0ULBIE7mg
         JFU2T5aW5hJVVnb/ydfGXQPRJKrkiYmWt6NLUwNFQVEmyCRjK0HfKQG66CLQj9JKF8yV
         jVcw==
X-Gm-Message-State: AOJu0YzhQHyTXTMyPSx7VwryHLpLJl6DY4ZgNFdB4LTbkikBHExQGcS0
        mTvMcSZT2MiHXST5EFkmLVVfBvZW3RcVv960tcf//g==
X-Google-Smtp-Source: AGHT+IH2qkgyc3P3wrgTwRHmjGqihfZX/MS1d01+bMZCjuJ/E8bglfxeD1d64wEbHjO/Ut60Cr8v+8J4PFD889cPxno=
X-Received: by 2002:a50:c30f:0:b0:525:573c:643b with SMTP id
 a15-20020a50c30f000000b00525573c643bmr97048edb.7.1696250133829; Mon, 02 Oct
 2023 05:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230922111247.497-1-ansuelsmth@gmail.com> <CANn89iJtrpVQZbeAezd7S4p_yCRSFzcsBMgW+y9YhxOrCv463A@mail.gmail.com>
 <65181064.050a0220.7887c.c7ee@mx.google.com> <CANn89iJqkpRu8rd_M7HCzaZQV5P_XTCzbKe5DOwnJkTRDZWEWw@mail.gmail.com>
 <651ab7b8.050a0220.e15ed.9d6a@mx.google.com>
In-Reply-To: <651ab7b8.050a0220.e15ed.9d6a@mx.google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 2 Oct 2023 14:35:22 +0200
Message-ID: <CANn89iJqFC-Z3NZwT+CXEG7R9rc9g4LRwNm6Zm=nZKpD3Mon7Q@mail.gmail.com>
Subject: Re: [net-next PATCH 1/3] net: introduce napi_is_scheduled helper
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, Simon Horman <horms@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 2:29=E2=80=AFPM Christian Marangi <ansuelsmth@gmail.=
com> wrote:

> Ehhh the idea here was to reduce code duplication since the very same
> test will be done in stmmac. So I guess this code cleanup is a NACK and
> I have to duplicate the test in the stmmac driver.

I simply wanted to add a comment in front of this function/helper,
advising not using it unless absolutely needed.

Thus my question "In which context is it safe to call this helper ?"

As long as it was private with a driver, I did not mind.

But if made public in include/linux/netdevice.h, I would rather not
have to explain
to future users why it can be problematic.
