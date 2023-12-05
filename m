Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6A805F0C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbjLEUFk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 15:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjLEUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:05:38 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40559196
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:05:44 -0800 (PST)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 096BE1A024F;
        Tue,  5 Dec 2023 20:05:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id E0B1520027;
        Tue,  5 Dec 2023 20:05:38 +0000 (UTC)
Message-ID: <7c353e1ba4025dfce4c4789033f5779c4371f048.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Also accept commit ids with 13-40 chars of
 sha1
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Simon Horman <horms@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, linux-kernel@vger.kernel.org
Date:   Tue, 05 Dec 2023 12:05:37 -0800
In-Reply-To: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
References: <62f82b0308de05f5aab913392049af15d53c777d.1701804489.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: E0B1520027
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Stat-Signature: e6d87maxwpxabitsw7e46awgdw54fx9b
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19FuZwpzAmxTGY9e0DrTuJ5SeKve/kl90Y=
X-HE-Tag: 1701806738-979379
X-HE-Meta: U2FsdGVkX182IRRhXQpBruauMyC0eCZ3uyo6lPDSXQwdOiW+pyLH5CSUdnS+Dt5RjztYbuGZZltvZOw4NSzRhM/a8Cy5Ud8g48dFZIu1zgMqXIwG4MIaRz2hiNoCEXjVVJJtScqYnft1LQdgH1kgtB+c+8RBiY3XfB4E3Chv6ANt9T56pfcjIpnWei0cxDKGuTH+l/ZlARDWAYUaGLWLsRi7sLmv4F6NxMqXpurJ+ODC16sXUMc4zyw33DjojycMYjGzJ9HzW61M6jgF0gWjZWaTq12A81/LqbHbhKzSQALWERI10ipK8YHJ4cGQpN/m
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-05 at 20:34 +0100, Geert Uytterhoeven wrote:
> Documentation/dev-tools/checkpatch.rst says:
> 
>   **GIT_COMMIT_ID**
>     The proper way to reference a commit id is:
>     commit <12+ chars of sha1> ("<title line>")

It's not just checkpatch.

Documentation/process/submitting-patches.rst:``git bisect``, please use the 'Fixes:' tag with the first 12 characters of


So that would need to be updated as well.

And 12 still has quite some headroom.

$ git rev-list --all --abbrev=0 --abbrev-commit | \
  awk '{ a[length] += 1 } END { for (len in a) print len, a[len] }'
5 107
6 684276
7 505734
8 41769
9 2665
10 174
11 8


