Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361B07F4159
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjKVJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjKVJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:16:13 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9F1A2;
        Wed, 22 Nov 2023 01:16:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD0C024000D;
        Wed, 22 Nov 2023 09:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700644567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pd8P94KReE7rtC9tl5ie2LKIkhmNIUEsbYj4grCZU0M=;
        b=ZW/ci6WZHSFyXWwK4JmihGUwbWHjWUTjUBhA/E8IZ0w3FE/PJmx3QB7CPbJ3ECb0G+E5bQ
        NlM5N7gLomjSpiCVQHJPvrx3oXoUmr2L2nQXlMhTPq7SSpFhaMnC/bXdsz7WQNJT4y5axb
        60mpTFTDvJMLu4t6jmwG5miPll28wiuDyCXymKKwmtt5ZwhcCcBdLC2vljYmWsoXW8+Z21
        ym15nG/lJC0hd524C44lrBMk6roj2wgzMZ0fDIwSkGRqraj1+cugpt76P3yNCqRePg3AcT
        eY+urbL+FEQy7PClrqeSzREUKsgBZBkC9caSvAxLsukJUy5yURXKmtpZMJ/d/w==
Date:   Wed, 22 Nov 2023 10:16:05 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] firmware_loader: Expand Firmware upload
 error codes with firmware invalid error
Message-ID: <20231122101605.0786440b@kmaincent-XPS-13-7390>
In-Reply-To: <20231121173022.3cb2fcad@kernel.org>
References: <20231121-feature_firmware_error_code-v2-1-f879a7734a4e@bootlin.com>
        <20231121173022.3cb2fcad@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jakub,

On Tue, 21 Nov 2023 17:30:22 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 21 Nov 2023 11:50:35 +0100 Kory Maincent wrote:
> > No error code are available to signal an invalid firmware content.
> > Drivers that can check the firmware content validity can not return this
> > specific failure to the user-space
> >=20
> > Expand the firmware error code with an additional code:
> > - "firmware invalid" code which can be used when the provided firmware
> >   is invalid =20
>=20
> Any idea what this is?
>=20
> lib/test_firmware.o: warning: objtool: test_fw_upload_prepare() falls thr=
ough
> to next function __cfi_test_fw_upload_cancel()
>=20
> My build shows this on an incremental clang 17 build.

Thanks for the report.
It seems I have to update fw_upload_err_str accordingly.
Didn't know about this test_firmware.c file.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
