Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3B80749C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjLFQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFQNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:13:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08E1A5;
        Wed,  6 Dec 2023 08:13:22 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 064591FD10;
        Wed,  6 Dec 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1701879200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfGRtKpQu6L46Fs8Jv9je69slO0FA+DhppgBOBXUjak=;
        b=a/2sA2VvDHfBg/KaldM4o6rMqr54Q8Qcty4PxZ6Gw55qZvq+th+p9uHpCGY4Rv6qrOxpDg
        qdF4JJSEb83ZgNwZvhfGltPF24iWeZazLbSvi9CQuR8prJN2FNdqeaLJsvX6MyxO0bo1uc
        0jvqpv3oDxo+sW2x/bwx/y1+ROKs0B8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1701879200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfGRtKpQu6L46Fs8Jv9je69slO0FA+DhppgBOBXUjak=;
        b=H9JnJBEvd4nR4cy+zB3mSducV2D4LUaJlhrZq3ZrHndCGxOoXgADJZTZEaSlAc8uxuW1HT
        7kNT09QobzFMEMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D37EE13408;
        Wed,  6 Dec 2023 16:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 3VX8Mp+dcGUcXgAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Wed, 06 Dec 2023 16:13:19 +0000
Message-ID: <457899ac-baab-e976-44ec-dfdeb23be031@suse.cz>
Date:   Wed, 6 Dec 2023 17:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] supplement of slab allocator removal
Content-Language: en-US
To:     sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com,
        linux-mm@kvack.org
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
        arnd@arndb.de, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20231203001501.126339-1-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231203001501.126339-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.10
X-Spamd-Result: default: False [-1.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         BAYES_HAM(-1.30)[90.04%];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[16];
         FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/23 01:14, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> Hi,
> 
> Patch 1 is to remove an unused parameter. This patch actually is v3, but
> it is not reasonable to add v3 tag in the cover letter, so I put the
> change history inside the patch.
> 
> ---
> Patch 2 is to replace slub_$params with slab_$params.
> Vlastimil Babka pointed out we should use "slab_$param" as the primary
> prefix for long-term plan. Please see [1] for more information.
> 
> This patch is to do that. However, the patch is big, I'm not sure if
> everything is proper in it, so I added "RFC" in the patch title. For more
> information please see the commit message of patch.
> 
> I did the basic tests with qemu, which passed values by sl[au]b_max_order,
> sl[au]b_min_order, sl[au]b_min_objects and sl[au]b_debug in command line.
> The values looks correct by printing them out before calculating orders.
> 
> One thing I'm not sure about the forth parameter of __setup_param(),
> Is it correct to set the parameter to 0 directly?

Yep it's fine.

