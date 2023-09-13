Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944D79F514
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjIMWev convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 18:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:34:51 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43C21BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:34:46 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id C49DA1CA609;
        Wed, 13 Sep 2023 22:34:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 69C1B2000E;
        Wed, 13 Sep 2023 22:34:43 +0000 (UTC)
Message-ID: <7a9f7631b7352d7f9ce07bdc53cfc92065cb11a3.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: Add a couple new alloc functions to
 alloc with multiplies check
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 15:34:42 -0700
In-Reply-To: <9ea1b028-8ac7-61b0-90e2-d240d52aaffb@embeddedor.com>
References: <cover.1694636817.git.joe@perches.com>
         <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
         <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
         <5d5e987a4a1a624f1d8a99a2b7f76c7c3db70241.camel@perches.com>
         <9ea1b028-8ac7-61b0-90e2-d240d52aaffb@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 69C1B2000E
X-Stat-Signature: bbhzgkfe565hdab6odbs9d19p6aefxek
X-Spam-Status: No, score=1.27
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+L7ZzEG1Zbb3v2r8dKRbZVmTewpeslQqU=
X-HE-Tag: 1694644483-327146
X-HE-Meta: U2FsdGVkX18l+sMfzzQOpe19+Yx4A8fwG0r0icnxdrGFV6wg8kheOg+VW5e++Uu5M1AGThrSnHyx7KuAIuccUXwaccMPVS7cGR4Pz5v1LVphwGIWLJKlQKWeoToWLRhW9t/BRvethQRs+oWL60jmEzsSwmZE1tOY7H1ELjxCsFXfOpNWfvtyAifxOEllZKfWHFlBI9SYcgVJZe1b0vmxMk35j9MqtVFlidbV36rGB/XzyQ5hdXFc4aeYnt2VaKgpWHKCnVt50Gv4kUzfnsFbeUuCGUFDLfGHULrLsRLfayKrEHBH8Do0BYQ0XSe8y1aqTc0n5kjchK3VkIj7Q7BSraT2Ts1guTrpuVV5zMmF4QHTgZykWZvVhm6oWr61FC+LVRBM1ksztGE4nne1I5WQWQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-13 at 16:32 -0600, Gustavo A. R. Silva wrote:
> 
> On 9/13/23 16:25, Joe Perches wrote:
> > On Wed, 2023-09-13 at 16:14 -0600, Gustavo A. R. Silva wrote:
> > > 
> > > On 9/13/23 14:37, Joe Perches wrote:
> > > > vmalloc() and vzalloc() functions have now 2-factor multiplication
> > > > argument forms vmalloc_array() and vcalloc(), correspondingly.
> > > > 
> > > > Add alloc-with-multiplies checks for these new functions.
> > > > 
> > > > Simplify the original codes repeated else to use a hash.
> > > > 
> > > > Link: https://github.com/KSPP/linux/issues/342
> > > > 
> > > > Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > 
> > > Why don't you wait for a response or a v2 from the original
> > > submitter?
> > 
> > Because there really is no need to wait.
> 
> By the way, did you test it?

Yes, against arch/s390/include/asm/idals.h

Did you?  If so, you could also add your own tested-by...

