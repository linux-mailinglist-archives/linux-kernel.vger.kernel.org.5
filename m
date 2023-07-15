Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C4754C14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 23:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGOVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGOVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 17:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D22738;
        Sat, 15 Jul 2023 14:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E2460BB8;
        Sat, 15 Jul 2023 21:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EC7C433C7;
        Sat, 15 Jul 2023 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689455343;
        bh=kNsOwCiSGFR+k07yheKrA2oM7aIAa0Rcc+Kbq9GFej0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yc6cKkhY9d5WVG64GsSEjMAo8J4bBPxHbTHZ5Mh7wHE6/Yv4QExsgbiJN0WKF4ElS
         KZwoacFMbSkCM3VZw6VyId9Byrn6S0nVpI7lnK0vGD9wBT2MIdEr38TdxzNCTgCGvY
         o6kPCt7R8LR46PsFByAf0xYQqHy09JKklyNoZ3BALkpxRQGtZ0WFR4xmMYecZTX+sr
         4xRdkqM8khX69XwGB+YMUQxCB2V0OzN6c1h5Rzz24TLa5pVuJxbW/xpxdXpRwUTiWP
         2QsjX4gOzUn33sUT3XSmrtQeNcyhFFZyN2VbRjvQ4i0WCdLFGLX6YihwBHnI7YFPA/
         mxphxvGuPA9wg==
Date:   Sat, 15 Jul 2023 14:12:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Cc:     linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v3 2/2] remoteproc: qcom: Add remoteproc tracing
Message-ID: <ytm2mpm4izvv4elp57xp5mcnwqe4uu2m37cmaz5zinw5vj6lv3@lllmedbkavt5>
References: <cover.1683741283.git.quic_gokukris@quicinc.com>
 <3efc06319d52973e74c64fec701111427639044c.1683741283.git.quic_gokukris@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efc06319d52973e74c64fec701111427639044c.1683741283.git.quic_gokukris@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:05:04AM -0700, Gokul krishna Krishnakumar wrote:
> This change attempts to add traces for start, stop, crash
> subsystem/subdevice events, these will serve as standard checkpoints in
> code and could help in debugging the failures in subdevice/subsystem
> prepare, start, stop and unprepare functions. This will also breakdown
> the time taken for each step in remoteproc bootup/shutdown process.

Please read submitting-patches about "imperative mood".

> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_common.c     | 37 ++++++++++++++++++++++++++++
>  drivers/remoteproc/qcom_q6v5.c       |  9 +++++++
>  drivers/remoteproc/remoteproc_core.c |  8 ++++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238492e9..c19bcb2dd603 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/soc/qcom/smem.h>
> +#include <trace/events/rproc_qcom.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> @@ -191,6 +192,10 @@ static int glink_subdev_start(struct rproc_subdev *subdev)
>  
>  	glink->edge = qcom_glink_smem_register(glink->dev, glink->node);
>  
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),

If you add a "name" to struct rproc_subdev, and trace this from
remoteproc_core, then suddenly you have added value to the entire
remoteproc ecosystem, not just your corner.

> +					"glink", "start",
> +					PTR_ERR_OR_ZERO(glink->edge));

The last trace argument is "ret", this doesn't look like a return value.

