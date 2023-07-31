Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B354769CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbjGaQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbjGaQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:38:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E22102
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:38:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB14F2212B;
        Mon, 31 Jul 2023 16:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690821509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu3hau3URp8DICPDRf+gefbn2Z5+ZSSp25qCWSFsxDw=;
        b=CPCdPxshTz7famaKTrzxSj4Y6KD0E0fZetAF9mlKeZnJe7vcZfpvKLMCGRur6tWRO9jNfv
        Z+cazYZE6pB+CXD0F71Ujpjc2ftb8RBMAHI+GOIhPT25wfMx4PPnfQOwd/2Qmrephh8qAx
        B4XwDvezuo+X3BAVe4l6UdWn0gIUR4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690821509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu3hau3URp8DICPDRf+gefbn2Z5+ZSSp25qCWSFsxDw=;
        b=G3JYHm8kNu+wctf0TlH7KDTYcUs7oIvr6na+WX/prAa8sdBn5rGRrGavOrc507vP2ekb37
        KHzwMkQuZ4T9SEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64DAB1322C;
        Mon, 31 Jul 2023 16:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QBymFoXjx2RsGAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:38:29 +0000
Message-ID: <59caeb97-a32a-1e83-c4cd-38e70628027d@suse.de>
Date:   Mon, 31 Jul 2023 18:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] nvme-auth: set explanation code for failure2 msgs
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk, kbusch@kernel.org
References: <20230731145106.917526-1-shiftee@posteo.net>
 <20230731145106.917526-2-shiftee@posteo.net>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731145106.917526-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 16:51, Mark O'Donovan wrote:
> Some error cases were not setting an auth-failure-reason-code-explanation.
> This means an AUTH_Failure2 message will be sent with an explanation value
> of 0 which is a reserved value.
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> ---
> v1->v2: Set failure explanation in a single place if the error handling
> code has not already done so.
> 
>   drivers/nvme/host/auth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index e1a98647c3a2..9556cfc4f5f3 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
>   	}
>   
>   fail2:
> +	if (chap->status == 0)
> +		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
>   	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
>   		__func__, chap->qid, chap->status);
>   	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

