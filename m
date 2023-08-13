Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707BB77A470
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 02:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjHMA5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 20:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHMA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 20:57:16 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40411706;
        Sat, 12 Aug 2023 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=GwNvcGCEu2wb+suTa9T22xUCaBCAWRmXtJQNZV9bEc8=; b=rGyupDRGsS+yvbfuxEnQ4FQ3rX
        zs01jy5w5+/8V7nuNCZvI3bh7Av2rmpnD3rRwR9n+3WkdIGolhEmE+gpoFjqzdg5Vt9TqG+DgAojQ
        K2jTugw69dKO1AFb/SaFVPx9dJKOwrDVo8EmRbyWpiZmtUwxL9aAL+su2RMoOTLnbC5j9rrGRN3H+
        LifIzeBt8t+BeRH7fOUFXxBY+Xo9tPILUb7J6L7a6CjDsA4Sd+1nagYguZVp5jQkpt744z8WTgG+/
        W4EzRhRdszNL/dUqKkjQ2K1OOAUa4RIYxo9o+KPPYkD8PpaIHAtuGpKUREOkquiLEUqKWvH6PLd4j
        U5oCWvrg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qUzPp-006b9Z-V5; Sun, 13 Aug 2023 00:57:09 +0000
Date:   Sun, 13 Aug 2023 00:57:09 +0000
From:   "Dr. David Alan Gilbert" <dave@treblig.org>
To:     Paulo Alcantara <pc@manguebit.com>, smfrench@gmail.com
Cc:     Tom Talpey <tom@talpey.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linkinjeon@kernel.org, shaggy@kernel.org,
        linux-cifs@vger.kernel.org, krisman@collabora.com,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Message-ID: <ZNgqZRZNgN8JdiL4@gallifrey>
References: <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
 <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
 <ZLrxYzGXJzsLmGDs@gallifrey>
 <16f50dff126af9b20f9b99ca056ad5fa.pc@manguebit.com>
 <ZLr0wFMKhEaannov@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZLr0wFMKhEaannov@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 00:57:00 up 37 days, 10:28,  1 user,  load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dr. David Alan Gilbert (dave@treblig.org) wrote:
> * Paulo Alcantara (pc@manguebit.com) wrote:
> > "Dr. David Alan Gilbert" <linux@treblig.org> writes:
> > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n3737
> > > 	if ($realfile =~ /\.(h|s|S)$/) {
> > > 		$comment = '/*';
> > > 	} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
> > > 		$comment = '//';
> > >
> > > I don't get where that idea came from.
> > 
> > Check Documentation/process/license-rules.rst.
> 
> Oh, that's a painful history!
> Hmm that landed just after I posted a v3 (of just this patch)
> 
> Steve: Your call, do you want me to post a v4 with that comment
> back and but with the copyright lineas as in v3?

I've posted the v4.

Dave

> Dave
> 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