> +
>  	return PTR_ERR_OR_ZERO(glink->edge);
>  }
>  
> @@ -199,6 +204,11 @@ static void glink_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
>  	qcom_glink_smem_unregister(glink->edge);
> +
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),
> +					"glink", "stop",
> +					PTR_ERR_OR_ZERO(glink->edge));
> +
>  	glink->edge = NULL;
>  }
>  
> @@ -206,6 +216,10 @@ static void glink_subdev_unprepare(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(glink->dev->parent),
> +					"glink", "unprepare",
> +					PTR_ERR_OR_ZERO(glink->edge));
> +
>  	qcom_glink_ssr_notify(glink->ssr_name);
>  }
>  
> @@ -300,6 +314,10 @@ static int smd_subdev_start(struct rproc_subdev *subdev)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(smd->dev->parent),
> +					"smd", "start",
> +					PTR_ERR_OR_ZERO(smd->edge));
> +
>  	smd->edge = qcom_smd_register_edge(smd->dev, smd->node);
>  
>  	return PTR_ERR_OR_ZERO(smd->edge);
> @@ -309,6 +327,10 @@ static void smd_subdev_stop(struct rproc_subdev *subdev, bool crashed)
>  {
>  	struct qcom_rproc_subdev *smd = to_smd_subdev(subdev);
>  
> +	trace_rproc_subdev_event(dev_name(smd->dev->parent),
> +					"smd", "stop",
> +					PTR_ERR_OR_ZERO(smd->edge));
> +
>  	qcom_smd_unregister_edge(smd->edge);
>  	smd->edge = NULL;
>  }
> @@ -425,6 +447,10 @@ static int ssr_notify_prepare(struct rproc_subdev *subdev)
>  		.crashed = false,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_BEFORE_POWERUP",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_BEFORE_POWERUP, &data);
>  	return 0;
> @@ -437,6 +463,9 @@ static int ssr_notify_start(struct rproc_subdev *subdev)
>  		.name = ssr->info->name,
>  		.crashed = false,
>  	};
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_AFTER_POWERUP",
> +					data.crashed);
>  
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_AFTER_POWERUP, &data);
> @@ -451,6 +480,10 @@ static void ssr_notify_stop(struct rproc_subdev *subdev, bool crashed)
>  		.crashed = crashed,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_BEFORE_SHUTDOWN",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_BEFORE_SHUTDOWN, &data);
>  }
> @@ -463,6 +496,10 @@ static void ssr_notify_unprepare(struct rproc_subdev *subdev)
>  		.crashed = false,
>  	};
>  
> +	trace_rproc_subdev_event(ssr->info->name,
> +					"ssr", "QCOM_SSR_AFTER_SHUTDOWN",
> +					data.crashed);
> +
>  	srcu_notifier_call_chain(&ssr->info->notifier_list,
>  				 QCOM_SSR_AFTER_SHUTDOWN, &data);
>  }
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 192c7aa0e39e..2f4e9c8ebbf9 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -15,6 +15,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> +#include <trace/events/rproc_qcom.h>
>  #include "qcom_common.h"
>  #include "qcom_q6v5.h"
>  
> @@ -113,6 +114,7 @@ static irqreturn_t q6v5_wdog_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "watchdog without message\n");
>  
>  	q6v5->running = false;
> +	trace_rproc_interrupt_event(q6v5->rproc, "q6v5_wdog", msg);

Move this into rproc_report_crash() and you have added value to
everyone.

Seems very useful to have "msg" in this trace, so please fix the
rproc_report_crash() prototype to carry this information.

That would have the additional benefit of allowing you to remove the
annoying double print, where both qcom_q6v5.c and rproc_report_crash()
tells us that something crashed. (I.e. start with that in a separate
patch please)

Also, this isn't an "interrupt event", it's a "watchdog bite" event.

>  	rproc_report_crash(q6v5->rproc, RPROC_WATCHDOG);
>  
>  	return IRQ_HANDLED;
> @@ -134,6 +136,7 @@ static irqreturn_t q6v5_fatal_interrupt(int irq, void *data)
>  		dev_err(q6v5->dev, "fatal error without message\n");
>  
>  	q6v5->running = false;
> +	trace_rproc_interrupt_event(q6v5->rproc, "fatal", msg);

This isn't an "interrupt event", it's a "fatal error" event.

>  	rproc_report_crash(q6v5->rproc, RPROC_FATAL_ERROR);
>  
>  	return IRQ_HANDLED;
> @@ -165,6 +168,8 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
>  	if (!ret)
>  		disable_irq(q6v5->handover_irq);
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "Ready", !ret ? "-ETIMEDOUT":"done");

