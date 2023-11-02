Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5ED7DED39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjKBH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKBH2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:28:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3712A;
        Thu,  2 Nov 2023 00:27:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77D2F1F86C;
        Thu,  2 Nov 2023 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698910074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHxSxPsxeSDgEIYJ1S2Vpzyaxo/McSBrkw9iugmyWEo=;
        b=0vp6xixAxLiAhQwcW9P90iuZk7NrT034mPBWOe4OFLbe8R5WnHLfwJ8N8x8lPAfBcSa3i1
        cKexHflGcTDKwhSrpbbPV8LK5jT9cNiQqT8Kch2V7w3KO4Ohh1W0TXbs1roCAGReN463d0
        2AHvKeRC5gxSef8uPQ+svojGfPoBOew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698910074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHxSxPsxeSDgEIYJ1S2Vpzyaxo/McSBrkw9iugmyWEo=;
        b=b/QZeOMZvSuuD03FxtynpmC69tvac8/MaVVTCIasZhfBbwWz96/RKqfNPSsseeELeA2zE/
        nmhIXd+O1TukbuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BF9B138EC;
        Thu,  2 Nov 2023 07:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W4BfBXpPQ2XJMAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 02 Nov 2023 07:27:54 +0000
Message-ID: <41c2fd4c-f6b3-450f-87b3-d059d52ba2f0@suse.de>
Date:   Thu, 2 Nov 2023 08:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] scsi: fnic: Add and improve log messages
Content-Language: en-US
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027180302.418676-1-kartilak@cisco.com>
 <20231027180302.418676-4-kartilak@cisco.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231027180302.418676-4-kartilak@cisco.com>
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
> Add link related log messages in fnic_fcs.c,
> Improve log message in fnic_fcs.c,
> Add log message in vnic_dev.c.
> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---
>   drivers/scsi/fnic/fnic_fcs.c | 36 ++++++++++++++++++++++++------------
>   drivers/scsi/fnic/vnic_dev.c |  4 ++++
>   2 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
> index 55632c67a8f2..203ffec625a4 100644
> --- a/drivers/scsi/fnic/fnic_fcs.c
> +++ b/drivers/scsi/fnic/fnic_fcs.c
> @@ -64,8 +64,8 @@ void fnic_handle_link(struct work_struct *work)
>   			new_port_speed);
>   	if (old_port_speed != new_port_speed)
>   		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host,
> -				"Current vnic speed set to :  %llu\n",
> -				new_port_speed);
> +				"fnic<%d>: %s: %d: Current vnic speed set to: %llu\n",
> +				fnic->fnic_num, __func__, __LINE__, new_port_speed);
>  
Please update FNIC_MAIN_DBG() to use the 'fnic' structure as an 
argument, then you don't have to prefix all messages with 'fnic<%d>'.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

