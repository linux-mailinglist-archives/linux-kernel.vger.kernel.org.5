Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3741E803050
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343760AbjLDKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjLDKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:33:09 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25A85
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:33:15 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B9CC1F8A6;
        Mon,  4 Dec 2023 10:33:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4138D1398A;
        Mon,  4 Dec 2023 10:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id ZoffDemqbWW9VwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Mon, 04 Dec 2023 10:33:13 +0000
Date:   Mon, 4 Dec 2023 11:33:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <muchun.song@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/7] mm: shrinker: Add a .to_text() method for shrinkers
Message-ID: <ZW2q6GAanaogxCSV@tiehlicka>
References: <76A1EE85-B62C-49B3-889C-80F9A2A88040@linux.dev>
 <20231128035345.5c7yc7jnautjpfoc@moria.home.lan>
 <abd0ddd6-389c-43dc-b18f-aa5e3a4fcf5a@bytedance.com>
 <ZWaHG09fY2BYjyGD@P9FQF9L96D.corp.robot.car>
 <ZWcBDglmDKUJdwMv@tiehlicka>
 <20231129231147.7msiocerq7phxnyu@moria.home.lan>
 <ZWhEawxI1CT8stu9@tiehlicka>
 <20231201014745.b2ud4w3ymztdtctu@moria.home.lan>
 <ZWmvp5Yeb5HE1Uxo@tiehlicka>
 <20231201212506.skgzaoafi5zgi3pi@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201212506.skgzaoafi5zgi3pi@moria.home.lan>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 5B9CC1F8A6
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-12-23 16:25:06, Kent Overstreet wrote:
> On Fri, Dec 01, 2023 at 11:04:23AM +0100, Michal Hocko wrote:
> > On Thu 30-11-23 20:47:45, Kent Overstreet wrote:
> > > On Thu, Nov 30, 2023 at 09:14:35AM +0100, Michal Hocko wrote:
> > [...]
> > > > All that being said, I am with you on the fact that the oom report in
> > > > its current form could see improvements.
> > > 
> > > I'm glad we're finally in agreement on something!
> > > 
> > > If you want to share your own ideas on what could be improved and what
> > > you find useful, maybe we could find some more common ground.
> > 
> > One thing that I would consider an improvement is to have a way to
> > subscribe drivers with excessive memory consumption or those which are
> > struggling to dump their state.
> 
> Remember the memory allocation profiling patchset? The one where you
> kept complaining about "maintenancy overhead"?

Yes, I still maintain my opinion on that approach. I have never
questioned usefulness of the information.

> We can plug that into the show_mem report too, and list the top 10
> allocations by file and line number.
> 
> > Maybe your proposal can be extended that way but the crucial point is to
> > not dump all sorts of random shrinkers' state and end up with unwieldy
> > reports.  If, on the other hand, any particular shrinker struggles to
> > reclaim memory and it is sitting on a lot of memory it could be able to
> > flag itself to be involved in the dump.
> 
> Great, since as was mentioned in the original commit message it's not
> "all sorts of random shrinkers", but top 10 by objects reported, what
> I've got here should make you happy.

Can we do better and make that a shrinker decision rather than an
arbitrary top N selection? The thing is that shrinkers might even not
matter in many cases so their output would be just a balast. The number
of objects is not universaly great choice. As Dave mentioned metdata
might be pinning other objects.

That being said, if you want to give more debugability power to
shrinkers then it makes more sense to allow them to opt-in for the oom
report rather than control which of them to involve from the oom
reporting code which doesn't have enough context on its own.
-- 
Michal Hocko
SUSE Labs
