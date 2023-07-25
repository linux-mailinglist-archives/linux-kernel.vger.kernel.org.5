Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0634E762769
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjGYXfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjGYXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 19:35:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4880A1FCF;
        Tue, 25 Jul 2023 16:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3FB261938;
        Tue, 25 Jul 2023 23:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954EBC433C8;
        Tue, 25 Jul 2023 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690328103;
        bh=FBbc5V63e6sL0phu+X3Ges8NLZoxCVBOjNs2xldkd1A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FgTdY2bsPEE/JnW/CQyPw7Db1avhYZCpTgTUGn8ib4tEOO7sY958fMcnGDlBTGKxK
         7tO5RIS8PG/o2IMQUQ2L5EGCyFrQU1gpdD1O/Huh05gkwwPyxZ1X3UAd+je8/YVgrZ
         jcGIAnPF3qG7XuCxE23dGbyAbIoQ8+nhUMaJApXRnOaE83DE2BB5x5y9wRjQKX+klA
         nMsnIhvSHF5xCqs5AY3vxUMhsbU3An4bG5EW59/7HD7eojKiZjsh+7UBRfAwy+pFVG
         z9y3Dk1XKRSzVBvcipBZEGV2wVdFD2p7/DSUSJuIzVD6pPKUe76mqntHMM/XXxPlxX
         QZjhMlMopzTXA==
Message-ID: <09b3a989-6215-5eac-0723-a8745d3f896d@kernel.org>
Date:   Wed, 26 Jul 2023 08:35:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] ata: pata_arasan_cf: Use dev_err_probe() instead
 dev_err() in data_xfer()
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, Viresh Kumar <vireshk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA PATA ARASAN COMPACT FLASH CONTROLLER" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230725030627.1103-1-duminjie@vivo.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230725030627.1103-1-duminjie@vivo.com>
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

On 7/25/23 12:06, Minjie Du wrote:
> It is possible for dma_request_chan() to return EPROBE_DEFER, which means
> acdev->host->dev is not ready yet.
> At this point dev_err() will have no output.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Applied to for-6.5-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

