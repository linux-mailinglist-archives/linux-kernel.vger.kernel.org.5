Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086D07DED34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjKBHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjKBHYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:24:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2D12F;
        Thu,  2 Nov 2023 00:23:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 899142187D;
        Thu,  2 Nov 2023 07:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698909837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQMzONqa3bMlZXzok54TMBiqoqe2JHnXMnrV3HsQWCE=;
        b=okfl7S/xU1Z7nBYD09W6GWwXmYtmDFR+QiWufxg3cSztszvSR6SPHu0sA0OYuPEj+weq46
        ep4AjNUDYU2jcmFiokpkrL/FnAN1MTO4zo0Y6oahpO4pKPyV+k+WZzNFfiv8/IaRbKomHZ
        fseejJpux+d7zyiqI6n/rUh88Dp18n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698909837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQMzONqa3bMlZXzok54TMBiqoqe2JHnXMnrV3HsQWCE=;
        b=S7VCp1awRGet6m74qe2nFl+v+97K2fdpRONK0sm9KCuWfnjs606/6gF4gO0dO2a5JJxhi1
        qVbCTOroWx0vieBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21C15138EC;
        Thu,  2 Nov 2023 07:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tcAWB41OQ2VCLwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:23:57 +0000
Message-ID: <5d718b3b-6635-4a73-8ac9-df54f4a7183c@suse.de>
Date:   Thu, 2 Nov 2023 08:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] scsi: fnic: Modify definitions to sync with VIC
 firmware
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-2-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-2-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 20:02, Karan Tilak Kumar wrote:
> VIC firmware has updated definitions.
> Modify structure and definitions to sync with the latest VIC firmware.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/vnic_scsi.h | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/vnic_scsi.h b/drivers/scsi/fnic/vnic_scsi.h
> index 4e12f7b32d9d..f715f7942bfe 100644
> --- a/drivers/scsi/fnic/vnic_scsi.h
> +++ b/drivers/scsi/fnic/vnic_scsi.h
> @@ -26,7 +26,7 @@
>   #define VNIC_FNIC_RATOV_MAX                 255000
>   
>   #define VNIC_FNIC_MAXDATAFIELDSIZE_MIN      256
> -#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2112
> +#define VNIC_FNIC_MAXDATAFIELDSIZE_MAX      2048
>   
>   #define VNIC_FNIC_FLOGI_RETRIES_MIN         0
>   #define VNIC_FNIC_FLOGI_RETRIES_MAX         0xffffffff
> @@ -55,7 +55,7 @@
>   #define VNIC_FNIC_PORT_DOWN_IO_RETRIES_MAX  255
>   
>   #define VNIC_FNIC_LUNS_PER_TARGET_MIN       1
> -#define VNIC_FNIC_LUNS_PER_TARGET_MAX       1024
> +#define VNIC_FNIC_LUNS_PER_TARGET_MAX       4096
>   
>   /* Device-specific region: scsi configuration */
>   struct vnic_fc_config {
> @@ -79,10 +79,19 @@ struct vnic_fc_config {
>   	u16 ra_tov;
>   	u16 intr_timer;
>   	u8 intr_timer_type;
> +	u8 intr_mode;
> +	u8 lun_queue_depth;
> +	u8 io_timeout_retry;
> +	u16 wq_copy_count;
>   };
>   
>   #define VFCF_FCP_SEQ_LVL_ERR	0x1	/* Enable FCP-2 Error Recovery */
>   #define VFCF_PERBI		0x2	/* persistent binding info available */
>   #define VFCF_FIP_CAPABLE	0x4	/* firmware can handle FIP */
>   
> +#define VFCF_FC_INITIATOR         0x20    /* FC Initiator Mode */
> +#define VFCF_FC_TARGET            0x40    /* FC Target Mode */
> +#define VFCF_FC_NVME_INITIATOR    0x80    /* FC-NVMe Initiator Mode */
> +#define VFCF_FC_NVME_TARGET       0x100   /* FC-NVMe Target Mode */
> +
>   #endif /* _VNIC_SCSI_H_ */

I would have thought that you may want to check for the firmware version 
here; updating some limits with no check for the version will mean the 
driver might fail on older firmware, no?

But this is arguably not part of this patch, so:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

