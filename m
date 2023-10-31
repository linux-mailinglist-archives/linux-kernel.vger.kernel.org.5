Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246A97DD12B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJaQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbjJaQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:06:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952FB4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:06:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 590161F38C;
        Tue, 31 Oct 2023 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698768408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SUSyMWoubFo1JlnewUQEtX0aacilks/g9wP8Qc5UNQ=;
        b=UPKzvkgtjQS3m1mGxy+kYGeRtEMoOjXSUHRXnFuBzFkHmnB6XcD0D8TqRYnQ4e+oqhRigV
        aKUZ8j/EU80zZ1t1R8wdUm+3XKCv0EcrX6xy2fb65HIXqu79iISjgVwE9GmnATVIKRWSRJ
        0sdrhuMDLn+ylq1BrqHOi5C7uHTOx74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698768408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5SUSyMWoubFo1JlnewUQEtX0aacilks/g9wP8Qc5UNQ=;
        b=gLnaQ+oi5tEV+IsHABW78T+fAkyQw84ZxoFdJhzg/F+ngvHiP1GDJlHjqybxAokssQQXVO
        faXjNBBwVC37N6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49481138EF;
        Tue, 31 Oct 2023 16:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C/7ZERgmQWXBSAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 31 Oct 2023 16:06:48 +0000
Date:   Tue, 31 Oct 2023 17:08:24 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <krtenpf5lcrgujgvsuvolr2peszhnk5o4eoamwwp4f6hck5oe3@ozjmudep3qub>
References: <20231030160044.20355-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160044.20355-1-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
> 
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
> 
> Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Unfortunately, Kenji is not able to post on the mailing list, so here his tag:

Tested-by: Kenji Tomonaga <tkenbo@gmail.com>
