Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154967FC58D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbjK1Uf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Uf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:35:56 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656BE4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:36:02 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b88f2a37deso480147b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701203761; x=1701808561; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QlqPdsqaKfOX4ybpeoxfRZcdk2EJ2CcgPBS+ybUncU=;
        b=OZo70hHWiTTFFoNK/myvRMKlNndV5GgTqTBj7uIQhy8oyN4WgomPZMPm7k21r2PJV2
         Siv8v78XFghK3IYVj8ah0Nos6L7hfS4zO2+mYubq9Hst5wTOjQnNBkj2v+RdSd23SlYW
         oxpBSp92bCszoWbYMob3cpV+H46wO6Q73xw8vOGZLcTKYQOPhDQpWZZhZP+Lp9SEO78a
         680geMRkI6YKOC90jr82eBA878lf6CJQnypyAQfpw/s0I0cUFYZRVft45W2oa8u72fuk
         PVLU1AWmiHSmCMZBUFDbK2jz0hV2H2TkfAP01IsxF9UY/3FDsVpx33KwajyGwyMflJd2
         eUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701203761; x=1701808561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QlqPdsqaKfOX4ybpeoxfRZcdk2EJ2CcgPBS+ybUncU=;
        b=iJ7yXqMS9b/n5Nrii0VJwVQbx7wcWAJ1ilAAgFf1dxe7RZQVEhBX09R+QBGrax/5PZ
         a17x+v+OygqgfKy1mJp73TeQyybLZJ/B6NGr21hUrdReWbB6qgfihkc9rH3hGj+sLzvf
         X58SIL59qOnIhoHFLGeDjevUpLGEawNfwbJWx+ysa2B6QtpeLFKKkTrLUkd2A1g5I6+9
         qiEhOD49D513qXofxJ5rH/F6tVnzwBuskGq42TOED2z7dq5tZcfr1QdoRIWmEqBtFQIY
         /Kxzg8MohRLDhdqu+x0YxKiAfAZ0gWRgP5PsphePW44TesWthws7+cP51CuikOrThF9w
         PHNA==
X-Gm-Message-State: AOJu0YxOBKBAfRzKpLULmp2e3/5nS7/1urcJ4QC9VjTOhF041XTuuIGD
        qfMKXc8kUjca6E0dgR30K7+sVbIxpyRoYRaI58kdvQ==
X-Google-Smtp-Source: AGHT+IFzsmlB/1Q5gxxim4y4vmRNi1YzA551Xf7Btg7SG2Mt7yLBRFaDXl11rOlT2eb6ssG2GPUC+ENHaKVHfploOV4=
X-Received: by 2002:a05:6358:60cd:b0:16b:c249:9b97 with SMTP id
 i13-20020a05635860cd00b0016bc2499b97mr20105639rwi.18.1701203761477; Tue, 28
 Nov 2023 12:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org> <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org> <20230608123720.GC5672@thinkpad>
 <20231117070602.GA10361@thinkpad> <20231117162638.7cdb3e7d@kernel.org>
 <20231127060439.GA2505@thinkpad> <20231127084639.6be47207@kernel.org>
In-Reply-To: <20231127084639.6be47207@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 28 Nov 2023 22:35:50 +0200
Message-ID: <CAA8EJppL0YHHjHj=teCnAwPDkNhwR1EWYuLPnDue1QdfZ3RS_w@mail.gmail.com>
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

On Mon, 27 Nov 2023 at 18:46, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 27 Nov 2023 11:34:39 +0530 Manivannan Sadhasivam wrote:
> > I think you made up your mind that this driver is exposing the network interface
> > to the firmware on the device. I ought to clearify that the device running this
> > driver doesn't necessarily be a modem but a PCIe endpoint instance that uses the
> > netdev exposed by this driver to share data connectivity with another device.
>
> Doesn't matter how many legit use cases you can come up with.
> Using netdev as a device comm channel is something I am
> fundamentally opposed to.
>
> > This concept is not new and being supported by other protocols such as Virtio
> > etc...
>
> Yes. Use virtio, please.

We can try using virtio if we control both sides of the link. However
there are usecases of the upstream Linux running on the modem (PCIe
EP) side and other systems (Win, Android) running on the RC side. In
such cases we have to provide the interface that is expected by the
host driver, which unfortunately is MHI. Not to mention that one of
the PCIe EP regions contains registers which are targeting the MHI
protocol. I am not sure how hardware will react if we bypass this
completely and implement VirtIIO or NTB instead.

Also, please excuse me if this was already answered, just for my understanding:
- If we limit functionality to just networking channels which are used
to pass IP data between host and EP, will that be accepted?

- If we were to implement the PCIe networking card running Linux (e.g.
using Freescale PowerQUICC or Cavium Octeon chips), would you also be
opposed to implementing the EP side of the link as the netdev?

-- 
With best wishes
Dmitry
