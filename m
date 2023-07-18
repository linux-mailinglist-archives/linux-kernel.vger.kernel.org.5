Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4861E75798A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 12:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjGRKtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGRKtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 06:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD594;
        Tue, 18 Jul 2023 03:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A6FF61510;
        Tue, 18 Jul 2023 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85ECC433C7;
        Tue, 18 Jul 2023 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689677354;
        bh=7PuKfUbT6USNeApOTjrCEwazNajiRjhN8ITdMPSKfEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tGr1dQZGbwwUXSI2i67E2GhUCIHAZwJ1xRNNzVQFufQmiFiSIXsCAg60FzyMnGKBd
         Yrvjjak311rpKf5wqWOLhnRoGY0DMLwRs3xM3R8nKQDTCOKA4ac8K+HAI3FT3UT8GU
         Qmvr/HPrwCQy97hTA0b5cRbGxg1CcbiX2v3/K80X2lSmprEAZZgarSXDrN9hzuEZOz
         05E/DG4JPgNgVfNUOMvmECm5tBl5C2riR0zf3JGT7s+fMy0mBtIn0W/X1XfyDzatdP
         TANbppvvJcPsQvGAoaeAL0H0iLumM/xVtP43IPnVAXKIWz4r1557DqCjj62q9vsEK8
         nRzW+EHsliRzQ==
Message-ID: <e7340950-5854-add1-a383-fa57fc208b29@kernel.org>
Date:   Tue, 18 Jul 2023 19:49:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: space required after that ','
Content-Language: en-US
To:     hanyu001@208suo.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_1D2A7704CC3721452CCE2B2E86EE04F5D90A@qq.com>
 <a1b3139f2635446abf6f3c39306aa164@208suo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a1b3139f2635446abf6f3c39306aa164@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 18:48, hanyu001@208suo.com wrote:
> Fixes the following checkpatch errors:

Same comment as in my previous email. What patch triggers this ?
Yes it is a bad code style and changing the code in that area will definitely
trigger warnings with checkpatch. But you are not changing anything...
So let's avoid churn please. If you actually fix something in that area, then
OK, add this syntax change as well.

> 
> ./drivers/ata/libata-transport.c:92: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:92: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:92: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:92: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:94: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:94: ERROR: space required after that 
> ',' (ctx:VxV)
> ./drivers/ata/libata-transport.c:94: ERROR: space required after that 
> ',' (ctx:VxV)
> 
> Signed-off-by: Yu Han <	hanyu001@208suo.com>
> ---
>   drivers/ata/libata-transport.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-transport.c 
> b/drivers/ata/libata-transport.c
> index e4fb9d1..4e87f77 100644
> --- a/drivers/ata/libata-transport.c
> +++ b/drivers/ata/libata-transport.c
> @@ -89,9 +89,9 @@ struct ata_internal {
>   /*
>    * Hack to allow attributes of the same name in different objects.
>    */
> -#define ATA_DEVICE_ATTR(_prefix,_name,_mode,_show,_store) \
> +#define ATA_DEVICE_ATTR(_prefix, _name, _mode, _show, _store) \
>       struct device_attribute device_attr_##_prefix##_##_name = \
> -    __ATTR(_name,_mode,_show,_store)
> +    __ATTR(_name, _mode, _show, _store)
> 
>   #define ata_bitfield_name_match(title, table)            \
>   static ssize_t                            \

-- 
Damien Le Moal
Western Digital Research

