Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205997774A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbjHJJdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjHJJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:33:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795863A9E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:33:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bcc0adab4so102021166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691659972; x=1692264772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb0rfZaZQTOJ9RosZEXBpg0Z1lQ7lbBcT+HB1fvjTT8=;
        b=j1hNz2mlXMpJkSQMmOO6lLf1l50U5/dhUMjMeyvKuDEQWGtT2wpDhQy8CDQ1UTANAq
         mNgcsQ8SJP2mKxF/y0CkzJFBHcXSGcxBJuzIbG4C3zQHw8GJTJD6XFM/H6Cpe9AsTO9m
         u6HzWSdNpul1pLFtlst+jG61wu0BdzbSC6KT/HHTIirtIPrHubh+LeleL5o4fSe8Hlnt
         w06qmLLcg87+EQ8VaMZX9HRHGRPTMe9D7LZREHvdhx6hsz3l3kFYoJO7V+JbEVOvFpoH
         O1qAoo9VN//nhMDD6fK1n5vX/p10NWcyFEy4pbrJ2zg5zfhkmow3w4ozGLJPPNOvm73C
         kp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659972; x=1692264772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb0rfZaZQTOJ9RosZEXBpg0Z1lQ7lbBcT+HB1fvjTT8=;
        b=CFKO4tD96g/bOLo8QxZ02L4RqxBvBDrP1h6azRUkMnlp+UvDZ9tsZH6nLJidBPAAAe
         kY3JnSMwL5Z18iaVFCJ9xoP0bN/rhB8fc1bycYBdEDxwUWA76zE6RIEYn/sZBu2hT0Si
         P2yfUg5+vmEtvU27UtPq57XR9NqUEQNIzR1TqKm836jlvDGqF7+UDWFKjcdIxdkmvf9v
         9GGB48La69jZrcRpmvJvcB6hxGajsWfEuZoYeV/5F89Wfl1bHGKYPb0sNz+ipl7gIkFU
         80SGwM1MAMlArfpJFGq6EeMPn8BKzR2z4dtemDiCdrKVSJ6LyYYHnXsnKnIDg57Elwob
         Fcng==
X-Gm-Message-State: AOJu0Yw6LZTBW18n0MHJXDTvVdVaRIpkSjpovbAirPWAp5QmHVXm2APX
        DGicrwmnLAoCIV2HiCSmdUsCPg==
X-Google-Smtp-Source: AGHT+IEHlYdFQPucZN7ly1WkptrPpgjmpsdinQYlUi2ctGN2pqdQAaHrmqx/Lt/CxlAhk9fNyirRVQ==
X-Received: by 2002:a17:906:76ca:b0:99c:bb4d:f5a0 with SMTP id q10-20020a17090676ca00b0099cbb4df5a0mr1590701ejn.14.1691659972393;
        Thu, 10 Aug 2023 02:32:52 -0700 (PDT)
Received: from blmsp ([2001:4090:a245:81da:7521:a3aa:9abb:fac5])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709065a9200b00991e2b5a27dsm685380ejq.37.2023.08.10.02.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:51 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:32:50 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v5 00/12] can: m_can: Optimizations for m_can/tcan part 2
Message-ID: <20230810093250.fxzxss7cfmazsrd7@blmsp>
References: <20230718075708.958094-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

did you have some time to review this series? Anything I should rework?

Thanks,
Markus

On Tue, Jul 18, 2023 at 09:56:56AM +0200, Markus Schneider-Pargmann wrote:
> Hi Marc, Simon and everyone,
> 
> v5 got a rebase on v6.5 with some small style fixes as pointed out in v4.
> 
> It is tested on tcan455x but I don't have hardware with mcan on the SoC
> myself so any testing is appreciated.
> 
> The series implements many small and bigger throughput improvements and
> adds rx/tx coalescing at the end.
> 
> Based on v6.5-rc1. Also available at
> https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.5?ref_type=heads
> 
> Best,
> Markus
> 
> Changes in v5:
> - Add back parenthesis in m_can_set_coalesce(). This will make
>   checkpatch unhappy but gcc happy.
> - Remove unused fifo_header variable in m_can_tx_handler().
> - Rebased to v6.5-rc1
> 
> Changes in v4:
> - Create and use struct m_can_fifo_element in m_can_tx_handler
> - Fix memcpy_and_pad to copy the full buffer
> - Fixed a few checkpatch warnings
> - Change putidx to be unsigned
> - Print hard_xmit error only once when TX FIFO is full
> 
> Changes in v3:
> - Remove parenthesis in error messages
> - Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
>   header and data in one transaction'.
> - Replace spin_lock with spin_lock_irqsave. I got a report of a
>   interrupt that was calling start_xmit just after the netqueue was
>   woken up before the locked region was exited. spin_lock_irqsave should
>   fix this. I attached the full stack at the end of the mail if someone
>   wants to know.
> - Rebased to v6.3-rc1.
> - Removed tcan4x5x patches from this series.
> 
> Changes in v2:
> - Rebased on v6.2-rc5
> - Fixed missing/broken accounting for non peripheral m_can devices.
> 
> previous versions:
> v1 - https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> v2 - https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
> v3 - https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
> v4 - https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
> 
> Markus Schneider-Pargmann (12):
>   can: m_can: Write transmit header and data in one transaction
>   can: m_can: Implement receive coalescing
>   can: m_can: Implement transmit coalescing
>   can: m_can: Add rx coalescing ethtool support
>   can: m_can: Add tx coalescing ethtool support
>   can: m_can: Use u32 for putidx
>   can: m_can: Cache tx putidx
>   can: m_can: Use the workqueue as queue
>   can: m_can: Introduce a tx_fifo_in_flight counter
>   can: m_can: Use tx_fifo_in_flight for netif_queue control
>   can: m_can: Implement BQL
>   can: m_can: Implement transmit submission coalescing
> 
>  drivers/net/can/m_can/m_can.c | 517 +++++++++++++++++++++++++---------
>  drivers/net/can/m_can/m_can.h |  35 ++-
>  2 files changed, 418 insertions(+), 134 deletions(-)
> 
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> -- 
> 2.40.1
> 
