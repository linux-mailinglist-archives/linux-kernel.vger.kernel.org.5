Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DF7BABBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjJEVCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjJEVCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:02:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B10D9F;
        Thu,  5 Oct 2023 14:02:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3958PDUC060718;
        Thu, 5 Oct 2023 03:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696494313;
        bh=aNdE9+9lpU/PBM+gU6ruz+7cnqOSZMuKGfyVQxZWM+s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=nFK8z6rzA8/SShkqxHPZe2LtFu1pAAWYbCBeEJJerhvJHK4UutEwk9yZA5NHisvQF
         u4kreJ9KuEc4kK3vefZ9690m/ZpeesacxZJXVvzf9CG97NUHN0xcY9yR6Iw6a0GOPR
         OXLln4lxWgOLxM5Wjb1p6vEtusXNXUQ1mbY657Yc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3958PDk7129292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 03:25:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 03:25:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 03:25:12 -0500
Received: from [10.249.142.56] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3958P9JS009458;
        Thu, 5 Oct 2023 03:25:10 -0500
Message-ID: <f70dec2a-dbdf-479c-af5b-a70db02b27b4@ti.com>
Date:   Thu, 5 Oct 2023 13:55:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the ti tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
CC:     Roger Quadros <rogerq@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231005141536.77538147@canb.auug.org.au>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20231005141536.77538147@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Rob and DT list

Hi Stephen

On 10/5/2023 8:45 AM, Stephen Rothwell wrote:
> Hi all,
> 
> [I may have missed this yesterday, sorry]
> 
> After merging the ti tree, today's linux-next build (arm64 defconfig)
> produced these warnings:
> 
> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #address-cells value
> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #size-cells value
> 
> Introduced by commit
> 
>   45a0c06571e1 ("arm64: dts: ti: am642-evm: Add overlay for NAND expansion card")
> 

Thanks for the report. I will drop the offending comment.

Roger,

Sorry, this would need to be fixed in dtc or need exception from DT
maintainers to ignore the warnings.

Regards
Vignesh
