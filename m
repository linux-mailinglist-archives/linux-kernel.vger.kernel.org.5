Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5CB77404A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjHHRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjHHRBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191D422A;
        Tue,  8 Aug 2023 09:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B34062526;
        Tue,  8 Aug 2023 12:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC44C433C8;
        Tue,  8 Aug 2023 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691497376;
        bh=dhLlrUwCQzvrRjQ5imxEgR6Ov8s1gSR9MYGmH4eHroU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=inb2pUnlNEEJgy4+g5toDu6y1uAJzpYq7fGl7Yj5xlru9xEmVuqqiIgunYaYHPZU+
         mTXTJzGyG32X+d0k4NQAWhwxfMhLY4lxHSGNVN39C1cryrCRDtLExinq9sRWFreoU8
         Z1fuCZaj5xrM3r+I1Rsr0kiR+PHPeFLJzGQMvnED75JEkphMueQJ2ZXogCRisv/bXU
         BqtytwaE30LlME+Xoq4BDRh/wq/wydL5Y/MBr5khnGgZR9LjKxNr6xkNAgWcwTkb40
         Fi6pxDrjA6iYVRzTgzuUdAQd7a6WHwNyuY9eobLIp1kI0QA38nvgyCCipraZrbqPNq
         L34Q36eKS0Obg==
Message-ID: <529218f6-2871-79a2-42bb-8f7886ae12c3@kernel.org>
Date:   Tue, 8 Aug 2023 15:22:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Introduce IEP driver and packet
 timestamping support
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>, Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230808-unnerving-press-7b61f9c521dc@spud>
 <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1c8e5369-648e-98cb-cb14-08d700a38283@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 15:18, Md Danish Anwar wrote:
> On 08/08/23 5:38 pm, Conor Dooley wrote:
>> On Mon, Aug 07, 2023 at 04:30:43PM +0530, MD Danish Anwar wrote:
>>> This series introduces Industrial Ethernet Peripheral (IEP) driver to
>>> support timestamping of ethernet packets and thus support PTP and PPS
>>> for PRU ICSSG ethernet ports.
>>>
>>> This series also adds 10M full duplex support for ICSSG ethernet driver.
>>>
>>> There are two IEP instances. IEP0 is used for packet timestamping while IEP1
>>> is used for 10M full duplex support.
>>>
>>> This is v2 of the series [v1]. It addresses comments made on [v1].
>>> This series is based on linux-next(#next-20230807). 
>>>
>>> Changes from v1 to v2:
>>> *) Addressed Simon's comment to fix reverse xmas tree declaration. Some APIs
>>>    in patch 3 and 4 were not following reverse xmas tree variable declaration.
>>>    Fixed it in this version.
>>> *) Addressed Conor's comments and removed unsupported SoCs from compatible
>>>    comment in patch 1. 
>>
>> I'm sorry I missed responding there before you sent v2, it was a bank
>> holiday yesterday. I'm curious why you removed them, rather than just
>> added them with a fallback to the ti,am654-icss-iep compatible, given
>> your comment that "the same compatible currently works for all these
>> 3 SoCs".
> 
> I removed them as currently the driver is being upstreamed only for AM654x,
> once I start up-streaming the ICSSG driver for AM64 and any other SoC. I will
> add them here. If at that time we are still using same compatible, then I will
> modify the comment otherwise add new compatible.
> 
> As of now, I don't see the need of adding other SoCs in iep binding as IEP
> driver up-streaming is only planned for AM654x as of now.

But, is there any difference in IEP hardware/driver for the other SoCs?
AFAIK the same IP is used on all SoCs.

If there is no hardware/code change then we don't need to introduce a new compatible.
The comment for all SoCs can already be there right from the start.

-- 
cheers,
-roger
