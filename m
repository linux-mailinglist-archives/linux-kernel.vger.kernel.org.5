Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548647FE422
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjK2XU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2XU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:20:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29260BF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:20:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263AEC433C7;
        Wed, 29 Nov 2023 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701300032;
        bh=YXXUetntHaoD/oZOG6nHngu5pIoCCOvIwSu2+9ObcQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=czyY+fkOLMklJdZ7Zkn+OXhMF8fk8zJmtbIPKzSRViHsA6ibYGWCyOX2SjD4mJrej
         z2zBQrXU53T8qKfkxklZ+P5HShDm5DSIJ8+nWDgFqPA/RfzK6CyngSUKAvpsrwaLSG
         qUFtjdGHYVBf0DpLgy+BBtOXOnQQnQXTII2rNBrFUwEWlUzuAL+Km3uCDXjRzbkRNH
         vbGxWnm3OmiGlnk247GQl7AjTsDRuEnQ94vsAqZHucKaJNtaMMjvy46iDvJFpbz6H0
         wfoN+o67vEdLmG06cK96HahHiE8tcCAVTkjsjBpbC6ZM4fqQm5jApykxGUJVpwYVRw
         V9Kz5ltsQWYTg==
Date:   Thu, 30 Nov 2023 00:20:28 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 24/24] i2c: designware: Fix spelling and other issues
 in the comments
Message-ID: <20231129232028.nvcucoapxe4fhraw@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-25-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-25-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

[...]

> @@ -210,12 +210,12 @@ static void psp_release_i2c_bus(void)
>  {
>  	mutex_lock(&psp_i2c_access_mutex);
>  
> -	/* Return early if mailbox was malfunctional */
> +	/* Return early if mailbox was malfunctioned */

has malfunctioned?

>  	if (psp_i2c_mbox_fail)
>  		goto cleanup;
>  
>  	/*
> -	 * If we are last owner of PSP semaphore, need to release aribtration
> +	 * If we are last owner of PSP semaphore, need to release arbitration
>  	 * via mailbox.
>  	 */

as we are at this, perhaps we can add some articles and pronouns
to improve the grammar:

	/*
	 * If we are the last owner of the PSP semaphore, we need to release
	 * arbitration via the mailbox
	 */

Rest looks good.

Thanks,
Andi
