Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF943754302
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 21:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjGNTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjGNTES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 15:04:18 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187D3593
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689361412;
        bh=RKP9+dtkOSw8kdqrXIUG65h5IJS1XWS71zarVC+olgM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Kwlm2ygxo9BGH1c/RgLChWDAJL80sdWP21sxfTiXfkmVg+lEiXc6CB4rGo6Fu9PrG
         IhbYWNfM5F7T2Ozw6lP6xBYJLYdWDGKz/5667MJ2zTki+cc3wWKi4BltXwZg1ZEhtK
         rYaN3i8u91HKfJAquBd2u61CzM6jLdAjmAAhMibT4itIfCk0fxJdQJllOIyXOVCE7j
         +pLeYZxqp9YzDR2llCZxA4kj7thBKjaST+uUPPefbfWLQvCaI8DIim/ln8tZFRzFRr
         IljBjHxXV5YxId3bmTWB0J47oOdjO0Rkk/6U5TjF6kqxJ0xk4VswQ4r5u85+8uxr7G
         3Trz0XvpgIhnA==
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
Thread-Index: AQHZtWtRfWVqFQFEA06/3ZItgT3fA6+3fyIAgAA0IHCAABAkAIABu/qQ
Date:   Fri, 14 Jul 2023 19:03:28 +0000
Message-ID: <c9759811145747f98462388f63358dd6@dh-electronics.com>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
 <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
In-Reply-To: <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown [mailto:broonie@kernel.org]
Sent: Thursday, July 13, 2023 6:34 PM
> On Thu, Jul 13, 2023 at 03:36:38PM +0000, Christoph Niedermaier wrote:
>> From: Mark Brown [mailto:broonie@kernel.org]
>=20
>>> Are there any dependencies for this patch?  The fact that I acked it
>>> makes me think there were MFD parts
>=20
>> It's a patch series. This patch is the last one in this series, that is
>> missing to have the ability to run the DA9061/62 without a connected IRQ
>> pin. The other patches are already upstreamed and yes there are MFD part=
s,
>> see below:
>=20
> Oh, dear.  Why weren't they applied, it's not even the confusion there
> was over what Reviewed-by means...
>=20
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@=
intel.com/
>=20
>>> I really doubt that the LKP bot ran into an issue due to a system with
>>> this device without an IRQ wired up...
>=20
>> In V3 of this patch the kernel test robot found an issue. I had really
>> overlooked that. Thanks to LKP. I forgot to replace the irq variable in
>> the function devm_request_threaded_irq(). So it affected the path with
>> IRQ. In V4 I fixed that. In V5 I only rebased it on the current next
>> 20230713 and add Marek's Reviewed-by tag.
>=20
> That doesn't mean you should include tags like this, it makes it look
> like they reported the commit...

Thanks for helping me. May I asked which tags are you referring to here?

Regards
Christoph
