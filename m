Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE087C5D92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjJKTVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjJKTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:21:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADEC0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Qrnh7rbxwVwDex5X3GQxqCIR/olGT5gTFJ9QHD21HaU=; b=2MEGdpTK7JRd9txqowILZuSgwk
        S9e8O6GlblsBhv0+dSnQ249NXpUguqRns1GTe7wTLUrYAqPNaOyLtYAG6TCbLIArK4eJ1BzNYTIXj
        kzv6TXob6Ys6ZUNqxIFajZmkNoTR9a9EklrYJ3V9OnkM3+FxHTWESIdfoiklfAFoc9f9H0EbvsRnh
        7U4KKhpA1c3iWSdqbBak+FI5PskUavNQj2/yDyl8boBaAzh2fPVPUzAGAq8q3de25ufEd94zlSgg1
        70ps/ehh11nnyN2abAdR8w7ll/K9yEeqyqp9YjDfvKguznTsaSvdXaBf93W4mUfm82n6a16SO1+ix
        gx/oq+og==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqelV-00GXai-1m;
        Wed, 11 Oct 2023 19:21:05 +0000
Message-ID: <211f9333-393f-4fb3-bdab-23840791af45@infradead.org>
Date:   Wed, 11 Oct 2023 12:21:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [char-misc-next 2/3] mei: docs: add missing entries to kdoc in
 struct mei_cfg_idx
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
References: <20231011074301.223879-1-tomas.winkler@intel.com>
 <20231011074301.223879-3-tomas.winkler@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231011074301.223879-3-tomas.winkler@intel.com>
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



On 10/11/23 00:43, Tomas Winkler wrote:
> Document all entries in struct mei_cfg_idx.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.


> ---
>  drivers/misc/mei/hw-me.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index 95cf830b7c7b63e1cf555048..204b92af6c4785beb23f0212 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -102,10 +102,14 @@ static inline bool mei_me_hw_use_polling(const struct mei_me_hw *hw)
>   * @MEI_ME_PCH12_SPS_CFG:  Platform Controller Hub Gen12 5.0 and newer
>   *                         servers platforms with quirk for
>   *                         SPS firmware exclusion.
> + * @MEI_ME_PCH12_SPS_ITOUCH_CFG: Platform Controller Hub Gen12
> + *                         client platforms (iTouch)
>   * @MEI_ME_PCH15_CFG:      Platform Controller Hub Gen15 and newer
>   * @MEI_ME_PCH15_SPS_CFG:  Platform Controller Hub Gen15 and newer
>   *                         servers platforms with quirk for
>   *                         SPS firmware exclusion.
> + * @MEI_ME_GSC_CFG:        Graphics System Controller
> + * @MEI_ME_GSCFI_CFG:      Graphics System Controller Firmware Interface
>   * @MEI_ME_NUM_CFG:        Upper Sentinel.
>   */
>  enum mei_cfg_idx {

-- 
~Randy
