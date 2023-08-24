Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC48786AC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjHXIwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbjHXIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83010E4;
        Thu, 24 Aug 2023 01:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DF9664785;
        Thu, 24 Aug 2023 08:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D583DC433C7;
        Thu, 24 Aug 2023 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692867138;
        bh=Cca/vEi7U8rHOsNTCfi3SJJmYuNAdDFTzCZqoo9E/Dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8Q+RBPGOKoApRKuh/5WoEWeDdBfWeIlYbG4xhQvrymPBH300Wu/ojTx2cC62yQON
         W3OlxCt6e5v1/9bEKUNGmFpp4avuquNjyCfghTXFQwMiAUhQoC16AVKlBp/0frZsUf
         7Ov+c91FYTO1S08aIpYXRg7jwL8Fia+PPEX+NZU1RcjD566/jZQrNw7YcSxJwQ9u70
         Lv/YtmvgsFh1hAbGTLofkY2yOKgS873Q/fAtdvJX57Ces6S2LM7vpSEevlNjeRrt1T
         HNlCsPJiKf+xhYdbho5mSIbCHiCObpKxDYsYrai5cClmb7gieS8aYhZxgC1Nay2s81
         QvILQaQmZkv2w==
Date:   Thu, 24 Aug 2023 10:52:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: linux-next: manual merge of the nolibc tree with the vfs-brauner
 tree
Message-ID: <20230824-randfigur-emittenten-de303734445c@brauner>
References: <20230824141008.27f7270b@canb.auug.org.au>
 <3028a552-bd75-4ded-9211-62d10768d9ea@t-8ch.de>
 <20230824-moment-wehten-5a47e319ae66@brauner>
 <26bc62c7-32c7-4ef1-b8d1-77738fa98598@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26bc62c7-32c7-4ef1-b8d1-77738fa98598@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyways Linus should also be able to resolve the conflict for v6.6 with
> a small hint in the PR.

Suprisingly, we've done this before. :)
