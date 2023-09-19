Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463757A6163
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjISLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:35:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81D4118
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:35:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3FDC433C8;
        Tue, 19 Sep 2023 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695123311;
        bh=0pBI6sCAihdhsv5bY7X6wkSaJqwGGZtkQFy4U3+xUmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d491L4obeamS0W93OSoeKFnBCfZRNzreahdHnE54X8Lr3w59o2daKP85/Ahtkp58o
         999HWfKsfrIAP5hyYvIkEiYbanrTYdbfnZdYuCL3GNtVF2ZFzqTi1HWTLCFIpqc/fK
         pg6GxNRPPpFj/YZzLgIw8c1WaC6tZpozW6BlDLh93IpieVhJa3Xdsv6R1xK1l+hXvH
         xC4B7wDTMGSLV5+/Txw8XbKUc659V25O4pyyZoIurrlIUcASje50mnoOqYfUiVBsaY
         md46I2QFY1j0po8dQCd6mcGrGpR6CDZ2B0eGRUIrfjt46vyISt7zWRHGxTT53nJlVg
         YhziABWBUy+NQ==
MIME-Version: 1.0
Date:   Tue, 19 Sep 2023 13:35:07 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 00/41] mtd: spi-nor: clean the flash_info database up
In-Reply-To: <11380d64-09dd-352a-a6bf-3b8be332ec1c@linaro.org>
References: <20230807-mtd-flash-info-db-rework-v3-0-e60548861b10@kernel.org>
 <11380d64-09dd-352a-a6bf-3b8be332ec1c@linaro.org>
Message-ID: <996b67b91708b7858f76c35fb953e448@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-09-19 11:39, schrieb Tudor Ambarus:
> On 08.09.2023 13:16, Michael Walle wrote:
>>  - w25q32dw/layerscape spi
>>  - w25q32dw (with empty size and empty no_sfdp_flags)/layerscape spi
>>  - w25q16dw/mediatek spi
> 
> all looks good, Michael, thanks for specifying the tests done.
> I'll queue the patches with or without the small comments addressed,
> just waiting for a couple of hours to get a response from you.

Thanks, there is one small piece missing, see my reply in patch 10.
It would be great if you can amend that.

-michael
