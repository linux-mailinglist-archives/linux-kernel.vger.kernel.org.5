Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC71B7B99D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjJEBx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbjJEBx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:53:27 -0400
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CC9E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:53:24 -0700 (PDT)
Date:   Thu, 5 Oct 2023 01:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696470801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XUx51LJ0xLjbmrNDmhaeRIVL3oP6MsbVtEzTUru1wBA=;
        b=iPXzHzNNj+AbXtjC1JFw8O8kkMpfws2fSyJMGirMfyqmtoV4pracdp/gO3ab1EoDZ9YlfU
        RGT5/FnJiDtk0nmqmVIwwj7gHMdeMWDWt6X+9QlnqwVXyGHA1xNGiQLc6YzPVGHs/ywMUY
        GOpDVQZgwP5LvRw+IldwEoY7E57bBTk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-arm tree
Message-ID: <ZR4XDY5LMQ9l-esD@linux.dev>
References: <20231005123159.1b7dff0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005123159.1b7dff0f@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Oct 05, 2023 at 12:31:59PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kvm-arm tree, today's linux-next build (native perf)
> failed like this:
> 
> In file included from util/../../arch/arm64/include/asm/cputype.h:201,
>                  from util/arm-spe.c:37:
> tools/arch/arm64/include/asm/sysreg.h:132:10: fatal error: asm/sysreg-defs.h: No such file or directory
>   132 | #include "asm/sysreg-defs.h"
>       |          ^~~~~~~~~~~~~~~~~~~

Gah, shame on me, I didn't build everything in tools/ after this change.

> Caused by commit
> 
>   6a4c6c6a56c1 ("KVM: arm64: selftests: Import automatic generation of sysreg defs")
> 
> I have used the kvm-arm tree from next-20231004 for today.

Thanks much, I'll back this out from the kvmarm side of things until we
get it sorted.

-- 
Thanks,
Oliver
