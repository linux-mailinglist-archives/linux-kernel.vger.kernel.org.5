Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B776BBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHASBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjHASBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC34C2110;
        Tue,  1 Aug 2023 11:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C9B6165F;
        Tue,  1 Aug 2023 18:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CAAC433C8;
        Tue,  1 Aug 2023 18:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912874;
        bh=SDiTEHmqRQneCIydIMNwfooNPbP30yM2hiPLGaYqj9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ptx2v+Vu3yMtXEfT16XDzMzFpUTBSk/3Xq71X8iJrKVJASiElf181+4Ui+0ulyEM+
         0ez1IGRAE5meiiZrsEfnYPepMHFYqck8oFMM4lypZ/nCIObh8P0xkXVAk+HalC8G3s
         QA/ZJUGElEONjH97muCkFqItoJNZNKnBn77DZY7BVToyERQbjniNhJY0d1o86BuyI5
         HCh9PW8FMWhSxa4JTtPMEKr5qHreDpdQrzLvHTX8Cf7WauGot2zB4ILHn+fkPt0r4v
         ucXOzG/wlP8tkbozN8PbJUqhO8KjEIBoMH+NnV3/pWEQLy4bJI4XaddF6kP4N658eN
         ZsZAdIvp/54wg==
Date:   Tue, 1 Aug 2023 19:01:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
        lgirdwood@gmail.com, broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r: Correct device IDs
Message-ID: <20230801190107.2ebc3e61@jic23-huawei>
In-Reply-To: <38b71b347f9c75e926dec55d7ecfa078aedd70c6.1690804520.git.marcelo.schmitt1@gmail.com>
References: <38b71b347f9c75e926dec55d7ecfa078aedd70c6.1690804520.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 08:59:35 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Device IDs for AD3542R and AD3552R were swapped.
> Change device ID values so they are correct for each DAC chip.
> 
Hi Marcelo,

Agreed with the patch and that it matches the datasheets.. However
needs more info in the description so that people know how urgent the fix is.

Missing.
- Fixes tag so we know what trees need the fix (as they include the ID in
  the fixes tag.
- Description of the user visible effects of this bug.

With those added I'll be happy to queue this up. Note I've just sent
a pull request for fixes, so not in a hurry for this - otherwise
I 'might' have figured out the details and added them whilst applying.

Thanks

Jonathan
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
>  drivers/iio/dac/ad3552r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index d5ea1a1be122..a492e8f2fc0f 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -140,8 +140,8 @@ enum ad3552r_ch_vref_select {
>  };
>  
>  enum ad3542r_id {
> -	AD3542R_ID = 0x4008,
> -	AD3552R_ID = 0x4009,
> +	AD3542R_ID = 0x4009,
> +	AD3552R_ID = 0x4008,
>  };
>  
>  enum ad3552r_ch_output_range {

