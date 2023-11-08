Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC97E516C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjKHHxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjKHHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D6172E;
        Tue,  7 Nov 2023 23:53:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CD9C433C7;
        Wed,  8 Nov 2023 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699430017;
        bh=EO6SIeq3IRVmtcKnhSZW5myz/GbmhWsorKkfsMWlq0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aSnRQY4BD1Zt326N3ax1KgytTnQmiA7/5HwRTE9BjxrlM6t57aKI5tDLxjWKbsBCG
         XpmFBhlpZeeOmTQIcJ7TJYUyuhSL0UOs32vU80NdjTgdfPbEjznC54ZKN+KyoNxTdw
         ECKKUhFw5qPTj7Z2WU6umcUrUp1qOnGIBzY2Qj+kt42o3TivB/T7wdWVIWbzGL0hEh
         NrVwKVfnb/BFKTzlSNBaiF80d63DFH+3cZOvK1fYQKhmhvxSCQTegZP3o8BYTEtzEV
         9iXBC4GTjo3HtNqAyVYWlcgcfxx0pKXN86hO+VdXnW0v28QiiCYVFQSSgjtosqRI6D
         ofbIH/INlerDQ==
Date:   Wed, 8 Nov 2023 08:53:30 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
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
Message-ID: <20231108-redakteur-zuschauen-a9aeafaf4fad@brauner>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
 <87il6d1cmu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il6d1cmu.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why use struct __mount_arg (or struct mnt_id_req :) here rather than
> just passing in the mount ID directly?  You don't use the request_mask

Please see Arnd's detailed summary here:
https://lore.kernel.org/lkml/44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com
