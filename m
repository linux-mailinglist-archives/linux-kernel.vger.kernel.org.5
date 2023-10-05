Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDCA7B9FA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjJEO03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjJEOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1719261A0;
        Thu,  5 Oct 2023 05:16:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso896033f8f.0;
        Thu, 05 Oct 2023 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696508167; x=1697112967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9RLPKw/fdVMOG2mqUZ1IRmtC3X+vMbGsjNsnzZlTRY=;
        b=UNBXdUeXgUzUFGA4y04IfXkfA79DH8CSlX+6NgwrUJxUUDXxJkLrN3QVXQzqxJpBvU
         q2ibQn46etLD/XUP4lol3pBO1+b2e1RGr1N9b8yxGgtObWGdZcOcLk5Zf4LMxstqaKy/
         qiuEGcdGfqWjqfiv4acmnISS0M//uzL+nIt2b1cxdJB0FjekP/Jd33rCgVExqnwOLgn0
         1GNgPkMcVFd9if2X6hkxqYWgYcd0Nlo2YueclaxCQMcfTs+97yVF4CV4Ib6M7GfyrBTl
         hciGk1ssg+yytJNBQ1GGxk+v/FKl0bwzXlZZERLpEwQtTKHe9ua16Iq2O0BMxfFzWSyY
         c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696508167; x=1697112967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9RLPKw/fdVMOG2mqUZ1IRmtC3X+vMbGsjNsnzZlTRY=;
        b=P0rMuOCVZvgDJgTlr0B+2/g7dcDlERUBs0NdSqJdHPK9D7F7kJOxwngk8D2RBlA2SY
         SaJ/Vhq5S+YpYf+24sdNPIhr5eBnBd004YccsP9eNsY4Bc+N+dj+/88pDnf4uZlkXIS3
         GX+H4pRrxEKBjxYY1+8nmxOkaQ9FMvazfPcWVhEuOclWm8cr2NHIR8Q/zKQSbgDHkXBx
         6EtfNTc3j3WK1XMZI88D3GLjx4rfGiRh957Aeotx5YKLH6gLv+RV/L4rP2QGgToZ0kc1
         dcBn6cWHXWDGXS3KWejJMjgrqsLcqgRDn+Kn2NO5vSIqGM8r1mcyFHHiiP8rFWcY9qw9
         sjsA==
X-Gm-Message-State: AOJu0YxObJZUhITJ5ZX1UBaxT5uwG6KHAVyrlxUJk8qh6OLbirE40hpJ
        9q7iCGNBq2oYru4rmrJB8HQ01SDRRK98k5jEhWs=
X-Google-Smtp-Source: AGHT+IGcFTOdc9DVt1jQkccvp+BluXK8jOFb5t5ML2mh2pR8qWoJvyzHS8RhH+58BfEtm4AwdF7uOM965BiKgfKDTRM=
X-Received: by 2002:adf:ec83:0:b0:323:3346:7d51 with SMTP id
 z3-20020adfec83000000b0032333467d51mr4462588wrn.18.1696508167002; Thu, 05 Oct
 2023 05:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com> <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 5 Oct 2023 20:15:55 +0800
Message-ID: <CAAo+4rU0jBCcUha97nwVBWW0jmFnrYMowMzEkY+ocdzd=1LiNQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does it mean that dev_queue_xmit() should be executed under BH?

Thanks,
Chengfeng
