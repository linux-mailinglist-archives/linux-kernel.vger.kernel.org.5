Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95E7A65FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjISN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjISN6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1018D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:58:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9B3C433C8;
        Tue, 19 Sep 2023 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695131920;
        bh=UxRhnS3JOGCE8g/RmJvIG0qBsms7b8zFihoa5FSbe5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/niI/ZuPA5qXnFOhzy4YuWeoPzIBAGbOErwF8Uf67D/+nOnsruJeKdVJdBahW4Kl
         aMP9+crL7b0fMBs4XrVA3o2UrVuJ1cC8FAcRclwHggJ6gyNcTdIDqYsZFVvghl09J7
         UP9m0eTGZ9j4esZ4LP0KPQtcTG/q5S0hRmZM9vyrYrC5/Zu9M/0PISNpeN4FQrz1rO
         AdjVawEXPawPDUeZIfTyxFiVUGZrsGp4aLV6oV6LtS0xp78+kRiXB15vIU4hdEj50W
         f6Oh6h3J2l4/6hoiB5ByQUT99tGjMMQN+hxelvx/URIo3ntuRKceqPYq0EjUI2LESR
         D9F1H7Iqd9BwA==
Date:   Tue, 19 Sep 2023 14:58:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH for-v6.6] mfd: cs42l43: Use correct macro for new-style
 PM runtime ops
Message-ID: <20230919135835.GT13143@google.com>
References: <20230919110320.1388527-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230919110320.1388527-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Uwe Kleine-König wrote:

> From: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> The code was accidentally mixing new and old style macros, update the
> macros used to remove an unused function warning whilst building with
> no PM enabled in the config.
> 
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Link: https://lore.kernel.org/all/20230822114914.340359-1-ckeepax@opensource.cirrus.com/
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello Linus,
> 
> this patch was submitted on August 22 already, but -rc2 is still
> unfixed. This makes allmodconfig builds on (at least) s390 and m68k
> fail.
> 
> Lee who should normally send this fix to you seems to be swamped in
> other work and asked: "If anyone wants to submit this directly to Linus
> before -rc1, please, be my guest."
> 
> Voilà, I'm Lee's guest now :-)

Thanks Uwe.

> Thanks for considering to take this patch this way,
> Uwe
> 
>  drivers/mfd/cs42l43.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> index 37b23e9bae82..7b6d07cbe6fc 100644
> --- a/drivers/mfd/cs42l43.c
> +++ b/drivers/mfd/cs42l43.c
> @@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
>  }
>  
>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>  };
>  
>  MODULE_DESCRIPTION("CS42L43 Core Driver");
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> -- 
> 2.40.1
> 

-- 
Lee Jones [李琼斯]
