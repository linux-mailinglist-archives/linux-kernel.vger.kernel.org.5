Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233A7DA345
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbjJ0WOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJ0WOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:14:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B170CE;
        Fri, 27 Oct 2023 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CMf95GxFR8SIbHmrNw3UEkZJ72B9RcomHcSfUASgMLY=; b=ryYOFteNyJn3xL50GW8vCIdkTM
        OcKJT32lSdCpPKAjPbWcMmH2bHycXecgENHdB6FEGwWGtwQnOwtbnEyjJtZXHZg1MxWNTg6EY7aBf
        NVT/lum+j2pR+2NcpDz9N1OIYgmu1n/LBxYr3MO004xMWh8RO3yfTOmqJur7GcueMwJO17YzRifYA
        EI05e3OuCRsaradAexMOL+z+AICs7GbvuYal3sOLVo5ggtu/hT9cVywDe9DKLuOCuyktnGsnEWD43
        3uRbpPmCy5HXM37oVG/2Q9csmUNSeqsdbUyIBD4k9XPbicOr89C4lwTvn6A9h7Apm5qstLVpL4hTC
        3bcywDSA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwV6B-00HHV2-0J;
        Fri, 27 Oct 2023 22:14:35 +0000
Message-ID: <c211ae84-1e72-4c3f-b69b-e4d0e58560a8@infradead.org>
Date:   Fri, 27 Oct 2023 15:14:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: vfs: fix typo in struct xattr_handlers
Content-Language: en-US
To:     Ariel Miculas <amiculas@cisco.com>, linux-doc@vger.kernel.org
Cc:     serge@hallyn.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231027152101.226296-1-amiculas@cisco.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231027152101.226296-1-amiculas@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 08:21, Ariel Miculas wrote:
> The structure is called struct xattr_handler, singular, not plural.
> Fixing the typo also makes it greppable with the whole word matching
> flag.
> 
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/vfs.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 99acc2e98673..276a219ff8d9 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -437,7 +437,7 @@ field.  This is a pointer to a "struct inode_operations" which describes
>  the methods that can be performed on individual inodes.
>  
>  
> -struct xattr_handlers
> +struct xattr_handler
>  ---------------------
>  
>  On filesystems that support extended attributes (xattrs), the s_xattr

-- 
~Randy
