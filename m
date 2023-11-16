Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630B7EE639
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKPR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKPR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:56:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF95518D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:56:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1216C433C7;
        Thu, 16 Nov 2023 17:56:11 +0000 (UTC)
Date:   Thu, 16 Nov 2023 17:56:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     jim.cromie@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 0/3] kmemleak report format changes
Message-ID: <ZVZXuUvLY64zilZj@arm.com>
References: <20230425222446.170486-1-jim.cromie@gmail.com>
 <ZEwBcOdV1br94T5N@arm.com>
 <CAJfuBxwdrL=4nKntHF69PkJ=tzHvECh4Ro6EFZamtwJgnN_SKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxwdrL=4nKntHF69PkJ=tzHvECh4Ro6EFZamtwJgnN_SKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 05:19:38PM -0700, jim.cromie@gmail.com wrote:
> On Fri, Apr 28, 2023 at 11:25 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Tue, Apr 25, 2023 at 04:24:43PM -0600, Jim Cromie wrote:
> > > If format changes are not /sys/** ABI violating, heres 3 minor ones:
> > >
> > > 1st strips "age <increasing>" from output.  This makes the output
> > > idempotent; unchanging until a new leak is reported.
> > >
> > > 2nd adds the backtrace.checksum to the "backtrace:" line.  This lets a
> > > user see repeats without actually reading the whole backtrace.  So now
> > > the backtrace line looks like this:
> > >
> > >   backtrace (ck 603070071):  # also see below
> > >
> > > Q: should ck be spelled crc ? it feels more communicative.
> >
> > These all would make sense (and 'crc' sounds better) if they were done
> > from the start. I know there are test scripts out there parsing the
> > kmemleak sysfs file. I can't tell whether these changes would break
> > them.
> >
> > Cc'ing Dmitry, I think syzbot was regularly checking kmemleak (not sure
> > it still does).
[...]
> QED: there are no kmemleak parsers in public github repos that would
> break with these changes

Thanks for digging into this, I completely forgot about this series.
Would you mind rebasing to the latest kernel and reposting?

Thanks.

-- 
Catalin
