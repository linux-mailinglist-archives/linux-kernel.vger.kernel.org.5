Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6977DD54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbjHPJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbjHPJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:31:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1B26A1;
        Wed, 16 Aug 2023 02:31:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7D692191A;
        Wed, 16 Aug 2023 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692178297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sKyG7pmNqgi6eGz+JdQnSC3feV2UCUViK6Z12J6spo=;
        b=WZ4PRyHOlZ2TgjYP+EDYWHzP2I1VGz0nPyOBLVnX09XlvQUrNqGoN1VFpVE1cBvzTXPt9a
        9MbT3acHM6OysITkLAInhE8YwJsl4EEKyGTG/BTapu66or6dhtCFTI9FkCds77mAgcabRo
        0pgDRxM0zS4ee70PhrVK1+8sBUM4bd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692178297;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6sKyG7pmNqgi6eGz+JdQnSC3feV2UCUViK6Z12J6spo=;
        b=aSwtdCnQ4/CNaHi+iCBy4oLJWfpXKwLzE7fThb5aa6MLdqHdXVGY8HgbUIiXTO01J0G65h
        WiSJs4V6huUnARDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0215133F2;
        Wed, 16 Aug 2023 09:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GKQRK3mX3GSNTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 16 Aug 2023 09:31:37 +0000
Date:   Wed, 16 Aug 2023 11:31:46 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Message-ID: <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2023 at 05:59:53PM +0300, Sagi Grimberg wrote:
> 
> > Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
> > make sure we do not leak resources when something goes wrong. I run into this
> > while testing and all tests after the first failure failed then.
> 
> The name of the patch series suggest that it switches to allowed_hosts
> where it does that in 2 patches 11+12 out of 13 patches. The rest are
> just bug fixes and unifications. It's true that any series will include
> fixes, cleanups and prep patches, but this is too far :)

I see your point. The whole series started smaller, but just grew over
time. I suppose if we agree with the general direction we could just get
the first part done (bug fixes and refactoring).

> I'll let Shinichiro accept as he wish though.

I am fine either way, just let me know what you prefer.

> The cleanups look fine to me.

Thanks for reviewing!
