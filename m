Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEB7D096E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376542AbjJTHXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376536AbjJTHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:23:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A151BE3;
        Fri, 20 Oct 2023 00:22:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90EB521864;
        Fri, 20 Oct 2023 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1697786573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHUQDoUOG8wAnAcAHyKhIFWzNSj2D39ugT0s3djIGmk=;
        b=E+Ewv9SMxyIFu71T31LJGtPmf1yB2oBKlF8AOjxQdcqFSnwhaVN2NhuTWC9wGYMQj3QGqJ
        IzhlDFo+a2IgDXHljoaN2hKXRfBdGcZM3GgNxMohtKN0fUNNNfL1D7fT9+grhBQXevgalR
        67xHhzKQ3y97WZ4QrqUVijvKQLcQ6gw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1697786573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHUQDoUOG8wAnAcAHyKhIFWzNSj2D39ugT0s3djIGmk=;
        b=Ad1SMC4F86I12S3GpW0lebaCquRNIpFaWuFqIBUUl0QtVj/Guce9nNMky1NbMI/wgMZmEY
        M2rSeDOrjSCN72AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36AB313584;
        Fri, 20 Oct 2023 07:22:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8pbBN8oqMmX5CAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 20 Oct 2023 07:22:50 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.58
In-reply-to: <2023101518-subscript-entity-be71@gregkh>
References: <2023101518-subscript-entity-be71@gregkh>
Date:   Fri, 20 Oct 2023 18:22:47 +1100
Message-id: <169778656748.20306.1670865069010793541@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.1.58 kernel.
>=20
> All users of the 6.1 kernel series must upgrade.
>=20
> The updated 6.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-6.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Ds=
ummary
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------
>=20
>  Makefile                 |    2=20
>  fs/nfs/direct.c          |  134 ++++++++++++++----------------------------=
-----
>  fs/nfs/write.c           |   23 +++-----
>  include/linux/nfs_page.h |    4 -
>  lib/test_meminit.c       |    2=20
>  5 files changed, 55 insertions(+), 110 deletions(-)
>=20
> Greg Kroah-Hartman (7):
>       Revert "NFS: More fixes for nfs_direct_write_reschedule_io()"
>       Revert "NFS: Use the correct commit info in nfs_join_page_group()"
>       Revert "NFS: More O_DIRECT accounting fixes for error paths"
>       Revert "NFS: Fix O_DIRECT locking issues"
>       Revert "NFS: Fix error handling for O_DIRECT write scheduling"

FYI the problem with these NFS patch is now described in comment #4 of
https://bugzilla.kernel.org/show_bug.cgi?id=3D217999
which I include below.  They can be reapplied if the "Fix error
handling..." patch is fixed up as described.

NeilBrown

FYI the cause of this corruption is that the  backport of
   NFS: Fix error handling for O_DIRECT write scheduling

had an error.
The backported patch f16fd0b11f0f4d41846b5102b1656ea1fc9ac7a0
moves "pos +=3D req_len" in nfs_direct_write_schedule_iovec() from after
    req->wb_index =3D pos >> PAGE_SHIFT;
to before that statement.  This ->wb_index is wrong.
Possibly a better way to look at this is the use of "pos" is moved to *after*=
 it is updated.

The upstream patch 954998b60caa8f2a3bf3abe490de6f08d283687a
doesn't move the use of pos because
Commit 70e9db69f927 ("NFS: Clean up O_DIRECT request allocation")

removes the use.

v6.1.56 can be fixed with

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 5a976fa343df..69134e11e7d0 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -864,6 +864,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs=
_direct_req *dreq,
                                result =3D PTR_ERR(req);
                                break;
                        }
+                       req->wb_index =3D pos >> PAGE_SHIFT;
+                       req->wb_offset =3D pos & ~PAGE_MASK;
=20
                        if (desc.pg_error < 0) {
                                nfs_free_request(req);
@@ -883,8 +885,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs=
_direct_req *dreq,
                        }
=20
                        nfs_lock_request(req);
-                       req->wb_index =3D pos >> PAGE_SHIFT;
-                       req->wb_offset =3D pos & ~PAGE_MASK;
                        if (nfs_pageio_add_request(&desc, req))
                                continue;
