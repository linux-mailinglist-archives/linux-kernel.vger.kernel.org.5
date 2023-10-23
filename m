Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034787D3C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjJWQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJWQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:33:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E28E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:32:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4223C433C7;
        Mon, 23 Oct 2023 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698078778;
        bh=0M244WP+B22z6pXqP9dzivpUFrbkfNxne47wn1L0ZW4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UHqgLgwGnbMutjeOm+NYV0HlNhagHkMAAACFBUqKPMeurN3bBYDJuBwMQw4VjmPoS
         qfZb9IDIC0GpOUODsjbTzy0xygvAm7LqMLnCQ6+Adqlxbm+7An0xmz1CF/OKawyV0R
         8zlqsYNmUMaXVz2mE+kJSFBDZYQ1t0NgRmxH1iA9BrvWYNwXOTB624kcHckSLvKcdW
         5+PGhbNnpiSgTGYUGDNZFFt72OlYO1Lg/n22vXVL9Wx0T4VPXngwYs3BiocVVbS46p
         +2KVSpxcKlZmiMq1n/NEqlZy1RAbEHPGbO3ZU3sdryW/WRsm4Ic3+aGSkdHzqzwbpt
         BgHG3e6v2E5gA==
Date:   Mon, 23 Oct 2023 09:32:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Drewek, Wojciech" <wojciech.drewek@intel.com>
Cc:     Edward AD <twuufnxlz@gmail.com>,
        "syzbot+9704e6f099d952508943@syzkaller.appspotmail.com" 
        <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "reibax@gmail.com" <reibax@gmail.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ptp: ptp_read should not release queue
Message-ID: <20231023093256.0dd8f145@kernel.org>
In-Reply-To: <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <0000000000002e8d4a06085267f3@google.com>
        <20231023024622.323905-2-twuufnxlz@gmail.com>
        <MW4PR11MB57763BDD2770028003988D8AFDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 09:01:40 +0000 Drewek, Wojciech wrote:
> Consider adding a target to the subject: [PATCH net] in this case

The buggy commit only exists in net-next, [PATCH net-next] 
is the correct prefix.
