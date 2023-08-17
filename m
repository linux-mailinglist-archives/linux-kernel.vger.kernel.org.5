Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9809677F203
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbjHQIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348857AbjHQIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:22:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B9273F;
        Thu, 17 Aug 2023 01:22:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 37476210EF;
        Thu, 17 Aug 2023 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692260567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EGH713J2ziKAzyOkNilfz8/zPpxaQhAAZH84cXzWBY=;
        b=GQPbqN9EFWWPst1KJI7D0F/Yeit9yvIgs7hrfY5W47tsQMIGsiSXSegD8Zd2ErGDwZSKxB
        FYQh5CcGGt5tjOQ1QXR8/Jry4v8lrgLAYxmKzakrXoXp6gEMGP80VPGXdBvUvjD9FbDBqj
        MiyVMFQUYx2faFRNP+SP3Nuv3abj76o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692260567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EGH713J2ziKAzyOkNilfz8/zPpxaQhAAZH84cXzWBY=;
        b=30M/TwPol8ZLihjY3EvQgBq3Jthr1rYi3i6qzFeR2RfZuRsXwUmGcDjRa2eOhbHgw7WnbI
        TEeUxL9ZuYlJf7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 253A91392B;
        Thu, 17 Aug 2023 08:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9AiCNfY3WQoUwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:22:47 +0000
Date:   Thu, 17 Aug 2023 10:22:57 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 00/12] Switch to allowed_host
Message-ID: <wko3lfszmhyczqav7bks5cb2bsttfnq3uhjrqk44ayahtfozvs@s3ug7d7jnhor>
References: <20230810111317.25273-1-dwagner@suse.de>
 <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
 <2u7xe3szftmoeicayxahqt6r44lgkwl6owvmlkjpby4mqvu6hh@pq2gfkgw6p6e>
 <glfjkah5e54ymq75lp46akttuqrsccigb445nchcpe4ahixzxk@5al3wjxify5d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glfjkah5e54ymq75lp46akttuqrsccigb445nchcpe4ahixzxk@5al3wjxify5d>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:55:25AM +0000, Shinichiro Kawasaki wrote:
> On Aug 11, 2023 / 09:00, Daniel Wagner wrote:
> [...]
> > BTW, what do you think about removing nvme/006 and nvme/007? They are
> > basically doing nothing anymore except setting up a target with either
> > device or file backing. We exercise this code now in all the other
> > tests. So this is bit redundant IMO.
> 
> I think the test cases are meaningful. They confirm that target set up feature
> is working good. When other test cases fail, we can refer nvme/006 and nvme/007
> results and see if the failure cause is in target set up or not.

Fair enough. If I want to cut execution time I can just exclude those
test from the run.
