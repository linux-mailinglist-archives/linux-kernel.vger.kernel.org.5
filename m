Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1D57C0064
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjJJPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjJJPbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A78AC;
        Tue, 10 Oct 2023 08:31:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9F7C433C8;
        Tue, 10 Oct 2023 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696951864;
        bh=zM9CD4zVI4HADHZRaDO56vw+D30wmn7/1NApYfUfJgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i8sl59nRT/ygxhvnpFooiH7W+T1wyCI5zCNSOENW6OcLf50m/nNzIN8PPudUIoPLi
         QVwl+/npE8cCScanUkk42PkeExSOeEuml5/3q7owXgDjQGhrIZVwptA+ouz4af7ox9
         xNSVw3lE/CoItR4okQDhWkI792sG8SLv3aN53LdFgpmBen4NXbqdLejbZ5DCy11hHU
         hK2xdbJzwS7e1PnvHS43zPnjep9l495RBwlbIOLydjPwsh6twet+be+z4Nw4mY1Wbq
         PjF6eDgWE+vCTovl4qmj14GpDv3D/payx05x5Zxg7H62W27nMBzh44/JR1ZMu+JVoI
         8guVlFb8GrLBQ==
Date:   Tue, 10 Oct 2023 16:31:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: adc: ad7192: Add improvements and feature
Message-ID: <20231010163116.4d0a68ec@jic23-huawei>
In-Reply-To: <20231010124927.143343-1-alisadariana@gmail.com>
References: <20231010124927.143343-1-alisadariana@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 15:49:23 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Hello,
> 
> Here is the updated patch that adds fast settling support for AD7193. I
> also added 2 commits to clean up the driver that should be applied
> beforehand.
> 
> Please consider applying the patches in order.
Looks good to me.

Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> Thank you!
> 
> v3 -> v4
> 	- two commits from the previous series were already applied to
> 	  the tree
> 	- add two new commits for cleaning up
> 	- use standard ABI for fast settling feature instead of creating
> 	  new attributes
> 	Link: https://lore.kernel.org/all/20230924215148.102491-1-alisadariana@gmail.com/
> 
> v2 -> v3
>         - move comment line above
>         - correct FIELD_PREP to FIELD_GET where needed
>         - remove unnecessary !!
>         - "rms" -> "RMS"
>         Link: https://lore.kernel.org/all/20230920003342.118813-1-alisadariana@gmail.com/
> 
> v1 -> v2
>         - replace old macros with FIELD_PREP() in commit "Use bitfield
>           access macros"
>         - update the other commits accordingly
>         Link: https://lore.kernel.org/all/20230918214854.252781-1-alisadariana@gmail.com/
> 
> Kind regards,
> 
> Alisa-Dariana Roman (3):
>   iio: adc: ad7192: Organize chip info
>   iio: adc: ad7192: Remove unused member
>   iio: adc: ad7192: Add fast settling support
> 
>  drivers/iio/adc/ad7192.c | 156 +++++++++++++++++++++++++--------------
>  1 file changed, 100 insertions(+), 56 deletions(-)
> 

