Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D501479C258
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbjILCIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbjILCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:04:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5683A1108E7;
        Mon, 11 Sep 2023 16:28:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC8AC433BD;
        Mon, 11 Sep 2023 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468739;
        bh=eot6/mvNlQGR8WEUI/rQfkdZZuCigz0bZZ+hXnR05is=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=hweH9oyYSnVaxt37kN0ZC6yGITYBrv2suuRC69GZXCGCBw43231DH8BE+7B7pnlNt
         a7XrA2fj0AOiIXiJDDG6hYYyNn1SJXKjulFkZ+AJDEEGXZ1s2DBEJSI4negVxUh7CP
         Q50aXvJSgsDNIgORtYPsuUaZGI0rEBYqNgPdVf0KFUXpObVGTtu3MWIGTL/R7Q+1FU
         6u+g5lzv8hiGZi5WOvb9oNc8LgmUwcGykUuoJfkYQ0vYwecuixRjFSqaZWfuUMEeM0
         +RO9DZrZxAalPrQI/KaLls+3g+QYWeXzLrjF3zXE/1HLbobvF6CuzuRjYFDPlcW+7O
         wfL+Ct28P8kKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 00:45:35 +0300
Message-Id: <CVGF1AQT9WI4.2660NVII9NIDU@suppilovahvero>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "joeyli" <jlee@suse.com>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Michal Suchanek" <msuchanek@suse.de>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230907165224.32256-1-msuchanek@suse.de>
In-Reply-To: <20230907165224.32256-1-msuchanek@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 7, 2023 at 7:52 PM EEST, Michal Suchanek wrote:
> No other platform needs CA_MACHINE_KEYRING, either.
>
> This is policy that should be decided by the administrator, not Kconfig

s/administrator/distributor/ ?

> dependencies.
>
> cc: joeyli <jlee@suse.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  security/integrity/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 232191ee09e3..b6e074ac0227 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -68,8 +68,6 @@ config INTEGRITY_MACHINE_KEYRING
>  	depends on INTEGRITY_ASYMMETRIC_KEYS
>  	depends on SYSTEM_BLACKLIST_KEYRING
>  	depends on LOAD_UEFI_KEYS || LOAD_PPC_KEYS
> -	select INTEGRITY_CA_MACHINE_KEYRING if LOAD_PPC_KEYS
> -	select INTEGRITY_CA_MACHINE_KEYRING_MAX if LOAD_PPC_KEYS
>  	help
>  	 If set, provide a keyring to which Machine Owner Keys (MOK) may
>  	 be added. This keyring shall contain just MOK keys.  Unlike keys
> --=20
> 2.41.0

I'd suggest to add even fixes tag.

BR, Jarkko
