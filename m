Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125477BB478
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjJFJrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJFJra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:47:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4089F;
        Fri,  6 Oct 2023 02:47:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5000DC433C8;
        Fri,  6 Oct 2023 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696585648;
        bh=Yl15YQeFlc8bzC6oSZ0ClIT+LMOvWWe4T1wyTMdQweQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GDXRlib3O1Le5bWbTLHB6PgNtXJL+0OHtFGWLEGfe1PVHz1ASUZs3dV0LIuEsSKYF
         EZ1CUHgo/0oR5L8+6P2ynTmsW0CGQFxpBj9Dsb/c+f+5u4Meurhn6YOiqYOEc2ButZ
         nVsh2Re/XvHRw56MHOwh26rocm21yBZg2tIk4f9l34XmN2Ud/crC7xs3hYua4VNd40
         /fj+VvK1tugZZEpNnFCaYkiZfpGZvzL/SqNd3xoukROobjF5g/aLg1iPwe2XANuMMA
         d52FT8acCRJPiXQt9E4Cv4UmYG6tHD5LooLSh5brELHCZ+0QY3QQk5Si+p+hHpdELx
         tk7qkluolK49A==
Message-ID: <cf16e053-2303-e60e-dfa3-368393b54cec@kernel.org>
Date:   Fri, 6 Oct 2023 18:47:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/4] ata: pata_parport: fix EXP Computer CD-865 with
 MC-1285B EPP cable
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231005205559.6504-1-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231005205559.6504-1-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 05:55, Ondrej Zary wrote:
> 
> Two bugfixes, one workaround and IDE command set registers support for fit3
> driver. All needed for EXP Computer CD-865 drive with MC-1285B EPP cable to
> work.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
> Changes in v4:
>  - coding style fixes in patch 3
> 
>  drivers/ata/pata_parport/fit3.c         | 14 +-----
>  drivers/ata/pata_parport/pata_parport.c | 78 ++++++++++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 14 deletions(-)

Applied to for-6.6-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research

