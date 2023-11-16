Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7117E7EE8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjKPVnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPVni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:43:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118E181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:43:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD9AC433C7;
        Thu, 16 Nov 2023 21:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700171014;
        bh=twTNWRQdIKcOStkRGzXUGtwCSKQonpLZLAIQKx9vJcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QvKaTL3ndxsh2tVl73T17w+fISLhZTW0gIn7pe8oxtPfAcZfG+MvZhirVrmwYyJr7
         2fEEHfjUG6qKjAICs1TWsSOFv3l5im7ASasMGpFlpSsu7TbZgogyvG+feNReCzbSBO
         Z1uVpoTJqjG/Fp+2L/pKCJOiRojj95iCYDg6HN3A=
Date:   Thu, 16 Nov 2023 13:43:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lizhi Xu <lizhi.xu@windriver.com>
Cc:     <syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] squashfs: squashfs_read_data need to check if the
 length is 0
Message-Id: <20231116134332.285510d340637171d2fe968c@linux-foundation.org>
In-Reply-To: <20231116031352.40853-1-lizhi.xu@windriver.com>
References: <0000000000000526f2060a30a085@google.com>
        <20231116031352.40853-1-lizhi.xu@windriver.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 11:13:52 +0800 Lizhi Xu <lizhi.xu@windriver.com> wrote:

> when the length passed in is 0, the subsequent process should be exited.

Thanks, but when fixing a bug, please always describe the runtime
effects of that bug.  Amongst other things, other people need this
information to be able to decide which kernel versions need patching.

> Reported-by: syzbot+32d3767580a1ea339a81@syzkaller.appspotmail.com

Which is a reason why we're now adding the "Closes:" tag after
Reported-by:.

I googled the sysbot email address and so added

Closes: https://lkml.kernel.org/r/0000000000000526f2060a30a085@google.com

to the changelog.

I'll assume that a -stable kernel backport is needed.


