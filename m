Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DB7AC412
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIWRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 13:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjIWRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 13:40:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD58E136;
        Sat, 23 Sep 2023 10:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABF1C433C8;
        Sat, 23 Sep 2023 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695490796;
        bh=FnS3ok7in/fBj9/mDYEW2dhcaSuQTDf9YAPVVeESsY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iO8JFQ6yzim66llMAm6fhiAjUX/Dl76hCTEZKgKXHakvQQkErbKTqN+dxu6Ujp+S/
         9T4Tx/mQjFst1uvXzl/0H/eNjQ9vIsaJcDV13QYIpfV2xtqflfZnA8noTISKs3k/+A
         gX8MHqRvDpuIU/pTP9JVkipuTIPfrmBXeDRjW0UhSDiR9vSqryDLTv0ayQ1yBGpcEj
         VtZoa+4tQNEQ/TyQF+WdnB/TzLNS0SFWVJDc/VQjdG9721FZZLD8DYlhrzF9RqfAH6
         mv2k2bP0FBr7yWuDzZ0stgqtYcX71jRAYHDAbOxXFaehzXs0HP+FLFEsEdl6YAs5li
         BSDm1TNrFvpJQ==
Date:   Sat, 23 Sep 2023 18:39:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shen Shen <shengaoya@inspur.com>
Cc:     <lars@metafoo.de>, <robh@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: for kernel comment
Message-ID: <20230923183949.62b9715b@jic23-huawei>
In-Reply-To: <20230921031444.63594-1-shengaoya@inspur.com>
References: <20230921031444.63594-1-shengaoya@inspur.com>
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

On Thu, 21 Sep 2023 11:14:44 +0800
Andy Shen Shen <shengaoya@inspur.com> wrote:

> In line 460 of the palmas_gpadc.c file, fix kernel comment errors.
For future reference (I've tweaked it this time) please include
the driver name in the description and also say what the change
was at least briefly (drop duplicated the).

Applied to the togreg branch of iio.git and pushed out as testing because
other things on that branch need some build testing etc.

Thanks,

Jonathan

> 
> Signed-off-by: Andy Shen Shen <shengaoya@inspur.com>
> ---
>  drivers/iio/adc/palmas_gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index e202ea18af10..203cbbc70719 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -457,7 +457,7 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
>   *
>   * The gain error include both gain error, as specified in the datasheet, and
>   * the gain error drift. These paramenters vary depending on device and whether
> - * the the channel is calibrated (trimmed) or not.
> + * the channel is calibrated (trimmed) or not.
>   */
>  static int palmas_gpadc_threshold_with_tolerance(int val, const int INL,
>  						 const int gain_error,

