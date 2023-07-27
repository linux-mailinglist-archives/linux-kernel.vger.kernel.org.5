Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FE27643EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjG0Cnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjG0Cnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:43:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8761724
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=MEcfbRULj2reXSs4s7VLjvt6yrFh6kgpdDUO8o9DPm8=; b=i3PwP5XLsw8Va5txKY7pXf0jHU
        HcQqjtOE6OWm7XKHyQgRla/kkbwk0qBIBBntd0sAoxHfvzzXKnkOlR7fbB+Ydy+83lElBut3TmqfI
        kRcSBnsDm3a9bs4dB+wk0mtWy5kYadt4DdYr6XdMPA+NR+xs2ImFowjhf359Dz/TFCesyspuNRcM6
        da1pH/oBm4al04uaXDV8Aaz3grkuQx6VXcu6IEO+wgc2C0ri+FYoV9PW3uV2/ZFU37PQ89dawJhkf
        WEA+X5N25CD/kBku3SZASNC+Wuah2SoN+6vVi0Y4dYdKPRzumTbt2jlwdBCAzI1W4+kPEQ30L5ckY
        wFlTwbYQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOqyd-00BxEG-2Z;
        Thu, 27 Jul 2023 02:43:43 +0000
Message-ID: <4597bdb9-8a90-6d4e-3904-161fffb87350@infradead.org>
Date:   Wed, 26 Jul 2023 19:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] rapidio/tsi721: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, mporter@kernel.crashing.org,
        alex.bou9@gmail.com
Cc:     linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20230727020840.87684-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230727020840.87684-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 19:08, Yang Li wrote:
> Fix some kernel-doc comments to silence the warnings:
> 
> drivers/rapidio/devices/tsi721.c:215: warning: Function parameter or member 'data' not described in 'tsi721_cread_dma'
> drivers/rapidio/devices/tsi721.c:215: warning: Excess function parameter 'val' description in 'tsi721_cread_dma'
> drivers/rapidio/devices/tsi721.c:238: warning: Function parameter or member 'data' not described in 'tsi721_cwrite_dma'
> drivers/rapidio/devices/tsi721.c:238: warning: Excess function parameter 'val' description in 'tsi721_cwrite_dma'
> drivers/rapidio/devices/tsi721.c:2548: warning: Function parameter or member 'attr' not described in 'tsi721_query_mport'
> drivers/rapidio/devices/tsi721.c:2548: warning: Excess function parameter 'mbox' description in 'tsi721_query_mport'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5997
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/rapidio/devices/tsi721.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
> index 83323c3d10af..3e67001702bc 100644
> --- a/drivers/rapidio/devices/tsi721.c
> +++ b/drivers/rapidio/devices/tsi721.c
> @@ -205,7 +205,7 @@ static int tsi721_maint_dma(struct tsi721_device *priv, u32 sys_size,
>   * @hopcount: Number of hops to target device
>   * @offset: Offset into configuration space
>   * @len: Length (in bytes) of the maintenance transaction
> - * @val: Location to be read into
> + * @data: Location to be read into
>   *
>   * Generates a RapidIO maintenance read transaction.
>   * Returns %0 on success and %-EINVAL or %-EFAULT on failure.
> @@ -228,7 +228,7 @@ static int tsi721_cread_dma(struct rio_mport *mport, int index, u16 destid,
>   * @hopcount: Number of hops to target device
>   * @offset: Offset into configuration space
>   * @len: Length (in bytes) of the maintenance transaction
> - * @val: Value to be written
> + * @data: Value to be written
>   *
>   * Generates a RapidIO maintenance write transaction.
>   * Returns %0 on success and %-EINVAL or %-EFAULT on failure.
> @@ -2539,7 +2539,7 @@ static int tsi721_messages_init(struct tsi721_device *priv)
>  /**
>   * tsi721_query_mport - Fetch inbound message from the Tsi721 MSG Queue
>   * @mport: Master port implementing the Inbound Messaging Engine
> - * @mbox: Inbound mailbox number
> + * @attr: RIO mport device attributes
>   *
>   * Returns pointer to the message on success or NULL on failure.
>   */

-- 
~Randy
