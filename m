Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC347A89D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjITQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjITQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67F99;
        Wed, 20 Sep 2023 09:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54B642017D;
        Wed, 20 Sep 2023 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695229020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arrJUNtqjU/izONia38ns6kqz5a2Ljs8vzyYYK7Z784=;
        b=B5zucAFR4XyR8/5tRFN24icRoW3Li46w9AYROy5fgeQHJjHHmWe1VBSTJAgJzltxBUTQfj
        A2xO9YmlmCUAHIhnO6bcsmBlTch94Tqw9Zrs2J99gUVXgRrg7N5SnwIhK/ADmsG7DqDXb5
        NyDsDzox8Vmqa0S6njAX9jt6GCL7qPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695229020;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=arrJUNtqjU/izONia38ns6kqz5a2Ljs8vzyYYK7Z784=;
        b=TEI3317KDo5yb9aq6yYTvDHKSUd5zcn5XGrWvmgB48JFj1/RVX24vTZ5l0fScD+mlAMJpN
        CaN28xdVs9HUPMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 420581333E;
        Wed, 20 Sep 2023 16:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s1QXEFwkC2UDdgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 16:57:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AE8E8A077D; Wed, 20 Sep 2023 18:56:59 +0200 (CEST)
Date:   Wed, 20 Sep 2023 18:56:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, segher@kernel.crashing.org,
        anton.ivanov@cambridgegreys.com, ink@jurassic.park.msu.ru,
        jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        richard.henderson@linaro.org, richard@nod.at,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230920165659.coe7d2lydiaatoby@quack3>
References: <20230918175529.19011-1-peter@n8pjl.ca>
 <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca>
 <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca>
 <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-09-23 18:02:39, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Tue, Sep 19, 2023 at 5:58 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
> >  2) Stops building an obsolete and largely-unused filesystem unnecessarily.
> >     Some hobbyist targets like m68k and alpha may prefer to keep all filesystems
> >     available until total removal, but others like arm and UML have no need for
> >     ReiserFS to be built unless specifically configured.
> 
> As UML is used a lot for testing, isn't it actually counter-productive
> to remove ReiserFS from the UML defconfig?  The less testing it
> receives, the higher the chance of introducing regressions.

The only testing I know about for reiserfs (besides build testing) is
syzbot. And regarding the people / bots doing filesystem testing I know
none of them uses UML. Rather it is x86 VMs these days where reiserfs is
disabled in the defconfig for a *long* time (many years). Also when you do
filesystem testing, you usually just test the few filesystems you care
about and for which you have all the tools installed. So frankly I don't
see a good reason to leave reiserfs enabled in defconfigs. But sure if
m68k or other arch wants to keep reiserfs in it's defconfig for some
consistency reasons, I'm fine with it. I just suspect that for most archs
this is just a historical reason.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
