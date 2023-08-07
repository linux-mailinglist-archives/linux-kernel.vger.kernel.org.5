Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D2777194A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjHGFT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHGFTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:19:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C8170B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:19:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bbc64f9a91so36079305ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 22:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691385563; x=1691990363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFnplcIQrufgoEeVnD1iXcx2sLuZX9r5b+/X2IXHNf8=;
        b=Q7DxxIhgMo46QGY0MrbuPuKxRUCe4gavGP6YsLFndAQqK9FPDABdLLnQqnYB8H9ebW
         EkXHpkiFK7lecutNCxsohpe1hIPHd1HAxLXofeko7lWPAYlEUbYG/HWYA7VO6Ppji+L8
         KPFb4h8H+3yOU6595s5gH4QBLiOWkMRAnxZU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691385563; x=1691990363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFnplcIQrufgoEeVnD1iXcx2sLuZX9r5b+/X2IXHNf8=;
        b=E2nsTK9eRwqER0Sl/pGCs28YtwQPOSaEsEDsaUTIiwjSzdhyZruHgOPuPvPNMWkhbo
         B8QLsZxyc5IvoMVGO094gZbeCFgrJPXQU4LcT3jkVeBjL32LtMOrbHo+ST+QveMAdbLF
         dT9ajFL5pSib1w46y+w9NZ0xi6XybURcGUPbYx+Tg399IrhLuc6k0l5sR+3LhMAsNAu0
         zOLskwDHw1r0CUvB6LMzGeLkRLOXcM+qV8W1ihOkj6xgr71rJLLxSJn9AhQp9ScjTOgG
         nzLZwtBTDV7qbp4ldw67pmKLxky+VSFuVRb57/IR79IuspTmYskP5JKOjs8ztf5+8/u9
         +24Q==
X-Gm-Message-State: AOJu0YwK0Ovv7ju5BckzsvPG+RmJ8ImJSyfFSOMCsWkbmPcOACXZqUou
        PlSyntsb6awrQIieR8qx+AluwA==
X-Google-Smtp-Source: AGHT+IH9VWVSqgbvsZOfDQkkDfR3GmRAM6nKTnGLYAkOPsQI5W+o8XCsCIaf1qov50YwMQAeJ8h7JQ==
X-Received: by 2002:a17:902:d512:b0:1bb:59da:77f8 with SMTP id b18-20020a170902d51200b001bb59da77f8mr11480833plg.48.1691385563411;
        Sun, 06 Aug 2023 22:19:23 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001bba7aab826sm5793688plj.163.2023.08.06.22.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 22:19:22 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:19:17 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ian Wienand <iwienand@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Martin Doucha <mdoucha@suse.cz>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH 0/1] Possible bug in zram on ppc64le on vfat
Message-ID: <20230807051917.GC907732@google.com>
References: <20221107191136.18048-1-pvorel@suse.cz>
 <Y2l3vJb1y2Jynf50@google.com>
 <ZMycl7xKyJoQNpcu@fedora19.localdomain>
 <ZNB2kORYiKdl3vSq@fedora19.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNB2kORYiKdl3vSq@fedora19.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/07 14:44), Ian Wienand wrote:
[..]
> 
> At this point, because this test fills from /dev/zero, the zsmalloc
> pool doesn't actually have anything in it.  The filesystem metadata is
> in-use from the writes, and is not written out as compressed data.
> The zram page de-duplication has kicked in, and instead of handles to
> zsmalloc areas for data we just have "this is a page of zeros"
> recorded.  So this is correctly reflecting that fact that we don't
> actually have anything compressed stored at this time.
> 
> >  >> If we do a "sync" then redisply the mm_stat after, we get
> >  >>   26214400     2842    65536 26214400   196608      399        0        0
> 
> Now we've finished writing all our zeros and have synced, we would
> have finished updating vfat allocations, etc.  So this gets compressed
> and written, and we're back to have some small FS metadata compressed
> in our 1 page of zsmalloc allocations.
> 
> I think what is probably "special" about this reproducer system is
> that it is slow enough to allow the zero allocation to persist between
> the end of the test writes and examining the stats.
> 
> I'd be happy for any thoughts on the likelyhood of this!

Thanks for looking into this.

Yes, the fact that /dev/urandom shows non-zero values in mm_stat means
that we don't have any fishy going on in zram but instead very likely
have ZRAM_SAME pages, which don't reach zsmalloc pool and don't use any
physical pages.

And this is what 145 is in mm_stat that was posted earlier. We have 145
pages that are filled with the same bytes pattern:

> >  >> however, /sys/block/zram1/mm_stat shows
> >  >>   9502720        0        0 26214400   196608      145        0        0

> If we think this is right; then the point of the end of this test [1]
> is ensure a high reported compression ratio on the device, presumably
> to ensure the compression is working.  Filling it with urandom would
> be unreliable in this regard.  I think what we want to do is something
> highly compressable like alternate lengths of 0x00 and 0xFF.

So var-lengths 0x00/0xff should work, just make sure that you don't have
a pattern of sizeof(unsigned long) length.

I think fio had an option to generate bin data with a certain level
of compress-ability. If that option works then maybe you can just use
fio with some static buffer_compress_percentage configuration.
