Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37CC759240
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGSKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGSKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17522106;
        Wed, 19 Jul 2023 03:01:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA39F61355;
        Wed, 19 Jul 2023 10:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6302C433C7;
        Wed, 19 Jul 2023 10:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760861;
        bh=SSeHiXUfSG7Z7jlkcplDS675enDfnxq4QJm6cA2jMPI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c0lWD6Nk72NWD0M4r6k7PSYwI6H9kEf685fbrQP35C3DzvzapPOT38KE3sd4LRxsE
         3FZijP0YmZArQkXgYxU/fCKnmdi+QOnEthe0OSTDvQn/fYCJw2bwNHF2pKrLdMAI1I
         YdCCcPDTesToygGLZJZJFXbj28fsMp/4L4yu2oLdeX6HChBgg8QB/AgkFGVLaC0wy6
         ASGTA61JuVBKwLIMrZIAYZ7BdC29tnou7d5jvHca9BY6jj87IjAFOoGuOPa5vTZRru
         VKgWOvTGDObGRn7v/8SS96iyTyDFCNaYgpZND/+rsgdBm5d6ExtPRNkYhIIjtyptN7
         eu1vDNKo9p4+w==
Message-ID: <ba6fd61f-cf72-85b2-10a2-7dbe1813e54f@kernel.org>
Date:   Wed, 19 Jul 2023 19:00:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: Fix comment typo
Content-Language: en-US
To:     zhumao001@208suo.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718161444.1710-1-dengshaomin@cdjrlc.com>
 <20230718161444.1710-2-dengshaomin@cdjrlc.com>
 <56b15d6a54bb736314a3182a3aa1ba27@208suo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <56b15d6a54bb736314a3182a3aa1ba27@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 01:21, zhumao001@208suo.com wrote:
> Delete repeated word in comment.

Please fix the patch title to:

ata: sata_dwc_460ex: Remove repeated word in comment

> 
> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> ---
>  drivers/ata/sata_dwc_460ex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index fabdd1e380f9..28c0e31cc128 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1081,7 +1081,7 @@ static const struct scsi_host_template
> sata_dwc_sht = {
>      /*
>       * test-only: Currently this driver doesn't handle NCQ
>       * correctly. We enable NCQ but set the queue depth to a
> -     * max of 1. This will get fixed in in a future release.
> +     * max of 1. This will get fixed in a future release.
>       */
>      .sg_tablesize        = LIBATA_MAX_PRD,
>      /* .can_queue        = ATA_MAX_QUEUE, */

-- 
Damien Le Moal
Western Digital Research

