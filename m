Return-Path: <linux-kernel+bounces-27707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1F82F47D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60EECB21730
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3B61CF87;
	Tue, 16 Jan 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZuToFFF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484541C6AD;
	Tue, 16 Jan 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430556; cv=none; b=TjyCuSUHBX2tDBYO7d3WYqEnBXpsFWAaIIwY8sALzofcwilNDSlHEoSnSbYTyG5j+U7DlRDW0ecVbEjYNEeReKJamba/bvz+Ne/wt8ZrLvtUY7bh/9TsCWg5lP006iffqRH2DHT9NNeN89bb03KajKRBHQgKFS8v599KK5nH2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430556; c=relaxed/simple;
	bh=S5KMdyv9vEL0CeRHyQGtOqQf9LU2qa2NACMCFu2WPsM=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=NZdlMhD1BibVcppRpEx23U7GCiO2Lt2PNv6S9Nw/D8IBWQZclzdOFIcl0AkQc24wsYJ02YPregOBQYJCROGOkaLOEgsK89kG7xBV0UvpQZgZR1oXEZ4bAW7FhTjBaIFa9Z8c2JzkWsk5JlIYIq8aiaU+znkF4vewxhPQs/7O+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZuToFFF; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e9TcTM+d6L0MWKH8TdLtoZT8t+lgwD6ToTcpjBl3L8w=; b=FZuToFFFkxYwpfM4dHeFp9mm8W
	XAsUf9QlvmZxNQVzNbXYH0tIZ//pnEml6gCU6pORkGwajr84aYttfQaORLNiWHQE3LmisVPtBCv8U
	v/IjDI/D2A+qFedtBSRpusUNBsMjsXRWDHp7CtTZ5f010nrYjPVuV0ERg/PnUCyYp5p//S4Rrd4Xh
	aBIQgYnrjC6bPBgBYrMEJUyDUFtdRzCpSQ6QAeReS1TOruKUhIvuiI08yi0aw4WfmzstAKZAlKEsN
	9IO0OyWKk2ytQvve1SNTSTBqT5Aki8r0eNFMHjgENTILYHh+goNYvLROmaZqLhJzN1f89/8d6MKEe
	lzFeIwJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPoON-00Dt8T-KH; Tue, 16 Jan 2024 18:42:31 +0000
Date: Tue, 16 Jan 2024 18:42:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in __bio_release_pages
Message-ID: <ZabOF3/P/jQmjudb@casper.infradead.org>
References: <000000000000dbe2f2060f0d2781@google.com>
 <4bd438c0-75b8-4e28-939c-954716df7563@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd438c0-75b8-4e28-939c-954716df7563@kernel.dk>

On Tue, Jan 16, 2024 at 11:00:52AM -0700, Jens Axboe wrote:
> On 1/16/24 2:57 AM, syzbot wrote:
> > pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : _compound_head include/linux/page-flags.h:247 [inline]
> > pc : bio_first_folio include/linux/bio.h:289 [inline]
> > pc : __bio_release_pages+0x100/0x73c block/bio.c:1153
> > lr : bio_release_pages include/linux/bio.h:508 [inline]
> > lr : blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
> > sp : ffff800089a375e0
> > x29: ffff800089a375e0 x28: 1fffe0000162e879 x27: ffff00000b1743c0
> > x26: ffff00000b1743c8 x25: 000000000000000a x24: 1fffe000015a9e12
> > x23: ffff00000ad4f094 x22: ffff00000f496600 x21: 1fffe0000162e87a
> > x20: 0000000000000004 x19: 0000000000000000 x18: ffff00000b174432
> > x17: ffff00000b174438 x16: ffff00000f948008 x15: 1fffe0000162e886
> > x14: ffff00000b1743d4 x13: 00000000f1f1f1f1 x12: ffff6000015a9e13
> > x11: 1fffe000015a9e12 x10: ffff6000015a9e12 x9 : dfff800000000000
> > x8 : ffff00000b1743d4 x7 : 0000000041b58ab3 x6 : 1ffff00011346ed0
> > x5 : ffff700011346ed0 x4 : 00000000f1f1f1f1 x3 : 000000000000f1f1
> > x2 : 0000000000000001 x1 : dfff800000000000 x0 : 0000000000000008
> > Call trace:
> >  _compound_head include/linux/page-flags.h:247 [inline]
> >  bio_first_folio include/linux/bio.h:289 [inline]
> >  __bio_release_pages+0x100/0x73c block/bio.c:1153
> >  bio_release_pages include/linux/bio.h:508 [inline]
> >  blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
> >  bio_endio+0x4a4/0x618 block/bio.c:1608
> 
> This looks to be caused by:
> 
> commit 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Aug 14 15:41:00 2023 +0100
> 
>     block: Remove special-casing of compound pages

This looks familiar ... looks like it came up right before Xmas and
I probably dropped the patch on the floor?

https://lore.kernel.org/all/ZX07SsSqIQ2TYwEi@casper.infradead.org/

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ec4db73e5f4e..1518f1201ddd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -286,6 +286,11 @@ static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
 {
 	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
 
+	if (i >= bio->bi_vcnt) {
+		fi->folio = NULL;
+		return;
+	}
+
 	fi->folio = page_folio(bvec->bv_page);
 	fi->offset = bvec->bv_offset +
 			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
@@ -303,10 +308,8 @@ static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
 		fi->offset = 0;
 		fi->length = min(folio_size(fi->folio), fi->_seg_count);
 		fi->_next = folio_next(fi->folio);
-	} else if (fi->_i + 1 < bio->bi_vcnt) {
-		bio_first_folio(fi, bio, fi->_i + 1);
 	} else {
-		fi->folio = NULL;
+		bio_first_folio(fi, bio, fi->_i + 1);
 	}
 }
 

