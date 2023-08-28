Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AA78AA87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjH1KXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjH1KWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:22:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2539132;
        Mon, 28 Aug 2023 03:22:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-565dc391be3so2714441a12.0;
        Mon, 28 Aug 2023 03:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693218157; x=1693822957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEaJWeBAVOoawr4c33mkvjoKOidJHOfAi0d6D3J7utQ=;
        b=nVU2W7l+NmxVDoUJL2WyJAGvhjit71AAHto0Hp6vd4G3o3tDeOnth7/rtm5+CafRBa
         FU3U4IbbtzjJjCAYNdlUnXH6Qj8Qep/bUf4KvB0lelGn7Mfoj68ULuvWwLzorZaYugdH
         zo6JmPxza0/p/K9y1/utstUzy9tLotzQs7+IHqzYSsqSykziMqaf9bYzdXqg533TtDlC
         zhUj7pc0ctVglVDy0VkYTk0Wwj3+F93yg8qP7HSKuF/uQhioRSMTd6PrqucIn8ItdWI4
         tuiDwcLZx1zFttMJHGWhTcB3L9v+mmWkzdByUKdjDjU287NRKzWpPd2bOJCtao/ZANpT
         lu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693218157; x=1693822957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEaJWeBAVOoawr4c33mkvjoKOidJHOfAi0d6D3J7utQ=;
        b=Y4fokYsNw8yefM9v/04vYp/ykLCKnUl8IwJEXFVsEsuOhR7Egd73iDji9JIdbufG6S
         l3f9qBzOWLkFcmtgCp1mOgfp85A2PxXC2Bq3qWvcBaa2WgVck37EbSTxV3u4VUi7xt8e
         wYL1hucjbUQXAFOon16c9cy72lunDeFWKhMiWCDlOpQy0+fF8CVgoHE3iDh6zX3W9cCv
         h44AMNALJxm5sA2/OxWRGmGpuG3ipt9eTsaT8wpjrOPjJoFSn2KOmguYlcJTs0xqfN3j
         t8PK4IyP6TSHM7eXxeIpjulnxRooPTfPhUN8C73z+V4ynrvJXUlprZehSgUmTlCcaHGw
         p2Zw==
X-Gm-Message-State: AOJu0Yx7MqAH+7nJUwGSOOvY8PbrDfcEFdR11EeLyQMFbNws09FnFHWu
        QVv/WzAfDf8MlYs+R8pxVaGSgwjP4acyMhb4FKY=
X-Google-Smtp-Source: AGHT+IHunRJ8SKrwJgaP+51V2JJrecdxsMCTtZgn0eMB70U7pUC9syasL7KOaWROh+wvS8qj56tjawwSSP8Jbu9b7DA=
X-Received: by 2002:a17:90a:2a48:b0:269:68e7:bbb9 with SMTP id
 d8-20020a17090a2a4800b0026968e7bbb9mr38051213pjg.23.1693218157096; Mon, 28
 Aug 2023 03:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230828071829.64366-1-anshulusr@gmail.com> <2023082827-craftily-citric-06fa@gregkh>
 <CAPwwkU7+zHo2jpt+ovJDE1ca=K8AKyowyA5Z9pOFAy6iifVEwA@mail.gmail.com> <2023082801-cost-radiance-95fa@gregkh>
In-Reply-To: <2023082801-cost-radiance-95fa@gregkh>
From:   Anshul <anshulusr@gmail.com>
Date:   Mon, 28 Aug 2023 15:52:29 +0530
Message-ID: <CAPwwkU77=FvjtEFM9gzoMRLdporY8F7y1zXNky1Rj4cL0UpXHQ@mail.gmail.com>
Subject: Re: [PATCH] fixed formatting issues
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why are you changing coding style issues in this portion of the kernel?
> Do you have this hardware to test with?

I was exploring the source code and noticed a few discrepancies in the
coding style and followed to run `scripts/checkpatch.pl`.

> Normally coding style cleanups like this are only allowed in the
> drivers/staging/* portion of the kernel.  Unless you get approval from
> the maintainer of the subsystem you are changing, I wouldn't work on
> this as it's generally considered bad form.

I was not aware of that. I apologise in case my actions caused any
undue inconveniences, that was never my intention.

> Your name is only 1 word?
Yes, my legal name doesn't have a last name. I could change my From:
or Signed-off-by: lines to have "Anshul A" or add my informal last name
if that aligns better with kernel standards.

I appreciate your feedback and apologise for any problems caused,

Anshul
