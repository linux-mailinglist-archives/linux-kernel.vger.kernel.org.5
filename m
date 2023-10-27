Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD37D9A87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346026AbjJ0Nzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJ0Nzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:55:45 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF30C0;
        Fri, 27 Oct 2023 06:55:42 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39RDt8js078239;
        Fri, 27 Oct 2023 08:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698414908;
        bh=zHRB8cKNp3Ejq29yxcHT1tf60dlqVxPf+pQGoHmiGfY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EPjq8eHDETW4rOL286BtUtvIwyaD7rYg3PZ4jNgLhqlR0aP1Lq1PI9kdeLPqpzX7R
         swVQJlrCaD5JpbMOkLno1yFymFEJHnhRTU0C2djGj1g2uPNd11yCpc0ZYUQAlWm0Z8
         wTbPwYcLKeTDoyklF7euEFAl/P2PXHQThHAaDm9E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39RDt8n1070634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 08:55:08 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 08:55:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 08:55:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39RDt8wZ018748;
        Fri, 27 Oct 2023 08:55:08 -0500
Date:   Fri, 27 Oct 2023 08:55:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Benedikt Niedermayr <benedikt.niedermayr@siemens.com>
Subject: Re: [PATCH 4/7] arm64: dts: ti: iot2050: Refactor the m.2 and
 minipcie power pin
Message-ID: <20231027135508.2up657g74muvhz6t@favoring>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <ccac993e604b912bb8472f08f5fd43c528c7973b.1698413678.git.jan.kiszka@siemens.com>
 <20231027134325.qvwe4ocpf36qvmry@prism>
 <110c4e57-adab-4211-9d8f-4603a5e5e756@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <110c4e57-adab-4211-9d8f-4603a5e5e756@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:45-20231027, Jan Kiszka wrote:
> On 27.10.23 15:43, Nishanth Menon wrote:
> > On 15:34-20231027, Jan Kiszka wrote:
> >> From: Su Bao Cheng <baocheng.su@siemens.com>
> >>
> >> Make the m.2 power control pin also available on miniPCIE variants.
> >>
> >> This can fix some miniPCIE card hang issue, by forcing a power on reset
> >> during boot.
> >>
> >> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> >> ---
> > 
> > Jan - please Sign-off for the carried chain..
> > 
> 
> Sure, can do. Was intentionally not doing that because I somewhere
> picked up that this is not desired.

Hmm... Documentation/process/submitting-patches.rst
Signed-off-by: must always be that of the developer submitting the
patch. --> I assume you are this ;).
   Signed-off-by: First Co-Author <first@coauthor.example.org>
   Signed-off-by: Second Co-Author <second@coauthor.example.org>
   Signed-off-by: From Author <from@author.example.org>
   Signed-off-by: Random Co-Author <random@coauthor.example.org>
   Signed-off-by: From Author <from@author.example.org>
   Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
