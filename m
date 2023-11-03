Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E467E0294
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbjKCMJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKCMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:09:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A94A2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:09:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4CA291FD69;
        Fri,  3 Nov 2023 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699013362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekxLl5mg6uyebw0+8QSXiYfL8qTfhDVbDhwInXfLUCs=;
        b=tkveK/98j0/0draXLw8OIwF0WvNEDPyvfxcRnuavegSWlE8FdouNSqwS1LRsQIb5D5Of0+
        y0ELxBofh4mgL2JaDDeMS0yfhiiPekUigYUeoUeLDdMnuRx0nxL8M11uUOeB3ArmUXTF9B
        KZkdZR8AF5qWU8V6CM06T8qdmp0TIxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699013362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ekxLl5mg6uyebw0+8QSXiYfL8qTfhDVbDhwInXfLUCs=;
        b=dPRuMbCsrgZeA/flW50Cn19TW7Nu/uqqzqN4Nm/6Qn7BB+XbYRBmHtotYop5FARxZubDlO
        WaqOCBjMvNPl63CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32B8913907;
        Fri,  3 Nov 2023 12:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PmEMDPLiRGUJTQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 03 Nov 2023 12:09:22 +0000
Date:   Fri, 3 Nov 2023 13:11:02 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:08:53AM -0600, Keith Busch wrote:
> On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> > The firmware version sysfs entry needs to be updated after a successfully
> > firmware activation.
> > 
> > nvme-cli stopped issuing an Identify Controller command to list the
> > current firmware information and relies on sysfs showing the current
> > firmware version.
> > 
> > Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Thanks, applied for nvme-6.7.

I've got negative feedback from one of our customer. I've annotate the
code with

	dev_info(ctrl->device, "afi: %#x\n", log->afi);
	for (i = 0; i < 7; i++) {
		dev_info(ctrl->device, "frs%d: %.*s\n", i + 1,
			 nvme_strlen((char *)&log->frs[i], sizeof(ctrl->subsys->firmware_rev)),
			 (char *)&log->frs[i]);
	}


[  124.824812] nvme nvme8: afi: 0x3
[  124.824824] nvme nvme8: frs1: 0.4.0
[  124.824828] nvme nvme8: frs2: 0.3.0
[  124.824832] nvme nvme8: frs3: 0.4.0
[  124.824835] nvme nvme8: frs4:
[  124.824837] nvme nvme8: frs5:
[  124.824840] nvme nvme8: frs6:
[  124.824842] nvme nvme8: frs7:


This particular firmware seem to interpret afi one based, while
the this patch assumes it is zero based


	memcpy(ctrl->subsys->firmware_rev, &log->frs[log->afi & 0x7],
		sizeof(ctrl->subsys->firmware_rev));


The spec says


  Active Firmware Info (AFI): Specifies information about the active
                              firmware revision.

  Bit 7    is reserved.
  Bits 6:4 indicates the firmware slot that is going to be activated
           at the next Controller Level Reset. If this field is 0h,
           then the controller does not indicate the firmware slot that
           is going to be activated at the next Controller Level Reset.
  Bit 3    is reserved.
  Bits 2:0 indicates the firmware slot from which the actively running
           firmware revision was loaded.


It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
indicate to be 1 based.

Any ideas how to handle this?

Thanks,
Daniel
