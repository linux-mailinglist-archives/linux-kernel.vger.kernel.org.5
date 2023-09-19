Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61897A6249
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjISMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISMOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:14:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17A118;
        Tue, 19 Sep 2023 05:14:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0504C433C8;
        Tue, 19 Sep 2023 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695125641;
        bh=dauXQLkstRtCzMJMb/trFr2w1LvhwGBSPPyfgMFurg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjtUmVDnQuu+bFgm6br3V1WI5C2NapYx3u5HXEhzpdX0dfJp55l9KvXOmpoadJyAn
         zGl4fHyNp9Vd80LIMc/WMTRx2CFXofx4jpaAUN789waSxmED5pf9ojHKv4ZanOOmzd
         3Oyt14g4l7A+5Sk9jF+6gw8DqxwC6/98G8yvIv+L4jn8MIr5WI6u+I/lanWE8AGQ5I
         /rOq3J9CX0ZvqIEvV4z5S3HwyZyZk5D4V0DbEbMRXccagXtc2SoX/wzNdnAA26zEjF
         15GMMqTfKNqFhaO0rxFFONkXxMmlQmcFrOCRqaXHpOpQhqzCAkokz5bd7Cdodq+kB5
         YZUp0M2v19Igw==
Date:   Tue, 19 Sep 2023 14:13:55 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@nxp.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: imx-dsp: Fix an error handling path in
 imx_dsp_setup_channels()
Message-ID: <20230919121354.GA11740@T480>
References: <2b4bc0b22fac32ab3a7262240019486804c1691f.1673806409.git.christophe.jaillet@wanadoo.fr>
 <CAEnQRZC=JNGixTRVDnEK0p5rZWuQbOmQvApTUM5=0iJN9pzVRw@mail.gmail.com>
 <022417df-9d3b-6760-3a57-c725906561e5@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <022417df-9d3b-6760-3a57-c725906561e5@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:26:01AM +0200, Christophe JAILLET wrote:
> Le 17/01/2023 à 08:55, Daniel Baluta a écrit :
> > On Sun, Jan 15, 2023 at 8:35 PM Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> > > 
> > > If mbox_request_channel_byname() fails, the memory allocated a few lines
> > > above still need to be freed before going to the error handling path.
> > > 
> > > Fixes: 046326989a18 ("firmware: imx: Save channel name for further use")
> > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > 
> > Good catch.
> > 
> > Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> > 
> 
> Hi,
> 
> polite reminder.
> 
> This patch is still not in -next.

Sorry, not sure how this fell from the crack.

Applied, thanks!
