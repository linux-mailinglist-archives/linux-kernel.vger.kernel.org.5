Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A607F0ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjKTDSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKTDSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:18:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDFC1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:18:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1A8C433C7;
        Mon, 20 Nov 2023 03:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700450291;
        bh=8XwKCm9UP/VzeRcoLOhdlRbg4sYFffZ3ibiushCy1yw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oIfeAgWRpDjBoZG4r2u9wsAYFfU9/c29QTbXUwJF2NGYf/ONgIKzAohe3SMVfxa8n
         ivf5xgbudyhDqAbBblF4Shw+IX86bjwj8tZ+2DIfpU7Lv5ZAnw4Yg5JT3W/F4GYLlm
         bt3bQm4yF5EAKMWTr5q9VEjyKKu1IfbZXwyxUlLVX6GUBAg/DgrYyngTiHauaDXv32
         oTXDEzyavSMu04YPp2NrVuVZBCpTl+6p2jty6Q/WpmtU3OsJDNSMiArKSVxAZgrSE7
         hCRfA3iIVc9C16pdqyWNNVcB1ezreJ2zNdlikEN4NAr9N0tKo2gczyBji7J1eeESCK
         k0bxyQRe0W2JA==
Message-ID: <4e99d1a3-026f-b5f0-fd15-fba57692d973@kernel.org>
Date:   Mon, 20 Nov 2023 11:18:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add EROFS webpage
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231117085329.1624223-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/17 16:53, Gao Xiang wrote:
> Add a new `W:` field of the EROFS entry points to the documentation
> site at <https://erofs.docs.kernel.org>.
> 
> In addition, update the in-tree documentation and Kconfig too.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Nice work!

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   Documentation/filesystems/erofs.rst | 4 ++++
>   MAINTAINERS                         | 1 +
>   fs/erofs/Kconfig                    | 2 +-
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> index 57c6ae23b3fc..cc4626d6ee4f 100644
> --- a/Documentation/filesystems/erofs.rst
> +++ b/Documentation/filesystems/erofs.rst
> @@ -91,6 +91,10 @@ compatibility checking tool (fsck.erofs), and a debugging tool (dump.erofs):
>   
>   - git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
>   
> +For more information, please also refer to the documentation site:
> +
> +- https://erofs.docs.kernel.org
> +
>   Bugs and patches are welcome, please kindly help us and send to the following
>   linux-erofs mailing list:
>   
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f51d5ec1cf..cf39d16ad22a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7855,6 +7855,7 @@ R:	Yue Hu <huyue2@coolpad.com>
>   R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>   L:	linux-erofs@lists.ozlabs.org
>   S:	Maintained
> +W:	https://erofs.docs.kernel.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>   F:	Documentation/ABI/testing/sysfs-fs-erofs
>   F:	Documentation/filesystems/erofs.rst
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index e540648dedc2..1d318f85232d 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -21,7 +21,7 @@ config EROFS_FS
>   	  performance under extremely memory pressure without extra cost.
>   
>   	  See the documentation at <file:Documentation/filesystems/erofs.rst>
> -	  for more details.
> +	  and the web pages at <https://erofs.docs.kernel.org> for more details.
>   
>   	  If unsure, say N.
>   
