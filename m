Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3703805733
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346836AbjLEOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbjLEOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:22:51 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD318D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:22:57 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d7346442d4so31146017b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701786176; x=1702390976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Frwe5NoLiVErGGo0J2Fc9HYe79JYyuyxPi79nNvzQ=;
        b=GgmZ7moSb2Ls8Jzwp9GUedkL79ChZbe5Vn57Lcos0mXNbLufzaVZ/GoPFho+EEK//6
         r2/nmV9N6nmQH3TXCoCMSbI36hqlB1Z1WjMrcXj09US4WQwitsx6oqyl8KQ4m91RyXKr
         DistxXkG+oxDmdXjHcaLgY5nGPARlIhChV2ExZyhsvU/SiaWNCsMJB0qPzZjp9slVSmz
         boRTL/NHScMihGZzq0OU0MnoIll09LmammOAcC9PB2TbahTX3TBoHQuWpsWvH9Z3bkeM
         JnD2SdmkPIS8M6D3zLa1/tgKj9RQuIjcz7XF4+ieYf7ZijxhaqAb6R6TqfY39RIBAGW2
         awMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701786176; x=1702390976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/Frwe5NoLiVErGGo0J2Fc9HYe79JYyuyxPi79nNvzQ=;
        b=wExDOgGkuwQx8dQg+MRqfozMm1Lvjdj+kc3nzsKqzHMtMpBH9dGcv8mdcACBqLPHGr
         iDQhq0jmYncWOF9z2Qcr0OEd1n2pXTluusQJm/HgZbZaR1ACc+fFdzzCr567iQd4ZLA2
         bcsJBUhzblhmb6QrjkZF3ATfRTXM9xROATuHSM/MEj2ave4twUaeY4p8ASnqd97bnuH/
         6dWMAhWBoWQL4vjtqFcZP1YPE87zeZg3KGWUFt4btkY2+S8rceEPO89oOlWeqosiAeT7
         zahJOA51udnTQkXQbp9tzhGPT1pX3RKOFuzKYwYO3OSdMSb5bbe0/aMs7oDjMD+p3g8k
         1o8w==
X-Gm-Message-State: AOJu0YzxkLszzwQOn4416Iu4ZBdIMFwRdrh8vpPJ2uHz6/8cQYNUpZTt
        ZmRr6dTcArwKjV3qOrhAE89e2Th/Pcbs0o5v5v0BWQ==
X-Google-Smtp-Source: AGHT+IGyrKcpMlCc6HKeOLyBPWiYuASZdAWLwG2aWAnGxzTUHOjqtc2yXhgIigkdzOlV5dwo5Ofz4JjxN6ezYXE4viE=
X-Received: by 2002:a05:6902:248:b0:db7:dad0:76b5 with SMTP id
 k8-20020a056902024800b00db7dad076b5mr3673602ybs.81.1701786176179; Tue, 05 Dec
 2023 06:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org> <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org> <20230608123720.GC5672@thinkpad>
 <20231117070602.GA10361@thinkpad> <20231117162638.7cdb3e7d@kernel.org>
 <20231127060439.GA2505@thinkpad> <20231127084639.6be47207@kernel.org>
 <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
 <20231128125808.7a5f0028@kernel.org> <CAA8EJpqGAK-7be1v8VktFRPpBHhUTwKJ=6JTTrFaWh341JAQEQ@mail.gmail.com>
 <20231204081222.31bb980a@kernel.org>
In-Reply-To: <20231204081222.31bb980a@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Dec 2023 16:22:45 +0200
Message-ID: <CAA8EJprrcH3T8_aA7bZhZXKiWMXjUTZkvLkQzteHUG4_7e4i8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 18:12, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 4 Dec 2023 14:12:12 +0200 Dmitry Baryshkov wrote:
> > Ok, here you are talking about the control path. I can then assume
> > that you consider it to be fine to use netdev for the EP data path, if
> > the control path is kept separate and those two can not be mixed. Does
> > that sound correct?
>
> If datapath == traffic which is intended to leave the card via
> the external port, then yes.

Then I think I understand what causes the confusion.

The MHI netdev is used to deliver network traffic to the modem CPU,
but it is not the controlpath.
For the control path we have non-IP MHI channels (QMI, IPCR, etc).
This can be the traffic targeting e.g. SSH or HTTP server running on
the EP side of the link.

I probably fail to see the difference between this scenario and the
proper virtio netdev which also allows us to send the same IPv4/v6
traffic to the CPU on the EP side.

-- 
With best wishes
Dmitry
