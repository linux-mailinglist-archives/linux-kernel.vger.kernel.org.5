Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AB759A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGSPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjGSPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:47:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7855197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:47:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6687466137bso4709407b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689781646; x=1690386446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rA/3cYmYP9DShzYXoAgqhlU5HPUKS1wa/nHGxwzX3U4=;
        b=wAAwX/qgHXj2kKMJar6LkvswRhFcqjK5dFVIG9vjvEys/9BY2QohFe8CAuOWVhEioK
         UR3IoWsZQW7k7pO7RF6uoTEvPIDdo0vl3JMILlvySqf0XKmPZIdhCt7VDqkvvrHxtVpM
         758tPg33Mn1YHpR9jyrrP0p19IqHO/NpZl0//6o4YLbotUHfdMzkWE10Acy+YrftEn0b
         8r4eG1Z9wwWYSdNrT1vZrQMoaIffsVy+N3pe/f9ihbcuL/hRbHV1fUDPZazz0P8Cj/KB
         MlEJmV0u6MmQy+XF+CgzO+M4g721y3bZv6JTAFMqXDV8eL78y/rPweLSkTQcXst9UwAS
         TKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781646; x=1690386446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA/3cYmYP9DShzYXoAgqhlU5HPUKS1wa/nHGxwzX3U4=;
        b=X1wOYM8ePOYkHNuiMPch2V1KGl98RbW9nIZ9izdbI7UXHABhFYNNTRe25Wwij0+88R
         lAEzpq+JDcKZHRhqINpRSDGVs+tBdYn+BbTHHmEYx8X5V6usZ20GehiFsBLn80W9rAD1
         jGPQiwW8YAoezBnIGAKMA9JbE36srw3BN7eEbAYm94PdgWnGCBFXgu6iGI+/a5wo1SzB
         ITNPyBLB2m+sPn4XRu4eHHt1m5QS52NM3yWDCl470p2SJpnV46ht/wWZniKQ1s27PMpf
         JOHcLGkgJrkOhLxeNg1EbIg4by+iQYKIZUivhAFoYpvG3fmVcsH4BKwN8pjIbBfV+yCy
         j3Dg==
X-Gm-Message-State: ABy/qLbpppcO67QZdUEIG0Gli3QpK81b3EU0VEgSTYWfVONrI/XaokX6
        FuBfwGP0rRgzovgJBNmHu7C3sg==
X-Google-Smtp-Source: APBJJlFO0Ez8AMQpNzyS+AnJZrKeAbW1gKn8UNJsX4k6R0koGmrBG8IsKhxgiCrWFNvIbNgMoKwMrA==
X-Received: by 2002:a05:6a00:2ea7:b0:67b:d2e4:6bd2 with SMTP id fd39-20020a056a002ea700b0067bd2e46bd2mr3665417pfb.17.1689781646252;
        Wed, 19 Jul 2023 08:47:26 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6ba3:d4ce:34db:c692])
        by smtp.gmail.com with ESMTPSA id t1-20020a63b241000000b0055bf13811f5sm3669504pgo.15.2023.07.19.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 08:47:24 -0700 (PDT)
Date:   Wed, 19 Jul 2023 09:47:21 -0600
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
Message-ID: <ZLgFiW+IH3m4MWLw@p14s>
References: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
 <ZLV7q9ipDaw4b1Hi@p14s>
 <6fe5691f-67f4-ff70-8350-b4b6c08097b0@nxp.com>
 <ZLa0MqKvg1W3mx/7@p14s>
 <86da3550-9711-6714-0857-2f7611dc9453@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86da3550-9711-6714-0857-2f7611dc9453@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:44:49PM +0300, Iuliana Prodan wrote:
> On 7/18/2023 6:48 PM, Mathieu Poirier wrote:
> > On Tue, Jul 18, 2023 at 11:30:43AM +0300, Iuliana Prodan wrote:
> > > Hi Mathieu,
> > > 
> > > On 7/17/2023 8:34 PM, Mathieu Poirier wrote:
> > > > Hi Iuliana,
> > > > 
> > > > On Thu, Jul 13, 2023 at 01:42:51AM +0300, Iuliana Prodan (OSS) wrote:
> > > > > From: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > > > 
> > > > > There are cases when we want to test samples that do not
> > > > > reply with FW READY message, after fw is loaded and the
> > > > > remote processor started.
> > > > This seems like a bug to me - where is this FW comes from?
> > > The firmware is a generic sample from Zephyr repo: https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table
> > > 
> > > There is no bug, this is how the application was written.
> > But how did it ever worked before?
> 
> It never worked on this kind of samples (and it was never tested like this).
> We used only applications written by us (NXP) with the
> requirements/limitations we know we have.
> Now, we want to use also generic firmware/samples (from Zephyr) and we face
> other kind of limitations.
>

