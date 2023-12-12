Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745A480F1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjLLQHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjLLQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:07:02 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC559A;
        Tue, 12 Dec 2023 08:07:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF8F1E0006;
        Tue, 12 Dec 2023 16:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702397226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJpdj69LX9IEhqohq156R8WukFK3OJVd0O9X4X2+26Y=;
        b=ExG/pMwBBumC4QhP5vNOjlnVV8KqPLC136SVSVEYTsijZN/SA06MhMXAal58wtGcNHldD6
        Cshygd0aPgzABApx931nXxMFNn+x5AVJ3PvvpV+/VwKT4fG3Ko7OwKMDQ2Uq79eYCUH1Dq
        w4gn/6mqaBezusxxrAvb0M2wzznz0CIfuawXAuhhhNWIy1CdrHCfvfvnEG+uab5AKx9o3+
        rODyBlgGn2vtxJ87A1WjnN47yCkiIMgFJcd7c+WcfFamHY4VxFVz3LQVB34ocxMMN2oCbt
        jdmlOiEODcPCRajnrnGDNyQiDurVP1/XcKwYuov2Er1yZisjPF2BbNyM6aFlGw==
Date:   Tue, 12 Dec 2023 17:07:04 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
Message-ID: <20231212170704.74565969@device.home>
In-Reply-To: <20231212141200.62579-1-eichest@gmail.com>
References: <20231212141200.62579-1-eichest@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Tue, 12 Dec 2023 15:12:00 +0100
Stefan Eichenberger <eichest@gmail.com> wrote:

> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks for the patch,

Maxime
