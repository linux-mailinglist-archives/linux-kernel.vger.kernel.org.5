Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B5675431C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236203AbjGNTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGNTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:15:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5B35AC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:15:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so21837425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689362135; x=1691954135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWpYs8CNOdGMvN7PUCKK7yk/Bn/GzPi3qlDukGM0svY=;
        b=u6PqySub/kl2NX7TsnMPUgsANCQef+gR/n+Nhu9kgZ21hTNFF+QyOkoQ+7bqrPZe+E
         UdkMBztk103Z31sNAKjHV6KrDcrynswJO7k3ORSB/DQhRFKAlb6qohsTScwFM0uHTJwd
         70+51BNdlcX1ExDblhdHUhVMApT6fVpjxauHF3xkSf+Cpnaim3AYc8Q7z0ni83fW7erv
         LjIKwOLvevXt/I+PVeReVV0TMhCbnEz9+kU0/CP1ZclewPwNX5kZzxxulJMxVF6+Sb2N
         8qXhi2DpmbpHi0HT1wLRgi82sfikmTqLoht0QdiFfQx4nbeAibmSfARYGtPbClXL7FGr
         vqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689362135; x=1691954135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWpYs8CNOdGMvN7PUCKK7yk/Bn/GzPi3qlDukGM0svY=;
        b=dflK5iJTlTv0OKe1f401/xqFh+sSIYirDaWsbRAF8udfp+0YWj3SeqWLXJI0hX9Qau
         8NmgB/TjK42s7bBsxmRCo7M0BhNJDhYSOsrIYz1Hu3KScZJAvFgmCkQPcj/EsHKYNae4
         4mf80W9VSdH0Cx6wmFEbhzm5r1nzE0oDFSAI/pfuzWtwbCyLJmlDi0buxJ9pGqf6CYTe
         Bt3WvZ6HXgrRxKPJXpMhtahjg7ABK5hOAfRMOFcZwXJEJZQnnADSm4mFbS95hnwz8uuc
         shu4m9FCXDMYVnc0t7bnuHbhTUVccodTSRSL8iSHGL8HhgSesMiP2y6byOrKnpMN/vPB
         mnNg==
X-Gm-Message-State: ABy/qLYosPBp5Jd0Hr8fkPx6VCQ/oZXIcfdoFm0V0g8sV0100kEmMGNU
        yNqTJqJE2rJPc8SIqFPNRzUM3rGVUe9jWMbhXqJu1A==
X-Google-Smtp-Source: APBJJlHX6dLj7c4mGTpQQffA8nPlc153rMil3AEv5RNyi1HYhhgbFITU/Tv7HZL6ycDAMJ2p0B6XqAyqBusI0MosC4I=
X-Received: by 2002:adf:e8d0:0:b0:313:e2e3:d431 with SMTP id
 k16-20020adfe8d0000000b00313e2e3d431mr3161529wrn.12.1689362135219; Fri, 14
 Jul 2023 12:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop> <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com> <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop> <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
 <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
In-Reply-To: <453bcbbd-94f4-46da-98f6-c9fa5f931231@paulmck-laptop>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Fri, 14 Jul 2023 12:15:23 -0700
Message-ID: <CAB=BE-TC0s++t_5H6NjVVcpNvvvubtUpJhRxPsqq2p3ZgaFo9A@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     paulmck@kernel.org
Cc:     Alan Huang <mmpgouride@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Sandeep, thoughts?
>
I prefer to modify erofs check and contain the fix there as erofs
cares about it and it's
least invasive. For contexts where erofs cannot tell for sure, it will
always schedule kworker
(like CONFIG_PREEMPT_COUNT=n).

I will also do measurements to see if erofs should continue to check
for context and
what are the benefits.

Thanks,
Sandeep.
>                                                         Thanx, Paul
>
