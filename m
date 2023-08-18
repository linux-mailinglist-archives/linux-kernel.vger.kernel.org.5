Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F471780660
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358197AbjHRHcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358196AbjHRHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:32:33 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA7330DF;
        Fri, 18 Aug 2023 00:32:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7E1AFF803;
        Fri, 18 Aug 2023 07:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692343948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A6HvyMolA7JCHIViBlfczdYR2onctndQrc03iXd++Jo=;
        b=dV557G9orv+v+ecXHJWguTMc7FgPMBbybtyO/Y9iaDVbfBABJ1wM7ny9AtuT49UUp1Raab
        qXyriJwpPMdP8kFjpczDr0l6QrWoJRCtX3LOOVgRLajTwup+Ok/VwRH/jyqYIMajVU5UmX
        aDRNhjO/UFQ3fNiVFatFBxhnkPHXZmDCgN4xcSDvQ+bcACJjuvTRyEkTtEpblQJG+XTdUi
        Gux5n5p0LuNK5ajwrN03/xOGNLXquiQae07WZrVmMnOwGO43S1+r79v0GKA80I2f8bhcc9
        X1x4ADk072HEhNkBjkzfLJo4+ux4HQD0IZoOjr5ys82lTBrIfsgWUy8tJ3O0AA==
Date:   Fri, 18 Aug 2023 09:32:27 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 7/7] rtc: rzn1: Report maximum alarm limit to rtc
 core
Message-ID: <20230818093227.7d984302@xps-13>
In-Reply-To: <20230817225537.4053865-8-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
        <20230817225537.4053865-8-linux@roeck-us.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

linux@roeck-us.net wrote on Thu, 17 Aug 2023 15:55:37 -0700:

> RZN1 only supports alarms up to one week in the future.
> Report the limit to the RTC core and use the reported limit
> to validate the requested alarm time when setting it.
>=20
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
