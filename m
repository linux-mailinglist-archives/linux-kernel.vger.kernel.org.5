Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6E771136
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjHESBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjHESBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:01:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5246D187;
        Sat,  5 Aug 2023 11:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8D260DCB;
        Sat,  5 Aug 2023 18:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B54FC433C7;
        Sat,  5 Aug 2023 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691258499;
        bh=r7nBfSWyeTdYw/kWk2GY9jXQk/ILRFWkcNU/xw+9zrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DcKOvy9bKrt4ay23PaPaXsxVkDsr0hzCe7PetdtCqptTV2/KU4LgAJE/lKzvTRh4L
         Ej0HDWpC6JQeNen6jEtNfw5fwZmzjWZpUNpCEMkwU9wUL/cZpKIHGWlw23/xhrbS1h
         9lulpTcxZEtWGMYFpYw7mHgt0pTJBv4Y30cQ606o/ejaqkojWavIxNIWAkZqQy9DWl
         S6eI7nR6UBVvtGBqDNtrflqb5cxsl6EduAor19jVeuLHppz+tVm5Dyza1e+NiMBf1l
         xytVkYEZf7gXRGPqjoYGCb44j2a6UVYPy6usGEX4Qq5y69FOvh33yZKC6kMDtSpu3w
         RX3hUdXKLCjGg==
Date:   Sat, 5 Aug 2023 19:01:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
        lgirdwood@gmail.com, broonie@kernel.org,
        Chandrakant.Minajigi@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: ad3552r: Correct device IDs
Message-ID: <20230805190131.0cab0b3d@jic23-huawei>
In-Reply-To: <011f480220799fbfabdd53896f8a2f251ad995ad.1691091324.git.marcelo.schmitt1@gmail.com>
References: <011f480220799fbfabdd53896f8a2f251ad995ad.1691091324.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 16:56:23 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Device IDs for AD3542R and AD3552R were swapped leading to unintended
> collection of DAC output ranges being used for each design.
> Change device ID values so they are correct for each DAC chip.
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Reported-by: Chandrakant Minajigi <Chandrakant.Minajigi@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> A user has reported that the IDs were wrong and the output ranges were not ok.
> Also, the dt-doc and the driver require the adi,output-range-microvolt property
> for ad3542r but not for ad3552r, which could cause actual ad3552r probing to
> fail if the device node did not have that property.
> It's not clear from datasheet if setting the output range is really required for
> ad3542r.
> 
> Was once better at sending patches. Hope I get used to it again :)
> 
> Thanks
> 
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

