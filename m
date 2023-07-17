Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB7756F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 23:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjGQVta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 17:49:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548A518B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:49:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso52590215e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 14:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689630566; x=1692222566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s5RHrxe/LLr7IzhCXWm3zW0+C9QhocWfQDIT9MrfxP8=;
        b=qHEZqCKoduJMEGDHhyxcR5PtvjxSF6gCDDzc9uHPvf4fyu42veNWNgYVQule9MIhTB
         wxzr+LKrJph+hwQ9ugMedPPKXf682XdfgJiaIVrnBfkwvRr64JGkKPEScyeBqMSiPMxC
         NtPwEnMeECc56NirL7BaPeK5PWU0ckDpd/vcNomXxxB/DcoCCZEqMesY66WxFwc9cGcJ
         9X/cD9VOdYdhxzAGCZ66blyg24yyDz5NYccKn12sJ76viTL+Y52bGs9nkUXtHeE3HPKG
         1FxOIP1D9NluYKbz0oAcQjZ2Pfg9RdQ+myKD0q6Vz9PkSnFr6asBiyl99upBDcgXR4aS
         RwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689630566; x=1692222566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5RHrxe/LLr7IzhCXWm3zW0+C9QhocWfQDIT9MrfxP8=;
        b=IDMk5tv6IVTyQVvsxgdt/Prx0a6hOan/tlJ/aPaLcC6lgyIPOTo0UOrrxnqIHIOqnf
         95pM1e72+7oPovnSnKHNH1P5NM+lywlr1aW7N8vrH34fbXr8gRZJT5JIPX+JgXxxRbhm
         KMzLyWGq5iYRdkK7Xtf/3SMvBYZTnPLUAKktjggIDCREnNIfaZ7qNtnZM/KRtuOhn9kb
         NLLtsvRTu4NIjjeCNMjtKXNk+yv4oaQ8G2mHBKAxVDG3NmJ8Nt8gj4KlDxNtuxavV27P
         nmnsf4HhFWKOihFUF6Z/R01nauFlFxzHhN4w/b4MmdoIQ/dQ/ms/neD38F7UOpJItQnC
         wqtA==
X-Gm-Message-State: ABy/qLaFFb4eOCFj4oLC99bZwHkczTn8Z4SCZNESo92ZFfUhnQZUJGvM
        ly7RE++9ccl+U34Wt7X2QPeWOw==
X-Google-Smtp-Source: APBJJlHfILnCwScHw8v2EouOMW6ybIoZr0OLSn7LSIPJ8xA0KUSMy5Jl+by2NFuy6yRCj/sEij80FA==
X-Received: by 2002:a5d:680c:0:b0:315:9676:c360 with SMTP id w12-20020a5d680c000000b003159676c360mr12250670wru.25.1689630565717;
        Mon, 17 Jul 2023 14:49:25 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d61c4000000b0031435731dfasm514115wrv.35.2023.07.17.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 14:49:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 22:49:23 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230717214923.hhypecamvpvb5uao@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <20230211172829.f2igueizqpwijjjz@airbuntu>
 <2a9ed73a-256c-4ace-6b26-e30ac69cbdbc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a9ed73a-256c-4ace-6b26-e30ac69cbdbc@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/23 12:50, Hongyan Xia wrote:
> Hi Qais,
> 
> On 2023-02-11 17:28, Qais Yousef wrote:
> > On 02/07/23 10:45, Vincent Guittot wrote:
> > > [...]
> > 
> > Isn't it better to go back to v1 form then? The inconsistent type paired with
> > the cast isn't getting too ugly for me :(
> > 
> > I don't think we can convert cpu_cap to long without having to do more work as
> > it is used with 'util'.
> 
> Sorry if I'm missing something obvious, but why can't we convert util to
> long? The only place I see which mixes with util is
> 
> 	lsub_positive(&cpu_cap, util);
> 
> but at this point both cpu_cap and util should have sane values (top bit not
> set) so doing clamped subtraction should just work fine?

I think all options are not very pretty. But the least evil is what Vincent
suggested to simply do the cast in this one place. Util is used in more places
and assumed to be unsigned long, so chances of unhappy accidents are higher and
I don't feel like auditing more code for correctness given we have a simple
straightforward alternative now :)


Thanks

--
Qais Yousef
