Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4E877F4B0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350144AbjHQLBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350157AbjHQLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:00:47 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 04:00:43 PDT
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AF30C0;
        Thu, 17 Aug 2023 04:00:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4E341C0009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
        t=1692269574; bh=AehP888etUrm7amHfFcvQ6JX0HnlZBk7UUTpgRujN1s=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=Fmv5SawTv711CAVIx9xFXRxB7Ue6mmxK0aBMfy333sVwh1EjxK7fdxHwdN/OSsH4l
         EF17JKgSJpqoC+ASrZTUrGUoHhoJVTldV/jwD0sncSuHbiHCDpejBHH6eGudDmNdxo
         dzZRsjCMeTQaIaOqwmak/cgHg+UUMWyEOzz8uDyvcv2cehgDAvlxKC/DveHpSLLE+T
         XuQHBuwBIUBBxCdHfN89ZdboWUaJ54ry2pzaKSLKtuvFJwOucX+S1feKRF/puwCHiT
         g4Cmu3OsabcDdW7iZhzUYVYPllbH7Xl/UgCuXZ7l450qls/H6nB9neRoMED/gexM2Q
         gGA2RQOeQoQeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
        t=1692269574; bh=AehP888etUrm7amHfFcvQ6JX0HnlZBk7UUTpgRujN1s=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=L9Pss4wafQgF4+j4US+bbq98ahyzt05LdL8ktiIdf3ZsrhLTD6BQRqciiBqnrO88Y
         0oDJlyNAmioKau5c6jB7sae9gc7xH6XsU7V5lol+QG1ESSh/kdoV86Z7mEY9TQv/8S
         5YFHTCnjrH79S4j3Kf02DuXIY9CmVF4c80nLnqrrKlfaropWlRxn+b17R6b/+6eyTJ
         WcMBI/91LbNyMF9RgfB4nsLrCH8IK1/U/sO1dv0F/pPG9eiAE34csMnlVMNk/4oKa4
         V80yzQad7zvJZch2B6gBTY8F13Dbht7BQo+DxdjB8sXH4urEq28sKmGw5gPkO0UKJe
         jOQtNqk2elE2g==
Date:   Thu, 17 Aug 2023 13:52:52 +0300
From:   Dmitry Bogdanov <d.bogdanov@yadro.com>
To:     <coolrrsh@gmail.com>
CC:     <james.smart@broadcom.com>, <ram.vegesna@broadcom.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <rdunlap@infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH v2] scsi: sli4: Remove the buggy code
Message-ID: <20230817105252.GA14370@yadro.com>
References: <20230817103751.16350-1-coolrrsh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230817103751.16350-1-coolrrsh@gmail.com>
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:07:51PM +0530, coolrrsh@gmail.com wrote:
> 
> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> In the function sli_xmit_bls_rsp64_wqe, the 'if' and 'else' conditions
> evaluates the same expression and gives same output. Also the variable
> bls->local_n_port_id_dword is not used anywhere. Therefore removing the
> redundant code.
> 
> This fixes coccinelle warning such as:
> drivers/scsi/elx/libefc_sli/sli4.c:2320:2-4: WARNING: possible
> condition with no effect (if == else)
> 
> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> ---
> v1->v2
> Modified patch and verified with checkpatch.pl.
> 
> ---
>  drivers/scsi/elx/libefc_sli/sli4.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
> index 8f96049f62dd..af661b769464 100644
> --- a/drivers/scsi/elx/libefc_sli/sli4.c
> +++ b/drivers/scsi/elx/libefc_sli/sli4.c
> @@ -2317,13 +2317,6 @@ sli_xmit_bls_rsp64_wqe(struct sli4 *sli, void *buf,
>                 SLI4_GENERIC_CONTEXT_VPI << SLI4_BLS_RSP_WQE_CT_SHFT;
>                 bls->context_tag = cpu_to_le16(params->vpi);
> 
> -               if (params->s_id != U32_MAX)
> -                       bls->local_n_port_id_dword |=
> -                               cpu_to_le32(params->s_id & 0x00ffffff);
> -               else
> -                       bls->local_n_port_id_dword |=
> -                               cpu_to_le32(params->s_id & 0x00ffffff);
> -

omg, it is not an unused variable. Whole bls is a HW descriptor, all of
its variables are used by HW. You should keep v1 version of the patch.
According to the comment at the beginning of the funciton s_id here shall
be != U32_MAX. That is an explanation for your v1 patch.

>                 dw_ridflags = (dw_ridflags & ~SLI4_BLS_RSP_RID) |
>                                (params->d_id & SLI4_BLS_RSP_RID);
> 
> --
> 2.25.1
> 
