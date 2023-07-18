Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38997585B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGRTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGRTpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039F198D;
        Tue, 18 Jul 2023 12:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE15360B68;
        Tue, 18 Jul 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F86C433C7;
        Tue, 18 Jul 2023 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709550;
        bh=94qN7IxSeuyb7pEQYiFkSuDjUouVRsu/gsID7UmjLsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rPsOyVA7/PABWabDCwLsaJiEIzold1feSFOLd21VdtYtOmwg1+MgFTrfFdEahbjYJ
         cLKYT3VnO/S1zyb/kSuQCOrfEj2+TTkZraKhOCmqOz7SxvgkZZzCg2T4I+ZIGglZE6
         iOvWaFfax7yREr2Rb5KVySLopQr7jEoSEy1VQ4eFwSjfwpEEyMlQdP0oJP1v2nbMuP
         PMASQvA5uda3+QGF34YE0F+/yIkDGstbhXLzItw5KzpJag7oKSCFuKWjaFzuIDeJ+y
         LRweB2pzUFC+Eps48Ag9TS9taTyfjFXIp8FF9/1pwP8msO0bl3MrgYsSLor9GoBIko
         a+o/frAWTgHeA==
Date:   Tue, 18 Jul 2023 12:45:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in
 hci_uart_tty_ioctl
Message-ID: <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <00000000000077b5650600b48ed0@google.com>
References: <00000000000049baa505e65e3939@google.com>
        <00000000000077b5650600b48ed0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d772781964415c63759572b917e21c4f7ec08d9f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Jan 6 06:33:54 2023 +0000
> 
>     devlink: bump the instance index directly when iterating

Hm, don't think so. It's not the first issue where syzbot decided
this commit was the resolution. I wonder what makes it special.
