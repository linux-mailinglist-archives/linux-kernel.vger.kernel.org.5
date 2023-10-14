Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28307C9426
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 12:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjJNKgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 06:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjJNKgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 06:36:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A272BB;
        Sat, 14 Oct 2023 03:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C00DE21AAF;
        Sat, 14 Oct 2023 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697279765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eUB6q8AUUu3qn846x5mMgqAkIyynbetqYGQFrjzPow=;
        b=L7IC3ATZ1aLZZ7DSsK3d7tkMt6RjmOFlKUjvtP1LFM10RpdFPG/Ym0w7eUHTyIkMuJNJAH
        zNsBr1droY/Uhz2bPtxQGULp+5gtjwzcP0DV2SXvo37QOPpUEfES2cqB9inA4ZzXT5EYHY
        4audL7y9eQP/W3HNL7r5UaVecpFfbAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697279765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1eUB6q8AUUu3qn846x5mMgqAkIyynbetqYGQFrjzPow=;
        b=ESBRuYivpMxtLetyYDl6GjQ6ADwPmYC3thhiZFUdohH4UoFULdM45wsXhJXOvHWGphtpOt
        skcH9jCk1PfnOpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72E0E1390A;
        Sat, 14 Oct 2023 10:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lhpQGhVvKmXWGwAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 14 Oct 2023 10:36:05 +0000
Message-ID: <0a1ab53a-b63c-44c9-a63b-273ed70ba23c@suse.de>
Date:   Sat, 14 Oct 2023 12:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Add support for Bayhub SD/MMC controller
Content-Language: en-US
To:     =?UTF-8?B?5YiY55WF?= <liuchang_125125@163.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com
References: <20231013083242.10227-1-liuchang_125125@163.com>
 <bed3f2d9-362a-40f7-802d-172f1e32bde5@suse.de>
 <238c40.67f1.18b28fe0bfb.Coremail.liuchang_125125@163.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <238c40.67f1.18b28fe0bfb.Coremail.liuchang_125125@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.20
X-Spamd-Result: default: False [-5.20 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         BAYES_HAM(-1.11)[88.27%];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[10];
         FREEMAIL_TO(0.00)[163.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 14:23, 刘畅 wrote:
> Hi Hannes,
> 
> We know that there is a SD/MMC card drivers under drivers/mmc,
> but we have the following more features to support.
> 
> 1.We need to support the special functions customized by Bayhub.
> 2.We need to support SD UHSII cards and SD DDR200/225 cards.
>     The drivers under drivers/mmc do not support SD UHSII cards and
>     SD DDR200/225 cards at present.
> 
But all of that is an extension to the existing drivers/mmc subsystem.
None of the above is SCSI related, so a SCSI driver is the wrong approach.

Please convert your driver to use drivers/mmc, not drivers/scsi.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

