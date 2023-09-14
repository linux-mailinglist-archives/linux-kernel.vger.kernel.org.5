Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3124579FC28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjINGjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjINGjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 02:39:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B06ECD8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:39:49 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401ec23be82so6215455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694673587; x=1695278387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vw1xAqxeSq4kl4jeb6G5DgHyu+jon40ahkBSIlI62DE=;
        b=VOGnwLsa5qkR1VwZc1i2Woe1Nge1yaatlCqx4V3FYdGtLam+/+G0xRsMjro83oQiZ6
         yAdcAFQvsRjz2lq/Gdts3HpVlAbsbk6BfbJpoXUbetgZbKBgROwSZMKHyli+d1k72IyA
         7PKzfTN3oi1n2p8wmVeowOigdGrneji05hp48CXiufVUhaX0YjU325yL2mMBH5cEzVwI
         pXeYAbZ3cJR1GgZwKol4f2WEqjPhnYfC3maW8osJ1vzYNcj4Yoa0KyR/sDQgi2BfjdiR
         qeJRSd/HZV6QYD5aGvWvCCfy1BTzDC20kcWJ/FHYqMIGAogRatamTMThYR0hEUqHpLRj
         wScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694673587; x=1695278387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw1xAqxeSq4kl4jeb6G5DgHyu+jon40ahkBSIlI62DE=;
        b=K6u6nGKiz77/2R8LfaDkHt4bDHTNaWu3kFn/49MKyKmzfAPFRA6MQxJmwhHWqXHR4C
         1eWMQYIrMkgA5pQvKU2ActsJbrAY1VEsH1j/iYH04m44DSLdizlDsxmqRuhhtGwv6i/P
         Dm7nLnSeFg5cbRf6zNRg8RD/VgCtj1ZXnwR/CO33hIKDvEMRFfPdRCp1NQpAM6sua5iw
         zEWrjrJvt3IdT38hU6RExR81VzS7LC1bL5uEm4YCs8pxbspnjJnDgPiYRm/2uSKVNN5h
         LDLxciKdJixncrN60dPI3PEamQ8FvlpJ2+Zgqzz7WbTkyLhizYQXZW2ASfgecoi7outF
         Kxjg==
X-Gm-Message-State: AOJu0YwLbDoWVQ7EJKiM2eP/GzSFAfXfvLgU1bnI3GbM+pr9t4SjXWDr
        oJASgYXkb1lWfxUBec78srg=
X-Google-Smtp-Source: AGHT+IEL/pZOjLIhGTpDNc/dM2JnFH9ddv4ez2DZz2UBgRU3SL8zcdWMfCo50q7zqhkrQgEJV1sIKw==
X-Received: by 2002:a7b:ce93:0:b0:401:daf2:2735 with SMTP id q19-20020a7bce93000000b00401daf22735mr3785020wmj.31.1694673587417;
        Wed, 13 Sep 2023 23:39:47 -0700 (PDT)
Received: from gmail.com (1F2EF048.nat.pool.telekom.hu. [31.46.240.72])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c220600b00402dbe0bbdcsm3884895wml.28.2023.09.13.23.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 23:39:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 14 Sep 2023 08:39:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qais Yousef <qyousef@layalina.io>
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
Message-ID: <ZQKqsL0MCZCW3Rpi@gmail.com>
References: <20230821224504.710576-1-qyousef@layalina.io>
 <20230821224504.710576-2-qyousef@layalina.io>
 <d5407fdf-8e49-1035-3188-f96248c96c44@arm.com>
 <20230826204156.5gznalle6qzwl7y3@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826204156.5gznalle6qzwl7y3@airbuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qais Yousef <qyousef@layalina.io> wrote:

> > Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Thanks for the review!
> 
> I will wait for the maintainers to see if they would like a v5 to address 
> the nitpicks or it's actually good enough and happy to pick this up. I 
> think the commit messages explain the problem clear enough and doesn't 
> warrant sending a new version. But happy to do so if there's insistence 
> :-)

Yeah, please always do that: sensible review replies with actionable 
feedback cause a semi-atomatic "mark this thread as read, there will be a 
next version" reflexive action from maintainers, especially if a series is 
in its 4th iteration already...

Thanks,

	Ingo
