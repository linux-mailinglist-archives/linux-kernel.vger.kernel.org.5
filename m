Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28677C5D93
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbjJKTVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjJKTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:21:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF2B8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=IB3NJxaU2TzCk/8jvgobOJRjNIlf+WbQCZJyskhOPK4=; b=eQae293G/rKgUVDyqCFtl0DKQ1
        jHRPnAxrDYbI2jDXzLZCV3eSbNDlhv5InVfeVGBtcTqPOD75OH2kABsN1XQ14ib2DhDYs2AmaGynl
        EoEAkz1EAHhhK38OoK500+uUPaH2ap5Bk2hPmFgQIWz2s3Sw+k/nqaTk6VjVMHtz0/meupNCT2mPf
        ZAPtbju0k6UAl4VcZDPhy0S10AwE20gVt9EklGN4swUrSaSi1PCWEUkcsw3BEmOo0Ga8H0p80uDSv
        o0B6DEfrdJMSnW0IdpQiOFB/sV/8H0xaEYTJN4LJ+Rp39MyJovMXQB9s/nUeiOE8pF2FVmf8Uyy0p
        YrVIxihQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqelZ-00GXai-1k;
        Wed, 11 Oct 2023 19:21:09 +0000
Message-ID: <809fd1ee-73b3-495f-8b15-da02a7af3270@infradead.org>
Date:   Wed, 11 Oct 2023 12:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [char-misc-next 1/3] mei: docs: use correct structures name in
 kdoc
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
References: <20231011074301.223879-1-tomas.winkler@intel.com>
 <20231011074301.223879-2-tomas.winkler@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231011074301.223879-2-tomas.winkler@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 00:42, Tomas Winkler wrote:
> Fix misalignment between structures names and their kdoc in hw.h
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/misc/mei/hw.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
> index e910302fcd1f6a28c13fa46c..3ad3080519c42521d8643396 100644
> --- a/drivers/misc/mei/hw.h
> +++ b/drivers/misc/mei/hw.h
> @@ -429,7 +429,7 @@ struct mei_bus_message {
>  } __packed;
>  
>  /**
> - * struct hbm_cl_cmd - client specific host bus command
> + * struct mei_hbm_cl_cmd - client specific host bus command
>   *	CONNECT, DISCONNECT, and FlOW CONTROL
>   *
>   * @hbm_cmd: bus message command header
> @@ -733,7 +733,7 @@ struct hbm_dma_setup_response {
>  } __packed;
>  
>  /**
> - * struct mei_dma_ring_ctrl - dma ring control block
> + * struct hbm_dma_ring_ctrl - dma ring control block
>   *
>   * @hbuf_wr_idx: host circular buffer write index in slots
>   * @reserved1: reserved for alignment

-- 
~Randy
