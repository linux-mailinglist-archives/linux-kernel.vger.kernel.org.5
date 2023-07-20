Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE475BA84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGTWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjGTWWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:22:24 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ECC30F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:21:54 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5661eb57452so847955eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689891659; x=1690496459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ww5WuryDbj+ot6eFUCZgy718TF10XCTB2MyAj3dfUMk=;
        b=kMTrQS+AVMKURWTk8oT3YVUndrkw3YBFkSDPZfJfY/C+8W4opz2ZMK02Nlmjo8l6HR
         E8TYoLgI7yI0pqyy47KYCf0iT7ejiT2nT2Ofa5l2C/crlyHBKTAArhiVCdyikgfNKpwe
         +b66TFAyhOe7XyQM3ft0ise9UZuDXiDQ9bRe0XbTAcSgrx3vkmZmmviWMdDc7EJVgGHG
         +MfYOuElupYwFtTkpBDMWPWQ3m4zjiZGh6ojXvcea75t5WwAEAN5QR7rV5Pck3GgVZa7
         p2nbuHWDCAgAJywseSy+RnD3xifTl9d4wJ+BWajfFiR6R+JpwXtwltpRShZCpOJwdbS8
         Mbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891659; x=1690496459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww5WuryDbj+ot6eFUCZgy718TF10XCTB2MyAj3dfUMk=;
        b=DjHzDTFHkeuYQ1tVpt84XrntoAHUp0/Uv4yM6OZ2irJuMU84tXfMb0KLdbad9tiCJM
         cmkkscnq6uGIGN/DdsI0X6T5GxkT13XWoexH/tGc5gWmJNoGz8eDgNZeqhZHO4ZGLoxN
         r8T0Yjh3eKFLZZ4+XvlJm4fwNpjxkTShPxl+hrI9X8JTDhX4ih3RMsbnwDa1FJaFW3y6
         x+3eovlXLUs1K0BsLGnkjCGtlph5Bshbw6jDGq40++tpfF1NWu4BdVpqlLRaCprEiEBg
         sj+ot2H3XlWhpMkSHnze6ewj4/vq64cKXyXpXBxM0EqYZJrcAUO0zdp+0Vs0FIoFxi4e
         rOKA==
X-Gm-Message-State: ABy/qLZP+GnaLp033rTRhDzXacerK8k4YSTOrxEK2l9Araxg4CgmCyL6
        CXvTbnEtSFyXwMgJ418bRTj2qQ==
X-Google-Smtp-Source: APBJJlHEKoknw6tsS4AKB23rpXbrSIf0brs+wH8Daq3iqSBdDAYBXthi8Oaw/cEKo3F2y9BIkUw1QQ==
X-Received: by 2002:aca:1214:0:b0:39e:8678:4035 with SMTP id 20-20020aca1214000000b0039e86784035mr230543ois.13.1689891659575;
        Thu, 20 Jul 2023 15:20:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id gz18-20020a17090b0ed200b00263dfe9b972sm3127330pjb.0.2023.07.20.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:20:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qMc12-008Wfy-04;
        Fri, 21 Jul 2023 08:20:56 +1000
Date:   Fri, 21 Jul 2023 08:20:56 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
References: <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com>
 <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com>
 <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
 <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 02:27:50PM -0400, Jeff Layton wrote:
> On Thu, 2023-07-20 at 18:59 +0100, Matthew Wilcox wrote:
> > On Thu, Jul 20, 2023 at 07:50:47PM +0200, John Paul Adrian Glaubitz wrote:
> > > > Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> > > > MAINTAINERS and if distros are going to do such a damnfool thing,
> > > > then we must stop them.
> > > 
> > > Both HFS and HFS+ work perfectly fine. And if distributions or users are so
> > > sensitive about security, it's up to them to blacklist individual features
> > > in the kernel.
> > > 
> > > Both HFS and HFS+ have been the default filesystem on MacOS for 30 years
> > > and I don't think it's justified to introduce such a hard compatibility
> > > breakage just because some people are worried about theoretical evil
> > > maid attacks.
> > > 
> > > HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerMac
> > > and I don't think it's okay to break all these systems running Linux.
> > 
> > If they're so popular, then it should be no trouble to find somebody
> > to volunteer to maintain those filesystems.  Except they've been
> > marked as orphaned since 2011 and effectively were orphaned several
> > years before that (the last contribution I see from Roman Zippel is
> > in 2008, and his last contribution to hfs was in 2006).
> 
> I suspect that this is one of those catch-22 situations: distros are
> going to enable every feature under the sun. That doesn't mean that
> anyone is actually _using_ them these days.
> 
> Is "staging" still a thing? Maybe we should move these drivers into the
> staging directory and pick a release where we'll sunset it, and then see
> who comes out of the woodwork?

No, the train wreck of filesystems in staging proved that it wasn't
a viable process.

We should just follow the same process as we are using for reiser -
mark it as deprecated in place, pick a date that we are going to
remove it, then add a warning (both runtime, in kconfig and probably
in the kernel filesystem documentation) that it is deprecated and
support is going to be removed at a certain date.

We should be applying the same criteria and process for all the
other filesystems that are orphaned, too. We need to much more
proactive about dropping support for unmaintained filesystems that
nobody is ever fixing despite the constant stream of
corruption- and deadlock- related bugs reported against them.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
