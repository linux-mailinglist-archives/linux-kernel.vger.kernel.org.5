Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867CF7CC589
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJQOFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbjJQOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:05:05 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9423BF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:05:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0506240004;
        Tue, 17 Oct 2023 14:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697551501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2SWgNzwjbBpSUOPGOrMP6yTVIG3XK+FVYK04/px9Nc=;
        b=l9ZgiPwgnCd8UaS+fNemzxUVyL/C+RETm7R5MvKzrQLG6sX0OaHgHAwWmSxAwGHifxKM8W
        +H1oQp0uLo8Fv4tjQfcQH48vA4GtaFD47CTSsfqjxlC6L1r8KxgUuphF5DitIfFKsRx6WR
        0nYkShZbHZ3KEFe2GD00si33MjdobYNPwihhAvh3oqbgNAJaodI7WLAE8oFozqlX83jdnf
        Nov2IVJUSPhjigdAPofmCdwvPEdHMfXdVLzKYuKQH82lV2Wkzra9nkWVwYDXwl9iKBv5Zm
        bYBRZZfbaFrq+0eHMnoW+X8Xyi1RA6l9py/6iZyTYf3FGrzHZ3y6B6md30wpsA==
Date:   Tue, 17 Oct 2023 16:04:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/5] i3c: master: svc: enable hotjoin default
Message-ID: <20231017160457.4f0c2490@xps-13>
In-Reply-To: <20231016154632.2851957-2-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
        <20231016154632.2851957-2-Frank.Li@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:28 -0400:

> Hotjoin require clock running and enable SLVSTART irq.
> Add module parameter 'hotjoin' to disable hotjoin and enable runtime_pm to
> save power.

I am really not a big fan of the use of modules parameters. Maybe it
makes sense here. Alex, a better idea?

Thanks,
Miqu=C3=A8l
