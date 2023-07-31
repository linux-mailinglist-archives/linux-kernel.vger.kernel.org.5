Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9BD769C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGaQSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjGaQRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:17:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACA81BC
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:17:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1CAC1F45F;
        Mon, 31 Jul 2023 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690820269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQSYaglFHbCeXVvaupUEWLNsLwJkDurEJNTXFu1tGlY=;
        b=fLgdlIxC9biD85dIjEfPZAcsw6bhww0K+D0GLja5FV5vwRrO372Ys/enTwdNE+VG4d5tM4
        qAiLb+3hiOKT9uJrfCokDKgAxLS51q9yi+1s3gsNIBnSMco/SrdHsgmfBzxNvDQsAslG9p
        RRC2Rt8T56dzv8fnV4R4dYYZ8vH8q+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690820269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQSYaglFHbCeXVvaupUEWLNsLwJkDurEJNTXFu1tGlY=;
        b=3mIwl2OJUEZqJTS503a9Ppbzi82x36Qnihr3mTQ9GjrBOmu/0fcQCOkW7tiNuPvJ2nJPfG
        oauoFxRAM+SYVjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80AC1322C;
        Mon, 31 Jul 2023 16:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZbaCKq3ex2RdDwAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:17:49 +0000
Message-ID: <3b63d8d9-4246-3010-49e9-fbc433b1ce36@suse.de>
Date:   Mon, 31 Jul 2023 18:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Mark O'Donovan <shiftee@posteo.net>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <20230727134748.4163796-2-shiftee@posteo.net> <20230731055806.GB30150@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731055806.GB30150@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 07:58, Christoph Hellwig wrote:
> On Thu, Jul 27, 2023 at 01:47:48PM +0000, Mark O'Donovan wrote:
>> These error cases were not setting an auth-failure-reason-code-explanation.
>> This means an AUTH_Failure2 message will be sent with an explanation value
>> of 0 which is a reserved value.
> 
> I'll leave the final decision to Hannes, but shouldn't we find a common
> place, either behind a label or in the body of the function to set
> chap->status?  Having to add this in a lot of error labels doesn't feel
> very maintainable.
> 
Yeah; the whole AUTH_XXX errors are ever so cumbersome as we don't have 
a good way to passing them up the stack. Plus we can't transport errors
during connect, making it doubly pointless.
Maybe a printk() somewhere. I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

