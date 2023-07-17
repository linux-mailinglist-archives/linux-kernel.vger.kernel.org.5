Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFC7560FF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGQLAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:00:35 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265611B9;
        Mon, 17 Jul 2023 04:00:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9B286ECB41;
        Mon, 17 Jul 2023 04:00:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PHYwhA0G5s6o; Mon, 17 Jul 2023 04:00:32 -0700 (PDT)
Message-ID: <ae7865575edd11ab9e2bf81c54ee8826e0a2a766.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1689591632; bh=TgOupprCXdcHNadU7eli+8swMuQbvJHpJwx/sY+zHHs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C7DtMBQ1bf7BRHMBMz6w2fo9xm7Tdzco+CDlrpTaijQtsBZI/nIclO2mpFp/dNtjk
         rMZ8qsEvZwkMt2wmAZoFK78ovfUeiHl5F1QV2/LoalixfRodsbPkMf4e5tX4YPB5yk
         SjWSBX7X342Xrb6nRRbXDDkV0NiBscp6BJthtNnXxVg1enU92Xc5j0i11uLw+opXDn
         0GQLqXX9GURUvoGFcnUA2aWt8pBIT2KPBbFthLsWzdl8eA4w1nvRnWVFC38eKO/JJe
         qFmyrA72CTPlMp1u3aOqRLZBfZTn0zX8ntjJPXmuDfvzX6cEh9BsoGTagmNiuC05Y7
         ul1Np9SFkqgPg==
Subject: Re: [PATCH v2] media: imx: Unstage the imx8mq-mipi-csi2 driver
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        slongerbeam@gmail.com, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, rmfrfs@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jul 2023 13:00:26 +0200
In-Reply-To: <a4b3cf3be9f105adcbcad688f8745556eec4d9df.camel@puri.sm>
References: <20230425090804.2664466-1-martin.kepplinger@puri.sm>
         <20230425094346.GA17841@pendragon.ideasonboard.com>
         <a4b3cf3be9f105adcbcad688f8745556eec4d9df.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 16.05.2023 um 09:42 +0200 schrieb Martin Kepplinger:
> Am Dienstag, dem 25.04.2023 um 12:43 +0300 schrieb Laurent Pinchart:
> > Hi Martin,
> > 
> > Thank you for the patch.
> > 
> > On Tue, Apr 25, 2023 at 11:08:04AM +0200, Martin Kepplinger wrote:
> > > The imx8mq-mipi-csi2 MIPI CSI-2 receiver driver is used and
> > > maintained.
> > > There is no reason to keep it in staging. The accompanying CSI
> > > bridge
> > > driver that uses it is in drivers/media/platform/nxp as well.
> > > 
> > > One TODO is to get rid of csi_state's "state" and "lock"
> > > variables.
> > > Especially make sure suspend/resume is working without them. That
> > > can
> > > very well be worked on from the new location.
> > > 
> > > Also add a MAINTAINERS section for the imx8mq-mipi-csi2 mipi
> > > receiver
> > > driver.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks for reviewing Laurent,
> 
> Are there any second thoughts to this? If not: It still applies to
> todays' next kernel. Who would be able to queue this up?
> 
> (This enables Debian and other distributions to use cameras on
> imx8mq.)
> 
> thanks,
> 
>                        martin
> 

This still applies cleanly and would be helpful. Does anyone want to
queue this?

thanks,
                         martin

