Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29775426E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbjGNSQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjGNSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:16:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E66B4;
        Fri, 14 Jul 2023 11:16:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A0F9B5BF;
        Fri, 14 Jul 2023 18:16:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A0F9B5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689358602; bh=jm+R7vHwwOq2dhTjthyZ/gNcY4UldlFgG2p6s1wdco4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TXltqLpgWcA0ukU8yA1pgoc5eRXYGuiVDgH7RZU7clEhEfmZQddYbR2lsDE+9vqnt
         6lbFcgjl1LPrY0Hv2gG8c2ZK/xrnwmqQg6Iv1IXCPNh6GBOTGnkdSQCHDh3hyyPR50
         weYzwJjmQF/nUnUf3FBTxoFGM+FMj8YmU6M9xJ60iDNTOgMbd6M3qmk50FiMD8aygu
         zY6QFng7Drvgl+f8lErXUD47QWu5uEwlv5s8tqpMKFiIfG5DVfUsOoSX+nYnJ+y1UV
         loTp5VeS0VjRE6bzDxC/m4nAPcm/XH/2aR2wpicvpH2WK+tWJSh/utM6qSVjiyRmkN
         nDTyZ+38z8ZMQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH docs v2] MAINTAINERS: treat Documentation/maintainer as
 process docs
In-Reply-To: <20230713230713.1505561-1-kuba@kernel.org>
References: <20230713230713.1505561-1-kuba@kernel.org>
Date:   Fri, 14 Jul 2023 12:16:41 -0600
Message-ID: <87o7ke1hpy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

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

So what this may really be telling us is that we should move the
maintainer directory under Documentation/process/.  But applying this
patch is easier, so that's what I've done for now :)

Thanks,

jon
