Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF487C46E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344552AbjJKAyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:54:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31C8F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:54:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DCC433C8;
        Wed, 11 Oct 2023 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696985683;
        bh=0H4iRVCJQWGz61Tmn2yBFyuOebfIUuGff1Pt5wvl8yQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cvUFTAbx2/KN98oDPIvh9DGkRgRIbMXADOBHzGo+2U3qjgAozV7EpZSxuBtsc5jZ7
         cSqIONfcgAzTs85Ws4XS7bchxVLjz704w0sCbiqMoMSGrlb7Q16kRN2xnWWL3F28a9
         fAUwCILxx/NfB0JaudWnkpxCyVITNWn+o2RuBHb9rfc6pqcIGl3LhcFsbUjswN2t+z
         eiIIGp1pD6KLueDKpP1iOUT1XMKMHb2sdJN6kd/jWlDCojSfA8ev/KatXJJw4Bkl2S
         +iZeldSxJSaIDdZXw1izRBoYF3t4mcoZuy4pMXjAidbrQ3+6sN1Pi563lNPNIV1qNy
         jc3OCKhj1svaQ==
Date:   Tue, 10 Oct 2023 17:54:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Message-ID: <20231010175441.755cb82a@kernel.org>
In-Reply-To: <20231010174731.3a1d454e@kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
        <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
        <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
        <20231010174731.3a1d454e@kernel.org>
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

On Tue, 10 Oct 2023 17:47:31 -0700 Jakub Kicinski wrote:
> Please do read the netdev rules Jesse pointed you at.
> Maybe it's the combined flow of strncpy and __counted_by patches
> but managing the state of the "hardening" patches is getting 
> a bit tedious :(
> 
> Please group them into reasonable series. Do not repost withing 24h.
> Do not have more than 15 patches for networking pending at any given
> time. That's basically the gist of our "good citizen" rules.

FWIW you can see how many pending patches you have pending in netdev
using this here link:

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=206354
