Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948E752DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjGMXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjGMXOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:14:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A261999;
        Thu, 13 Jul 2023 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OjO2novDaGiT46H3m8d6xCRWHC4HljnpYm08g8bi3eQ=; b=E2RQNa6ZF1FSJ7QV/QpJ+bt57l
        0R9tgns6fFstKI1Klc1b60yxOAKr6ZWbRKaJHbT5qIxy8oPDBoFn8+keLlR3AAVpKZcAHiiaKnfuE
        L8QtqZg8L9F/xIjSxlHu7Kiqpzv7t+XzO55El3dbCK0UD5OuPc7EIFKSlAachVGO+O0GVin4xIunX
        YlJV/InS4Llv0/7DZ0qAH8tvE1SqFja8faZRKqDZdVWRzs4i4d1qb7nkfqV0T8uDRN6/73znwPpuX
        5nMjZ1OWYIPP4gvynf12gfMqUiU5WTSBzBL6zQdlrqioPGjDAjAhGGHSzQ+AGipjGEtNnCrtJaOT4
        FEwMLTkw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qK5W3-004XLo-0c;
        Thu, 13 Jul 2023 23:14:31 +0000
Message-ID: <001d94a5-6afa-98cb-3b2f-05711ae309d0@infradead.org>
Date:   Thu, 13 Jul 2023 16:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH docs v2] MAINTAINERS: treat Documentation/maintainer as
 process docs
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230713230713.1505561-1-kuba@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713230713.1505561-1-kuba@kernel.org>
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

Hi,

On 7/13/23 16:07, Jakub Kicinski wrote:
> A handful of people got caught out by the recent changes in git
> which changed the format of Message-ID and broke our recommended
> applyhook for adding lore links.
> 
> This was fixed in the docs by commit 2bb19e740e9b ("Documentation:
> update git configuration for Link: tag") but it seems like few people
> have noticed. Add maintainer directory to the process entry so that
> workflows@ gets CCed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

Not your problem, but I find "DOCUMENTATION PROCESS" confusing.
It's not about the documentation process. IMO it needs a colon
at least:
DOCUMENTATION: PROCESS
or
DOCUMENTATION: DEVELOPMENT PROCESS


> ---
> v2:
>  - fix order of entries
> v1: https://lore.kernel.org/all/20230712161011.1339829-1-kuba@kernel.org/
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..fff7e50948b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6206,6 +6206,7 @@ DOCUMENTATION PROCESS
>  M:	Jonathan Corbet <corbet@lwn.net>
>  L:	workflows@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/maintainer/
>  F:	Documentation/process/
>  
>  DOCUMENTATION REPORTING ISSUES

-- 
~Randy
