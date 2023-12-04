Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD5F80353A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjLDNo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:44:25 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59DFD2;
        Mon,  4 Dec 2023 05:44:31 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4DiBr0130520;
        Mon, 4 Dec 2023 07:44:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701697451;
        bh=fTVcrXPSImjpa073BD8FHXIdvonxGLgz3UpsiJtH+co=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=xSA1upa2xPez+65zinQyjI7cNWHaG0guYXu49l8aUVgPDYLhM3FFdxWThhlNBzK4F
         Wjog+7BEZ3vvkvFuhpcOHxkOpTw+5pBZI6hH1EdZ9JHb3MM/9QYsd2I81GbUSQfBS6
         QrusVyJjYgIvFrzdWL82PcJG1tgH4dbAA5wse+7k=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4DiBSk034303
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Dec 2023 07:44:11 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 07:44:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 07:44:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4DiBWa067930;
        Mon, 4 Dec 2023 07:44:11 -0600
Date:   Mon, 4 Dec 2023 07:44:11 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Wadim Egorov <w.egorov@phytec.de>
CC:     Garrett Giordano <ggiordano@phytec.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: phycore-am64: Add R5F DMA Region and
 Mailboxes
Message-ID: <20231204134411.jp3kgateozajxlyh@parameter>
References: <20231102201216.3771589-1-ggiordano@phytec.com>
 <20231103001707.2ktwfgtqegpfiijy@subpanel>
 <5effa700-480b-4030-8335-304ebc4444b7@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5effa700-480b-4030-8335-304ebc4444b7@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:00-20231103, Wadim Egorov wrote:
> Hi Nishanth,
> 
> Am 03.11.23 um 01:17 schrieb Nishanth Menon:
> > On 13:12-20231102, Garrett Giordano wrote:
> > > Communication between the R5F subsystem and Linux takes place using DMA
> > > memory regions and mailboxes. Here we add DT nodes for the memory
> > > regions and mailboxes to facilitate communication between the R5
> > > clusters and Linux as remoteproc will fail to start if no memory
> > > regions or mailboxes are provided.
> > > 
> > > Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
> > is this fixes? Sounds more or less like rproc support is added in?
> 
> I would say it is also a fix, as the R5 cores are enabled by default at the
> SoC level devicetree and also require mboxes & memory regions to be
> configured. The docs mention both as mandatory.
> 
> Otherwise, we will encounter errors such as
> 
>   platform 78000000.r5f: device does not have reserved memory regions, ret =
> -22
> 

Please repost this, for some reason, the patch[1] does not appear[2] in the
archives and b4 drops out.

[1] https://lore.kernel.org/all/5effa700-480b-4030-8335-304ebc4444b7@phytec.de/
[2] https://lore.kernel.org/all/20231102201216.3771589-1-ggiordano@phytec.com/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
