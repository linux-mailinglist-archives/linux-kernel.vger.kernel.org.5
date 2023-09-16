Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FA57A322E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbjIPT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239406AbjIPT1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:27:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4CD139
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:27:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40476ce8b2fso24807725e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694892431; x=1695497231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w7ve4STZCqGPr6S0Mqjp3qKSLpdP4D49x5sftmoEMc=;
        b=v85lGhEy2ArRZLjc+F6D+pdjW9CoZD1Jr7dle4CI0bJntvgkq9VCgVrzsaPa32XVFV
         VYsnvmgEJTIA45Mv5Z8xihiZ0F8P68JmoEVdnORH3bKjA+KpEsg4OcETKLkRFaDjanbI
         /d+9RNTgtcebjmY9SFoNzC61hy0/EsCA3Y8SeqvgBe9T/+TscGVifqjeUkB4AxiYO66o
         DGs04LVmzip5+hQeffHY8MPiPV1vBDG3M9XyN0EbD5VqyB9DTDDCyM+8CU/57ECvQywe
         nJd58lTmsYfZbdAWNkw0GKR4HoXXYCQcgKAQ+4O1T7fimuC02GMnfw0gO0rCSmiqC1Si
         BfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694892431; x=1695497231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w7ve4STZCqGPr6S0Mqjp3qKSLpdP4D49x5sftmoEMc=;
        b=u2ZSfBatkCWUAGmi/ibj6uPTiu1wwJgW9co6dGIoBgtroH8P5Rpr9lHBDCpABUpkps
         lzwR1hXoXt3qD4CdxQWa3u4kp57xdNkY+/8MIR9laqdpIpqI7j0S7+Kf5jzYc9mIBLj+
         UiMIB51OcnHRMA4T2kM04SzW/Mw1otdjZy8rvEn+J76fNMESPBHUABuRVbIVFHNS2l1D
         31MksMBEqpXiNjQxlNzuBTMhIF/DRUdpsfAbUPW5OHDvMUoubuFR9QSiuPP3k+3Q9vru
         E2M607yGy6aDzq7K8n42sobYc4xr6hg9u2SdvKUF19mruukHHtdgq8R426MQCJT7Q4bS
         hL2A==
X-Gm-Message-State: AOJu0YyWv54t+Q3x8QqpiMR/rS7FBog+g5MT3WSVi/Hl5PwhSsgrU/NS
        6woWCse1DX3w4uIlH16zFtfZhg==
X-Google-Smtp-Source: AGHT+IFck6LaYBLeQsmyagGhELi/K0Zj8ALsgDvIAK4Czo8s4jyeE2sRxkC0jkVTQdbvpPehYCKO5g==
X-Received: by 2002:a05:600c:3781:b0:401:b2c7:349b with SMTP id o1-20020a05600c378100b00401b2c7349bmr4098099wmr.7.1694892431002;
        Sat, 16 Sep 2023 12:27:11 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id l13-20020a7bc44d000000b00401c595fcc7sm10841915wmi.11.2023.09.16.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:27:10 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:27:09 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH v4 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230916192709.5s22femf73pccmu3@airbuntu>
References: <20230821224504.710576-1-qyousef@layalina.io>
 <20230821224504.710576-2-qyousef@layalina.io>
 <d5407fdf-8e49-1035-3188-f96248c96c44@arm.com>
 <20230826204156.5gznalle6qzwl7y3@airbuntu>
 <ZQKqsL0MCZCW3Rpi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQKqsL0MCZCW3Rpi@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/14/23 08:39, Ingo Molnar wrote:
> 
> * Qais Yousef <qyousef@layalina.io> wrote:
> 
> > > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > Thanks for the review!
> > 
> > I will wait for the maintainers to see if they would like a v5 to address 
> > the nitpicks or it's actually good enough and happy to pick this up. I 
> > think the commit messages explain the problem clear enough and doesn't 
> > warrant sending a new version. But happy to do so if there's insistence 
> > :-)
> 
> Yeah, please always do that: sensible review replies with actionable 
> feedback cause a semi-atomatic "mark this thread as read, there will be a 
> next version" reflexive action from maintainers, especially if a series is 
> in its 4th iteration already...

Apologies. I did realize that and intended to send a new version last weekend,
but failed to get to it. I hope to be able to do so today or tomorrow.


Thanks!

--
Qais Yousef
