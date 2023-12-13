Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8122810E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjLMKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjLMKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:23:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA0DAF;
        Wed, 13 Dec 2023 02:24:05 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 75A591F38C;
        Wed, 13 Dec 2023 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702463043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFJ3A25nYfF7sKdr5SLQblvtW35pp9rQh+LbkrjDHEc=;
        b=CWeXgfMlyj7ewzSjRqOXCA8cD5phO6tf++t4XQJrNRFQXaXktffT2jkSuOrhdbk7wAPmdA
        dLP+Ot9mClmy/z74Yqru33RhwaOmvUbbc61X9youRWUdaAFfO1ibA6UofGLRDU0KkQVwIs
        pAfuUzpUeY39v+yNumME2DFruzCouPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702463043;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFJ3A25nYfF7sKdr5SLQblvtW35pp9rQh+LbkrjDHEc=;
        b=FXJlljIqzm7cs9hQix5t8A7U2+jtPIagqmYVpCmNaM4DFMlr5Q6Z2qWBxAvbeusap8Y7Ra
        w/Z0vjPuBqJsVBBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702463042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFJ3A25nYfF7sKdr5SLQblvtW35pp9rQh+LbkrjDHEc=;
        b=Ax1gwWUVycOHB/yQUkrU60Qn0tf8irN8tIBjt8ZmrKtwsY2XgLOMf3jaU13Ih+kNpEKmcN
        X+kNIRNKZ6pB28G6sdp8Glo1q2lT8vb+MdgXnllGrspKQfn5b0hEvfnQl1F+A/tyi8lfa2
        vaQl0W3NKur1ybKZz//1pILrorUbPS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702463042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YFJ3A25nYfF7sKdr5SLQblvtW35pp9rQh+LbkrjDHEc=;
        b=XSuX6j5+x76Kb/Ot/VdVeA6G21m6Bhy6XjAfYEKRH73ky+n7TrZxPhiEdRkKWwafXsqlpM
        MqpnG2Q02d2mfaDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 592D21391D;
        Wed, 13 Dec 2023 10:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id TgOBFUKGeWXbcgAAn2gu4w
        (envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 10:24:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BED2AA07E0; Wed, 13 Dec 2023 11:24:01 +0100 (CET)
Date:   Wed, 13 Dec 2023 11:24:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v2 03/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20231213102401.epkxytqq7e5lskw2@quack3>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-4-john.g.garry@oracle.com>
X-Spam-Level: 
X-Spam-Score: -0.81
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[24];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,oracle.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[43.37%]
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-12-23 11:08:31, John Garry wrote:
> From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> 
> Extend statx system call to return additional info for atomic write support
> support if the specified file is a block device.
> 
> Add initial support for a block device.
> 
> Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Just some nits below.

> +#define BDEV_STATX_SUPPORTED_MSK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
                                ^^^
				I believe saving one letter here is not
really beneficial so just spell out MASK here...

>  /*
> - * Handle STATX_DIOALIGN for block devices.
> - *
> - * Note that the inode passed to this is the inode of a block device node file,
> - * not the block device's internal inode.  Therefore it is *not* valid to use
> - * I_BDEV() here; the block device has to be looked up by i_rdev instead.
> + * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
>   */

Please keep "Note ..." from the above comment (or you can move the note in
front of blkdev_get_no_open() if you want).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
