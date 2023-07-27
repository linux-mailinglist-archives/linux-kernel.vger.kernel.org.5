Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3BB7648D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjG0HiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjG0Hhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A406EAC;
        Thu, 27 Jul 2023 00:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB6A61D46;
        Thu, 27 Jul 2023 07:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B1BC433C7;
        Thu, 27 Jul 2023 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690442836;
        bh=cRltrGoMF1XVHVMN+3895nVzlR8IUj6FdeqfN9lvsWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WchpQOaPQLed6S4iw7SWGXSSDamJo1JrETXZe96VYmtSR8TcJJHkfEZfo65tWcBnu
         1YE+vJ9QUQVznrfZl2Ms6Anfi8SOWkLJ0buzZd7laEC24yfwQ2L6/nG2F//9+etF98
         rSD48NW1a87mSFUCAV9EoLwztLKvH95eMkBObMIL485PTWYzzbAE3QSm2hOiMq1zNA
         IUPC3c5OMeV5DZknwGVF5pcVUvTba8cRLOUHyGCeUXXLR66gxYtsSUrXp1ThtCGmNK
         S1j28xAkB+vxfA/L0FwBf0ELBegwVP/jilFtCouc+PUs1uS3uYaQ1CEF19FF2E6Ucl
         jcRoi73Q/Qs1A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qOvPK-0008Uq-2R;
        Thu, 27 Jul 2023 09:27:34 +0200
Date:   Thu, 27 Jul 2023 09:27:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_hemantg@quicinc.com
Subject: Re: [PATCH v13 1/2] Bluetooth: hci_qca: adjust qca btsoc type print
 expression
Message-ID: <ZMIcZqpN-CBgCFS8@hovoldconsulting.com>
References: <20230727044011.965205-1-quic_tjiang@quicinc.com>
 <20230727044011.965205-2-quic_tjiang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727044011.965205-2-quic_tjiang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:40:10PM +0800, Tim Jiang wrote:
> This patch make the print btsoc type expression more clearly.
> 
> Signed-off-by: Tim Jiang <quic_tjiang@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9b785c947d96..e11d47210e80 100644
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
> @@ -1762,10 +1763,32 @@ static int qca_setup(struct hci_uart *hu)
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
> +	case QCA_QCA6390:
> +		soc_name = "QCA6390";
> +		break;
> +	case QCA_WCN3990:
> +	case QCA_WCN3991:
> +	case QCA_WCN3998:
> +		soc_name = "wcn399x";
> +		break;
> +	case QCA_WCN6750:
> +		soc_name = "wcn6750";
> +		break;
> +	case QCA_WCN6855:
> +		soc_name = "wcn6855";
> +		break;

I still think the above should be sorted (alphabetically) as maintaining
these lists otherwise soon becomes harder than it should be. And similar
throughout the driver.

> +	default:
> +		soc_name = "unknown soc";
> +		break;
> +	}
> +	bt_dev_info(hdev, "setting up %s", soc_name);

Johan
