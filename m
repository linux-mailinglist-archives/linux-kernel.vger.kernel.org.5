Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5137D7591D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGSJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGSJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD411BFD;
        Wed, 19 Jul 2023 02:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BA461355;
        Wed, 19 Jul 2023 09:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E45AC433C9;
        Wed, 19 Jul 2023 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689759822;
        bh=O05gYRt4tnmtGMhoOJ98YjOddIc4z4YFM2DBhuss2PI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pPC/JQfaKSN9jJb8qejSES0aMcIeBHme5q9ampwNQgiNJ0ioLad84EKefPP3VI8px
         tvxiPmLKizxEl7rk3sF/YcyoMd0MhxDxXbgAFgR6ucYI9rWv15RKMtXjKQFXOKUIJn
         jcA/qNSIEEOn/xgStqJH1vrpwmCnv0zZ0WdTQbxJpL20XDTwwC/dAfMYqBP3AFAMxc
         SjFW8Qglf7zPIJeaPrdNy7E/ZMYGhqqRIkdP9tAirqNS8Wv9dNtcMWwxwQM0ce0YHz
         q80Al5SoJWFD6fCmvyyDIhIC5BE63E30fvZSPr6wNRfHxh877J8iyKR8RoU2Web8Es
         Jd/WJztFiNEqA==
Message-ID: <231b4e0c-bc58-1f4f-ac26-30fc0036887f@kernel.org>
Date:   Wed, 19 Jul 2023 18:43:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: pata_serverworks: "foo * bar" should be "foo *bar"
Content-Language: en-US
To:     hanyu001@208suo.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_FAA8D636BA8369FE01896CB144F12E543905@qq.com>
 <fee05ac48ee8c60b0843a7d63260ba1d@208suo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <fee05ac48ee8c60b0843a7d63260ba1d@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 10:54, hanyu001@208suo.com wrote:
> This patch fixes the checkpatch.pl error:
> 
> ./drivers/ata/pata_serverworks.c:305: ERROR: "foo * bar" should be "foo
> *bar"
> 
> Signed-off-by:     Yu Han <hanyu001@208suo.com>

Please stop sending patches like this. I will not apply such patch
unless you actually fix a bug or a compilation warning.

> ---
>  drivers/ata/pata_serverworks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_serverworks.c
> b/drivers/ata/pata_serverworks.c
> index b348784..549ff24 100644
> --- a/drivers/ata/pata_serverworks.c
> +++ b/drivers/ata/pata_serverworks.c
> @@ -302,7 +302,7 @@ static int serverworks_fixup_csb(struct pci_dev *pdev)
> 
>      /* Third Channel Test */
>      if (!(PCI_FUNC(pdev->devfn) & 1)) {
> -        struct pci_dev *findev = NULL;
> +        struct pci_dev * findev = NULL;
>          u32 reg4c = 0;
>          findev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
>              PCI_DEVICE_ID_SERVERWORKS_CSB5, NULL);

-- 
Damien Le Moal
Western Digital Research

