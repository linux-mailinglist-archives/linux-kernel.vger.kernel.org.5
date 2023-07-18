Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D1757952
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGRKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjGRKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F4CE60;
        Tue, 18 Jul 2023 03:33:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403146148E;
        Tue, 18 Jul 2023 10:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90F4C433C7;
        Tue, 18 Jul 2023 10:33:09 +0000 (UTC)
Message-ID: <d252cbfe-98bb-2cd2-b251-81d29e99413d@xs4all.nl>
Date:   Tue, 18 Jul 2023 12:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: imx: Unstage the imx8mq-mipi-csi2 driver
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        rmfrfs@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        kernel@puri.sm, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230425090804.2664466-1-martin.kepplinger@puri.sm>
 <20230425094346.GA17841@pendragon.ideasonboard.com>
 <a4b3cf3be9f105adcbcad688f8745556eec4d9df.camel@puri.sm>
 <ae7865575edd11ab9e2bf81c54ee8826e0a2a766.camel@puri.sm>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ae7865575edd11ab9e2bf81c54ee8826e0a2a766.camel@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 13:00, Martin Kepplinger wrote:
> Am Dienstag, dem 16.05.2023 um 09:42 +0200 schrieb Martin Kepplinger:
>> Am Dienstag, dem 25.04.2023 um 12:43 +0300 schrieb Laurent Pinchart:
>>> Hi Martin,
>>>
>>> Thank you for the patch.
>>>
>>> On Tue, Apr 25, 2023 at 11:08:04AM +0200, Martin Kepplinger wrote:
>>>> The imx8mq-mipi-csi2 MIPI CSI-2 receiver driver is used and
>>>> maintained.
>>>> There is no reason to keep it in staging. The accompanying CSI
>>>> bridge
>>>> driver that uses it is in drivers/media/platform/nxp as well.
>>>>
>>>> One TODO is to get rid of csi_state's "state" and "lock"
>>>> variables.
>>>> Especially make sure suspend/resume is working without them. That
>>>> can
>>>> very well be worked on from the new location.
>>>>
>>>> Also add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi
>>>> receiver
>>>> driver.
>>>>
>>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
>>>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Thanks for reviewing Laurent,
>>
>> Are there any second thoughts to this? If not: It still applies to
>> todays' next kernel. Who would be able to queue this up?
>>
>> (This enables Debian and other distributions to use cameras on
>> imx8mq.)
>>
>> thanks,
>>
>>                        martin
>>
> 
> This still applies cleanly and would be helpful. Does anyone want to
> queue this?

I'll queue this up, likely later this week.

Regards,

	Hans

> 
> thanks,
>                          martin
> 

