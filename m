Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936F807752
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442757AbjLFSIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378992AbjLFSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206C122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701886135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuqiBkPwlY2HXqxQqL3cC1VexkgQjNgO5uHmyoXbHn4=;
        b=iOA7UhUL2Zu8XMQMJt2YxZ0M8h4gjTw8yLQzbLPJ/qeEJdeYHi7RHxYuemw7IRzvowreiA
        cx6kBJEO4S1+9ETiRd56rmou7+sRC6yOwprrppnh6L0tWV91hfDQFAt9ZOeg6uId5JV4Sa
        Nb3X/oP9oR/hSHAf8ud4DZ9vHHTEaHM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-9gAe3ruMPjSdU8yURDTLBg-1; Wed, 06 Dec 2023 13:08:43 -0500
X-MC-Unique: 9gAe3ruMPjSdU8yURDTLBg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58794776af4so18129eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 10:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886122; x=1702490922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuqiBkPwlY2HXqxQqL3cC1VexkgQjNgO5uHmyoXbHn4=;
        b=epw3O9bj1FHX1Nog3MTFEKj3D0fdvfgfJ4UvWsNGv8x1806Uy0SCARzP67blQ9mKIg
         VZSDyzi82sSR1dcpYZdAagCuhqJogcl0s3tDHhWOYycdT5XxAGnLcSTooNcMlSmhNFhv
         DjOOPGbd7s8grIbOMERK1iQ4kaPMGy1ymeWkcaTx1eCOTKyoRwqiLU64sS9U5jO5Zzki
         SNtKjZwypRV1oTKaBpmRAqWLFg9G9PIrMy2ogvZrMGmepYBh1OVvWBoDs83m88eutQSN
         X6N5yZLiH+f6M0/1DfKi+jexz/xDLo7f+4Ja0ct8bzuQ81Qh+WwL5iAFXDQwPsW1JQ4U
         QCxA==
X-Gm-Message-State: AOJu0Yx26PrLrWEcKLzr3SEfjyOsBiPWmAw0TDYnq+R81MqjndcWwPVu
        bspjprO96pozmnrSZK6fd70FOyamWshU447IADFRicOLT5hrgBju05a2Ci0TQ56uBs3gjJgJx75
        7rkoxvn0Pe6y9/xciDGcu/eSf
X-Received: by 2002:a05:6358:7504:b0:170:61c5:f2fa with SMTP id k4-20020a056358750400b0017061c5f2famr2084885rwg.38.1701886122012;
        Wed, 06 Dec 2023 10:08:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGamHCenfAZjFP5rNg+1b4/YYFi/5d47GeOh3mst5VBZPXsGpbtxdzeGEy3IORSvuG0nzWYNQ==
X-Received: by 2002:a05:6358:7504:b0:170:61c5:f2fa with SMTP id k4-20020a056358750400b0017061c5f2famr2084860rwg.38.1701886121566;
        Wed, 06 Dec 2023 10:08:41 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id qz22-20020a05620a8c1600b0077d71d46887sm129645qkn.112.2023.12.06.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:08:41 -0800 (PST)
Date:   Wed, 6 Dec 2023 12:08:38 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com
Subject: Re: [PATCH 01/13] scsi: ufs: qcom: Use clk_bulk APIs for managing
 lane clocks
Message-ID: <d4sk5x5fh2vwkyxxis47ujv5opwkr57yuaymfq7zacofk6byb6@77f6izcb3juo>
References: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
 <20231201151417.65500-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201151417.65500-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 08:44:05PM +0530, Manivannan Sadhasivam wrote:
