Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D97F2E59
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjKUNcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjKUNcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:32:00 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1F2D4B;
        Tue, 21 Nov 2023 05:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700573514;
        bh=i0wLYaOPYdVNi/v8GJrh3T7Dl41RZhrj0CgcZP50xAU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tifmBJA9e2vKpjaPCnsvZmYUlQXcc4X3MAtoLBLFfhMVUCNfwERzt2iy5Aju1UAVT
         /5/hflHF8goV30slXpz+FHTI+F57II+L/RNI4uw2S9HmLsxh9ByQwY8PwhftmBOVth
         Xj31fgSUjmrQjynKsIfaUZS43flEESPZQ1xxz0ho=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EFCF11286B89;
        Tue, 21 Nov 2023 08:31:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id us5JTmT0cmzc; Tue, 21 Nov 2023 08:31:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700573514;
        bh=i0wLYaOPYdVNi/v8GJrh3T7Dl41RZhrj0CgcZP50xAU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=tifmBJA9e2vKpjaPCnsvZmYUlQXcc4X3MAtoLBLFfhMVUCNfwERzt2iy5Aju1UAVT
         /5/hflHF8goV30slXpz+FHTI+F57II+L/RNI4uw2S9HmLsxh9ByQwY8PwhftmBOVth
         Xj31fgSUjmrQjynKsIfaUZS43flEESPZQ1xxz0ho=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 524AC1286B29;
        Tue, 21 Nov 2023 08:31:53 -0500 (EST)
Message-ID: <c4342441ddd27d587af3805dd9de882ee0b5cfd0.camel@HansenPartnership.com>
Subject: Re: scsi regression that after months is still not addressed and
 now bothering 6.1.y users, too
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        John Garry <john.g.garry@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>
Date:   Tue, 21 Nov 2023 08:31:48 -0500
In-Reply-To: <fe89fd29-562c-46c0-9a15-e3a5c43da9a1@leemhuis.info>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
         <47e8fd80-3f87-4b87-a875-035e69961392@oracle.com>
         <a3ddbd03-7a94-4b6a-9be1-b268ce883551@leemhuis.info>
         <18b3745d3e5de2ffd9b74f9cc826c2c3235dc6ca.camel@HansenPartnership.com>
         <fe89fd29-562c-46c0-9a15-e3a5c43da9a1@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-21 at 14:24 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
> On 21.11.23 14:05, James Bottomley wrote:
> > On Tue, 2023-11-21 at 13:24 +0100, Linux regression tracking
> > (Thorsten
> > Leemhuis) wrote:
> > > On 21.11.23 12:30, John Garry wrote:
> > [...]
> > > > Is there a full kernel log for this hanging system?
> > > > I can only see snippets in the ticket.
> > > > And what does /sys/class/scsi_host/host*/nr_hw_queues show?
> > > 
> > > Sorry, I'm just the man-in-the-middle: you need to ask in the
> > > ticket, as  the privacy policy for bugzilla.kernel.org does not
> > > allow to CC the reporters from the ticket here without their
> > > consent.
> > 
> > How did you arrive at that conclusion?
> 
> To quote https://bugzilla.kernel.org/createaccount.cgi:
> """
> Note that your email address will never be displayed to logged out
> users. Only registered users will be able to see it.
> """

OK, so someone needs to update that to reflect reality.

> Not sure since when it's there. Maybe it was added due to EU GDPR?
> Konstantin should know. But for me that's enough to not CC people. I
> even heard from one well known kernel developer that his company got
> a
> GDPR complaint because he had mentioning the reporters name and email
> address in a Reported-by: tag.
> 
> Side note: bugbot afaics can solve the initial problem (e.g. interact
> with reporters in bugzilla by mail without exposing their email
> address). But to use bugbot one *afaik* still has to reassign a
> ticket to a specific product and component in bugzilla. Some
> subsystem maintainers don't want that, as that issues then does not
> show up in the usual queries.

I'm not sure we need to solve a problem that doesn't exist. Switching
to email is a standard maintainer response:

https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
https://lore.kernel.org/all/20230314144145.07a3e680362eb77061fe6d0e@linux-foundation.org/
...

James

