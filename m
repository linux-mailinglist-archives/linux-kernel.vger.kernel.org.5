Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D97F79A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjKXQoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKXQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:44:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD010FB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:44:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D05C433C8;
        Fri, 24 Nov 2023 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700844282;
        bh=Jv88ICKZ110o1np2p9LtMmd50STofDmEsKMRuaqgi7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qWC7AvJVPIlEnviCx7I6e7oQ953NxvnapmOeKmMXPK+XNf7weDESmBFKIX9Fm6kz9
         zQtGkUM7zWgxA2VZl4OoLv7T4usgzbJKsX+t+H85rmkSQi61+FBx+orVD4b9CR6d1i
         AL7IgDp6N89DKQ10Q+OvjgoKPhNwwSCrvTjKpHIU=
Date:   Fri, 24 Nov 2023 08:44:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        eric_devolder@yahoo.com, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-Id: <20231124084441.b913fc404fec53d5d0946c55@linux-foundation.org>
In-Reply-To: <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
        <20231123073652.507034-3-bhe@redhat.com>
        <CALrw=nFzy2zq-khLUCXsuf8J5_mka0YPyTosO190OUst2QSjVQ@mail.gmail.com>
        <ZV80X+lf2iOOTboW@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 19:15:43 +0800 Baoquan He <bhe@redhat.com> wrote:

> > > CONFIG_KEXEC is used to enable kexec_load interface, the
> > > crash_notes/crash_notes_size/crash_hotplug showing depends on
> > > CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> > >
> > > Fix it now.
> > 
> > Can we add Fixes/CC stable, so it gets eventually backported into 6.6?
> 
> Makes sense. Will add it in v2 since I need respin to add the missing
> stuff in patch 1. Thanks.

Please avoid mixing cc:stable patches and this-merge-window fixes in
the same series as next-merge-window material.  Because I'll just have
to separate them out anyway, causing what-I-merged to unnecessarily
differ from what-you-sent.


