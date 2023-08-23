Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63ED785502
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjHWKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjHWIVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D9A1707;
        Wed, 23 Aug 2023 01:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF9E96214F;
        Wed, 23 Aug 2023 08:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C03C433C8;
        Wed, 23 Aug 2023 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692778548;
        bh=f7/tnL/CYJkwKNLcLrlquf8W0oqouUPAZbxzQF2xWrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K29YbCvSIvPIqrCKyzF6IAffEdlYbhbCNNjtIERAkM39WOwz/obWYbhEcPuC8WYTw
         IRvra7Xt1BozBNGXoyiLEp4yBZFEMiH4plosQCODwPjZApgakAChJ4c9p2Hu+sI5VE
         JP8V0gaTauWxvLnx2Ti8GdmxbTFgmQMdp8kAW7RQ=
Date:   Wed, 23 Aug 2023 10:15:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023082333-unruly-explode-9ee8@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
 <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
 <2023082247-synthesis-revenge-470d@gregkh>
 <87a5uiw5x4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5uiw5x4.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:53:43AM +0300, Kalle Valo wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
> >> So I wonder if the right answer is to put it in drivers/net/wireless
> >> initially and if we come up with a need later for non wifi producers we can
> >> discuss moving it at that time.
> >
> > Please do so.
> 
> Sorry, I haven't been able to follow the discussion in detail but just a
> quick comment: if there's supposed to be code which is shared with
> different wifi drivers then drivers/net/wireless sounds wrong,
> net/wireless or net/mac80211 would be more approriate location.

That's fine with me as well, just not drivers/core/ please :)

thanks,

greg k-h
