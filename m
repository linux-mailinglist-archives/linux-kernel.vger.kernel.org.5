Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A4781B95
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHTAKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHTAKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:16 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD56A15F3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 13:11:22 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSqd45DXRz47;
        Sat, 19 Aug 2023 22:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692475881; bh=OpJ1uI/Ps7DSUFxIPTF35Q0TVt1dn8fJ32llb63Es78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rP9734H2eiOO9+Ex+Hw3QD7Li+kNF0UPGSjsKYGs2M7DvwMvs+GB0F06/i2F7DSGg
         HRLFMOXSwAqZVA6u0jrkEnmY2kJwdAkn15UjbaOszsPNqsbESkabK4TSMRSI83kcZz
         s21tX81cnsGhIFdWYVUs2/gvaXg22vD8EvwOC6n9Esb8QI/551NQvXJstRjooOcFQ4
         jlD5tQpnbvOBJwbY1A8mYRr1aCOgfA6GBNGaEZIydWw5TWpC7yjdiB7RDhT4GVn+b7
         Ul13K73Rc8mXTllj02PHJHoRZvxM5fC2fNL64UogaUntmtKXt/I1vpaTDmKTHbS0jX
         UbijjNEqmquRA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 19 Aug 2023 22:11:19 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: simplify nested locking
Message-ID: <ZOEh591udUYSJiGY@qmqm.qmqm.pl>
References: <30323316714bfa0b8f8d4b82b438a579b418b904.1692298249.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30323316714bfa0b8f8d4b82b438a579b418b904.1692298249.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 08:52:05PM +0200, Micha³ Miros³aw wrote:
> Simplify regulator locking by removing locking around locking. rdev->ref
> is now accessed only when the lock is taken.
> 
> This patch depends on 12235da8c80a ("kernel/locking: Add context to
> ww_mutex_trylock()").

Please ignore for now: this somehow works with DEBUG_LOCK_ALLOC, but
fails without it. I'll post an extracted simplification part of the code
to have it easier to review.

Best Regards
Micha³ Miros³aw
