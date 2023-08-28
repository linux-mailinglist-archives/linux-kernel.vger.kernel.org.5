Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E578B287
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjH1OEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjH1ODs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:03:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103AF7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:03:45 -0700 (PDT)
Received: from letrec.thunk.org (pool-173-48-116-73.bstnma.fios.verizon.net [173.48.116.73])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37SE3EFX027429
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 10:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1693231396; bh=GiV+PLZ4PXJ5RNYN7YJy4Ypfs0e09vXf4xSw2J026BM=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=O4vevDump4c7g9IVOLwGQsDmK4z1oR4JMD8OMVwNPQ4NdsAiQqvaBAj+fqj1ANlFb
         S19kAnVRSPLaooDsMZ1YNAFv0jDXCq/tpiIazt9byap5mUErTlukDu4iifzyt6Idz4
         ctfhjY7sht4CO+DEUfiSO1hrAQrg4iVQcj7n/MsX/MqVkNwZrAup6aaINSjZZFAaOZ
         jeMgXYjEHol1SKJeDJ2v5+ahCiMq5j9g09kzC74/fevaaKyc633iTGIJMsL90JZF8I
         EKGBNnyhtLEpTjNwMN58bu87Wn+hbMmj0GudzD67E6Zrl263IPSSuSKdQx06M8bVpp
         N21MuyVygCDVw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 5A3788C0281; Mon, 28 Aug 2023 10:03:14 -0400 (EDT)
Date:   Mon, 28 Aug 2023 10:03:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andras Sebok <sebokandris2009@gmail.com>,
        linux-serial@vger.kernel.org, andriseseboke@gmail.com,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org
Subject: Re: [PATCH 1/2] Simplify sysrq help
Message-ID: <ZOypIovdqGnV6opC@mit.edu>
References: <20230828102753.4811-2-sebokandris2009@gmail.com>
 <2023082831-undefined-hut-11fd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082831-undefined-hut-11fd@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:51:38PM +0200, Greg KH wrote:
> So now the options all scroll off the screen?  Are you sure this is
> wise?  What problem are you trying to solve here, it just looks like you
> are changing one "help text format for another", and doesn't actually
> change much of anything.

Indeed, if you are using a VT console, this is a bad, Bad, BAD idea,
since there is very limited console scrollback, and this would blow
away a huge amount of useful information.  Maybe it might be useful
for novices who are using a serial console, but magic sysrq is
primarily used by experts, not by novices....

				- Ted
