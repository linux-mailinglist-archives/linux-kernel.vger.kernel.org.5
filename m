Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5D762C38
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjGZHAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjGZG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013435A5;
        Tue, 25 Jul 2023 23:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D495561377;
        Wed, 26 Jul 2023 06:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ECEC433C8;
        Wed, 26 Jul 2023 06:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690354749;
        bh=YJbZWjLmv2nhGyocw8/jLi13ut4U4Org0GZYTO108vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBw3F3Py5F4fIGRHeO8kwhm8EXu+BE1gVsooNOEhoC5VfKhoYUZ0HaQY+cljOwkji
         1ZesAbgIcGpclM7bLxrXc8ZVe5334I+ZU4+kYXORSTeFT8wcZHvmTUQlcjNGynlb9Y
         UsUgcs8Dlr52hPw+yirtNPeU7YHuppmeaKvZZ9ZRu92E3d5/U0Vq/4rqROACbXVmCU
         iNzRu7/GwbAQB7RIiJPwfJ7/TNybJa+t5Xbi02tbV0YqBaF997+9Qn6Iw35PLtYtIs
         Ei0V7DnXN1mRRoTv7KP/LBbkZR+RGZg78Mu5PYBHIYp1wPXSlh9ZvgvkAN1dY1i/ta
         sQTgpvnkpBIYA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOYUX-0003Ql-0S;
        Wed, 26 Jul 2023 08:59:25 +0200
Date:   Wed, 26 Jul 2023 08:59:25 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, quic_hemantg@quicinc.com
Subject: Re: [PATCH v12 1/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA2066
Message-ID: <ZMDETVMUmJxmbIvW@hovoldconsulting.com>
References: <20230726052245.609987-1-quic_tjiang@quicinc.com>
 <20230726052245.609987-2-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726052245.609987-2-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix up the subject of this patch, which should be different from
patch 2/2 and instead summarise what *this* patch does.

Note that keeping the same 2/2 subject on the cover letter is fine as
2/2 is the primary patch and sort of summarises the series.

On Wed, Jul 26, 2023 at 01:22:44PM +0800, Tim Jiang wrote:
> This patch make the print btsoc type expression more clearly.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/btqca.h   |  1 +
>  drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index b884095bcd9d..529382f0abb1 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -148,6 +148,7 @@ enum qca_btsoc_type {
>  	QCA_QCA6390,
>  	QCA_WCN6750,
>  	QCA_WCN6855,
> +	QCA_QCA2066,

This belongs in the next patch.

These are currently not sorted by probably should be to make it easier
to look up and add new entries. This could be done in a third,
preparatory, patch.

>  };
>  
>  #if IS_ENABLED(CONFIG_BT_QCA)
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9b785c947d96..453000df7aec 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1748,6 +1748,7 @@ static int qca_setup(struct hci_uart *hu)
>  	const char *firmware_name = qca_get_firmware_name(hu);
>  	int ret;
>  	struct qca_btsoc_version ver;
> +	const char *soc_name;
>  
>  	ret = qca_check_speeds(hu);
>  	if (ret)
> @@ -1762,10 +1763,35 @@ static int qca_setup(struct hci_uart *hu)
>  	 */
>  	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>  
> -	bt_dev_info(hdev, "setting up %s",
> -		qca_is_wcn399x(soc_type) ? "wcn399x" :
> -		(soc_type == QCA_WCN6750) ? "wcn6750" :
> -		(soc_type == QCA_WCN6855) ? "wcn6855" : "ROME/QCA6390");
> +	switch (soc_type) {
> +	case QCA_AR3002:
> +		soc_name = "ar300x";
> +		break;
> +	case QCA_ROME:
> +		soc_name = "ROME";
> +		break;
> +	case QCA_WCN3990:
> +	case QCA_WCN3991:
> +	case QCA_WCN3998:
> +		soc_name = "wcn399x";
> +		break;
> +	case QCA_QCA2066:
> +		soc_name = "QCA2066";
> +		break;

This also belongs in the next patch.

> +	case QCA_QCA6390:
> +		soc_name = "QCA6390";
> +		break;
> +	case QCA_WCN6750:
> +		soc_name = "wcn6750";
> +		break;
> +	case QCA_WCN6855:
> +		soc_name = "wcn6855";
> +		break;
> +	default:
> +		soc_name = "unknown soc";
> +		break;
> +	}

And you should probably sort the above as well.

> +	bt_dev_info(hdev, "setting up %s", soc_name);
>  
>  	qca->memdump_state = QCA_MEMDUMP_IDLE;

Johan
