Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428837E2E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjKFUxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFUxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:53:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2921CF3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:52:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BA1C433C8;
        Mon,  6 Nov 2023 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699303978;
        bh=uiFtSMJtgsfJ/bNf1yRT0A0/EhLw1YECLioBli3+JIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O/D1O9li5NFX7VnY8p1Cnp7xXe8lptR2O9UlSt18mn++8+oOnxz/2V6eh9tDxQv/e
         2QiWpE+CVUe9Hbxb5y8pNBTmMO88ZQIrSkAcfnyzWRcHAxceLVy/qBvIY4uJWT2RJN
         etoyYRUGGz/XMZDVEdgv8XnA1QYEnY+ww1mVqUrlwqT/fGckC7H7EeDFo+4zWgzgGx
         M0fqaMTIw5eJUCJQcHBP3cLNIEsRlAMxL3bSXf4Osj3u+4vPvvA+tgjPcCCF1tod/F
         riATYD4H4Z/glc2YBFWqG24cSSHDIuosZsiUAOVYT//1xsc57GNtGcqzae+w0frUn9
         KLPZS6LQLXihA==
Date:   Mon, 6 Nov 2023 12:52:57 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        dsahern@kernel.org, pabeni@redhat.com, ndesaulniers@google.com,
        trix@redhat.com, 0x7f454c46@gmail.com, noureddine@arista.com,
        hch@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH net v2] tcp: Fix -Wc23-extensions in tcp_options_write()
Message-ID: <20231106125257.43f52b1f@kernel.org>
In-Reply-To: <20231106155806.GA1181828@dev-arch.thelio-3990X>
References: <20231106-tcp-ao-fix-label-in-compound-statement-warning-v2-1-91eff6e1648c@kernel.org>
        <CANn89i+GF=4QuVMevE7Ur2Zi0nDjBujMHWJayURR9fbcr+McnA@mail.gmail.com>
        <20231106155806.GA1181828@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 08:58:06 -0700 Nathan Chancellor wrote:
> Ah, this suggestion is much better, thanks. I'll make this adjustment
> and send a v3 later today in case others have any suggested changes (I
> know netdev prefers waiting 24 hours for another revision but I'd like
> to get this warning cleared up by -rc1 so it does not proliferate into
> other trees and I sent v1 almost a week ago).

Definitely, sorry about the delay, feel free to post v3 ASAP.
