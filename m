Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFAF752DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbjGMXI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGMXIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:08:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26117B7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:08:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313f1085ac2so1374253f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689289721; x=1691881721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7MIq8bTzHJaUBMG7MB1mjwVxSlLGLbSF+iBBc0I9Blo=;
        b=GmGWN0bFc/PuVur7Q3f0M7RB/m2bVuZ/rjjDnClPiEHktBfSiDlNMY0qUGFdXlmqbD
         +kn+ROYAjwpRPL/TF1HntuFpaXzJMSHEJqWKZiULfXvUFbsIBj34i3AC6SwCoAmbm2MN
         jnGjQv4MTyLFByIC0XtbCGR0TNjfVBmXQFXpel9qRRXaQyj0fUojIye3Th8aPTHjr4MY
         fFjNTzULgGP00gMxv8B7W6WNa8+hj29Wh3lpfQM5V5aO/GTAESEa5Lp7v6jyfeGse339
         G7DGlkPHcjog6PrMcMGg0H7+d0gxOMShEsgDWoAJ5ooPEavrn1Nqxc1oIBcGKYrZKQCm
         CFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689289721; x=1691881721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MIq8bTzHJaUBMG7MB1mjwVxSlLGLbSF+iBBc0I9Blo=;
        b=OvIIUvYvyIf36TSyXuCyRDXMtJsqsY8QmSSDhQbQ7pIK197PfNMUNjpX+E1cAygjT6
         udu/BipTsQ0sTD98ShMVBCc+s/Egzgaktq3+SCeAjc+bgD4AOniSXy1oJYOtiXCrDzS/
         MmWuE4xT6Mc2SkOIeUpHJVltV7FNbOur13SgBd4GAbjQsa9840SF1biORXqg+up1Bwp3
         ZKE8PmVXVq94R5Nj+nBxBDxECFI2eh3I7qoieabwFwyIiZPRBvRpTMJEcZkAExB/jE8u
         QmBGkXSylud6fExMyOSbVq5TsD8boLlpznYc5MJkwS+Zs8XY61rLcHYKpdjF6xCUZPyi
         Ysvw==
X-Gm-Message-State: ABy/qLYobr7iLciuG880GD1N9bFVg1so9gW16lEQTXZfLT1/h0UR0QS1
        X6Dor3VtDle5x4WdmCCLxb+TTQUoUU1SzBAA5rUHrQ==
X-Google-Smtp-Source: APBJJlEXzrAclXWVxYwGAmtlIpk6nS9KAbCBTtui9wvHi9uUzxWq0odQGTMSmxgCGTjogJzTvdm61WONNB0CrmpkFeo=
X-Received: by 2002:adf:ff8c:0:b0:313:eadf:b827 with SMTP id
 j12-20020adfff8c000000b00313eadfb827mr2503418wrr.56.1689289721521; Thu, 13
 Jul 2023 16:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop> <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com> <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop> <CAB=BE-QSaRKvVQg28wu6zVoO9RwiHZgXJzUaEMdbtpieVLmT8A@mail.gmail.com>
 <39923da8-16a1-43a8-99f1-5e13508e4ee4@paulmck-laptop> <CAB=BE-QNFhOD=xe09hiZOLmDN7XQxnaxyMz1X=4EeU7SFKaRKA@mail.gmail.com>
 <32b8c9d5-37da-4508-b524-fc0fd326c432@paulmck-laptop>
In-Reply-To: <32b8c9d5-37da-4508-b524-fc0fd326c432@paulmck-laptop>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Thu, 13 Jul 2023 16:08:29 -0700
Message-ID: <CAB=BE-SwUTDkVvd5s3-NjEzBTqoZnHFdZg0OU-YVK+h3rxnEuw@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Sorry, but the current lockdep-support functions need to stay focused
> on lockdep.  They are not set up for general use, as we already saw
> with rcu_is_watching().
>
Ok, understood.

> If you get a z_erofs_wq_needed() (or whatever) upstream, and if it turns
> out that there is an RCU-specific portion that has clean semantics,
> then I would be willing to look at pulling that portion into RCU.
> Note "look at" as opposed to "unconditionally agree to".  ;-)
> > > I have no official opinion myself, but there are quite a few people
> > ...
> >
> > Regarding erofs trying to detect this, I understand few people can
> > have different
> > opinions. Not scheduling a thread while being in a thread context itself
> > is reasonable in my opinion which also has shown performance gains.
>
> You still haven't quantified the performance gains.  Presumably they
> are most compelling with large numbers of small buffers to be decrypted.
>

Maybe you missed one of the replies. Link [1] shows the scheduling overhead
for kworker vs high pri kthread. I think we can all see that there is non-zero
cost associated with always scheduling vs inline decompression.

> But why not just make a z_erofs_wq_needed() or similar in your own
> code, and push it upstream?  If the performance gains really are so
> compelling, one would hope that some sort of reasonable arrangement
> could be arrived at.
>
Yes, we will incorporate additional checks in erofs.

Thanks,
Sandeep.

[1] https://lore.kernel.org/linux-erofs/20230208093322.75816-1-hsiangkao@linux.alibaba.com/
