Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08179DF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjIMEQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjIMEQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:16:52 -0400
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316A192
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:16:46 -0700 (PDT)
Received: (qmail 5274 invoked from network); 13 Sep 2023 13:16:45 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.38)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 13:16:45 +0900
Received: (qmail 9269 invoked from network); 13 Sep 2023 13:16:45 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 13:16:45 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913131645_26618989>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, fido_max@inbox.ru,
        joabreu@synopsys.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mwkim@gaonchips.com, perex@perex.cz,
        robh+dt@kernel.org, tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Date:   Wed, 13 Sep 2023 13:09:03 +0900
Message-Id: <20230913040902.1496711-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
References: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This feels like something we ought to be discovering from the DMA API
> somehow, while it's not quite a property of the DMA controller (but
> rather of the SoC integration) in this case it could be a property of
> some DMA controller elsewhere and the whole process of finding and
> figuring out the properties of the DMA controler is handled by the DMA
> API.

In this case, it is not used through the DMA API. 
The connection relationship is as follows.
  i2s --- pcm_dmaengine ---  DMA IP (ie. pl330)
So, control was possible only by directly setting the maxburst property.

And, I will send v2 (separate code and bindings)

Thanks,
myunguk

