Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5D17514BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjGLXqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjGLXql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:46:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0772210C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=L9tpokstGVrz15ke9uYakgX1lrcBxGQZF3ESE7tsLVc=; b=wX/onM/q/YJk+q9YGE7Jd26ImD
        PYh1ZhkbW5P8BaRgEDUo45GtGZqijTJLoFBd0nNxCdExNd/rwml69azHcesqEZjfvisV4zVU/3VDI
        E2lfuCnbUvcAw0ZrwLBMs8MtCU5ESdWzVUXz2F3oQOvEel0KxL+6T6ZWUqoS1LW/s7xx1oL7t3xoC
        YFk8nK1CvD7VZUXaa3Fr62inMVojAXbWxryNZoCkwNYRBb4nZ7waX1q+qxI5sJS3hEFapR8abl4PR
        5GAlm58GghKP7nccRd53OkfJjRarsaLWnGv+pYRl3t04d36f3Wnjfbfm1yruxUe58ekLfqlKxPFZt
        YKLc2gig==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJjXN-001Vzs-33;
        Wed, 12 Jul 2023 23:46:25 +0000
Message-ID: <e3a637af-ed6f-cd18-9423-bdb34ae60f3b@infradead.org>
Date:   Wed, 12 Jul 2023 16:46:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND] erofs: DEFLATE compression support
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230712233026.118706-1-hsiangkao@linux.alibaba.com>
 <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230712233347.122544-1-hsiangkao@linux.alibaba.com>
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

Hi--

On 7/12/23 16:33, Gao Xiang wrote:
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

	                                      while
or	  although
or	  but

> +	  overhead.
> +
> +	  DEFLATE support is an experimental feature for now and so most
> +	  file systems will be readable without selecting this option.
> +
> +	  If unsure, say N.

-- 
~Randy
