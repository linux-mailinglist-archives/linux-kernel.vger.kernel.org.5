Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651C7F8F7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 22:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKYV23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 16:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYV21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 16:28:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F3A8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 13:28:33 -0800 (PST)
Received: from letrec.thunk.org ([50.233.158.190])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3APLSSc5012771
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Nov 2023 16:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1700947709; bh=OXQ/kkY1gBTgy+MW+6mAZuijFYVhpY+CzVvVMyOK0yc=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=PATxOBnqfFChA383KP+Hiz9l+tS3ZJw7PfD3pU7IMjyhkVAo0MSevqq0pUJSZYo4N
         y7+0qvgVb+2+sqOkBR31dEiyS6pVF/YVMQZA5tXbzgvHshVJ+QoYoMph3RAalnukMS
         gMw6jgf2dA4ROujYzmkUoxTYODx1D+OQEVECtiY8fmCvMJ39IN3WNCZpAviUH+QW9e
         fDle9eA6KgnynsLlLZXI1morjDd13+VQwQfshOBuh0GtKUsq985PJ0fPxqr2A1pWCr
         yZoorN3Lblmx05wkZVaPd0h0F7DgjarJlWagBm1MRF21nrtBUVMjlD+eJt+uDsqQhG
         f72WFv3YGQVhQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A21648C019B; Sat, 25 Nov 2023 16:28:27 -0500 (EST)
Date:   Sat, 25 Nov 2023 16:28:27 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Aaron Gray <aaronngray.lists@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can we please have a major fork of Linux into a modern and
 legacy versions ?
Message-ID: <ZWJm-6elPNNtbNI5@mit.edu>
References: <CANkmNDcCX+UwbEjy8Ly7jav9sA=Wark7xFEFdhX-KuR6uOkp-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkmNDcCX+UwbEjy8Ly7jav9sA=Wark7xFEFdhX-KuR6uOkp-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 08:30:01PM +0000, Aaron Gray wrote:
> I hear Linux is going to drop a lot of legacy devices including the
> ones dropped already. I am wondering if we can please have a major
> fork of Linux into a modern and legacy versions ?
> 
> With a consolidation and security updates to the older version.

If someone wants to take an LTS kernel and volunteer to maintain it,
including cherrypicking security updates, and making sure that fixes
in core subsystems don't cause some of these legacy drivers to break,
anyone can create such a fork.

These things don't come for free though, and if you can't find a set
of volunteers to do the work to maintain such a fork, maybe that's a
good hint as to why such a fork hasn't happened.  Of course, if you
are willing to provide all of that work yourself, that would be great!

Cheers,

						- Ted
