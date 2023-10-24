Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A087D46E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJXFZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJXFZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:25:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6FA125
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:24:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 433FB21B65;
        Tue, 24 Oct 2023 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698125098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xKoNE41itsf53R8KnfXvJY7xIgN+SlleTH+6Hkx508=;
        b=HQxVO+RZzP/2M9FrSXdLRF4zGbweYrjkWaC6nPce5cOf0UN1SCKPQa09F4T/IUVzWqSe//
        BEdNB14zraXi8e20q+0QO9FIjeGXJXrDYyrmiHEW0QrSI8jINZ1rrZkaK/icfAaDz4pRag
        q8CDTCsz4MAlKUV7aH8WmBX6owX4XNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698125098;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3xKoNE41itsf53R8KnfXvJY7xIgN+SlleTH+6Hkx508=;
        b=l+uRzkjg4nqQow1Q67Km6jlgRB2GHIIV/48C5RkRlDf1K9Ia4loL+MqAhkGEin0t90xDHT
        MXMV9zkxzmmU47BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 108471391F;
        Tue, 24 Oct 2023 05:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tq7HAipVN2XiAwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 Oct 2023 05:24:58 +0000
Message-ID: <de7adb36-183c-4ca1-b945-d3675ce87fb3@suse.de>
Date:   Tue, 24 Oct 2023 07:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-keyring: add MODULE_LICENSE()
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20231023230052.31161-1-rdunlap@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231023230052.31161-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.05
X-Spamd-Result: default: False [-11.05 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-2.96)[99.83%];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/23 01:00, Randy Dunlap wrote:
> When NVME_KEYRING=y (NVME_AUTH is not set), there is a modpost build
> error:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o
> 
> so add a MODULE_LICENSE() to keyring.c (copied from auth.c).
> 
> Fixes: 9d77eb527784 ("nvme-keyring: register '.nvme' keyring")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: linux-nvme@lists.infradead.org
> ---
>   drivers/nvme/common/keyring.c |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff -- a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
>   	key_put(nvme_keyring);
>   }
>   EXPORT_SYMBOL_GPL(nvme_keyring_exit);
> +
> +MODULE_LICENSE("GPL v2");

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

