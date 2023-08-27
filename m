Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A36A7899EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjH0ASh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjH0ASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:18:10 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F01BE;
        Sat, 26 Aug 2023 17:18:08 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso31704451fa.1;
        Sat, 26 Aug 2023 17:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693095486; x=1693700286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0O9+Nd81lV61HUqL9J8WFR0wEb+50cA6S0W+jgCLe8=;
        b=c/affskxQbENShZrDrcXcKAkTEXbHsnQQKmV0Pou8bPhhXgqTFq+jOGmmDB/J9k+Z3
         Lwj8SoVltyelWC4dq4f05GgIu1Vl3mAC1moPIvkwCjrkQda++FmI0T73NwWdda9WZ4tl
         ZPUL61i4oIuWMvnAWboCGhLHW5Yiz4OTRdctRiGAv3YePFte8v7Eb0sfg1dqQeEuzE6p
         GI41iMMFHl97rHL/QlgVJZnR2W2SO8laQCgdHK0nAUme/x6tOqEILrLVU82JZDGO5H0c
         NVJNCC7/BocOfV9X13sU7FSmqaC1KEGSjvkPH9+ez455BpePqhA8J5kTYASrGoC8D72D
         8fLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693095486; x=1693700286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0O9+Nd81lV61HUqL9J8WFR0wEb+50cA6S0W+jgCLe8=;
        b=Q3AYhm4zZscO12pAJVRhSPBUI7l0GxSsBWQSfJVy2iNG7MLXS4vB5k6i1nMW0nHl3k
         T+uR/DOCzlG2Wdt9y+DyzTX4X8Gjv9QcD1cCjK5FaDUnfw6Pc6iODecqMCK3glPu17W9
         H0NgrYBwHPRiS75UGmV7eTy8UOCHUGlI0PK00uUj7EKhkt5MJgo+JqLOVu6jtVdK5ZpS
         qppoYOC3B3G/NGSWUoHLy4qX9bUOYZkhU+NmlhBItQ/BK1ZVnxOyn2kE5iaf7mrKxCOX
         S1uTy78cWNGcnxG9t/wMsr39AjtkI7faqgo62oMAlM+NWI+O5zn+dtZNNS4C2S8sErzp
         mfOw==
X-Gm-Message-State: AOJu0YzvD6HKCWvxd7uHdoRTbl9i1RLUMxzpnzr2IFZv7pfT3lhSOw/Q
        oHjTXiYlcLJggj6Wp2PEs2DzbcToP0nFCw==
X-Google-Smtp-Source: AGHT+IETf2PT2oT9j6J9nHb3QF2V2wh+kc6yhG5eIffZAbTs9nY9WVTgxgZMkeph09QnN5G5PyYhHw==
X-Received: by 2002:a2e:3c0e:0:b0:2b6:3651:f12f with SMTP id j14-20020a2e3c0e000000b002b63651f12fmr17021462lja.3.1693095486177;
        Sat, 26 Aug 2023 17:18:06 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id x1-20020a05651c104100b002bcd2653872sm1015042ljm.30.2023.08.26.17.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:18:05 -0700 (PDT)
Date:   Sun, 27 Aug 2023 03:18:03 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     alexandre.torgue@foss.st.com, conor+dt@kernel.org,
        conor.dooley@microchip.com, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, peppe.cavallaro@st.com, robh+dt@kernel.org
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <stdtvjzyaudpnxoj4pxdqw4okrmq2bkmbefvyapbs2racx4dhv@of5t463f4nm5>
References: <l7yajzhpuotn62pjkxk43qtcn3u4zltpyqcvo224737bjg3eab@bzu6pirxbvh2>
 <20230823171004.6825-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823171004.6825-1-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:10:04AM +0800, Rohan G Thomas wrote:
> >On Tue, Aug 22, 2023 at 05:15:25PM -0700, Jakub Kicinski wrote:
> >> On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
> >> > +      snps,tx-queues-with-coe:
> >> > +        $ref: /schemas/types.yaml#/definitions/uint32
> >> > +        description: number of TX queues that support TX checksum offloading
> >> 
> >
> >> Is it going to be obvious that if not present all queues support
> >> checksum offload? I think we should document the default.
> >
> >This question is debatable:
> >1. By default the DW xGMAC and DW QoS Eth IP-cores are
> >synthesized with only the very first Tx queue having Tx COE enabled.
> >2. If TSO is disabled then the Tx COE can be individually enabled
> >for each queue available on DW QoS Eth controller and for the very
> >first N queues on DW xGMAC controller.
> >3. If TSO is enabled then the Tx COE will be automatically and always
> >enabled for as many first queues as there are TSO-capable
> >DMA-channels.
> >4. At the current state the STMMAC driver assumes that all Tx Queues
> >support Tx COE.
> >
> >The entry 4 can't be changed since we'll risk to catch regressions on
> >the platforms with no property specified. On the other hand it partly
> >contradicts to the rest of the entries. I don't know what would be a
> >correct way to specify the default value in this case. Most likely
> >just keep the entry 4 and be done with it.
> >
> >BTW I just noticed that but the suggested "snps,tx-queues-with-coe"
> >property semantic will only cover a DW XGMAC-part of the case 2. DW
> >QoS Eth can be synthesized with Tx COE individually enabled for a
> >particular queue if TSO is unavailable.
> 
> Hi Serge,
> 
> Didn't know about a different IP configuration supported by DW QoS Eth IP. If
> this is the case, I think we can have a flag 'coe-unsupported' for any TX
> queue subnode as below.
> 
> +          snps,coe-unsupported:

> +            $ref: /schemas/types.yaml#/definitions/flag

AFAIR tKrzysztof preferred to use type: boolean for the flags.

> +            description:
> +              TX checksum offload is unsupported by the TX queue. 

> +              If TX checksum
> +              offload is requested for a packet to be transmitted through this
> +              TX queue then have a software fallback in the driver for checksum
> +              calculation.

This is redundant in the HW description.

> 

> If this is okay, I can rework the patch based on this. Covers both DW QoS Eth IP
> and DW XGMAC IP cases.

I guess that's the only choice we have seeing the driver already
expects all the Tx queues having the COE supported.

-Serge(y)

> 
> >
> >-Serge(y)
> >
> >> -- 
> >> pw-bot: cr
> 
> BR,
> Rohan
