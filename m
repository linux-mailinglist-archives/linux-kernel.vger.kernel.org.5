Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8EB777CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHJPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJPvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D7D19F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 913C5636CC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE67C433C8;
        Thu, 10 Aug 2023 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691682664;
        bh=1mLxM2cwBzu4CEmkaRoNn++ZOQ+dvHOMD8BKuKYi7Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LOtc26X0gHudlfZPsfmYzARQM6dXUgefeDu+UloaMVozEXo+spTAPZ006pWnm+WOu
         sAHF3v8KuruVNB58VfDLVM6Fy24KMe7Ozjq3ilks643alEKW+RJExad4HBy+5AkVAA
         /feh/E+z4e5HxhbgxSLngRSCk9b/3Ab1avAh2AE3ux4NHCeuTdXRPilAwwOVCK5Snc
         w/xLsiMcgWVs/ADwjpVxOb/P5gXe0q6qGvWONb0UpYGh4MCy1abD0lf52Ubi5s/2p4
         MZKyX2IY0pg2192tT2TamGqfh8mCNqouZFne9WRepRrlCPuTLBBF/3SK6S/YrouTFE
         kNXWvHuU36NOA==
Date:   Thu, 10 Aug 2023 08:51:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Petr Oros <poros@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "Maziarz, Kamil" <kamil.maziarz@intel.com>,
        "dawidx.wesierski@intel.com" <dawidx.wesierski@intel.com>,
        "Palczewski, Mateusz" <mateusz.palczewski@intel.com>,
        "Laba, SlawomirX" <slawomirx.laba@intel.com>,
        "Zulinski, NorbertX" <norbertx.zulinski@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH net v2 0/2] Fix VF to VM attach detach
Message-ID: <20230810085102.30b01d62@kernel.org>
In-Reply-To: <38f4dcfd-ccee-3481-a862-58b269bc0acc@intel.com>
References: <20230809151529.842798-1-poros@redhat.com>
        <38f4dcfd-ccee-3481-a862-58b269bc0acc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 14:52:33 +0200 Przemek Kitszel wrote:
> You have forgot to propagate reviewed-by tags from v1 (Simon's, Jake's, 
> mine)
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> (I'm not sure if I should copy-paste not mine RBs here?)

Not 100% sure either but most of the time I reckon it'd be a good thing.
Higher probability that we may miss a tag than that the person intended
to withdraw it. Just make sure the person who's tag you're copying is
on CC and that you add a link to where the tag was provided.
