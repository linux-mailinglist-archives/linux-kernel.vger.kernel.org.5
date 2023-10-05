Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724377BA347
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjJEPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjJEPvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:08 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545771299;
        Thu,  5 Oct 2023 07:11:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395DTLwU018466;
        Thu, 5 Oct 2023 08:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1696512561;
        bh=dVZ/oX4gmdQ7oMdeoiY0ZTmy74eTe12SQx5ysletSRI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kWMhQIrLPXh7kyX+YVvoMGsKc1ZUERWjry/SoCJmbHOdneCvAtd+iLbR0Bb6RgiJ0
         4507NzhDcMA/J/cGyvwhsoQp26PWD2sxY6/wqxVel6/Lp7O7x15J3+RVeUY2lgMQy1
         gBqMvxVLiP1W1Y88ALez67l6mAsMzuxaS1y06/6Q=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395DTLtw051139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Oct 2023 08:29:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 08:29:21 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 08:29:21 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395DTLYR127845;
        Thu, 5 Oct 2023 08:29:21 -0500
Date:   Thu, 5 Oct 2023 08:29:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@kernel.org>
CC:     "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the ti tree
Message-ID: <20231005132921.2vg6kdcr273bh7et@cabbage>
References: <20231005141536.77538147@canb.auug.org.au>
 <f70dec2a-dbdf-479c-af5b-a70db02b27b4@ti.com>
 <2905cfc2-912f-4620-9455-2e91586a2839@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2905cfc2-912f-4620-9455-2e91586a2839@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:12-20231005, Roger Quadros wrote:
> Hi,
> 
> On 05/10/2023 11:25, Raghavendra, Vignesh wrote:
> > + Rob and DT list
> > 
> > Hi Stephen
> > 
> > On 10/5/2023 8:45 AM, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> [I may have missed this yesterday, sorry]
> >>
> >> After merging the ti tree, today's linux-next build (arm64 defconfig)
> >> produced these warnings:
> >>
> >> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #address-cells value
> >> arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning (avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #size-cells value
> >>
> >> Introduced by commit
> >>
> >>   45a0c06571e1 ("arm64: dts: ti: am642-evm: Add overlay for NAND expansion card")
> >>
> > 
> > Thanks for the report. I will drop the offending comment.
> > 
> > Roger,
> > 
> > Sorry, this would need to be fixed in dtc or need exception from DT
> > maintainers to ignore the warnings.
> 
> Please don't drop this patch as the issue is not with the patch but with
> the dtc tool itself.
> 
> As this is a DT overlay there is no way to specify address-cells/size-cells
> of parent here. This will be resolved only after merge with base tree.
> 
> This will be fixed in next dtc sync.
> https://www.spinics.net/lists/devicetree-compiler/msg04036.html
> 
> See further discussion here
> https://lore.kernel.org/all/CAL_JsqLmv904+_2EOmsQ__y1yLDvsT+_02i85phuh0cpe7X8NQ@mail.gmail.com/
> 

Roger, build warnings are a strict NO,NO for kernel. Lets bring in the
series *after* the dtc sync is complete.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
