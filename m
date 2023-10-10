Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583B17C4562
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjJJXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJJXVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:21:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA993;
        Tue, 10 Oct 2023 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9sUglALyJfqvIklPpk3QQK7nuXm06wGiOcRLGqL0UuM=; b=UkS2lcx/eZWT3e5+Be3G6QP17C
        /Hb9cugVyfwHLVYYZyvnWsp3pwe2qs97xA0UHjUObVOTY6CV53goR6j9fKpDRzjMfbk6OvRhpw6ZG
        7gvSssiFA3kZTqztPpn20XbcO8XNiX7SMIt9feGHVwl1ezdiG07ns4AUFGmYFn2zkZp6h36v/+m0i
        U6y+ta4kT3MdOUac3sEWZDjlfLeuNE/2dAch0CDzIzdKFy2FvG6BnLORy9lk44/oNT+XGZnA3Sxhv
        JgCIOHkBJc/dsMDJ7UQC3RNKI/DwtLtAI9laHtmDRMgUAO/9bmUwnwTPB9vR+f/ftcTRxt7eFy2X5
        4e9TCFTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqM2S-00ELhu-0X;
        Tue, 10 Oct 2023 23:21:20 +0000
Date:   Tue, 10 Oct 2023 16:21:20 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] params: harden string ops and allocatio ops
Message-ID: <ZSXccPBRINnuWIec@bombadil.infradead.org>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
 <202310020957.022F9047F0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310020957.022F9047F0@keescook>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:57:59AM -0700, Kees Cook wrote:
> On Mon, Oct 02, 2023 at 03:48:51PM +0300, Andy Shevchenko wrote:
> > A couple of patches are for get the string ops, used in the module,
> > slightly harden. On top a few cleanups.
> > 
> > Since the main part is rather hardening, I think the Kees' tree is
> > the best fit for the series, but I'm open for another option(s).
> > 
> > Changelog v2:
> > - dropped the s*printf() --> sysfs_emit() conversion as it revealed
> >   an issue, i.e. reuse getters with non-page-aligned pointer, which
> >   would be addressed separately
> > - added cover letter and clarified the possible route for the series
> >   (Luis)
> > 
> > Andy Shevchenko (5):
> >   params: Introduce the param_unknown_fn type
> >   params: Do not go over the limit when getting the string length
> >   params: Use size_add() for kmalloc()
> >   params: Sort headers
> >   params: Fix multi-line comment style
> 
> Seems like a nice bit of clean-up.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
