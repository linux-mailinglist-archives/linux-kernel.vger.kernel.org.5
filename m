Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A076FD38
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjHDJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHDJZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:25:28 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 02:25:22 PDT
Received: from h2.cmg2.smtp.forpsi.com (h2.cmg2.smtp.forpsi.com [81.2.195.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1C649E4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:25:22 -0700 (PDT)
Received: from lenoch ([80.95.121.122])
        by cmgsmtp with ESMTPSA
        id Rr2eqhrFTv5uIRr2fqOA5Z; Fri, 04 Aug 2023 11:24:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1691141059; bh=ehgtpf9N2GNyOfygAYteEUrKM2M3ean2tmrHYuaJuas=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=VUk5pyFxvxGNtXPgBWsAdu788V87xThPqP7oVIVII1K4+CZdhOloLMnWT8B3nPCuJ
         OHbS1a3WR7laOVDuwKvQZpC0Ohe9yCW9qlXO5yOPQCCnb7BPeKajjoz87XePXEZrQL
         3xQOtQPqLN7DnOF9jVziCBC3VPMcOzKLE2imzqOypWvWRndKQNysuJ1ax1DylTn3tx
         x/gzAcm9EAtP/43mcEVinQzpMAkfq5u13D55mvvf49NYG7ucapiUr7UCyvir4QRAgt
         WrLLfHrVjENQkBEMsofpCXaenVjVTV9MtZsN58sRWdluc1hzKcjNSD7PXAzvY2wBD/
         DPyNHNPOqTk1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1691141059; bh=ehgtpf9N2GNyOfygAYteEUrKM2M3ean2tmrHYuaJuas=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=VUk5pyFxvxGNtXPgBWsAdu788V87xThPqP7oVIVII1K4+CZdhOloLMnWT8B3nPCuJ
         OHbS1a3WR7laOVDuwKvQZpC0Ohe9yCW9qlXO5yOPQCCnb7BPeKajjoz87XePXEZrQL
         3xQOtQPqLN7DnOF9jVziCBC3VPMcOzKLE2imzqOypWvWRndKQNysuJ1ax1DylTn3tx
         x/gzAcm9EAtP/43mcEVinQzpMAkfq5u13D55mvvf49NYG7ucapiUr7UCyvir4QRAgt
         WrLLfHrVjENQkBEMsofpCXaenVjVTV9MtZsN58sRWdluc1hzKcjNSD7PXAzvY2wBD/
         DPyNHNPOqTk1A==
Date:   Fri, 4 Aug 2023 11:24:16 +0200
From:   Ladislav Michl <oss-lists@triops.cz>
To:     Jimmy Hu <hhhuuu@google.com>
Cc:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, kyletso@google.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: tcpm: IS_ERR_OR_NULL check for
 port->partner
Message-ID: <ZMzDwEBwJSB5k5Ci@lenoch>
References: <20230804084928.1153600-1-hhhuuu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804084928.1153600-1-hhhuuu@google.com>
X-CMAE-Envelope: MS4wfG+pqHNhsnQ+P6d+Yi59qqsNFMDJSew+YjjdsoCwnxJt3+8gJxdOTYeUDUUVhAeUILwfNfCxWQICExAJHA2LFRyed1QBnD6EfLPIvxgdGrvUQtRZVomW
 aB9E9S+PPczvbiCnb5DJzCdpvkUa3PDxSrHbZlQsnFpBul2zmxVDGp4aBXUQXWX5E+oRYFFp2pi5c4I9vgF5SrDvz3t+ZILbMcgjhaRR1CNmq8xGB167PJM6
 gh3fVJWWTsc9GckUv1YCGFCZDM5HovxGpYXNpFg77ziyuVX8y5/iq/D3mY88lsFEKooznXQPcO/EQlbASAG+R/LXdZ0k9bOv3f6Uvb/GGfSWvjpfIUpT/owC
 D7LkKnbzamGZa3ul9nIryFTgnX4Cs3rPDYYqzVuOnXwzXBlAHXcGGZlFIjRBDO/wShA71g53
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jimmy,

On Fri, Aug 04, 2023 at 08:49:28AM +0000, Jimmy Hu wrote:
> port->partner may be an error or NULL, so we must check it with
> IS_ERR_OR_NULL() before dereferencing it.
> 
> Move the check to the beginning of the tcpm_handle_vdm_request function.
> 
> Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 829d75ebab42..2c6a0af155ab 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1683,10 +1683,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>  			      (VDO_SVDM_VERS(typec_get_negotiated_svdm_version(typec)));
>  		break;
>  	case CMDT_RSP_ACK:
> -		/* silently drop message if we are not connected */
> -		if (IS_ERR_OR_NULL(port->partner))
> -			break;
> -
>  		tcpm_ams_finish(port);
>  
>  		switch (cmd) {
> @@ -1792,6 +1788,12 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>  	u32 response[8] = { };
>  	int i, rlen = 0;
>  
> +	/* silently drop message if we are not connected */

...comment moved.

> +	if (IS_ERR_OR_NULL(port->partner)) {
> +		dev_warn(port->dev, "port partner is an error or NULL\n");

But code is actually not silent. Also, does the verbsity make sense? And
if it does, is knowing what error port->partner is containing usefull?

> +		return;
> +	}
> +
>  	for (i = 0; i < cnt; i++)
>  		p[i] = le32_to_cpu(payload[i]);
>  
> -- 
> 2.41.0.585.gd2178a4bd4-goog
