Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16B797A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbjIGRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245037AbjIGRiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:38:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BEF1FCF;
        Thu,  7 Sep 2023 10:38:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCD5421863;
        Thu,  7 Sep 2023 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694107953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGYwNz03YulIsCZJihrmGVpNxcONlEpOhJ+MXjB3s8s=;
        b=o6uJrfKHoe+ZkVeE08Z1gTMkBmZRxXI2whJMFzZkaEeFwVzuKzFMAVvHaqTXlK6/4R5MQC
        zJUbGx1QCTskck5km0fo4IuLs1xamWY1RKF8XSRPXJYEghVyyO4Oqljiy6MAHf9X/xYU2a
        2zPepL4+pyQTUiLnlNr4wvNgWDSYVJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694107953;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGYwNz03YulIsCZJihrmGVpNxcONlEpOhJ+MXjB3s8s=;
        b=DDIaMkobFd5PRkWIdSVin4Dk8AwHbj04k3n4tXkUXxWLz354QyfXO+eICI/+qZfUcriRpg
        /UBmV/H1vLfp7SBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B70A2C143;
        Thu,  7 Sep 2023 17:32:33 +0000 (UTC)
Date:   Thu, 7 Sep 2023 19:32:32 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joeyli <jlee@suse.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
Message-ID: <20230907173232.GD8826@kitsune.suse.cz>
References: <20230907165224.32256-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907165224.32256-1-msuchanek@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding more CC's from the original patch, looks like get_maintainers is
not that great for this file.

On Thu, Sep 07, 2023 at 06:52:19PM +0200, Michal Suchanek wrote:
> No other platform needs CA_MACHINE_KEYRING, either.
> 
> This is policy that should be decided by the administrator, not Kconfig
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
> -- 
> 2.41.0
> 
