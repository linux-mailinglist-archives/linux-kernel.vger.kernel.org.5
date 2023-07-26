Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6F762AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGZFbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjGZFbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFC8268D;
        Tue, 25 Jul 2023 22:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F186140F;
        Wed, 26 Jul 2023 05:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084EEC433C7;
        Wed, 26 Jul 2023 05:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690349466;
        bh=KU3vQCx18WHSd2+PMtdOeua7nW32gCD9MnK8C/cdnks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoJ3hEzs4f0cM6vPwtOXikVDCSCfVtsEoqKhIk1EgmKgA8IxYYn+yQCy4MIazZ5Uf
         eZRlS3MRQTnA5SaUd8SCV2UM1yV5YGhMphxgLHJU5awjiiJ7AJfD7xEaCsDUN7/oQQ
         d9oAeYvt7FhhtfHN+zK0c+aNq0pi0931oQ8GSNo/qqoB7wMvvZldHUK3S1RvwNKFvO
         /ciy+EHwd6Ue289pqI3+BVgYoh1Fu6xNPM7hOs3YfI2I1cQH5fDgmTOXsH0pJ2CYnJ
         gZ1tAtgBU8IIljgpo3xg2iTO2x+qe2vVyn+qLf2RfboEU1V0wDxPJmVDPVQR9wzyth
         j2CPp57XGPcXQ==
Date:   Tue, 25 Jul 2023 22:34:18 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_narepall@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manish Pandey <quic_mapa@quicinc.com>
Subject: Re: [PATCH V1 2/2] scsi: ufs: ufs-qcom: check host controller state
Message-ID: <qlxiohqdw52tb3d7duvv3rlusfzo6n73wipmeracchbp7ajrzz@d6ebtuqaldsw>
References: <20230725192710.26698-1-quic_nitirawa@quicinc.com>
 <20230725192710.26698-3-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725192710.26698-3-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:57:10AM +0530, Nitin Rawat wrote:
> Check host controller state before sending hibern8 command.
> 

Please read https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>

Please read https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 8d6fd4c3324f..95412e98a598 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -1254,6 +1254,10 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba,
>  	struct ufs_pa_layer_attr *dev_req_params = &host->dev_req_params;
>  	int err = 0;
> 
> +	/* check the host controller state before sending hibern8 cmd */

That is exactly what the two lines does, but the comment does not
provide any insight into why this is done. Keeping a comment here seems
relevant, please make sure that it adds value.

Thanks,
Bjorn

> +	if (!ufshcd_is_hba_active(hba))
> +		return 0;
> +
>  	if (status == PRE_CHANGE) {
>  		err = ufshcd_uic_hibern8_enter(hba);
>  		if (err)
> --
> 2.17.1
> 
