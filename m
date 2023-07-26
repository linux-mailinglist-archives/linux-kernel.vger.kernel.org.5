Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C857642B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGZXpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 19:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGZXpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFE52135;
        Wed, 26 Jul 2023 16:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A30B661CE2;
        Wed, 26 Jul 2023 23:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADD6C433C7;
        Wed, 26 Jul 2023 23:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690415121;
        bh=pswvlk0rv9q0ZAF4xafe2oGNPXfZhIoRZDhMjRbAWtk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=so4vX3ACqE8266USjgITPYC0q8sPPePqUJVptSocGKzEwQSEW/LZ+V6aqH6N8yMEP
         1gMMB92tI5Osjoxkec/dxJO9mYV2i2zhBtj06YUe/CZ+kRIIyG29+9qF6HdPBbOoqy
         vou1WBU15AL4OngAK+tcTaTN9WHl4fcjZMivZ10npwKwwnDis5sD9ftTZUYKMgL1+/
         MTAexjo2FHcY6XC0eOm9jzmUOAseu2pO+L70CCjRLlgC+Zevdfg6Aw0mH7TIJd97hk
         OE4CLRjRkME27qgMD6jR3RKNKI5MFfxTXpVrlW1/6nPbjAJBmefrfwcQlJ++Vvibby
         cy/kk70KiajWA==
Message-ID: <ce6e2fbe-1c74-44e1-7499-5542747426bd@kernel.org>
Date:   Thu, 27 Jul 2023 08:45:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v2] ata: pata_ns87415: mark ns87560_tf_read static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230726203354.946631-1-arnd@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726203354.946631-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 05:33, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The global function triggers a warning because of the missing prototype
> 
> drivers/ata/pata_ns87415.c:263:6: warning: no previous prototype for 'ns87560_tf_read' [-Wmissing-prototypes]
>   263 | void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> 
> There are no other references to this, so just make it static.
> 
> Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to for-6.5-fixes. Thanks !


-- 
Damien Le Moal
Western Digital Research

