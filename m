Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F7E7BD397
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjJIGj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjJIGj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:39:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B4BA6;
        Sun,  8 Oct 2023 23:39:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7082E2183A;
        Mon,  9 Oct 2023 06:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696833593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2u6vYyS+812CkJSt5+jVbKml4me73ulgL4G0MCFLf4=;
        b=lINKX74DKhQW6SCPgq20Fit9WwSI3hpV3S0PLXQpWQW9Ei2KhX6JSgLpx+hBQSO/KLr0PJ
        xziZG3OdSEUb3NoxL5TQzVb7w9pMHyUNAn6FGAvPup6fkMh0xDTQ8GiDalePDZCr7N+LwB
        Zn/MHHUg/5je7DHNWWQWCfmcH83xCRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696833593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2u6vYyS+812CkJSt5+jVbKml4me73ulgL4G0MCFLf4=;
        b=T86hnp2mWFI5QaKOexVWnij0nTY09vNPcg8sqvYh+O9Z9+qvr5SSy7efiE7ZPsZl9G8UVE
        cDoJdfCxcEURWyDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1160213586;
        Mon,  9 Oct 2023 06:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gDYfAjmgI2UmCgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 09 Oct 2023 06:39:53 +0000
Message-ID: <40943d68-f6ff-4456-97d6-e18139d39e9d@suse.de>
Date:   Mon, 9 Oct 2023 08:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] scsi: libsas: Delete enum sas_phy_type
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-4-john.g.garry@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230814141022.36875-4-john.g.garry@oracle.com>
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
> enum sas_phy_type is used for asd_sas_phy.type, which is only ever set,
> so delete this member and the enum.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>   drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
>   drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
>   drivers/scsi/isci/phy.c               | 1 -
>   drivers/scsi/mvsas/mv_init.c          | 1 -
>   drivers/scsi/pm8001/pm8001_init.c     | 1 -
>   include/scsi/libsas.h                 | 6 ------
>   6 files changed, 11 deletions(-)
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

