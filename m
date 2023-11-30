Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899607FEC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjK3KJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3KJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:09:47 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370F10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:09:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2B16DFF811;
        Thu, 30 Nov 2023 10:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701338991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvljltiRA/0ipo6rsSpOVOq9yCewhyizJDRIN7ESJBs=;
        b=g/PqJupxHoS1SgFzAvk3uFQbyqqgNVDpPtoLQ3pGuKRtRXheUyBKcIyIz5VdfM1hpCqvk2
        jiEd+xFGEwyOHydd6sZ4HZCxcb9uYWmOBaWUOsg19FGhpsXqPNZJ1llSNVJn6mfTb/2OsB
        k+XmKXlD+yBeZBoqYW2AoJEiNnoPAw1siqwsmzt/uudNfzgPZW5mnErETfgRv2zUpqlj48
        Jb+Pt398+IORIyHmR7pR3UueFE/QS9vrfPkvpBjFXgyLGy9VMQ9o+RsiUFDbsTVzctyD/K
        FLzTKbEWUlKSCXnfsTaLZb6iskZEN51WPSIqiByYh49zmH9goiul68e/FsWxcg==
Date:   Thu, 30 Nov 2023 11:09:48 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v4 5/6] i3c: master: svc return actual transfer data len
Message-ID: <20231130110948.11a1ac71@xps-13>
In-Reply-To: <20231129221225.387952-6-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
        <20231129221225.387952-6-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Wed, 29 Nov 2023 17:12:24 -0500:

> I3C allow devices early terminate data transfer. So set "actual_len" to
> indicate how much data get by i3c_priv_xfer.

The title prefix should be the same in the two patches addressing the
SVC driver.

With this fixed:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Thanks,
Miqu=C3=A8l
