Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2495F7AA68E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjIVBde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjIVBdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:33:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDF19B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE732C433C8;
        Fri, 22 Sep 2023 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695346404;
        bh=hgf+/wwL2bSZ5fupqOPqm+9H6IdZ7z7D6atBwYgaMpU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GvBwpIxI2GcAwSDRhWd3jisdO/CqiYQhel75el489tnVKctdp65xy4MD6nAy1/Vbd
         bQKzllRA0LKzLMLJawr/PKHxmvgomXPQ5d2DG0vqWu2ufwKQAdyAOXUNIxMHz2kvKz
         DcMomXaoY40mfH6QVM0j6yo5CpgZY/YG/Ud9SGtk=
Date:   Thu, 21 Sep 2023 18:33:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Subject: Re: [PATCH v4 5/6] mm: Add a NO_INHERIT flag to the PR_SET_MDWE
 prctl
Message-Id: <20230921183323.c990c57d0b43832b39d3e363@linux-foundation.org>
In-Reply-To: <20230828150858.393570-6-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
        <20230828150858.393570-6-revest@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:08:57 +0200 Florent Revest <revest@chromium.org> wrote:

> This extends the current PR_SET_MDWE prctl arg with a bit to indicate
> that the process doesn't want MDWE protection to propagate to children.
> 
> To implement this no-inherit mode, the tag in current->mm->flags must be
> absent from MMF_INIT_MASK. This means that the encoding for "MDWE but
> without inherit" is different in the prctl than in the mm flags. This
> leads to a bit of bit-mangling in the prctl implementation.

Is a manpage update planned?

And did we update the manpage for PR_SET_MDWE?
