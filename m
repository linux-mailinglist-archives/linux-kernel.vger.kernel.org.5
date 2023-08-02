Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EED76C74D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjHBHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbjHBHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:45:05 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E1E2710;
        Wed,  2 Aug 2023 00:42:44 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id C6487213FA;
        Wed,  2 Aug 2023 09:42:42 +0200 (CEST)
Date:   Wed, 2 Aug 2023 09:42:39 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Hiago De Franco <hiago.franco@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: ti: k3-am625-verdin: enable CAN_2
Message-ID: <ZMoI70GFNcdIiJnN@francesco-nb.int.toradex.com>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-3-francesco@dolcini.it>
 <20230802034325.puqhry4xocaceldl@clothes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802034325.puqhry4xocaceldl@clothes>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:43:25PM -0500, Nishanth Menon wrote:
> On 15:36-20230724, Francesco Dolcini wrote:
> [...]
> 
> > +	/* Verdin CAN_2 */
> > +	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
> > +		pinctrl-single,pins = <
> > +			AM62X_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> > +			AM62X_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */ /* SODIMM 24 */
> 
> This is minor - I realize we already accepted this, but:
> /* (B3) MCU_MCAN0_RX */ /* SODIMM 26 */
> Vs
> /* (B3) MCU_MCAN0_RX - SODIMM 26 */
> 
> I wonder if you'd like the second style.

For sure I do not like to have the file with 2 different styles, and to
me this is just a taste thingy that would not justify updating the whole
file.

I'll keep it as it is.

Francesco


