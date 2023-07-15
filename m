Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464EE754BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGOUOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGOUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 16:14:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8250C2707
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 13:14:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57D5C19715F;
        Sat, 15 Jul 2023 16:14:06 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=ErKe1gdZ84QYC6a109T7x1Vj9nyshpXprrRzxN5
        EghI=; b=Sv5f0xIGUdtMhOV+CQAPEXbQvpsY7v0qx2qM/5mEjsjHlpNwhZd6Wvm
        CEj8g8UnGQCmtR+uinqn7V2ZKU7UyP6Kd+Uh8JmeiQKy5QhYnOXO5g4a1bS5/Pj3
        V7E+Ru4OVYa3ZHTI7JrbdxHJF9FDzrPamLI+ewZ2D20F/RS+pmcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CCCA19715D;
        Sat, 15 Jul 2023 16:14:06 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=2019-09.pbsmtp; bh=ErKe1gdZ84QYC6a109T7x1Vj9nyshpXprrRzxN5EghI=; b=L2AC7SWM6+4oq3ipcezJMBS8keCGxvAb2gEXdezPULhaVzELS2mpOQpDSdNyreCpUN7iX5fAc59P14y2wuvoArFoBXl7MxAce26lbTURJPTWzZ6ygcJ5Gj6dHChyQI+LyJFwwZibbYlHtnaQFKwynZ1IiLjeykWBX0xffRxSIrs=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8DA4A19715A;
        Sat, 15 Jul 2023 16:14:04 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Sat, 15 Jul 2023 13:14:59 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, dan.carpenter@linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Message-ID: <ZLL+Q0tcW5S8Xjmj@basil>
References: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
 <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com>
X-Pobox-Relay-ID: 2599DF7A-234C-11EE-943F-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 10:48:56PM +0200, Philipp Hortmann wrote:
> On 7/6/23 03:59, Tree Davies wrote:
> > This patch renames variable bCurrentHTSupport to bcurrent_ht_support
> > to fix checkpatch warning Avoid CamelCase.
> > 
> > Signed-off-by: Tree Davies<tdavies@darkphysics.net>
> > ---
> >   drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
> >   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
> >   drivers/staging/rtl8192e/rtl819x_BAProc.c    | 12 ++++++------
> >   drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
> >   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
> >   drivers/staging/rtl8192e/rtllib_softmac.c    | 16 ++++++++--------
> >   drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
> >   drivers/staging/rtl8192e/rtllib_tx.c         |  8 ++++----
> >   8 files changed, 30 insertions(+), 30 deletions(-)
> 
> 
> Hi Tree,
> 
> when I try to apply your patch on the top of all the other patches I get the
> following error message:
> 
> kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply -v
> ~/Downloads/20230706-\[PATCH\]\ staging_\ rtl8192e_\ Rename\ variable\
> bCurrentHTSupport-10002.txt
> Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_core.c...
> Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_wx.c...
> Checking patch drivers/staging/rtl8192e/rtl819x_BAProc.c...
> Checking patch drivers/staging/rtl8192e/rtl819x_HT.h...
> Checking patch drivers/staging/rtl8192e/rtl819x_HTProc.c...
> Checking patch drivers/staging/rtl8192e/rtllib_softmac.c...
> error: while searching for:
> 	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
> 	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
> 		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
> 	if (ieee->ht_info->bCurrentHTSupport) {
> 		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
> 		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
> 		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);
> 
> error: patch failed: drivers/staging/rtl8192e/rtllib_softmac.c:816
> error: drivers/staging/rtl8192e/rtllib_softmac.c: patch does not apply
> Checking patch drivers/staging/rtl8192e/rtllib_softmac_wx.c...
> Checking patch drivers/staging/rtl8192e/rtllib_tx.c...
> 
> 
> My be the previous send patches are not taken then your chance is better
> that this one will fit. Will see what happens.
> 
> 
> You need to put your patches into a patch series.
> This reduces email traffic as the reviewer can just send one email and does
> not need to send four.
> 
> A possible command for a patch series is looking like this:
> git format-patch -o ~/Documents/kernel/patches/ --cover-letter -n
> --thread=shallow --to="Greg Kroah-Hartman <gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org"
> 4bbbd60d84e15fdb7bffde98a687ed168a4dfbbd^..HEAD
> 
> Use the git commit id of your first patch.
> 
> Bye Philipp
> 
> 

Philipp,

I think I understand what I did wrong. Each of these original patches were 
created/based from the same commit hash. So it makes sense that only the
first one applied would apply cleanly and the others would fail. 

My apologies,
Tree

 
