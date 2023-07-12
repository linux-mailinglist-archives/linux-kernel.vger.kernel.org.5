Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F2751241
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGLVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGLVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A81FF5;
        Wed, 12 Jul 2023 14:11:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (unknown [188.20.72.2])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C265557E;
        Wed, 12 Jul 2023 23:10:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1689196222;
        bh=Nfrt1vHDxsUP0vDsPlprMD4mikah9/nQ8e1/EUlb0X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3tL4WYwV3fEqPXqXIiVVvNOs/d8UYCRwkU7KzKIHmhXuVErxFryEumjI5r7Uwf8S
         BaNSCFb4w5m/ik/0AQ5nLxahIZ/2tP4fwwc0twGru9hLAHBdo7dnH5qT9blBWN2O72
         eqhHQNpQVlPOycgW706FKzpuxS/+zZ9BNKDc/GZc=
Date:   Thu, 13 Jul 2023 00:11:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     syzbot <syzbot+0b0095300dfeb8a83dc8@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, nogikh@google.com,
        sakari.ailus@linux.intel.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in
 __media_entity_remove_links
Message-ID: <20230712211112.GD30092@pendragon.ideasonboard.com>
References: <0000000000003ee3610599d20096@google.com>
 <000000000000c26a66060035ad18@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000c26a66060035ad18@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 06:00:08AM -0700, syzbot wrote:
> This bug is marked as fixed by commit:
> media: uvcvideo: Avoid cyclic entity chains due to malformed
> 
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:

#syz fix: media: uvcvideo: Avoid cyclic entity chains due to malformed USB descriptors

Can a commit ID be used as well ?

> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
> 
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=0b0095300dfeb8a83dc8
> 
> ---
> [1] I expect the commit to be present in:
> 
> 1. for-kernelci branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> 
> 2. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> 
> 3. master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> 
> 4. main branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
> 
> The full list of 9 trees can be found at
> https://syzkaller.appspot.com/upstream/repos

-- 
Regards,

Laurent Pinchart
