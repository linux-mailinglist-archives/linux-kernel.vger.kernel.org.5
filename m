Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63D97DBC5B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjJ3PFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJ3PFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:05:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D51DB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:05:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 314C9218D6;
        Mon, 30 Oct 2023 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698678346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRSRixE2mgVa7EvEDqaaDxfv9jGRdAqZmDs0EgL3tJ0=;
        b=DBG6F9BWLVvk/qnBjGmeeh4L/T31SoFVPzcLORdktl2gR3VdOuH70WJkQImKtuu3+WvAip
        ZrcabA/a7gFpz4n9Y/aLcjal20VYAEnBkXnY5r2N2V13Ru9RPgG6xOhghILuZMaI5qGdbk
        efFTa+0H9zXRkAtvYBCB7EgUdBlGBqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698678346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pRSRixE2mgVa7EvEDqaaDxfv9jGRdAqZmDs0EgL3tJ0=;
        b=E8m9QPC1QxJVZvTMOoRu1BnzSKrZ/n3y2iFSoVnyWXVWle9Dx6kyqsGEzdmQjK8IO1L8I6
        asrlzLntKGUtSkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171D6138EF;
        Mon, 30 Oct 2023 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f+eYBUrGP2XCWgAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 15:05:46 +0000
Date:   Mon, 30 Oct 2023 16:07:21 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ed23l2ustamwrhseseuilvunwnenpuaaeduvcmfpk4up2nstpq@rtvf7emq3erl>
References: <20231013163420.3097-1-dwagner@suse.de>
 <ZSlzxGx8k9pgkhDk@kbusch-mbp>
 <ZSmqi7Va4CkpQ4zl@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSmqi7Va4CkpQ4zl@x1-carbon>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 08:37:32PM +0000, Niklas Cassel wrote:
> On Fri, Oct 13, 2023 at 10:43:48AM -0600, Keith Busch wrote:
> > On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
> > >  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
> > > -			log, sizeof(*log), 0))
> > > +			 log, sizeof(*log), 0)) {
> > >  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> > > +		goto out_free_log;
> > > +	}
> > > +
> > > +	afi = le64_to_cpu(log->afi);
> 
> BTW, this field is a single byte, so there should be no need to
> use *_to_cpu() on this. (Byte order is only important when the
> field is more than one byte.)

Indeed, I somehow thought afi is of type __le64.
