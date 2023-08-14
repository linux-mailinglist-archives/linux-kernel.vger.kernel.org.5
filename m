Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A057B77C0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjHNTmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjHNTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC11703
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A61960B20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBD5C433C8;
        Mon, 14 Aug 2023 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692042102;
        bh=zl2aOJRJj+dpNouyUBlstVWJhNFR00w6HUQepUo3LMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XB+yj6dlB9Qk23gj4kugltY4YQy2EidoUs9/GiEPgfKHj5zM1ZxbvsygeLYzpwo2I
         MUsxiYfLEIxBte4o3Ay5Ij+c4Rcoyu+px3iVF0WJKvpz4s3SN1syMJp14CJZqfTuEY
         naFJAoUsPVkuEt0T9q03olPmGqT1S4BU+pyI3JQj9e2+Tg5FYafFS1Hw1Rmjc+elHV
         JQF5eP5VQHQwWgmd0kQeaL5K4k3v9Kqnhdw9wBHbKwvIWMhtHZbbtt1HpvP2BrvCBI
         Y+HHBsfC9jprOyiOmjug5fHnR4NNl+jecbaHl1oozpaAQN947Yik8y4Sk8zJWp29YH
         svicVnDL2NsDw==
Date:   Mon, 14 Aug 2023 12:41:40 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: Re: [PATCH v2 06/11] x86/cpu: Rename original retbleed methods
Message-ID: <20230814194140.xcehjmyt5bkzgeui@treble>
References: <20230814114426.057251214@infradead.org>
 <20230814121148.909378169@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814121148.909378169@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 01:44:32PM +0200, Peter Zijlstra wrote:
> Rename the original retbleed return thunk and untrain_ret to
> retbleed_return_thunk and retbleed_untrain_ret.
> 
> Andrew wants to call this btc_*, do we have a poll?

It should stay retbleed because:

1) It doesn't mitigate all possible manifestations of BTC.  It only
   mitigates BTC-RET, aka AMD "retbleed".

2) It should match the naming of the user interfaces which aren't going
   to change at this point.

-- 
Josh
