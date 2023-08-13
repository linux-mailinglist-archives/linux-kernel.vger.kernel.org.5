Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5794B77A561
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjHMHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 03:19:01 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FD1700;
        Sun, 13 Aug 2023 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691911141;
        bh=qvwZl3SzPyq12X60teQWoMKD8MU6AleDgJKWdPlqzYU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=TJmI0DNF3xSajleCa6lO1rh5Xsr19ieJRpN3PQRSjAHXUsE2IglNIMe6lRLCOxsj/
         DG0aZUjjJ02Wmjj0xIvt88k2n5XPHqXXYCVKwVWZ+QPtOlb74cg5T/3qwbNuoTbOoY
         hU3iO92tEAtXWCLm7s24UudH7XHxO+VrT/O6lIb8=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 488041281BF5;
        Sun, 13 Aug 2023 03:19:01 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id wTdblXev8Yjr; Sun, 13 Aug 2023 03:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691911141;
        bh=qvwZl3SzPyq12X60teQWoMKD8MU6AleDgJKWdPlqzYU=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=TJmI0DNF3xSajleCa6lO1rh5Xsr19ieJRpN3PQRSjAHXUsE2IglNIMe6lRLCOxsj/
         DG0aZUjjJ02Wmjj0xIvt88k2n5XPHqXXYCVKwVWZ+QPtOlb74cg5T/3qwbNuoTbOoY
         hU3iO92tEAtXWCLm7s24UudH7XHxO+VrT/O6lIb8=
Received: from [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c] (unknown [IPv6:2a00:23c8:1005:a801:e95:68ca:9caa:7c8c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DDA001281B8F;
        Sun, 13 Aug 2023 03:18:59 -0400 (EDT)
Message-ID: <23b17fee21dd289d5508c8a3ef7b7f1f462cbdd1.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc5
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 13 Aug 2023 08:18:56 +0100
In-Reply-To: <CAHk-=whk-PxHDjEe_kNN-ZANc032cnYTd9unO8OBQqUq6C6fqw@mail.gmail.com>
References: <4987ff9fa2467bc036759afac47b95c77a415963.camel@HansenPartnership.com>
         <CAHk-=whk-PxHDjEe_kNN-ZANc032cnYTd9unO8OBQqUq6C6fqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-08-12 at 08:32 -0700, Linus Torvalds wrote:
> On Fri, 11 Aug 2023 at 23:45, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > 
> > The short changelog is:
> 
> Hmm. Neither the shortlog nor the diffstat matches what I get, and
> you also have a non-standard truncated pull-request format that
> doesn't even show the expected top commit etc, so I think I'll just
> unpull and wait for you to actually verify what you sent me and make
> a new pull request that matches what the git contents are..

Hm, yes, in my haste to get away on holiday, I thought I'd sent one
more pull request than I actually had and got the wrong merge base
which missed about four commits.  I'll resend with the correct
information, sorry about that.

Regards,

James

