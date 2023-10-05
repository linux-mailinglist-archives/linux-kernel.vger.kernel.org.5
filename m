Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8963D7BA5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241665AbjJEQSm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbjJEQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:14:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBD39523;
        Thu,  5 Oct 2023 08:43:48 -0700 (PDT)
Received: from i53875a3c.versanet.de ([83.135.90.60] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qoQVr-0006gu-Jp; Thu, 05 Oct 2023 17:43:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: rk3588is: Add AV1 decoder node
Date:   Thu, 05 Oct 2023 17:43:42 +0200
Message-ID: <8278535.T7Z3S40VBb@phil>
In-Reply-To: <531ea6cc-83b5-4c88-90a3-576e2e38bf80@collabora.com>
References: <20231005145420.169594-1-benjamin.gaignard@collabora.com>
 <2298521.ElGaqSPkdT@phil>
 <531ea6cc-83b5-4c88-90a3-576e2e38bf80@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2023, 17:39:18 CEST schrieb Benjamin Gaignard:
> 
> Le 05/10/2023 à 17:30, Heiko Stuebner a écrit :
> > Am Donnerstag, 5. Oktober 2023, 17:12:10 CEST schrieb Sebastian Reichel:
> >> Hi,
> >>
> >> On Thu, Oct 05, 2023 at 04:54:20PM +0200, Benjamin Gaignard wrote:
> >>> Add node for AV1 video decoder.
> >>>
> >>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >> No need for my SoB. Instead have this one:
> >>
> >> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >>
> >> Also worth mentioning, that this Patch needs one small fix in the DT
> >> binding (adding "resets") and one small fix in the driver for out of
> >> the box AV1 support:
> >>
> >> https://lore.kernel.org/all/20231005144934.169356-1-benjamin.gaignard@collabora.com/
> >> https://lore.kernel.org/all/20231005145116.169411-1-benjamin.gaignard@collabora.com/
> > additionally the node name should be generic.
> > The phandle can of course be av1d but the node
> > name itself needs a change.
> 
> Does "video-codec-av1@fdc70000" sound good for you ?

Nope ... please go with
	video-codec@fdc...
I.e. see the other Rockchip soc dtsi for reference.


Thanks
Heiko


