Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF3B800696
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjLAJJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:09:50 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11B10A;
        Fri,  1 Dec 2023 01:09:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F82460002;
        Fri,  1 Dec 2023 09:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701421795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L+NKVfOz2Fgbsio6zc8cuhstHjWh59AQsU5LZmUWwnQ=;
        b=bkDAD8t0tE7udB5z5ZdGmW2o/mcENfEYh8t8Tv75sXtRonnh4mvpgu0dsigbZ1B6tB9feX
        dUOJ9u0Ejc1vYVA4jDKFkY6lJ7ZGj0OKbz/YlzchVee3u6xuZ4JNvyruId2hiwgui9xdNi
        Q7aoJCGI7K5GmO1q3mWRKJPKX1n57lHGh7uev6Q+rl1wYWSFTddJ8WRX0OxxkCdkJpgxhc
        XTwDIp9i1+YvPJrdAEV5P+Hn4w0ukjSPkGxjm1ZjgQJWgvPkBjDW1I2p4tyuO7EcdILuB3
        yFVL1wB2+l4Tjs32qOs/0o8Pb0W/V+evoChEWjXhTkfocdcx+/7Y7C8HAkXdkQ==
Date:   Fri, 1 Dec 2023 10:09:54 +0100
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lu jicong <jiconglu58@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] usb: dwc3: don't reset device side if dwc3 was
 configured as host-only
Message-ID: <20231201100954.597bb6de@kmaincent-XPS-13-7390>
In-Reply-To: <20231121104917.0fd67952@kmaincent-XPS-13-7390>
References: <20231116174206.1a823aa3@kmaincent-XPS-13-7390>
        <20231116175959.71f5d060@kmaincent-XPS-13-7390>
        <20231117014038.kbcfnpiefferqomk@synopsys.com>
        <20231117015527.jqoh6i3n4ywg7qui@synopsys.com>
        <20231121104917.0fd67952@kmaincent-XPS-13-7390>
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

On Tue, 21 Nov 2023 10:49:17 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> Hello Thinh,
>=20
> On Fri, 17 Nov 2023 01:55:30 +0000
> Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:

> Still not working on my side.

Hello,

Just wondering if you have received my email as you said having client mail
issue.

regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
