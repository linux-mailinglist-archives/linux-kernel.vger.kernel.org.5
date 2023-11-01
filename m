Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD97DE43D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKAPyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:54:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909510F;
        Wed,  1 Nov 2023 08:54:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAB8C433C7;
        Wed,  1 Nov 2023 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698854075;
        bh=JYx6SExCh08Bm1b+89icz86zNSgiBleVA/ww9551uSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R5/9KVOyL+tS6/J+l1xb4bnAOleAUHFaYO7WWxKUDKDPTItJ2PT/M64zm7r0kk2/K
         D+NIr5tHLMSiaXg2b9rWGqTrDPZbB/odbUgIIVM03JlJxI55/oOsoO7KwbEos36BlV
         zS9noXoXSTGycP82UgC86v0MklCkIB1u4YUdlvH5ww4ezLxEBI/4LkVuZOVCF5Dcqn
         yGAxyMySIiRUuo9+EapXJZY6Mjpqi4B7K8oszmRmBEZ0Fi9H70WhHpPWMY8WWtEo0Y
         TlHxkqRirMdd0dO1LE6yLPHzRoqXv5cxthC3m4EjyCT1hBxFHKwZdOUDVMZ/iGMrAX
         OZvHOTNmhfo+g==
Date:   Wed, 1 Nov 2023 16:54:28 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] querying mount attributes
Message-ID: <20231101-nickel-syntaktisch-7123fc5b6c91@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231101-urenkel-banal-b232d7a3cbe8@brauner>
 <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOssrKcf5NQ8pGFWKq2hG9BmFZN-0rhhO+MuYCe7fVfmFO4DAA@mail.gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:18:30PM +0100, Miklos Szeredi wrote:
> On Wed, Nov 1, 2023 at 12:13 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > I've renamed struct statmnt to struct statmount to align with statx()
> > and struct statx. I also renamed struct stmt_state to struct kstatmount
> > as that's how we usually do this. And I renamed struct __mount_arg to
> > struct mnt_id_req and dropped the comment. Libraries can expose this in
> > whatever form they want but we'll also have direct consumers. I'd rather
> > have this struct be underscore free and officially sanctioned.
> 
> Thanks.
> 
> arch/arm64/include/asm/unistd.h needs this fixup:
> 
> -#define __NR_compat_syscalls 457
> +#define __NR_compat_syscalls 459

Everytime with that file. It's like a tradition that I forget to update
it at least once.

> 
> Can you fix inline, or should I send a proper patch?

No need to send. I'll just fix it it here.
