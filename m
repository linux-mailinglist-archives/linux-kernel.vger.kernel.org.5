Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895B75B80D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGTTeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjGTTeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:34:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D779272C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:34:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF6FC61C28
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A2AC433C8;
        Thu, 20 Jul 2023 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689881650;
        bh=x9POu8nwpWCKsGKV4M4myOjDZLVHqsNlbAI0nik7MCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMTrufQ7wxYDKV4rmIASHji8yUu38DYaDuCIMA/01Xuhj74f3ZtP4EbafcszbxHLB
         wgqSSpFL3YmuDyDhtkZAwLhXe6FxCBL1zvNMBjX/GqsNizTak74niDlOWzgdc3NdRF
         m1Bn6pcaxcb/lZMUbijy9YMdR7+23dFKgRvOsxh4=
Date:   Thu, 20 Jul 2023 21:34:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tree Davies <tdavies@darkphysics.net>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Message-ID: <2023072048-skewed-demise-a536@gregkh>
References: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
 <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com>
 <ZLL+Q0tcW5S8Xjmj@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLL+Q0tcW5S8Xjmj@basil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2023 at 01:14:59PM -0700, Tree Davies wrote:
> On Thu, Jul 06, 2023 at 10:48:56PM +0200, Philipp Hortmann wrote:
> > On 7/6/23 03:59, Tree Davies wrote:
> > > This patch renames variable bCurrentHTSupport to bcurrent_ht_support
> > > to fix checkpatch warning Avoid CamelCase.
> > > 
> > > Signed-off-by: Tree Davies<tdavies@darkphysics.net>
> > > ---
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
> > >   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
> > >   drivers/staging/rtl8192e/rtl819x_BAProc.c    | 12 ++++++------
> > >   drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
> > >   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
> > >   drivers/staging/rtl8192e/rtllib_softmac.c    | 16 ++++++++--------
> > >   drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
> > >   drivers/staging/rtl8192e/rtllib_tx.c         |  8 ++++----
> > >   8 files changed, 30 insertions(+), 30 deletions(-)
> > 
> > 
> > Hi Tree,
> > 
> > when I try to apply your patch on the top of all the other patches I get the
> > following error message:
> > 
> > kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply -v
> > ~/Downloads/20230706-\[PATCH\]\ staging_\ rtl8192e_\ Rename\ variable\
> > bCurrentHTSupport-10002.txt
> > Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_core.c...
> > Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_wx.c...
> > Checking patch drivers/staging/rtl8192e/rtl819x_BAProc.c...
> > Checking patch drivers/staging/rtl8192e/rtl819x_HT.h...
> > Checking patch drivers/staging/rtl8192e/rtl819x_HTProc.c...
> > Checking patch drivers/staging/rtl8192e/rtllib_softmac.c...
> > error: while searching for:
> > 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
> > 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
> > 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
> > 	if (ieee->ht_info->bCurrentHTSupport) {
> > 		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
> > 		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
> > 		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
> > 
> > error: patch failed: drivers/staging/rtl8192e/rtllib_softmac.c:816
> > error: drivers/staging/rtl8192e/rtllib_softmac.c: patch does not apply
> > Checking patch drivers/staging/rtl8192e/rtllib_softmac_wx.c...
> > Checking patch drivers/staging/rtl8192e/rtllib_tx.c...
> > 
> > 
> > My be the previous send patches are not taken then your chance is better
> > that this one will fit. Will see what happens.
> > 
> > 
> > You need to put your patches into a patch series.
> > This reduces email traffic as the reviewer can just send one email and does
> > not need to send four.
> > 
> > A possible command for a patch series is looking like this:
> > git format-patch -o ~/Documents/kernel/patches/ --cover-letter -n
> > --thread=shallow --to="Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org"
> > 4bbbd60d84e15fdb7bffde98a687ed168a4dfbbd^..HEAD
> > 
> > Use the git commit id of your first patch.
> > 
> > Bye Philipp
> > 
> > 
> 
> Philipp,
> 
> I think I understand what I did wrong. Each of these original patches were 
> created/based from the same commit hash. So it makes sense that only the
> first one applied would apply cleanly and the others would fail. 

Please redo them all and send them as a proper patch series.

thanks,

greg k-h