> Lane clock handling can be simplified by using the clk_bulk APIs. So let's
> make use of them. This also get's rid of the clock validation in the driver
> as kernel should just rely on the firmware (DT/ACPI) to provide the clocks
> required for proper functioning.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/ufs/host/ufs-qcom.c | 94 ++-----------------------------------
>  drivers/ufs/host/ufs-qcom.h |  6 +--
>  2 files changed, 7 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 96cb8b5b4e66..cbb6a696cd97 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -194,52 +194,12 @@ static inline int ufs_qcom_ice_suspend(struct ufs_qcom_host *host)
>  }
>  #endif
>  
> -static int ufs_qcom_host_clk_get(struct device *dev,
> -		const char *name, struct clk **clk_out, bool optional)
> -{
> -	struct clk *clk;
> -	int err = 0;
> -
> -	clk = devm_clk_get(dev, name);
> -	if (!IS_ERR(clk)) {
> -		*clk_out = clk;
> -		return 0;
> -	}
> -
> -	err = PTR_ERR(clk);
> -
> -	if (optional && err == -ENOENT) {
> -		*clk_out = NULL;
> -		return 0;
> -	}
> -
> -	if (err != -EPROBE_DEFER)
> -		dev_err(dev, "failed to get %s err %d\n", name, err);
> -
> -	return err;
> -}
> -
> -static int ufs_qcom_host_clk_enable(struct device *dev,
> -		const char *name, struct clk *clk)
> -{
> -	int err = 0;
> -
> -	err = clk_prepare_enable(clk);
> -	if (err)
> -		dev_err(dev, "%s: %s enable failed %d\n", __func__, name, err);
> -
> -	return err;
> -}
> -
>  static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>  {
>  	if (!host->is_lane_clks_enabled)
>  		return;
>  
> -	clk_disable_unprepare(host->tx_l1_sync_clk);
> -	clk_disable_unprepare(host->tx_l0_sync_clk);
> -	clk_disable_unprepare(host->rx_l1_sync_clk);
> -	clk_disable_unprepare(host->rx_l0_sync_clk);
> +	clk_bulk_disable_unprepare(host->num_clks, host->clks);
>  
>  	host->is_lane_clks_enabled = false;
>  }
> @@ -247,43 +207,14 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>  static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>  {
>  	int err;
> -	struct device *dev = host->hba->dev;
> -
> -	if (host->is_lane_clks_enabled)
> -		return 0;
>  
> -	err = ufs_qcom_host_clk_enable(dev, "rx_lane0_sync_clk",
> -		host->rx_l0_sync_clk);
> +	err = clk_bulk_prepare_enable(host->num_clks, host->clks);
>  	if (err)
>  		return err;
>  
> -	err = ufs_qcom_host_clk_enable(dev, "tx_lane0_sync_clk",
> -		host->tx_l0_sync_clk);
> -	if (err)
> -		goto disable_rx_l0;
> -
> -	err = ufs_qcom_host_clk_enable(dev, "rx_lane1_sync_clk",
> -			host->rx_l1_sync_clk);
> -	if (err)
> -		goto disable_tx_l0;
> -
> -	err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
> -			host->tx_l1_sync_clk);
> -	if (err)
> -		goto disable_rx_l1;
> -
>  	host->is_lane_clks_enabled = true;
>  
>  	return 0;
> -
> -disable_rx_l1:
> -	clk_disable_unprepare(host->rx_l1_sync_clk);
> -disable_tx_l0:
> -	clk_disable_unprepare(host->tx_l0_sync_clk);
> -disable_rx_l0:
> -	clk_disable_unprepare(host->rx_l0_sync_clk);
> -
> -	return err;
>  }
>  
>  static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
> @@ -294,26 +225,11 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>  	if (has_acpi_companion(dev))
>  		return 0;
>  
> -	err = ufs_qcom_host_clk_get(dev, "rx_lane0_sync_clk",
> -					&host->rx_l0_sync_clk, false);
> -	if (err)
> -		return err;
> -
> -	err = ufs_qcom_host_clk_get(dev, "tx_lane0_sync_clk",
> -					&host->tx_l0_sync_clk, false);
> -	if (err)
> +	err = devm_clk_bulk_get_all(dev, &host->clks);
> +	if (err <= 0)
>  		return err;
>  
> -	/* In case of single lane per direction, don't read lane1 clocks */
> -	if (host->hba->lanes_per_direction > 1) {
> -		err = ufs_qcom_host_clk_get(dev, "rx_lane1_sync_clk",
> -			&host->rx_l1_sync_clk, false);
> -		if (err)
> -			return err;
> -
> -		err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> -			&host->tx_l1_sync_clk, true);
> -	}
> +	host->num_clks = err;
>  
>  	return 0;
>  }
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 9950a0089475..e2df4c528a2a 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -213,10 +213,8 @@ struct ufs_qcom_host {
>  	struct phy *generic_phy;
>  	struct ufs_hba *hba;
>  	struct ufs_pa_layer_attr dev_req_params;
> -	struct clk *rx_l0_sync_clk;
> -	struct clk *tx_l0_sync_clk;
> -	struct clk *rx_l1_sync_clk;
> -	struct clk *tx_l1_sync_clk;
> +	struct clk_bulk_data *clks;
> +	u32 num_clks;
>  	bool is_lane_clks_enabled;
>  
>  	struct icc_path *icc_ddr;
> -- 
> 2.25.1
> 
> 

