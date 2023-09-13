Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA68179F4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjIMWZX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 18:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMWZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:25:21 -0400
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A7198B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:25:17 -0700 (PDT)
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 329B34020C;
        Wed, 13 Sep 2023 22:25:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id E706332;
        Wed, 13 Sep 2023 22:25:13 +0000 (UTC)
Message-ID: <5d5e987a4a1a624f1d8a99a2b7f76c7c3db70241.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Add a couple new alloc functions to
 alloc with multiplies check
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 15:25:12 -0700
In-Reply-To: <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
References: <cover.1694636817.git.joe@perches.com>
         <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
         <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E706332
X-Stat-Signature: 7gjm3q4bxfmdiegb695hbn9th6upufuh
X-Spam-Status: No, score=1.39
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19aeweXyRZthNUjkll/JFexJWdOyvB9iU8=
X-HE-Tag: 1694643913-423633
X-HE-Meta: U2FsdGVkX18fqRU8wzCJaUlDMNllcQdcJ27I+y+n4LwiGejRCdo5jnDUEal3RItGx0/scPDOWxe0XRHV333MlMl/5dMmOp+oM4iyx2Blfqr56ZAb90cMDvAL5KtzpfH+U4M793SEA+fJiYoktzNuZkmYub6NyTPBXStVEMY9YQL5xIzCEGMVulxyxWGI2dByAxGum0QQk4vaGiZvgXKzd2KfeqyJmzsBXvG5CcLuea1Dp8jUNQpgjv1NKjhWupr3mSGhixI/PFN/3dSUfJx0Qn34PPC9euv3FfVC08jw5wiwKha9H/12sK7PFB+1gOMVEEJB3995e/B0g9oAGXZjhng6fDO4DwLOVSkmE4nbCrHxvIzQYD46Q47dLThZZSHU8xnbdfUjFrm+lfNK8FsyIA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 16:14 -0600, Gustavo A. R. Silva wrote:
> 
> On 9/13/23 14:37, Joe Perches wrote:
> > vmalloc() and vzalloc() functions have now 2-factor multiplication
> > argument forms vmalloc_array() and vcalloc(), correspondingly.
> > 
> > Add alloc-with-multiplies checks for these new functions.
> > 
> > Simplify the original codes repeated else to use a hash.
> > 
> > Link: https://github.com/KSPP/linux/issues/342
> > 
> > Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Why don't you wait for a response or a v2 from the original
> submitter?

Because there really is no need to wait.
