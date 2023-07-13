Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69617752A44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGMSVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjGMSVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:21:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982252D43;
        Thu, 13 Jul 2023 11:21:19 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIL7Qk083022;
        Thu, 13 Jul 2023 13:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689272467;
        bh=EujEkEbqmzWpWU/kv+bpKsFhVWw8zK17xtacArJ+lhA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jNc0ArRmJcvP8r1r52CMUBo65vO3qIX4C3OeYrwgIB80Js5PDYBYIw+Dl2J2vx1Ii
         YvKfqA3taKIebSxCouq7cqxcwZDd26g9A87G0f6pNp+9mMOJ3ACYINiliZ/PtpP/qN
         ICL9Enf9ZXHda8obQw93Fm69F4RS/Q3g/wjoDqyc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIL7ac091856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:21:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:21:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:21:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIL7eC048060;
        Thu, 13 Jul 2023 13:21:07 -0500
Date:   Thu, 13 Jul 2023 13:21:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
Message-ID: <20230713182107.ashuygyg4x4j77s5@backboard>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-4-j-choudhary@ti.com>
 <20230712141828.lnpo4mhd5dv34rlz@census>
 <18310450-05f3-172c-e4bc-fda114f333a4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18310450-05f3-172c-e4bc-fda114f333a4@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:01-20230713, Jayesh Choudhary wrote:
> 
> 
> On 12/07/23 19:48, Nishanth Menon wrote:
> > On 15:47-20230710, Jayesh Choudhary wrote:
> > > From: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > 
> > > J784S4 SoC has 4 Serdes instances along with their respective WIZ
> > > instances. Add device-tree nodes for them and disable them by default.
> > > 
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > [j-choudhary@ti.com: fix serdes_wiz clock order]
> > > Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> > > ---
> > NAK. This patch introduces the following dtbs_check warning.
> > arch/arm64/boot/dts/ti/k3-am69-sk.dtb: serdes-refclk: 'clock-frequency' is a required property
> > 
> 
> Sorry for this. This property was added in the final board file.
> I will fix it in the next revision.
> I will add '0' as clock-property in the main file similar to j721e[1]
> which will be overridden in the board file with required value to get
> rid of this warning.

That would follow what renesas (r8a774a1.dtsi) and imx
(imx8dxl-ss-conn.dtsi) seem to be doing as well. Just make sure to add
documentation to the property to indicate expectation. Unless someone
has objections to this approach.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
