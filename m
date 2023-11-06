Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C0F7E1A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKFG7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFG7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:59:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0EA4
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:59:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E5F32183B;
        Mon,  6 Nov 2023 06:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699253940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+p3StKUp0N4ggikwgytWyMwdQGjDE4+4rKwUV67bhsU=;
        b=PuVxkGtZdtGmu2UK2oJtGPxV3OeuBHA8hWosz3VO6B72F8zNW073K8Pa/ruiqVQJ/OqNy/
        vj1QFwOl2uPr2r+rDNVn4B+wgYXobgM/SPA8yf794+WHH//u21oGTrWHT+CkRQuNabeNSx
        0J5OXt+lPSTkAEYLERd/qKf3oHTNJs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699253940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+p3StKUp0N4ggikwgytWyMwdQGjDE4+4rKwUV67bhsU=;
        b=rH1xXDK1/rY2sTVfHR8aJIYhU5jI+sDMzb34PHQNE+F4UMqEXZlQlOt+MO+WVKYECRBlk/
        byzUjO0xxZ3jFGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20B3A138E5;
        Mon,  6 Nov 2023 06:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vyT3B7SOSGVDMAAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 06 Nov 2023 06:59:00 +0000
Date:   Mon, 6 Nov 2023 08:00:44 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 08:22:11AM -0600, Keith Busch wrote:
> > All 0's based (what a stupid term..) fields in NVMe are explicitly
> > marked as such.  And even if that wasn't the case I'd very much
> > expect the same encoding for the two sub-fields.
> 
> Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
> slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
> (firmware commit SF field, or fw log AFI bits 6:4), or is reserved
> value, like in Identify Controller FRMW.NOFS, and has no place in the FW
> Slot Info log page.
> 
> Our first slot in the log page is defined as slot one, so we have to
> subtract one from the AFI field to index into the slot array. I messed
> up for not catching that earlier, but thanks for pointing it out now.

Thanks for the clarification.

Do you want me to send a follow up patch, a new version of this one or
do you fix up yourself?
