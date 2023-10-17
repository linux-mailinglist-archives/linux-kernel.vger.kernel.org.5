Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977437CC596
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjJQOHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:07:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6492
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:07:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B55831BF209;
        Tue, 17 Oct 2023 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697551651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JN4ZGYYW38xpilPMmfTxgTyQKe9+4lxOfEsytKMKEQ=;
        b=L4flTNurZT4xkQl7CucQ+PvtwH2F8NnDAKIONZsu0uTx1usez8MsbvwKOrNqE9FxoxexVW
        5Ym2R8s5dttxQwt1tcvV6XGoKVB4t63pRBUCKPs/gXo4Fa3f8FjTEepAA0F7qjxueiZxpJ
        Q+fceWvpci8O2Uiz5/wPUzULytih6A+96MiPVSTYViwJnPC2vbt2IaAUfUzO0FzyX3CEGC
        DdVthaYI9pJOTQ0decuNvrb/Eg8MukKnKAe+Y7fFYiJ3cF80YAk5UcvAngF/isvMHMEC7s
        qsj8w3Z5sdXGYXuCGh4wM7wx4Z92wGAKDJjVoYNlnCyJ2EgR0Jp9taqtohA6Zw==
Date:   Tue, 17 Oct 2023 16:07:29 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/5] i3c: svc: rename read_len as actual_len
Message-ID: <20231017160729.58984467@xps-13>
In-Reply-To: <20231016154632.2851957-4-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
        <20231016154632.2851957-4-Frank.Li@nxp.com>
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

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:30 -0400:

> I3C transfer, target can early terminate transfer.
> I2C transfer, target can NACK write transfer.
>=20
> 'actual_len' is better name than 'read_len'.

I don't find read_len confusing because it may mean "how much bytes
were actually read" rather than "how much we need to read". But if
actual_len sounds better, I'm fine.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks,
Miqu=C3=A8l
