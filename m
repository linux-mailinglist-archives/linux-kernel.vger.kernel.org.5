Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2187E7BD392
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345286AbjJIGiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJIGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:38:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B3A3;
        Sun,  8 Oct 2023 23:38:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 960152183A;
        Mon,  9 Oct 2023 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696833485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5UvHjopYiENz10RDDQnvbNcaN8Eck7n+Yazp9vpOsU=;
        b=SGV9Vj4jx+Vdc+uDcApYBZd4CjZSYBi4TGOrK8QerxqjLvKqmyJPglCyoVfLZhBmVLb72i
        WhtBOkS00IBF94aKI6PbNerGJiKINRY0y/6VxsNdtMIvrSRkKmOwf1gXl/svTM/HPCTV9w
        dVTV1jKOsEmQfoxzDiRyODpnPRAGlU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696833485;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5UvHjopYiENz10RDDQnvbNcaN8Eck7n+Yazp9vpOsU=;
        b=TyxEUMCmjyUrT3AkWRKIBWgF2ssg4/qjEsGdGN5omcCByO751Dl9CWTWMFIlqENb7Nv+ME
        Cp6I7l40gI74LBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D09813586;
        Mon,  9 Oct 2023 06:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J0KsFc2fI2UmCgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 09 Oct 2023 06:38:05 +0000
Message-ID: <d5ae456f-876d-4b73-983e-6f0f638137fe@suse.de>
Date:   Mon, 9 Oct 2023 08:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] scsi: libsas: Delete sas_ha_struct.lldd_module
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-2-john.g.garry@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230814141022.36875-2-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 16:10, John Garry wrote:
> Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
> driver"), sas_ha_struct.lldd_module has only ever been set, so remove it.
> 
> Struct scsi_host_template already has a reference to the LLD driver
> module as to stop the driver being removed unexpectedly.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_init.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 -
>   drivers/scsi/isci/init.c               | 1 -
>   drivers/scsi/mvsas/mv_init.c           | 1 -
>   drivers/scsi/pm8001/pm8001_init.c      | 1 -
>   include/scsi/libsas.h                  | 1 -
>   7 files changed, 7 deletions(-)
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

