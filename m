Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9505D77807C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjHJSkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjHJSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:40:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA930F8;
        Thu, 10 Aug 2023 11:39:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AIcQdt058130;
        Thu, 10 Aug 2023 13:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691692706;
        bh=hRZmdsTWeuInrXsDWuDx+n88pGGV2SKD+bTU4SvORAo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kYxZDMpitOXoaCOQfjBlLT0OvfF+WcBDnsloMclcG6jtYGC+1z49u3gMXGxXyeDch
         A/jPPXjKjw1lpYpaNsm/GBD2AMSm8JYV5iN2dBP2Tyh/FSJVNaP6yoIVOk8l68xLLG
         TepXCg2qah0hbstm/RE3v9p1tr3K+U8wsivJOET0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AIcQrI107503
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 13:38:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 13:38:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 13:38:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AIcPDm107716;
        Thu, 10 Aug 2023 13:38:25 -0500
Date:   Thu, 10 Aug 2023 13:38:25 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: disable remote proc nodes
Message-ID: <20230810183825.2qtfno7ggdredpsu@glucose>
References: <20230810005629.21738-1-hnagalla@ti.com>
 <20230810011046.ta3qapj3oj2oqs7o@value>
 <2f0e9dde-0c6c-b808-02a0-c4ec659fc622@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f0e9dde-0c6c-b808-02a0-c4ec659fc622@ti.com>
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

On 10:38-20230810, Hari Nagalla wrote:
> On 8/9/23 20:10, Nishanth Menon wrote:
> > > Disable the dsp and r5f subsystem nodes by default. Proper functioning
> > > of remote processors with ipc need mailbox configurations which can
> > > vary between board configurations and applications. Hence move enabling
> > > the remote processor device nodes to where the required configurations
> > > are complete.
> > > 
> > > Signed-off-by: Hari Nagalla<hnagalla@ti.com>
> > > ---
> > > This patch fixes the remote proc yamllint errors for am69-sk board
> > Fixes tag?
> As such this yamllint errors for am69-sk.dtb were present in several earlier
> tags of linux-next. Checked with latest tag: next-20230809.
> 
> Please let me know if you would need v2 with the tag specified in comments.
> 

Please rebase on
https://lore.kernel.org/all/5ec8b817-e63f-3d76-894d-8af4f4e880db@ti.com/
series.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
