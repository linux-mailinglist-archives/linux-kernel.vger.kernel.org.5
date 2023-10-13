Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F87C8438
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjJMLRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:17:49 -0400
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06ADB7;
        Fri, 13 Oct 2023 04:17:45 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Fri, 13 Oct 2023 13:17:37 +0200
MIME-Version: 1.0
Date:   Fri, 13 Oct 2023 13:17:37 +0200
From:   m.brock@vanmierlo.com
To:     Rob Herring <robh@kernel.org>
Cc:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
        michal.simek@amd.com, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com,
        srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
In-Reply-To: <20231012205158.GA1714449-robh@kernel.org>
References: <20231011145602.3619616-1-manikanta.guntupalli@amd.com>
 <20231011145602.3619616-2-manikanta.guntupalli@amd.com>
 <c4d6ec9a13807866b7dbc7cbed478494@vanmierlo.com>
 <20231012205158.GA1714449-robh@kernel.org>
Message-ID: <42864886e6d5cf11b6ab817f57008611@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring wrote on 2023-10-12 22:51:
>> How about introducing an rs485 generic gpios property instead of xlnx
>> private one? See also rs485-term-gpios and rs485-rx-during-tx-gpios.
>> 
>> Also note that every kernel driver expects to use RTS for this 
>> purpose.
>> So why not give this driver the option to choose a gpio instead of its
>> native RTS? And from there on use the rts route?
>> What if someone wants to use normal (non-rs485) RTS on a GPIO instead
>> of the native pin?
>> 
>> @Rob Herring
>> I am curious to know how the rs485 maintainers look at this.
> 
> Ask them.

Funny, your name is the only one listed under the maintainers in
Documentation/devicetree/bindings/serial/rs485.yaml

And there is no mention of (RS-)485 in MAINTAINERS.

> We already have 'rts-gpios'. If that's what's always used, then perhaps
> we should use that in the RS485 case too?
> 
> Rob

Sounds like a good idea.

Maarten

