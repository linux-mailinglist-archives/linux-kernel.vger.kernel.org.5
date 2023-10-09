Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132607BD3DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbjJIGzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345336AbjJIGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:55:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071BFA6;
        Sun,  8 Oct 2023 23:55:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDEF61F891;
        Mon,  9 Oct 2023 06:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696834514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4z8iB8pzmdQEi50ddYto8Z/gCg4lm+6DDcRtC7AiNA=;
        b=RagLyUC/Xe8l2ntnYQMaNFJIc0XrrmAQhcFcE1cFpHPb9R1djPzp4vFEZmVBA8xbSM16ZG
        2IztxvbyW1Za1uTx2qBR5ZjV8BqR5rCeauku8SQ4vc/4FYg3TNJc7YaVWyo5EouWW+bEzw
        MZBykxMrgMKVQu3ZwqMrCV7ElE4UNp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696834514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4z8iB8pzmdQEi50ddYto8Z/gCg4lm+6DDcRtC7AiNA=;
        b=PCHMp6+RWsXSKRCmnZpLEISvlVzRuSPfaw9CzzkzozGSzjhAbmEPe48lwbOJTjmR6GFrbG
        jV615Nn/cPogc1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73A5F13586;
        Mon,  9 Oct 2023 06:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HSDVGtKjI2XLEQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 09 Oct 2023 06:55:14 +0000
Message-ID: <346bdffb-8a59-445e-a352-f3f1912fda1e@suse.de>
Date:   Mon, 9 Oct 2023 08:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-8-john.g.garry@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230814141022.36875-8-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 16:10, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ssp_task.task_prio is never set, so delete it
> and any references which depend on it being set (all of them).
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_task.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +--
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
>   drivers/scsi/isci/request.c            | 1 -
>   drivers/scsi/mvsas/mv_sas.c            | 3 +--
>   drivers/scsi/pm8001/pm8001_hwi.c       | 1 -
>   drivers/scsi/pm8001/pm80xx_hwi.c       | 1 -
>   include/scsi/libsas.h                  | 1 -
>   9 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
> index 1ac4d3afc1a1..f67983e8b262 100644
> --- a/drivers/scsi/aic94xx/aic94xx_task.c
> +++ b/drivers/scsi/aic94xx/aic94xx_task.c
> @@ -485,7 +485,6 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
>   	scb->ssp_task.ssp_frame.tptt = cpu_to_be16(0xFFFF);
>   
>   	memcpy(scb->ssp_task.ssp_cmd.lun, task->ssp_task.LUN, 8);
> -	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_prio << 3);
>   	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_attr & 7);
>   	memcpy(scb->ssp_task.ssp_cmd.cdb, task->ssp_task.cmd->cmnd,
>   	       task->ssp_task.cmd->cmd_len);
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> index d4e3c3a058e0..3c555579f9a1 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
> @@ -1022,8 +1022,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
>   
>   	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
>   	if (!tmf) {
> -		buf_cmd[9] = task->ssp_task.task_attr |
> -				(task->ssp_task.task_prio << 3);
> +		buf_cmd[9] = task->ssp_task.task_attr;
>   		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
>   				task->ssp_task.cmd->cmd_len);
>   	} else {
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 404aa7e179cb..73b378837da7 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -1798,8 +1798,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
>   
>   	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
>   	if (!tmf) {
> -		buf_cmd[9] = task->ssp_task.task_attr |
> -				(task->ssp_task.task_prio << 3);
> +		buf_cmd[9] = task->ssp_task.task_attr;
>   		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
>   				task->ssp_task.cmd->cmd_len);
>   	} else {
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index 813807a24ae1..bbb64ee6afd7 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -1326,7 +1326,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
>   
>   	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
>   	if (!tmf) {
> -		buf_cmd[9] = ssp_task->task_attr | (ssp_task->task_prio << 3);
> +		buf_cmd[9] = ssp_task->task_attr;
>   		memcpy(buf_cmd + 12, scsi_cmnd->cmnd, scsi_cmnd->cmd_len);
>   	} else {
>   		buf_cmd[10] = tmf->tmf;
> diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
> index 6370cdbfba08..fdb8dff2e50c 100644
> --- a/drivers/scsi/isci/request.c
> +++ b/drivers/scsi/isci/request.c
> @@ -180,7 +180,6 @@ static void sci_io_request_build_ssp_command_iu(struct isci_request *ireq)
>   	cmd_iu->_r_a = 0;
>   	cmd_iu->_r_b = 0;
>   	cmd_iu->en_fburst = 0; /* unsupported */
> -	cmd_iu->task_prio = task->ssp_task.task_prio;
>   	cmd_iu->task_attr = task->ssp_task.task_attr;
>   	cmd_iu->_r_c = 0;
>   
> diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
> index 165f46320bd2..1444b1f1c4c8 100644
> --- a/drivers/scsi/mvsas/mv_sas.c
> +++ b/drivers/scsi/mvsas/mv_sas.c
> @@ -663,8 +663,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
>   	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
>   
>   	if (ssp_hdr->frame_type != SSP_TASK) {
> -		buf_cmd[9] = task->ssp_task.task_attr |
> -				(task->ssp_task.task_prio << 3);
> +		buf_cmd[9] = task->ssp_task.task_attr;
>   		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
>   		       task->ssp_task.cmd->cmd_len);
>   	} else{
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
> index 18070e0e06d5..35797b56ea0a 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -4053,7 +4053,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>   	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
>   	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
>   	ssp_cmd.tag = cpu_to_le32(tag);
> -	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
>   	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
>   	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
>   	       task->ssp_task.cmd->cmd_len);
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index ad5a73b86415..1c092ee37bdd 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -4316,7 +4316,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
>   	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
>   	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
>   	ssp_cmd.tag = cpu_to_le32(tag);
> -	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
>   	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
>   	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
>   		       task->ssp_task.cmd->cmd_len);
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index d77db53cbd8d..5b2e6932c564 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -565,7 +565,6 @@ enum task_attribute {
>   struct sas_ssp_task {
>   	u8     LUN[8];
>   	enum   task_attribute task_attr;
> -	u8     task_prio;
>   	struct scsi_cmnd *cmd;
>   };
>   
Hmm. While true in general, we lose information on how the 'prio' field 
is coded for the various drivers.
Would it be an idea to use explicitly state TASK_ATTR_SIMPLE
in the various drivers such that we know what to fix if we ever
decide to bring task attributes back to life?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

