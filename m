Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57976CE59
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjHBNUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjHBNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:20:14 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCB32D76;
        Wed,  2 Aug 2023 06:19:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 372DJaQW121305;
        Wed, 2 Aug 2023 08:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690982376;
        bh=M72XeTXRwzSvth9sAd+tBED6fXANjUgTO4CFhDTqHxk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ogM8pqWz6B61S34M7CTJTlxeBWBzQk74uw8L9lQiudnQodBxN3n/w3fLydBGCCiKH
         QkEkIruCCAAqywTblzmvkjXtiOcYkFs04rhLK1m/O5RQEXkx8x11hT7mvo+BlkNE9r
         ypgETG+2ZiCnP3us1fO/G92fPhWR4pzGzr7tnXoI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 372DJaOI041360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Aug 2023 08:19:36 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Aug 2023 08:19:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Aug 2023 08:19:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 372DJab2081580;
        Wed, 2 Aug 2023 08:19:36 -0500
Date:   Wed, 2 Aug 2023 08:19:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hiago De Franco <hiago.franco@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-am625-verdin: enable CAN_2
Message-ID: <20230802131936.zkxypz5odj6ua4mv@cassette>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-3-francesco@dolcini.it>
 <20230802034325.puqhry4xocaceldl@clothes>
 <ZMoI70GFNcdIiJnN@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMoI70GFNcdIiJnN@francesco-nb.int.toradex.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:42-20230802, Francesco Dolcini wrote:
> On Tue, Aug 01, 2023 at 10:43:25PM -0500, Nishanth Menon wrote:
> > On 15:36-20230724, Francesco Dolcini wrote:
> > [...]
> > 
> > > +	/* Verdin CAN_2 */
> > > +	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
> > > +		pinctrl-single,pins = <
> > > +			AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> > > +			AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */
> > 
> > This is minor - I realize we already accepted this, but:
> > /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> > Vs
> > /* (B3) MCU_MCAN0_RX - SODIMM 26 */
> > 
> > I wonder if you'd like the second style.
> 
> For sure I do not like to have the file with 2 different styles, and to
> me this is just a taste thingy that would not justify updating the whole
> file.
> 
> I'll keep it as it is.

That is fine. Thanks.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
