Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A676787F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjG1W3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjG1W3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 18:29:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3372136
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:29:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso1973738b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690583358; x=1691188158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8umto85lFOsMjOOJkbaCNVGW8Pn8sjRWz/5J34AL9mI=;
        b=RHkA8ShzyZ11Ac14ktRMDEVa5HTOf84/TpVv8bKhfRH5PDWGIlsqtuAnJ5SOpctMfP
         NR89D0QRJD7H59RmoOiGP23zT8siCPuh/aFJr0sDys+NK5td/07olKEHto0ZPgihvU4z
         4w+3YILrfKHQE9WhV/H6Bk00+30LaI7xPgedU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690583358; x=1691188158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8umto85lFOsMjOOJkbaCNVGW8Pn8sjRWz/5J34AL9mI=;
        b=XijlUFBinAdH2A/2aI/rY7HWdDQ/9EkRODCcgG2oT+3oUwQ32gBOmkLWHs7uNfybXF
         mEeFNZVZHGDG/V9g33+yaSXtV2mh/FZ2c2Vtl6T/K5+14tQtDYlhx9GudV7L8Erf2DBl
         0izCug9yeBNhdBWbDqTXj0JDR4dDUYd66NDCRkw+C49TZFPOnJWBX35Gr41oXHgutFy4
         zVpKazUaxeyl66y3pr+7GA1T0B+rs6Eu1kHVdxZjEDRceoVSGxubeY4B3W36ssgXzVJI
         gbjyPnX0pylC3jgWABHJwWxAI5fDR5UjsPEc0wkwMM/qpdZfk/3bG2qw+X6iV06tU941
         ULqw==
X-Gm-Message-State: ABy/qLYOj2ZVkifiGnWu30LrUOI6sXcXq+471tApEcK9oOC2Q+l1WUo5
        UPsnLFtvaUyKNPrDEpeIn0W4DsSRAqD4xHtdjsg=
X-Google-Smtp-Source: APBJJlER1FAg4n/elG1kpOAL3M0WPLwKlU/yvj9/qMTrf+Zkic2J1OOG0h4sfGtKezJLJUCEPQXtww==
X-Received: by 2002:a05:6a20:9383:b0:134:1d88:1d88 with SMTP id x3-20020a056a20938300b001341d881d88mr3221404pzh.58.1690583358354;
        Fri, 28 Jul 2023 15:29:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020aa7804f000000b0066a4e561beesm3752873pfm.173.2023.07.28.15.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 15:29:17 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:29:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] scsi: mpt3sas: Replace a dynamic allocation with a
 local variable
Message-ID: <202307281528.086CF1D063@keescook>
References: <20230725161331.27481-1-james@equiv.tech>
 <20230725161331.27481-7-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725161331.27481-7-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:13:31AM -0700, James Seo wrote:
> This dynamic allocation can be replaced with a local variable.
> 
> Signed-off-by: James Seo <james@equiv.tech>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> index cd6f36094159..a32a6fa728a7 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> @@ -5361,10 +5361,9 @@ _base_update_diag_trigger_pages(struct MPT3SAS_ADAPTER *ioc)
>  static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
>  {
>  	Mpi2ConfigReply_t mpi_reply;
> -	Mpi2SasIOUnitPage1_t *sas_iounit_pg1 = NULL;
> +	Mpi2SasIOUnitPage1_t sas_iounit_pg1;
>  	Mpi26PCIeIOUnitPage1_t pcie_iounit_pg1;
>  	u16 depth;
> -	int sz;
>  	int rc = 0;
>  
>  	ioc->max_wideport_qd = MPT3SAS_SAS_QUEUE_DEPTH;
> @@ -5374,28 +5373,21 @@ static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
>  	if (!ioc->is_gen35_ioc)
>  		goto out;
>  	/* sas iounit page 1 */
> -	sz = offsetof(Mpi2SasIOUnitPage1_t, PhyData);
> -	sas_iounit_pg1 = kzalloc(sizeof(Mpi2SasIOUnitPage1_t), GFP_KERNEL);

Hunh. So Mpi2SasIOUnitPage1_t is used without the flexarray at all?

-Kees

> -	if (!sas_iounit_pg1) {
> -		pr_err("%s: failure at %s:%d/%s()!\n",
> -		    ioc->name, __FILE__, __LINE__, __func__);
> -		return rc;
> -	}
>  	rc = mpt3sas_config_get_sas_iounit_pg1(ioc, &mpi_reply,
> -	    sas_iounit_pg1, sz);
> +	    &sas_iounit_pg1, sizeof(Mpi2SasIOUnitPage1_t));
>  	if (rc) {
>  		pr_err("%s: failure at %s:%d/%s()!\n",
>  		    ioc->name, __FILE__, __LINE__, __func__);
>  		goto out;
>  	}
>  
> -	depth = le16_to_cpu(sas_iounit_pg1->SASWideMaxQueueDepth);
> +	depth = le16_to_cpu(sas_iounit_pg1.SASWideMaxQueueDepth);
>  	ioc->max_wideport_qd = (depth ? depth : MPT3SAS_SAS_QUEUE_DEPTH);
>  
> -	depth = le16_to_cpu(sas_iounit_pg1->SASNarrowMaxQueueDepth);
> +	depth = le16_to_cpu(sas_iounit_pg1.SASNarrowMaxQueueDepth);
>  	ioc->max_narrowport_qd = (depth ? depth : MPT3SAS_SAS_QUEUE_DEPTH);
>  
> -	depth = sas_iounit_pg1->SATAMaxQDepth;
> +	depth = sas_iounit_pg1.SATAMaxQDepth;
>  	ioc->max_sata_qd = (depth ? depth : MPT3SAS_SATA_QUEUE_DEPTH);
>  
>  	/* pcie iounit page 1 */
> @@ -5414,7 +5406,6 @@ static int _base_assign_fw_reported_qd(struct MPT3SAS_ADAPTER *ioc)
>  	    "MaxWidePortQD: 0x%x MaxNarrowPortQD: 0x%x MaxSataQD: 0x%x MaxNvmeQD: 0x%x\n",
>  	    ioc->max_wideport_qd, ioc->max_narrowport_qd,
>  	    ioc->max_sata_qd, ioc->max_nvme_qd));
> -	kfree(sas_iounit_pg1);
>  	return rc;
>  }
>  
> -- 
> 2.39.2
> 

-- 
Kees Cook
