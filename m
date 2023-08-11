Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E73F7795FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjHKRRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjHKRRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:17:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ABC30CD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WraPZYkKFQ4NMLWFY/fKJ3wjO20h9kSxGeBUIDsxdhE=; b=uLUjl/Bn+xdNz2bzzEYBBem9gt
        EB0/9Y1nhu7EX+nLHm8W3xRWpqkNrKC9ox75hO0Lrza5CLjSKx6TF0bU+sJci2RkSZ0okLg3X5f5X
        pHJrZ2Vir3TuH19CRFzg2XzARJj9yoNt3h3GjzfSYMcsJhUFN6BZmQiezfeuyHrh2ofrcSU8RztTs
        8nd/nKOgMiKX4H4BzIxFYwKUosnmXSL8syeJAWBG+vzw61vf7L7WktWt/q1d7/kVZ1vX6j/mKiyfz
        dy6/zpOIy+jfzr4/ufVCGze+qYvqI2Lr8x7o0InQ4S02SIEUtIYWz+iMW+Js5SMnowfmRXEP9Hr7H
        LFto6LpQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUVlc-00BE1d-0i;
        Fri, 11 Aug 2023 17:17:40 +0000
Message-ID: <6d3b8501-0bfd-5269-cf3a-fe7a22300f73@infradead.org>
Date:   Fri, 11 Aug 2023 10:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next] mailbox: bcm-pdc: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
References: <20230811013448.115153-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230811013448.115153-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 18:34, Yang Li wrote:
> Fix some kernel-doc comments to silence the warnings:
> 
> drivers/mailbox/bcm-pdc-mailbox.c:707: warning: Function parameter or member 'pdcs' not described in 'pdc_tx_list_sg_add'
> drivers/mailbox/bcm-pdc-mailbox.c:707: warning: Excess function parameter 'spu_idx' description in 'pdc_tx_list_sg_add'
> drivers/mailbox/bcm-pdc-mailbox.c:875: warning: Function parameter or member 'pdcs' not described in 'pdc_rx_list_sg_add'
> drivers/mailbox/bcm-pdc-mailbox.c:875: warning: Excess function parameter 'spu_idx' description in 'pdc_rx_list_sg_add'
> drivers/mailbox/bcm-pdc-mailbox.c:966: warning: Function parameter or member 't' not described in 'pdc_tasklet_cb'
> drivers/mailbox/bcm-pdc-mailbox.c:966: warning: Excess function parameter 'data' description in 'pdc_tasklet_cb'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/mailbox/bcm-pdc-mailbox.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
> index 8c95e3ce295f..5401b9e3f5e8 100644
> --- a/drivers/mailbox/bcm-pdc-mailbox.c
> +++ b/drivers/mailbox/bcm-pdc-mailbox.c
> @@ -694,7 +694,7 @@ pdc_receive(struct pdc_state *pdcs)
>   * pdc_tx_list_sg_add() - Add the buffers in a scatterlist to the transmit
>   * descriptors for a given SPU. The scatterlist buffers contain the data for a
>   * SPU request message.
> - * @spu_idx:   The index of the SPU to submit the request to, [0, max_spu)
> + * @pdcs:      PDC state for the SPU that will process this request
>   * @sg:        Scatterlist whose buffers contain part of the SPU request
>   *
>   * If a scatterlist buffer is larger than PDC_DMA_BUF_MAX, multiple descriptors
> @@ -861,7 +861,7 @@ static int pdc_rx_list_init(struct pdc_state *pdcs, struct scatterlist *dst_sg,
>   * pdc_rx_list_sg_add() - Add the buffers in a scatterlist to the receive
>   * descriptors for a given SPU. The caller must have already DMA mapped the
>   * scatterlist.
> - * @spu_idx:    Indicates which SPU the buffers are for
> + * @pdcs:       PDC state for the SPU that will process this request
>   * @sg:         Scatterlist whose buffers are added to the receive ring
>   *
>   * If a receive buffer in the scatterlist is larger than PDC_DMA_BUF_MAX,
> @@ -960,7 +960,7 @@ static irqreturn_t pdc_irq_handler(int irq, void *data)
>  /**
>   * pdc_tasklet_cb() - Tasklet callback that runs the deferred processing after
>   * a DMA receive interrupt. Reenables the receive interrupt.
> - * @data: PDC state structure
> + * @t: Pointer to the Altera sSGDMA channel structure
>   */
>  static void pdc_tasklet_cb(struct tasklet_struct *t)
>  {

-- 
~Randy
