Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937607BD39C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbjJIGk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjJIGkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:40:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D58B9;
        Sun,  8 Oct 2023 23:40:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E81621854;
        Mon,  9 Oct 2023 06:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696833652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYk7Dl1IyTCruXA3J2ju4L+Som54gNCrrFPCGoBehbM=;
        b=esCDS5UFah073cdI00QPqzWMEaoaeoIHo1AjOjnkQB1mHZEZMYnFdlR/oLeZos1/kW4y/a
        ATyLZO1jQsr03CWYGumQko7zEG9ySFmq0bytXdnO/PYu89L3SyKToC84Qa91JrBJR2CwwJ
        SkRSVNMQJS18SnEmLcuU8CQLcX2DkMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696833652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYk7Dl1IyTCruXA3J2ju4L+Som54gNCrrFPCGoBehbM=;
        b=+EbK5n3XATka5iX477fowRczZPqlC4wP3ezzbQGg/LzhMzuxBdsIeeXXk8pq3uicYzo/aP
        YQnsHIi3g4ZzNuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AAF313586;
        Mon,  9 Oct 2023 06:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ENLaC3SgI2UmCgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 09 Oct 2023 06:40:52 +0000
Message-ID: <b84fca82-fcb7-4b41-9852-7e6e1991f245@suse.de>
Date:   Mon, 9 Oct 2023 08:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] scsi: libsas: Delete struct scsi_core
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-5-john.g.garry@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230814141022.36875-5-john.g.garry@oracle.com>
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
> Since commit 79855d178557 ("libsas: remove task_collector mode"), struct
> scsi_core only contains a reference to the shost. struct scsi_core is only
> used in sas_ha_struct.core, so delete scsi_core and replace with a
> reference to the shost there.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_hwi.c     |  2 +-
>   drivers/scsi/aic94xx/aic94xx_init.c    |  6 +++---
>   drivers/scsi/hisi_sas/hisi_sas_main.c  |  6 +++---
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  6 +++---
>   drivers/scsi/isci/host.h               |  2 +-
>   drivers/scsi/isci/init.c               |  4 ++--
>   drivers/scsi/libsas/sas_ata.c          |  8 ++++----
>   drivers/scsi/libsas/sas_discover.c     |  8 ++++----
>   drivers/scsi/libsas/sas_expander.c     |  2 +-
>   drivers/scsi/libsas/sas_host_smp.c     |  4 ++--
>   drivers/scsi/libsas/sas_init.c         | 16 ++++++++--------
>   drivers/scsi/libsas/sas_phy.c          |  8 ++++----
>   drivers/scsi/libsas/sas_port.c         |  6 +++---
>   drivers/scsi/libsas/sas_scsi_host.c    | 14 +++++++-------
>   drivers/scsi/mvsas/mv_init.c           |  4 ++--
>   drivers/scsi/pm8001/pm8001_init.c      |  2 +-
>   include/scsi/libsas.h                  |  7 +------
>   17 files changed, 50 insertions(+), 55 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

