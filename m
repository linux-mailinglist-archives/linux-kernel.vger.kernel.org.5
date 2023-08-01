Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6C76BE77
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjHAU3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjHAU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5457E45
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5DC616F2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 20:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF19C433C8;
        Tue,  1 Aug 2023 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690921756;
        bh=p+7E/WM0NDbhkT9TKeC9SNk+BVr0nurH4zEykwDbelQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XE6BjJp76eN2scRQ4ZgWTyi4mmDNPtMWf1s/Eu3jEi49VoMtTWf2NC9wZbJJl/zEn
         bk4j1MRrY8D+r0wRfuCE7vprO25GWfwhKa9YzlM4hoGGAmxyXYoJDAYqRFmn9an/QY
         7bxQ9n+46AkRCW+n7LHUHRQnfS1hRh4Ia7cl0iTqs89//Ge+sPtBkGZgR5FjyvR0Nn
         j6iI0Pf3ZBKNOsmu5QtZTVcN1shgx1pdAmKAsvnHse7Ycll5/dql7g3P/uReBxNsuv
         WkGijE12KZl7iF3HITwJkAE/pswqInX3x5i3JB4Vj5huRPlgvi2ZwBnbJlgrD+Lg7/
         YwE/lS22+gKFw==
Date:   Tue, 1 Aug 2023 14:29:12 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        August Wikerfors <git@augustwikerfors.se>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZMlrGNw5OMW3yxId@kbusch-mbp.dhcp.thefacebook.com>
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
 <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
 <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com>
 <20230731201047.GA14034@lst.de>
 <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
 <20230801112403.GA3972@lst.de>
 <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7fb9b2-d692-f9b8-5130-4555cc489846@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 06:30:52AM -0500, Mario Limonciello wrote:
> 
> Do you want that re-sent?  Or can you just pick up from that lore link?

I got it, and applied to nvme-6.5 now.
