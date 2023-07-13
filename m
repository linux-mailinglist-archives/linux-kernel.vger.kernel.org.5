Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C856B752763
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjGMPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjGMPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:37:34 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C16E2117
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689262602;
        bh=w9J3irrHs1UHas9WttzJ+3FfN1QrNrS6X6BKOOdzlf8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=W19Iw2laf5+2MTyVaOXEr6SQKej6bKaZYR6W9Mb1VXTX9jaBUuBphA/rBxzbv0eJ8
         DapFp13Ts5wFJQI6d/qwjtRFMRHNny3lFT0A4wLNi2+aVByJHzCVQOYxnmNzVSyHuZ
         vOhfv0zEBsFplcPAOmGM24nME10bqgDW0vqVLve9lTCnPkrlyi9bQMFCCA0IKn+tR9
         u82wzwOoffUljbK8FhkfmaR+1PhygxnLNIqI2kNyhKJJWRDuJbJBkm64R+UjT8JN7r
         be4bP6hX+MjSVXd9sq/WkKEFT4xqYFksVCHXJo2JbU75wiwkkOgryJvU+oK4zHCLbl
         th3Zq6y4onEJw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZtWtRfWVqFQFEA06/3ZItgT3fA6+3fyIAgAA0IHA=
Date:   Thu, 13 Jul 2023 15:36:38 +0000
Message-ID: <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
In-Reply-To: <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown [mailto:broonie@kernel.org]
Sent: Thursday, July 13, 2023 2:30 PM
> On Thu, Jul 13, 2023 at 11:03:28AM +0200, Christoph Niedermaier wrote:
>=20
>> This patch makes the use of IRQ optional to make the DA9061/62 usable
>> for designs that don't have the IRQ pin connected, because the regulator
>> is usable without IRQ.
>=20
> Are there any dependencies for this patch?  The fact that I acked it
> makes me think there were MFD parts

It's a patch series. This patch is the last one in this series, that is
missing to have the ability to run the DA9061/62 without a connected IRQ
pin. The other patches are already upstreamed and yes there are MFD parts,
see below:

1: commit 7ef5c57758c4 ("dt-bindings: mfd: da9062: Move IRQ to optional pro=
perties")
2: commit 7d61f6313e90 ("mfd: da9062: Use MFD_CELL_OF macro")
3: commit c923d5001ba0 ("mfd: da9062: Remove IRQ requirement")
4: This patch ("regulator: da9062: Make the use of IRQ optional")

>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@in=
tel.com/
>=20
> I really doubt that the LKP bot ran into an issue due to a system with
> this device without an IRQ wired up...

In V3 of this patch the kernel test robot found an issue. I had really
overlooked that. Thanks to LKP. I forgot to replace the irq variable in
the function devm_request_threaded_irq(). So it affected the path with
IRQ. In V4 I fixed that. In V5 I only rebased it on the current next
20230713 and add Marek's Reviewed-by tag.

Regards
Christoph
