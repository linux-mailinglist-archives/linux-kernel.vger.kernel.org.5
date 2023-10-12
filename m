Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D207C6632
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjJLHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJLHMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:12:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2F90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:12:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E788240004;
        Thu, 12 Oct 2023 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697094726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gUyEMS1q0fC0UAof2Vqf/bmiL6uURnF5y3TtaUUHCzY=;
        b=Y9d/fS0EBbOzRlvTRZ5L/tG9ANVdRNMenyyzmOl36Hg1ML+NiAoh8jqdGn51RtU0KZ5d1Z
        0c4PVbqo3FLyS4GoHRKpwuk6lPf491BY+uUVldbEP0O0LE4Zxmon/DIUpB7UIAZddA2pzR
        as0kmUI6rbywmQQT9RUWFJ084WGh+u1W+xiZS5eFpdxW8+0Zb3SlYz5QZ+ubIwBJmwmSOP
        SwJF30GOu+Mk1Lb3VE9GJAmGHL3UgGraByXfk0kKsdeAwYM6UtN6VZ1sg50+qibQ+phmpn
        dT19qyZkvjTQIJrLXv1R/Z4ALTd4bi+UoUiLxK1xrmgPEuYXDh/DZsfNkBJbqQ==
Date:   Thu, 12 Oct 2023 09:12:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@mail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v2 3/4] mtd: rawnand: brcmnand: pass host struct to
 bcmnand_ctrl_poll_status
Message-ID: <20231012091202.7c963f3f@xps-13>
In-Reply-To: <trinity-d3f78d82-f01e-4c98-9afa-18c5f7ddfd1c-1697071308619@3c-app-mailcom-lxa05>
References: <trinity-d3f78d82-f01e-4c98-9afa-18c5f7ddfd1c-1697071308619@3c-app-mailcom-lxa05>
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

Hi,

dregan@mail.com wrote on Thu, 12 Oct 2023 02:41:48 +0200:

> pass host struct to bcmnand_ctrl_poll_status instead of ctrl struct,

Capital letter

> since real time status requires host, and ctrl is a member of host.

real time status? I'm sorry this commit log is not very clear.

>=20
> Signed-off-by: David Regan <dregan@mail.com>
>=20

This new line should be dropped (in all your commit logs)

> ---
>=20
> Changes in v2: added this patch in series

The versioning is wrong btw, you should continuously increase the
counter, this is not just your second version. And as I said please use
b4 or git-send-email so patches 2+ are answers of patch 1 and in my
inbox it looks like 4 related patches instead.

Thanks,
Miqu=C3=A8l
