Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F747B5491
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbjJBNyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbjJBNys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:54:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4997B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:54:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-7742be66bd3so876831185a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1696254885; x=1696859685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=STxM7vkkmDyUmxUH+gQAbgTWzPPiXJaAVUcK/e9j1i4=;
        b=p+RYV19piPjRHM9Mw2x+fMFRK2I+NmPpr1O9Q+lYe3ltFSAzJHE047s1Mc9RnZAqXo
         C/3j9l1hyswjG7aXScr28pmn6xP9drhjD8Fo9MxlRCaZ597elhzK+cgOLYWLzvAg5ozy
         LwkyozfzAfWlWIaP2QzZioPHnPc9pg345mr33Fv/voFV8h12oiSSKcxX9dq1Z22TqgLC
         vRa+QYKkzeCFbR97RxPvKQzNASwUhQODtmUOtlF9OqSEgIH6Tcfz+3eRr3gN20GLOK3E
         9dRTnOW+8u/G4fPO3O+kSolj5MPcgzOzCoezhgaxVYJcbn4vk90Yb8rvIzYUX8fDziek
         zgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696254885; x=1696859685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STxM7vkkmDyUmxUH+gQAbgTWzPPiXJaAVUcK/e9j1i4=;
        b=CBEE3G8NkcwDilQWli0W+XLEpx+H8+ArAbRO/8l5rHdKDaW47VSb0j5gJyJm/d9q+m
         1PzurYNmFjTtplCpdpRoU+rMka+1kJuG0VYT7MxStGZQnM9UC+/RTWrh1RtzVv/uN+bh
         u9kCoUjDHQQpHmFVKMMkbwTv51JAq40ySZzc8QzSkYieVTAQTNM3HyvQGBjiPr7C+RtY
         7xEBDMYNeuwASX47NA6R73U6k0VX1gZkSkNLCoGhbLKOczPLEf3fgXKFfxg992NLKYUb
         Y0QRU7ITORo1NjV0UQ3Qg+U5ev4WiUC8VYItFX+3LHNzuwpqZCvsjvPOTHAHFebC9vQP
         aD1g==
X-Gm-Message-State: AOJu0YzGOdeI7a2Q4NSDShCBzFodadtZBUowKBZtpcp+wjvV3ZS/IVkU
        dSAJTuvMW4EEkFbv/SiLnYjtoBXic5ydx407lLjqU070
X-Google-Smtp-Source: AGHT+IEs4NNprUgXOj7mVjG0S6MI/X0bgLI21KGJ4S6Xc/WbrCRFCrApaXSxBK8zWzz0pDpmlfRmAA==
X-Received: by 2002:a05:620a:12f1:b0:774:13e:71cd with SMTP id f17-20020a05620a12f100b00774013e71cdmr10622494qkl.56.1696254884697;
        Mon, 02 Oct 2023 06:54:44 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id h8-20020ae9ec08000000b0076e672f535asm8922296qkg.57.2023.10.02.06.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 06:54:44 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:54:34 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>
Subject: Re: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
Message-ID: <ZRrLmjxoIIx7pIcs@dell-precision-5540>
References: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
 <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On Fri, Sep 29, 2023 at 10:48:47AM -0700, Jacob Keller wrote:
> 
> 
> On 9/27/2023 10:57 AM, Ben Wolsieffer wrote:
> > The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
> > driver does not enable the clock in stm32_dwmac_init() if the device was
> > suspended. The problem is that this same code runs on STM32 MCUs, which
> > do disable clk_rx during suspend, causing the clock to never be
> > re-enabled on resume.
> > 
> > This patch adds a variant flag to indicate that clk_rx remains enabled
> > during suspend, and uses this to decide whether to enable the clock in
> > stm32_dwmac_init() if the device was suspended.
> > 
> 
> Why not just keep clk_rx enabled unconditionally or unconditionally stop
> it during suspend? I guess that might be part of a larger cleanup and
> has more side effects?

Ideally, you want to turn off as many clocks as possible in suspend to
save power. I'm assuming there is some hardware reason the STM32MP1
needs the RX clock on during suspend, but it was not explained in the
original patch. Without more information, I'm trying to maintain the
existing behavior.

> 
> > This approach fixes this specific bug with limited opportunity for
> > unintended side-effects, but I have a follow up patch that will refactor
> > the clock configuration and hopefully make it less error prone.
> > 
> 
> I'd guess the follow-up refactor would target next?
> 
> > Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
> > Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
> > ---
> 
> This seems pretty small and targeted so it does make sense to me as a
> net fix, but it definitely feels like a workaround.
> 
> I look forward to reading the cleanup patch mentioned.

Sorry, I should have linked this when I re-posted this patch for
net, but I previously submitted this patch as part of a series with
the cleanup but was asked to split them up for net and net-next.
Personally, I would be fine with them going into net-next together (or
squashed).

The original series can be found here:
https://lore.kernel.org/linux-arm-kernel/20230919164535.128125-3-ben.wolsieffer@hefring.com/T/

Thanks, Ben
