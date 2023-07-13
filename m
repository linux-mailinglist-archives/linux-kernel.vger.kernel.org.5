Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B557514E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjGMABn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjGMABc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:01:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17561BF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KxXUCgJglmB5dbFFfEaMSuylDxhccdLxtBgB6REN/B4=; b=OTg/KzSH0/oOudFd276JdK54x/
        VZgOjVxeC5WtxoYfEjsEtHQ3sA93SkjC2rlVWoG82v/T8+Mbp+fN1eMP/PA8psq73Hlg89ULZLU5u
        gfelEk3Ct99LBW/Gj8N2qDBz+KhdKdbDZVk7q1U2St5KbV1vAtqqK9Cg2059dEh8Yftxu2IyWOD5d
        VaQpKWCEzJUH6hUelR7mY8MPITszMvFeqNOx5Nv398iQPTIrip8wFNOaPtOBo7IPYqd6ZJIFQq/bO
        jq8HoRqNjvL18YDhiNH7+xpg6Rnb9eUtpqYaKemeqEBLwzSjCXvaDNHdHLHVCPT5zUDHv7+P0iQje
        /awVgMKQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJjlx-001XO3-27;
        Thu, 13 Jul 2023 00:01:29 +0000
Message-ID: <a2900d12-d90a-b5d3-b158-c079911fdf03@infradead.org>
Date:   Wed, 12 Jul 2023 17:01:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] erofs: DEFLATE compression support
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
 <20230712234611.4712-1-hsiangkao@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712234611.4712-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/23 16:46, Gao Xiang wrote:
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index f259d92c9720..d7b5327215f0 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
>  
>  	  If unsure, say N.
>  
> +config EROFS_FS_ZIP_DEFLATE
> +	bool "EROFS DEFLATE compressed data support"
> +	depends on EROFS_FS_ZIP
> +	select ZLIB_INFLATE
> +	help
> +	  Saying Y here includes support for reading EROFS file systems
> +	  containing DEFLATE compressed data.  It gives better compression
> +	  ratios than the default LZ4 format, whileas it costs more CPU

not a word:                                   whileas

> +	  overhead.
> +
> +	  DEFLATE support is an experimental feature for now and so most
> +	  file systems will be readable without selecting this option.
> +
> +	  If unsure, say N.

-- 
~Randy