Right, we can't expect firmware written for a totally different OS to work out
of the box on Linux, and vice versa.

> >   And how does having a module flag to
> > characterize each FW implementation that springs up in the field can scale (and
> > be maintainable)?
> 
> I believe the FW_READY reply is a limitation introduced by imx_dsp_rproc.
> We cannot expect all firmware to give a FW_READY reply.
> So, to keep both usecases (internal firmware and generic sample) I added
> this flag.
>

What happens when a third, fourth and fifth protocol variation get introduced?
Adding flags just doesn't scale.

> > > Rather than modifying a generic sample for i.MX usecase, I prefer doing an
> > > "insmod imx_dsp_rproc.ko ignore_dsp_ready=1" just for this sample.
> > We already have a "no_mailbox" flag for cases where the FW doesn't need to
> > communicate with the main processor.
> "no_mailbox" - no IPC between cores;
> "ignore_dsp_ready" - we have IPC between cores, but the remote processor
> doesn't send a fw_ready reply
> These two can be combine, but for "no_mailbox" will do some useless memory
> allocations.
> 
> When I added the "no_mailbox" flag, the problem was still FW_READY.
> >   What happens when some FW implementation
> > requires a three-way handshake?  How many flags do we spin off?
> > 
> > As I said above this approach is not sustainable.  I suggest to either fix the
> > FW (it doesn't work with upstream in its present form anyway) or start using the
> > config space as described here [1] to dynamically probe the characteristics of
> > the FW being loaded.  Whichever option you chose, the FW needs to be updated and
> > the former is a lot more simple.
> I don't think I can modify a generic sample, used on other targets to send a
> FW_READY reply.
> How will it be handled on other platforms, if their *_rproc are not
> expecting this kind of message?
> 

The only way forward is to come up with a standard specification to describe the
protocol to use, the same way it is done for virtIO for example.

> Thanks,
> Iulia
> 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://elixir.bootlin.com/linux/latest/source/include/linux/remoteproc.h#L298
> > 
> > > Thanks,
> > > Iulia
> > > 
> > > > > In these cases, do not wait for a confirmation from the remote processor
> > > > > at start.
> > > > > 
> > > > > Added "ignore_dsp_ready" flag while inserting the module to ignore
> > > > > remote processor reply after start.
> > > > > By default, this is off - do not ignore reply from rproc.
> > > > > 
> > > > > Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> > > > > 
> > > > > ---
> > > > > This was discovered while testing openamp_rsc_table sample from Zephyr
> > > > > repo (https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table).
> > > > > 
> > > > > We have IPC, but the remote proc doesn't send a FW_READY reply.
> > > > > ---
> > > > >    drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
> > > > >    1 file changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> > > > > index b5634507d953..ed89de2f3b98 100644
> > > > > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > > > > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > > > > @@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
> > > > >    MODULE_PARM_DESC(no_mailboxes,
> > > > >    		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
> > > > > +static unsigned int imx_dsp_rproc_ignore_ready;
> > > > > +module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
> > > > > +MODULE_PARM_DESC(ignore_dsp_ready,
> > > > > +		 "Ignore remote proc reply after start, default is 0 (off).");
> > > > > +
> > > > >    #define REMOTE_IS_READY				BIT(0)
> > > > > +#define REMOTE_IGNORE_READY_REPLY	BIT(1)
> > > > >    #define REMOTE_READY_WAIT_MAX_RETRIES		500
> > > > >    /* att flags */
> > > > > @@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
> > > > >    	if (!priv->rxdb_ch)
> > > > >    		return 0;
> > > > > +	/*
> > > > > +	 * FW_READY reply is optional/ignored, so don't wait for it.
> > > > > +	 */
> > > > > +	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
> > > > > +		return 0;
> > > > > +
> > > > >    	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
> > > > >    		if (priv->flags & REMOTE_IS_READY)
> > > > >    			return 0;
> > > > > @@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
> > > > >    	else
> > > > >    		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
> > > > > +	if (imx_dsp_rproc_ignore_ready)
> > > > > +		priv->flags |= REMOTE_IGNORE_READY_REPLY;
> > > > > +
> > > > >    	dev_set_drvdata(dev, rproc);
> > > > >    	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
> > > > > -- 
> > > > > 2.17.1
> > > > > 
