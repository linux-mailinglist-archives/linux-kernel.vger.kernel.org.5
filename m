Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7BD7EE559
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjKPQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:42:14 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE6AD5C;
        Thu, 16 Nov 2023 08:42:09 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3591DE0004;
        Thu, 16 Nov 2023 16:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700152927; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tni4t3HeZYOoXCGlFujdXfP+7OQFDAQizL+X5ze6x40=;
        b=HkHpT/iTLoAUN7BorvxDQXf6ahzJQV3JohuuCIAYJp/cbEixyWqStUBH9o8PAaDcmspi4k
        THSHmZdHg8uDYWpYXGaq9Qly/28HStoUTaZogZzHKcR4M/hYR+BABa3I8goExOv3sGBrFj
        7kX2VBEsryqZC/IwPkEMNSW9JXffVWJSzGj1eQthWx0xtoDul3HKpgjY9Kxj7YYIFXTHXU
        8BXMCtza/49BSGi/9j1YyeFgEhrsAXplntVbctbv/iB+iT2ebG3zxek40Ez2MBoDtfziS3
        TienzVLHYwBWHxxPK7hwArRAUl2a0W9DopqqiMu11uOs8mUTEM8TUNVRI37sMA==
Date:   Thu, 16 Nov 2023 17:42:06 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Message-ID: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
Reply-To: <20230930074334.1406464-1-jiconglu58@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Similar issue with ZynqMP board related to that patch:

xilinx-psgtr fd400000.phy: lane 3 (type 1, protocol 3): PLL lock timeout
phy phy-fd400000.phy.3: phy poweron failed --> -110
dwc3 fe300000.usb: error -ETIMEDOUT: failed to initialize core

With CONFIG_USB_DWC3_DUAL_ROLE and dr_mode =3D "host";

It may not be the correct fix.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
