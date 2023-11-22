Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BF7F49AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKVPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbjKVPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:05:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B80A3;
        Wed, 22 Nov 2023 07:05:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3F8B29A;
        Wed, 22 Nov 2023 16:04:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700665494;
        bh=8pF7Wg5LEFskYqmGH2k4O2UFRmY8lfO9msZUpnevj7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CShra8iyVGhL/seg8ngLF0omh8ppTpS6fheUMXaFeIPh35gDLO3lI9zoQ8az5KjUU
         n55jw8XjIERadtTj31vPB8hIJ9+RAL35BjYl3dBxBaTyuFGxEagyXxj/L7+DJxGGjz
         N+cTzMP2JWtSaeGmmbIZ5uTqRfSvxkLLTeJufE+M=
Date:   Wed, 22 Nov 2023 17:05:32 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] media: imx-mipi-csis: csis clock fixes
Message-ID: <20231122150532.GG8627@pendragon.ideasonboard.com>
References: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
 <CAOMZO5AW0qft5ciGAWuX=RC0zHwAWEpLCyB5TbeE0QH3Nb+nQQ@mail.gmail.com>
 <61de2617-fdc2-4f0c-8ffc-5dfc99b825e7@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61de2617-fdc2-4f0c-8ffc-5dfc99b825e7@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:44:33PM +0200, Tomi Valkeinen wrote:
> On 22/11/2023 15:21, Fabio Estevam wrote:
> > On Wed, Nov 22, 2023 at 10:14 AM Tomi Valkeinen wrote:
> >>
> >> Two fixes to the csis driver: One to fix remove() another to only enable
> >> the clocks when needed.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >> ---
> >> Tomi Valkeinen (2):
> >>        media: imx-mipi-csis: Fix clock handling in remove()
> >>        media: imx-mipi-csis: Drop extra clock enable at probe()
> > 
> > Shouldn't both patches contain a Fixes tag?
> 
> I think the issue is there in the original commit adding the driver:
> 
> 7807063b862b ("media: staging/imx7: add MIPI CSI-2 receiver subdev for 
> i.MX7")
> 
> However, the driver has changed along the way, and I'm not sure if the 
> original one had an actual bug. Nevertheless, the same pattern (wrt. 
> clocks and runtime) is there in the original one, and I think that 
> pattern is not correct even if it wouldn't have caused any visible issue.
> 
> So I'll add that commit as Fixes-tag, but if someone with more knowledge 
> about the driver can verify this, that'd be great.

Sounds fine to me. I assume you'll send a v2.

-- 
Regards,

Laurent Pinchart
