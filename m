Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D27B041E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjI0M24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjI0M2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:28:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5A12A;
        Wed, 27 Sep 2023 05:28:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RCSl82038661;
        Wed, 27 Sep 2023 07:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695817727;
        bh=kpGv4yviBFiv3jDn0Nsp/s5B6ZpDCik8xDM9KmbC7A8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=I+o3hnfzmlncG62TGV3AQJQ+jYnezeeCJh5T0jfvPuHQs29nC7E/MUMXscwupzOir
         sB5QLr9fdIhSIYDv48lZ9bUNyf18nvNvKaZfi+GGgeRAMOZcGz3YKdmdBsbNLe+NrH
         1wdPVwb06h/Vz/ivUkpQbMHw+fpTr2pKjhT89lus=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RCSl4Y033798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Sep 2023 07:28:47 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 07:28:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 07:28:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RCSlDV053432;
        Wed, 27 Sep 2023 07:28:47 -0500
Date:   Wed, 27 Sep 2023 07:28:47 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v4 0/9] Add R5F and C7x DSP node for K3 J721S2, AM68 and
 AM69 SoCs
Message-ID: <20230927122847.jslgzitgcesnv5ik@gangway>
References: <20230906112422.2846151-1-a-nandan@ti.com>
 <ff0fabf8-8f55-4d91-04ee-7581efc465d6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ff0fabf8-8f55-4d91-04ee-7581efc465d6@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:24-20230927, Kumar, Udit wrote:
> 
> On 9/6/2023 4:54 PM, Apurva Nandan wrote:
> > This series adds the R5F processor nodes and C7x DSP nodes for
> > J721S2, AM68 and AM69 SoCs to align these nodes with other K3 SOC's node.
> > 
> > The first three patches adds the remote proc nodes to the SoC device
> > tree, remaining patches reserves the memory for remote proc IPCs
> > on K3 J721S2 EVM, AM68 SK, AM69 boards.
> > 
> > Note, K3 AM69 SoC derives from K3 J784S4 SoC, but is included in this
> > series as it was originally missed in the K3 J784S4 EVM rproc series.
> > (https://lore.kernel.org/all/20230502231527.25879-4-hnagalla@ti.com/).
> > 
> > kpv log: https://gist.githubusercontent.com/apurvanandan1997/57fcf127c118a48bd174ce36d8840329/raw/
> > Test log: https://gist.githubusercontent.com/apurvanandan1997/556b4148651ae74b50dda993ad07f1e5/raw/
> 
> You need to rebase the series
> 
> For patches 6/9, 7/9, 8/9 and 9/9
> 
> Reviewed by: Udit Kumar <u-kumar1@ti.com>

Please provide reviewed by for the exact patches than expecting
maintainers to pick the reviewed bys.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
