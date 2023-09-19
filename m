Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F77A6310
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjISMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:34:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46AF3;
        Tue, 19 Sep 2023 05:34:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BD5C433C7;
        Tue, 19 Sep 2023 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126846;
        bh=QETWPaa3KJlXSQrH8H4gx8KdLo/4AlYAVDYRM+8Ee7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TYYWKnm+Wg16T8zjWshL2mzP5w0MawCptWPB6rPZnDAZKgs7jPa4N+KOI4IpDakq6
         ji6rllo97r0YkctneJMuECh1pLLnjblZdN77L75gMyzbSE4VCkfi8fbzZI8q97rlRF
         yTmrT1MEdIVTByu7kLbp+9iM2xX/q9pZYje1YTL7jnSnpJLGNSsivnBE19+4vJOrFe
         rkH93VD2f6TC82CMXZYwNehQcI+aJhmkYAELZMKPAQDI+eFydmY/ExVOC29RVs+1vk
         B2CNWf1MHroUubSK1VsCIMwF80IYnkoIjKOT/xWoF/9vpKaivRX1tjNJvZJWE1pkAg
         tYeuTDsxe+jyw==
Date:   Tue, 19 Sep 2023 14:34:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the vfs-brauner tree
Message-ID: <20230919-zensieren-plakat-05a044361e57@brauner>
References: <20230915093953.310503ee@canb.auug.org.au>
 <20230918205206.GA348037@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918205206.GA348037@frogsfrogsfrogs>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:52:06PM -0700, Darrick J. Wong wrote:
> On Fri, Sep 15, 2023 at 09:39:53AM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the iomap tree as a different commit
> > (but the same patch):
> > 
> >   de5b0b257ee3 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> > 
> > This is commit
> > 
> >   4aa8cdd5e523 ("iomap: handle error conditions more gracefully in iomap_to_bh")
> > 
> > in the iomap tree.
> 
> Christian, do you want to push this to Linus instead of me?  I've a
> couple more fixes that I'm about to send out to fsdevel and could just
> roll all the iomap stuff into a single branch... but if you were about
> to this to Linus I don't mind letting that happen.

So I was about to send a pull request tomorrow. I thought I was supposed
to pick up iomap stuff. Let me know what you prefer. I can easily drop
this patch. :)
