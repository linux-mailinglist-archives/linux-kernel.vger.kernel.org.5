Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576CF79F544
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjIMXAn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 19:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMXAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:00:41 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA121BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:00:37 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 042DC16037F;
        Wed, 13 Sep 2023 23:00:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 9D31518;
        Wed, 13 Sep 2023 23:00:33 +0000 (UTC)
Message-ID: <7502c1de6c25668699db7ca557f4cd61f2f1eab6.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Add a couple new alloc functions to
 alloc with multiplies check
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 16:00:32 -0700
In-Reply-To: <8cf58a8a-5410-4d3f-eb1a-e5bb6ce36023@embeddedor.com>
References: <cover.1694636817.git.joe@perches.com>
         <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
         <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
         <5d5e987a4a1a624f1d8a99a2b7f76c7c3db70241.camel@perches.com>
         <9ea1b028-8ac7-61b0-90e2-d240d52aaffb@embeddedor.com>
         <7a9f7631b7352d7f9ce07bdc53cfc92065cb11a3.camel@perches.com>
         <8cf58a8a-5410-4d3f-eb1a-e5bb6ce36023@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9D31518
X-Spam-Status: No, score=1.35
X-Rspamd-Server: rspamout06
X-Stat-Signature: dz4aci8mf9tgqfdabypxuzqoah1gfemf
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+KhPP60qYqRbsmcOZX3hGgeutUfWN9CzU=
X-HE-Tag: 1694646033-589595
X-HE-Meta: U2FsdGVkX18snOFVXjDMAo0zPcilYn4Y2Lwte1E86bZ5iuGLoqOC1GZVzEXyQlu9MXnwQAvAJTPkpNA9lW2BLAJbsC9v2pGw4mEeGhik0MeqH3w4Gm+/WT5QEJ4FsTvcZynWdAYdSarR6Lfve/Nin8/A95Nzuatb/w1X71ksaggHsLVVvKPkrju8ajNFIRkRyCpZPxWlXsRcfKi+HnRXGWj48pgS0AdwQtNmlDPJtxjuoIZRen1Prd+uyZUIvVfmfR7DZkny+pDpCy0oBBEssmH/AQ7XzRnZLIqIx9SnVlmY0YbX2i+il16SY4Fb0gkcZU0zurfC8AhOlzQOUOq7cx70zkWNJUuCWHoMGO76sIzEEgKFb/PJwXJOsZdyPuxGjEdb/so6cs8187agb46Y+A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 16:41 -0600, Gustavo A. R. Silva wrote:
> 
> On 9/13/23 16:34, Joe Perches wrote:
> > On Wed, 2023-09-13 at 16:32 -0600, Gustavo A. R. Silva wrote:
> > > 
> > > On 9/13/23 16:25, Joe Perches wrote:
> > > > On Wed, 2023-09-13 at 16:14 -0600, Gustavo A. R. Silva wrote:
> > > > > 
> > > > > On 9/13/23 14:37, Joe Perches wrote:
> > > > > > vmalloc() and vzalloc() functions have now 2-factor multiplication
> > > > > > argument forms vmalloc_array() and vcalloc(), correspondingly.
> > > > > > 
> > > > > > Add alloc-with-multiplies checks for these new functions.
> > > > > > 
> > > > > > Simplify the original codes repeated else to use a hash.
> > > > > > 
> > > > > > Link: https://github.com/KSPP/linux/issues/342
> > > > > > 
> > > > > > Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > > 
> > > > > Why don't you wait for a response or a v2 from the original
> > > > > submitter?
> > > > 
> > > > Because there really is no need to wait.
> > > 
> > > By the way, did you test it?
> > 
> > Yes, against arch/s390/include/asm/idals.h
> 
> I don't see any instances of vmalloc() or vzalloc() in that file.

<snort>  Cute.

Missing a ? in the original search '\s*,?'
or just its removal...

Likely the removal would be better.

thanks, cheers, Joe
