Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62107E5B05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjKHQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjKHQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:20:32 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157401733;
        Wed,  8 Nov 2023 08:20:30 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A1C5F77D;
        Wed,  8 Nov 2023 16:20:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1C5F77D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1699460429; bh=3f9l14K9JHEdMbDYWDeilx1EKMCnJqGRBRwQlTmIpNw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gQ0T66yNdHz05Edc/4B+Ya8rn5WqGpFTkzO/X3C4RgDHFPqVNIBkym1WpOAZlgGeS
         kZuwF9qHQs/Uj43LDTPNBUM4VlNYTS+58+IfjrAs071vDa0c47raiDnNN2LeFSb0s4
         BIMueMfLGKMYzyZfySJ1SwNCxAhZ5IGkoItllmbrWLZZnq9RGZalUcF+AyKqhXVn6C
         dEEcPtaoj0W4RMJwjtu+NRND0QoqzGsT8J8xERWFMSeM2CQK38DtjThfJaCLsDm5Ag
         DX2ntsf9K6d6oWe4g63hcHwDT6uSJkjJbjbTPLwiZKPN6A+OQU1ZpLsfr3NL23B8X6
         oDG0xl+nE+fzg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
In-Reply-To: <20231108-redakteur-zuschauen-a9aeafaf4fad@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <87il6d1cmu.fsf@meer.lwn.net>
 <20231108-redakteur-zuschauen-a9aeafaf4fad@brauner>
Date:   Wed, 08 Nov 2023 09:20:28 -0700
Message-ID: <87o7g4xlmb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

>> Why use struct __mount_arg (or struct mnt_id_req :) here rather than
>> just passing in the mount ID directly?  You don't use the request_mask
>
> Please see Arnd's detailed summary here:
> https://lore.kernel.org/lkml/44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com

Ah, makes sense, I'd missed that.

Given this, though, it seems like maybe sys_listmount() should enforce
that req->request_mask==0 ?

Thanks,

jon
