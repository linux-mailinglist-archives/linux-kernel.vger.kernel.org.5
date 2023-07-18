Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCC2758145
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjGRPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjGRPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:48:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC8111C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:48:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-66869feb7d1so3914792b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689695286; x=1692287286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nMaNKzW364IzXp39gEH13PO0+N2Kob1GSxyJEEV3FuQ=;
        b=yUvq8kPvagHqLvP5wLP/JLTNJ4EPEruA/erv9/PV5l+FI3k3ExL84pPm2i91UaZ5wu
         mpQ7B3tyeWX2NkIEDXbqxeohUly2cQpmCFIhXzTjtxRGRKwznKGaCqmZg6MWO9Y+ByrE
         BPfXr/ZxMxmnU2ofcxtI0hJfdhLb9vamRo0kaA839lyHXGcmJbQTX6eZtTndjCXie0M0
         m/2DqZjQ+rbXo7OqVoDhCuQ/Rp60Y1RTf7G4SyNYGp2LiW5IW7ivch+iICV12IW4N/pt
         da4AAeHJxMnWQJXpaP1f3YSM1sfFzpOTmU3UvM48ynDCK5tkKCSZF7H6iHSvFapeI3xe
         P5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695286; x=1692287286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMaNKzW364IzXp39gEH13PO0+N2Kob1GSxyJEEV3FuQ=;
        b=CgiO6Aqr72HgriF3fzfE53k+qQ76e1IEFePgpOma4t8lYPbe7Rc4drhwoLps3WITzj
         knqzz07TN7rGDdChw70713RQx6lBB4pQHIxFXE4+aG2rz9tCXtN5oTmhoYumByJTVgtp
         Ctk1en9g5tjjOoFTCDO9k9zBsa/VmZveuseO4EFoJvBvH2czoC+uGtsvVfOpo2z7hNEZ
         /hkBvAo08HCfwocut9ygBgNfAwr/4Ha0wdxoD8Ql5kjyUsAGnfnuwSOCUFB4eAtY3+kS
         pB9iDE8LOrXmEx/ZFSCuLQ0arYM13F4aZCC92ifGp+FdS4lrivGYBKAWWAhgCTGHGNlu
         lvzQ==
X-Gm-Message-State: ABy/qLY/OksaxDOb6ElxA+HTKkJgLm2GnlaPp5ZWMP3EswePtyPACZUE
        34C/gWrknyKyS30pqtWZVZb4aA==
X-Google-Smtp-Source: APBJJlH9RnLLkdWYjAyRtMI2gK97UOiaQOggN18fZu9Dxpw3LMeoROZuCKARy5NAcvxTDRqufFLgiA==
X-Received: by 2002:a05:6a20:a122:b0:132:86ea:4725 with SMTP id q34-20020a056a20a12200b0013286ea4725mr17258077pzk.45.1689695285867;
        Tue, 18 Jul 2023 08:48:05 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:181:e3fe:53e1:920])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b00684ca1b45b9sm1748933pfu.149.2023.07.18.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 08:48:05 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:48:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: Re: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to
 ignore ready flag from remote processor
Message-ID: <ZLa0MqKvg1W3mx/7@p14s>
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
 <ZLV7q9ipDaw4b1Hi@p14s>
 <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:30:43AM +0300, Iuliana Prodan wrote:
> Hi Mathieu,
> 
> On 7/17/2023 8:34 PM, Mathieu Poirier wrote:
> > Hi Iuliana,
> > 
> > On Thu, Jul 13, 2023 at 01:42:51AM +0300, Iuliana Prodan (OSS) wrote:
> > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > 
> > > There are cases when we want to test samples that do not
> > > reply with FW READY message, after fw is loaded and the
> > > remote processor started.
> > This seems like a bug to me - where is this FW comes from?
> The firmware is a generic sample from Zephyr repo: https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table
> 
> There is no bug, this is how the application was written.

But how did it ever worked before?  And how does having a module flag to
characterize each FW implementation that springs up in the field can scale (and
be maintainable)?

> 
> Rather than modifying a generic sample for i.MX usecase, I prefer doing an
> "insmod imx_dsp_rproc.ko ignore_dsp_ready=1" just for this sample.

We already have a "no_mailbox" flag for cases where the FW doesn't need to
communicate with the main processor.  What happens when some FW implementation
requires a three-way handshake?  How many flags do we spin off?

As I said above this approach is not sustainable.  I suggest to either fix the
FW (it doesn't work with upstream in its present form anyway) or start using the
config space as described here [1] to dynamically probe the characteristics of
the FW being loaded.  Whichever option you chose, the FW needs to be updated and
the former is a lot more simple.

Thanks,
Mathieu

[1]. https://elixir.bootlin.com/linux/latest/source/include/linux/remoteproc.h#L298

> 
> Thanks,
> Iulia
> 
> > > In these cases, do not wait for a confirmation from the remote processor
> > > at start.
> > > 
> > > Added "ignore_dsp_ready" flag while inserting the module to ignore
> > > remote processor reply after start.
> > > By default, this is off - do not ignore reply from rproc.
> > > 
> > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > 
> > > ---
> > > This was discovered while testing openamp_rsc_table sample from Zephyr
> > > repo (https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fzephyrproject-rtos%2Fzephyr%2Ftree%2Fmain%2Fsamples%2Fsubsys%2Fipc%2Fopenamp_rsc_table&data=05%7C01%7Ciuliana.prodan%40nxp.com%7C4779cb20393e4af08a9408db86ec191e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638252120814415013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=iCjvv8wr3sQ4CEXFcXDsW0VSw5RXr1ASw7LN2J08SXE%3D&reserved=0).
> > > 
> > > We have IPC, but the remote proc doesn't send a FW_READY reply.
> > > ---
> > >   drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> > > index b5634507d953..ed89de2f3b98 100644
> > > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > > @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
> > >   MODULE_PARM_DESC(no_mailboxes,
> > >   		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
> > > +static unsigned int imx_dsp_rproc_ignore_ready;
> > > +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
> > > +MODULE_PARM_DESC(ignore_dsp_ready,
> > > +		 "Ignore remote proc reply after start, default is 0 (off).");
> > > +
> > >   #define REMOTE_IS_READY				BIT(0)
> > > +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
> > >   #define REMOTE_READY_WAIT_MAX_RETRIES		500
> > >   /* att flags */
> > > @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
> > >   	if (!priv->rxdb_ch)
> > >   		return 0;
> > > +	/*
> > > +	 * FW_READY reply is optional/ignored, so don't wait for it.
> > > +	 */
> > > +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
> > > +		return 0;
> > > +
> > >   	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
> > >   		if (priv->flags & REMOTE_IS_READY)
> > >   			return 0;
> > > @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
> > >   	else
> > >   		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
> > > +	if (imx_dsp_rproc_ignore_ready)
> > > +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
> > > +
> > >   	dev_set_drvdata(dev, rproc);
> > >   	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> > > -- 
> > > 2.17.1
> > > 
