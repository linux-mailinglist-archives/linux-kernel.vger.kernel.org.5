Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE077CD58D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344514AbjJRHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:40:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DC2B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:40:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29228C433C7;
        Wed, 18 Oct 2023 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697614807;
        bh=52gu4uhHVMhD/2inO2iHCSdv7ffG5JVaRL7n7IKgzIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V88jOWnNtotfbOOgqvqTCotxydelHAlUUl284iLp88/HB+ldzp/8igPk2zTn2uCJ6
         pEtR5S9WXCHXFS7kwze77ZrIdqmOkTdhgR3n1Sx5gO5BWdUwsw+frIuKCkyAwjofml
         ihWQZxpS4J0heyaFv8GnMSjccVa8mQFvZWNiYwMY=
Date:   Wed, 18 Oct 2023 09:40:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix coding style - remove CamelCasing
Message-ID: <2023101841-unglazed-hydration-d6b8@gregkh>
References: <ZS+HyqwvyVyfzGXs@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+HyqwvyVyfzGXs@lab-ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:22:50AM +0300, Calvince Otieno wrote:
> This patch addresses coding style errors identified by checkpatch. The
> changes include converting camel case names in constant variables to
> UPPERCASE. These changes align with the coding style guidelines.
> 
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>  drivers/staging/vme_user/vme.h        | 12 ++--
>  drivers/staging/vme_user/vme_fake.c   |  8 +--
>  drivers/staging/vme_user/vme_tsi148.c | 88 +++++++++++++--------------
>  3 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
> index fbcbd0204453..0b40859fee23 100644
> --- a/drivers/staging/vme_user/vme.h
> +++ b/drivers/staging/vme_user/vme.h
> @@ -33,13 +33,13 @@ enum vme_resource_type {
>  #define VME_SCT		0x1
>  #define VME_BLT		0x2
>  #define VME_MBLT	0x4
> -#define VME_2eVME	0x8
> -#define VME_2eSST	0x10
> -#define VME_2eSSTB	0x20
> +#define VME_2EVME	0x8
> +#define VME_2ESST	0x10
> +#define VME_2ESSTB	0x20

Checkpatch is wrong here, this should stay as-is.

thanks,

greg k-h
