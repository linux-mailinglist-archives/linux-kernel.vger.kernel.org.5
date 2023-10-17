Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52DB7CBD1B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjJQIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:10:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3760693
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:10:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 876EF21CF9;
        Tue, 17 Oct 2023 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697530227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB1bGwDpRlXbHfV7iisPURi1DjcBkBMCHVhzyIy2VZg=;
        b=u5yvMtBDd/A8tyr4b5XU335Bn7PhV3+N40F985eiXBYgDZ47pEX41fIcKHoMYoeWW0STx+
        FK1Iq8K/fvcWFzxSZVfSgXeCrR3wCqkNy/1Xe9dCLhEbRD1whAjFUNWTKUKZqvMBJpD82i
        ZR02NR+SbDQg/7iraI6oTiKGOZQZCrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697530227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB1bGwDpRlXbHfV7iisPURi1DjcBkBMCHVhzyIy2VZg=;
        b=HrAKMD1DTXWNQuHy3L+3arcbS37s7kdssgTFBTVS+2cl2qwc8sp89DUOWEd0meyqvpnFtZ
        Pf1Opxi6M1dNp6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6953913597;
        Tue, 17 Oct 2023 08:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xyT8GHNBLmWKRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Oct 2023 08:10:27 +0000
Message-ID: <ea3a6bb6-39d8-3577-a90c-b98084457fbb@suse.cz>
Date:   Tue, 17 Oct 2023 10:10:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/5] tools/mm: Remove references to free_ts from
 page_owner_sort
Content-Language: en-US
To:     Audra Mitchell <audra@redhat.com>, linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231013190350.579407-1-audra@redhat.com>
 <20231013190350.579407-3-audra@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231013190350.579407-3-audra@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.00)[29.91%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:03, Audra Mitchell wrote:
> With the removal of free timestamps from page_owner output, we no longer
> need to handle this case or the "unreleased" case. Remove all references
> to both cases.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

But geez, tools like this one would be easier to do e.g. in python these days :)

