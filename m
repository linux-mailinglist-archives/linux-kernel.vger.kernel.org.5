Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2E7D9A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbjJ0NoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346158AbjJ0NoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:44:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C9CCA;
        Fri, 27 Oct 2023 06:44:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39RDhQVF028798;
        Fri, 27 Oct 2023 08:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698414206;
        bh=3rDRLhnrXxERWUz9JFDk4LH+AO1bqojQxFOibShO0ks=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=vjD+cbFcueLVtw0uf67Onh1BVyECSXGfwPh0vEItvMMFnPhGwzhAbuqd0fP1gfn9i
         IWuuLsp+gJHorMGiKvq+Ia+0485u9o0Ed8Vj/04rle+bx383FU8ZZPuVGJDN3IBptM
         /FCvFnrtzBSyS/xflPq3gLb+cUqCCcGAuwxAtss8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39RDhQJS061568
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Oct 2023 08:43:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 27
 Oct 2023 08:43:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 27 Oct 2023 08:43:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39RDhPp2109082;
        Fri, 27 Oct 2023 08:43:25 -0500
Date:   Fri, 27 Oct 2023 08:43:25 -0500
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
Message-ID: <20231027134325.qvwe4ocpf36qvmry@prism>
References: <cover.1698413678.git.jan.kiszka@siemens.com>
 <ccac993e604b912bb8472f08f5fd43c528c7973b.1698413678.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ccac993e604b912bb8472f08f5fd43c528c7973b.1698413678.git.jan.kiszka@siemens.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:34-20231027, Jan Kiszka wrote:
> From: Su Bao Cheng <baocheng.su@siemens.com>
> 
> Make the m.2 power control pin also available on miniPCIE variants.
> 
> This can fix some miniPCIE card hang issue, by forcing a power on reset
> during boot.
> 
> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
> ---

Jan - please Sign-off for the carried chain..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