It's very useful to be able to consume the trace events
programmatically, encoding the start result as a string isn't
convenient.

Please trace this from rproc_start() instead, so that we don't need to
do this in every driver.

> +
>  	return !ret ? -ETIMEDOUT : 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
> @@ -180,6 +185,8 @@ static irqreturn_t q6v5_handover_interrupt(int irq, void *data)
>  
>  	q6v5->handover_issued = true;
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "handover", "Proxy votes removed");

"handover" and "proxy votes removed" is saying the same thing, I assume
you put the latter there to be able to reuse the overly generic trace
event.

This even actually is Qualcomm-specific, but similar events are present
in other remoteprocs. Perhaps it's worth keeping it generic anyways.

Please make it a "handover" event, without the extra parameters.

> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -216,6 +223,8 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5, struct qcom_sysmon *sysmon)
>  
>  	qcom_smem_state_update_bits(q6v5->state, BIT(q6v5->stop_bit), 0);
>  
> +	trace_rproc_interrupt_event(q6v5->rproc, "Stop", ret ? "done":"-EETIMEDOUT");

Again, please don't recode easy to parse data into strings, and please
move this to the core.

> +
>  	return ret == 0 ? -ETIMEDOUT : 0;
>  }
>  EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 695cce218e8c..ced7584c27c3 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -38,6 +38,7 @@
>  #include <linux/virtio_ring.h>
>  #include <asm/byteorder.h>
>  #include <linux/platform_device.h>
> +#include <trace/events/rproc_qcom.h>
>  
>  #include "remoteproc_internal.h"
>  
> @@ -1271,6 +1272,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  	/* load the ELF segments to memory */
>  	ret = rproc_load_segments(rproc, fw);
> +	trace_rproc_load_event(rproc, ret);

A common concept in trace events is to trace before and after an
operation, so that the trace events can be used to measure the duration
of the operation. Seems like this would be quite useful here as well.

>  	if (ret) {
>  		dev_err(dev, "Failed to load program segments: %d\n", ret);
>  		return ret;
> @@ -1306,6 +1308,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  	/* Start any subdevices for the remote processor */
>  	ret = rproc_start_subdevices(rproc);
> +

Leftover?

>  	if (ret) {
>  		dev_err(dev, "failed to probe subdevices for %s: %d\n",
>  			rproc->name, ret);
> @@ -1730,6 +1733,8 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  		return ret;
>  	}
>  
> +	trace_rproc_stop_event(rproc, crashed ? "crash stop" : "stop");
> +

Pass crashed as a bool to the trace event, so that the data can easily
be parsed from a tool. If you want you can convert it to a string in the
TP_printk for human consumption.

>  	rproc_unprepare_subdevices(rproc);
>  
>  	rproc->state = RPROC_OFFLINE;
> @@ -1940,6 +1945,8 @@ int rproc_boot(struct rproc *rproc)
>  		dev_info(dev, "attaching to %s\n", rproc->name);
>  
>  		ret = rproc_attach(rproc);
> +		trace_rproc_start_event(rproc, ret);
> +

Extra newline. And this isn't a start event, it's an attach_done event.

You have trace events for the individual operations further down the
stack, I think you should broaden the scope of this and the next one to
cover the whole "rproc_boot" instead of another trace presumably just
tracing the same value as the finer grained.


And as above, please write your trace events to answer the two questions
"how long did rproc_boot take" and "what was the outcome" (i.e. return
value).

Regards,
Bjorn

>  	} else {
>  		dev_info(dev, "powering up %s\n", rproc->name);
>  
> @@ -1951,6 +1958,7 @@ int rproc_boot(struct rproc *rproc)
>  		}
>  
>  		ret = rproc_fw_boot(rproc, firmware_p);
> +		trace_rproc_start_event(rproc, ret);
>  
>  		release_firmware(firmware_p);
>  	}
> -- 
> 2.40.1
> 
