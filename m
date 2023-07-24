Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F375F7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGXNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGXNGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:06:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B88DF;
        Mon, 24 Jul 2023 06:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDC2961176;
        Mon, 24 Jul 2023 13:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D9BC433C8;
        Mon, 24 Jul 2023 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204010;
        bh=ADbWdiG5m7FC03JjNyoWb5nYouhnLpSkLMz/+0jVixc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbbdLJgWpYJmTeYwWsvBtIvOSgmHTuNrSeq+un5zt6ujsvmGj/v76uJoEl/DqeOKa
         JejTNY2t92wGwpjklGy/1YzQCR78h8CFqsRRwH5UwTCxMzE3FbQ/qibEJsuVR+4Gz7
         sICH6+LmGaARXwy6JJFdsqFAEZbOHJT0suI+X3xXNRyr6ea88xAg65G3AGinLAIHv7
         NtzNiBy7IF7dL8ZhEA3YwNfQQjf4x97lNNiPj1sSoCgvJvEaTYgNc3PEJc7qogxH+V
         yfATcxtZ3sA9grzx2VfwbOavX9lb04V+fVO8y6SoxPLlfRrMmUhfZpZ97paZ51M196
         usS4/n+111Ujw==
Date:   Mon, 24 Jul 2023 18:36:33 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: remove unused variable
Message-ID: <20230724130633.GN6291@thinkpad>
References: <20230724122029.1430482-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724122029.1430482-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:19:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent change removed the only user of a local variable that needs
> to now also be removed:
> 
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
> drivers/ufs/host/ufs-qcom.c:1652:31: error: unused variable 'host' [-Werror=unused-variable]
> 
> Fixes: 8f2b78652d055 ("scsi: ufs: qcom: Get queue ID from MSI index in ESI handler")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 3ee5ff905f9a6..5728e94b6527b 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1649,7 +1649,6 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
>  	struct msi_desc *desc = data;
>  	struct device *dev = msi_desc_to_dev(desc);
>  	struct ufs_hba *hba = dev_get_drvdata(dev);
> -	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
>  	u32 id = desc->msi_index;
>  	struct ufs_hw_queue *hwq = &hba->uhq[id];
>  
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
