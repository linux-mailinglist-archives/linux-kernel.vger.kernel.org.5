Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6778E6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 08:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjHaG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 02:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjHaG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 02:58:53 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F41BB;
        Wed, 30 Aug 2023 23:58:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EC4740002;
        Thu, 31 Aug 2023 06:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693465121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mcCcXr5HETuNZSBKg2FbAkAvz3dX9WVKmz2hqOqYvZo=;
        b=eD/QmdpOXdXgYu8QQfPQg2dXJXG5uktxB68BECBUG44LETwJxUhTHls5cmbi8R3L9oarX2
        OPGTjRyCW1gG1+v/Fe/dWhHRORXVRWHP23nOWrUeTuOpkkN3yv4BM4ZVg7SgCPrsm3NR6f
        i4QT36ftg/CtL18mQeEeiQTTHSKRauYj2PnHHXP7UfTLYiPorU9Kx6Jmk6StJsyj3YBCd8
        g7kBuFZ3elqVr5351qeSQ6AP24eiUuiXYV/8WMSE4LNbiXC0G/6eV+5+nVwzxjlAA62aDz
        rfqCMC+9txoHowCcHrSkwHCtRg4RtIPj7X1Ayo1Vol4sWcAIg6qJO6vJSVkmKw==
Date:   Thu, 31 Aug 2023 08:58:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 3/4] thermal: Use
 thermal_tripless_zone_device_register()
Message-ID: <20230831085838.2e3b99cd@xps-13>
In-Reply-To: <8272147.T7Z3S40VBb@kreacher>
References: <1870450.tdWV9SEqCh@kreacher>
        <8272147.T7Z3S40VBb@kreacher>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

rjw@rjwysocki.net wrote on Wed, 30 Aug 2023 18:14:57 +0200:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> All of the remaining callers of thermal_zone_device_register()
> can use thermal_tripless_zone_device_register(), so make them
> do so in order to allow the former to be dropped.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

>  drivers/thermal/armada_thermal.c                        |    5 +++--

For armada:
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
