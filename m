Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D8788F89
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjHYUIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjHYUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26912689
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580C562ACE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3D0C433C8;
        Fri, 25 Aug 2023 20:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692994085;
        bh=Kk/U/dmMoGAwG8V2JaAxMWAZikzq1aQQ5Kcmkxqbo0Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ShHCY2NA6XMECd6rTPztrAOsIwrnMbqrCHnAqyN4Ew+Sf0Iv/iRUcQNZQTS7Ovzpq
         6F1BwZsbJoUTtkiBzRsgdsPE+f/bzAqxb2SAjJWtWHX8/GZWev5ycCnV5wYtjQwjlH
         G2pACuvhCI0uUesM3fq00GvJ49ivCTY1uDe6roAw=
Date:   Fri, 25 Aug 2023 13:08:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     shakeelb@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove remnants of SPLIT_RSS_COUNTING
Message-Id: <20230825130804.c35c8c0b2e59d4038cfbe2a0@linux-foundation.org>
In-Reply-To: <CAGudoHGveDS3rjLv90eAZQjroFRTOuyVj=mG=s-Z7OKjOGkFNg@mail.gmail.com>
References: <20230823170556.2281747-1-mjguzik@gmail.com>
        <CAGudoHGveDS3rjLv90eAZQjroFRTOuyVj=mG=s-Z7OKjOGkFNg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 21:58:33 +0200 Mateusz Guzik <mjguzik@gmail.com> wrote:

> anyone in particular I should cc to get this reviewed?
> 
> this finishes a removal from an earlier commit, there is not much to
> think about ;)

We're in late -rc7.   I have this saved away for consideration
after the merge window has closed.
