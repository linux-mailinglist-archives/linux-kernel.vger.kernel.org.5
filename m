Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364C75D63E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGUVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGUVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:13:20 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319573A82;
        Fri, 21 Jul 2023 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=lcJTNqRfG0mUbBpf0GldfJX03xDDVNXhUA/82mJ4Hcg=; b=d7E64/U87yqqjVZQBCQCP4nAVj
        ErluQYoVQC0B/tpxx2WHgIozt2fE4m9D63syItC0OFFoiO1UvggtjLuM9obFGHU9WQQYrogvaj82/
        CiiuPUTdlmyqEliHZoG7uKf+FcAiouez0a3vjPIuhUlb626mrSMFIH0+NxAc0JpyYWY9PoEnBGCoT
        2N9Mo40i1aJzIN6F7qVMG4Cm/Iz7K8PIENPZSBzcM1N6OVI3hNwtPH8QG5ElQ5l79DpCAnjcctEBP
        rF+ux/dp/YLUZUHJkEmG9NZw0Bdmr5rmG76p5DaZ72+ffJRZ4jW6GzXnPacMAM5MKva9I6TzwI3Nw
        wcBr8Gjg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qMxQO-002dYJ-BL; Fri, 21 Jul 2023 21:12:32 +0000
Date:   Fri, 21 Jul 2023 21:12:32 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Paulo Alcantara <pc@manguebit.com>, smfrench@gmail.com
Cc:     Tom Talpey <tom@talpey.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linkinjeon@kernel.org, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Message-ID: <ZLr0wFMKhEaannov@gallifrey>
References: <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
 <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
 <ZLrxYzGXJzsLmGDs@gallifrey>
 <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 21:11:06 up 15 days,  6:42,  1 user,  load average: 0.06, 0.01, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paulo Alcantara (pc@manguebit.com) wrote:
> "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n3737
> > 	if ($realfile =~ /\.(h|s|S)$/) {
> > 		$comment = '/*';
> > 	} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
> > 		$comment = '//';
> >
> > I don't get where that idea came from.
> 
> Check Documentation/process/license-rules.rst.

Oh, that's a painful history!
Hmm that landed just after I posted a v3 (of just this patch)

Steve: Your call, do you want me to post a v4 with that comment
back and but with the copyright lineas as in v3?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
