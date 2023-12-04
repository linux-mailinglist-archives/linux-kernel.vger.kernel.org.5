Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE895803238
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjLDMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjLDMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:12:17 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C13D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:12:23 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5d8d2b5d1b5so4512817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701691943; x=1702296743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YCGwGXRc8AWPbM6p5oU9fh3ewd5Eki7b3LIN2iWwphM=;
        b=dmE4a9yFjGI8pQ2+nlgpQFHPrYAnUi74fqeW7poNAqSSwRlAGTx71LdmEAk1GOmZdC
         9ERD6+esNKsBDcgajnHfmU2tg90Db0bbn2KZVvh78e3IlE+OtBYmB7PMATAdArLBmIIm
         MGb69z5C7iwFqlBS/pbAe5xfS9dcZM0bqfCaX8nprGiwQbZkSMyWaQ9mbj7JqOKctvHw
         81QMVsglNjFjMcZ0OSgWO2hPo6my73pgavav6NiXoM8gS+G9PfOkJYrpb+VuXRnD39d+
         iao9G2YJ4fhWhtR+TyBUhoNDCYNpT2owu1Wb96X6GJ/WlhhnZr0HN6kw23EjyPRDfsdR
         vymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691943; x=1702296743;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YCGwGXRc8AWPbM6p5oU9fh3ewd5Eki7b3LIN2iWwphM=;
        b=sGxWEMbMougvHPAY7JceKnZsOFf4D2Efd4ZKMHPTZ5XFHQVybc9s58UzIne29sK2RI
         /1Ajs0/4kbZ+zJoSEi7vdDfFPDGA+HqcRbaojIHOFCGu9TNnj2Yf1CoG97YQ6D6UUt/R
         Q0geap1savW5LN1GlZ99+GUIeR/kfgiih3KAFboO/BfpoQln1DHR5IPPpEVs2VAXFiXe
         WqnwlLasyt1fRf2EmPrPlmQgccP0jeMlYCjgnZp4WO5HvBtuxTZr+TGGuqtVZxCU2bCd
         5/pEXQ+C4D2erEsvd6p8OeX03FDMtWjP62wh7MWg34p07VytiGn0yPh+iFHuiNVY/CC+
         +mYA==
X-Gm-Message-State: AOJu0Yw32rgh6ompI4pj4Ja8M9IV+0h7DLkwakkzd58Rvo06S2jFucVq
        1QZU3rEEEn2ZuyaJ92bZygtFY12naQK5/ChMv6eRnw==
X-Google-Smtp-Source: AGHT+IEw0iO9X3qjmZ7kps5wExLi/tS9iX/64k7HmK4DPPUnZWl2yEZ04CtiVtXmEBn8yIjNBUovtUz3Q9RNKgEifaA=
X-Received: by 2002:a81:c84c:0:b0:5ca:61c7:4ac4 with SMTP id
 k12-20020a81c84c000000b005ca61c74ac4mr1278078ywl.51.1701691942997; Mon, 04
 Dec 2023 04:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org> <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org> <20230608123720.GC5672@thinkpad>
 <20231117070602.GA10361@thinkpad> <20231117162638.7cdb3e7d@kernel.org>
 <20231127060439.GA2505@thinkpad> <20231127084639.6be47207@kernel.org>
 <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com> <20231128125808.7a5f0028@kernel.org>
In-Reply-To: <20231128125808.7a5f0028@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Dec 2023 14:12:12 +0200
Message-ID: <CAA8EJpqGAK-7be1v8VktFRPpBHhUTwKJ=6JTTrFaWh341JAQEQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 at 22:58, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 28 Nov 2023 22:35:50 +0200 Dmitry Baryshkov wrote:
> > Also, please excuse me if this was already answered, just for my understanding:
> > - If we limit functionality to just networking channels which are used
> > to pass IP data between host and EP, will that be accepted?
>
> That's too hard to enforce. We have 200+ drivers, we can't carefully
> review every single line of code to make sure you stick to the "just
> networking" promise you make us. Plus the next guy will come and tell
> us "but you let the company X do it".
>
> > - If we were to implement the PCIe networking card running Linux (e.g.
> > using Freescale PowerQUICC or Cavium Octeon chips), would you also be
> > opposed to implementing the EP side of the link as the netdev?
>
> Yes.
>
> It's very tempting to reuse existing code, written for traffic to build
> a control channel. This becomes painful because:
>  - the lifetime rules for interfaces to configure vs to pass traffic
>    are different, which inevitably leads to bugs in common code,
>  - the use cases are different, which leads to hacks / abuse,
>    and then it's a lot harder for us to refactor and optimize core
>    code / data structures,
>  - IDK how "channel to talk to FW" fits with the normal IP stack...

Ok, here you are talking about the control path. I can then assume
that you consider it to be fine to use netdev for the EP data path, if
the control path is kept separate and those two can not be mixed. Does
that sound correct?

>
> The "FW channel netdevs" exist for decades now, and are very popular
> with middle box SDKs, I know. Your choices are:
>  - keep the code out of tree,
>  - use a generic interface with a strong standard definition, like
>    virtio, and expect that no customizations will be allowed.

-- 
With best wishes
Dmitry
