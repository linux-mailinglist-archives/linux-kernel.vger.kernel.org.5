Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F43772CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHGRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHGRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:22:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE03C19AB;
        Mon,  7 Aug 2023 10:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE9C62038;
        Mon,  7 Aug 2023 17:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9BC433C8;
        Mon,  7 Aug 2023 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691428937;
        bh=Btos6yEe/pTyrhgNSa9UQH62RHapqhrdMCY/H1ZIIUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nb8VGOo1PMsc4g0x+peqbaUowavB9SZT+KJAn6EZYprxEAVjjjIGOhlCPhxlVGJZD
         m71ht22A38Zpohb3HnKzamiFKfYd/us+Ra8OHo7pSvj9B7ZpRXTsuwpMYsbEH2jIne
         jXdFKZwyaMr0QuiP0YfGCY+lRyHVy4VMsrtM1QqLBAMVMqqkFEqiTm52rG54vYdUra
         D56s0L+xh6cLY48aVEEeehrMWplwQmbq1RQvaLrJm1I+1AK5IZcVIM7w6wBKrND6Am
         JVPLMdpu1Db7IKiW0HgBu9ehielZxrocv5XBfbYaumlal/sDXWSkGs9933/AHHuElq
         tb2OBuRmIK1vQ==
Date:   Mon, 7 Aug 2023 10:22:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Xinyu Liu <LXYbhu@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [BUG]Bluetooth: possible semantic bug when the status field of
 the HCI_Connection_Complete packet set to non-zero
Message-ID: <20230807102215.75d3322d@kernel.org>
In-Reply-To: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
References: <ed32aad7-41c0-c84d-c1f3-085a4d43ce09@buaa.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2023 12:35:25 +0800 Xinyu Liu wrote:
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system 
> in Linux 6.2

Sorry this is independent from your report.
Why are you fuzzing 6.2? It's end of life. Even 6.3 is at this point.
Please use latest kernels in your testing.
