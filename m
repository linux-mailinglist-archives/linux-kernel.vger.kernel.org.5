Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6F47DB512
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjJ3I1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3I1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:27:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402BFA7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SgtYiEbuKxzRlgP1dsKDl/ZpFr7gA4ucYSBfwNHXsEY=; b=P/hJC37gGMfNfOnjw7AS4EbYI+
        FbGci2usXQtQc12SiLg2N/OaVi+6osTc3Q3uCv2j0Zd74PCzEGk4rpYXjyYX03hESXIkS1HeKZuOx
        pv0jR9r22TCFUUURKCFt5NxACGOnsPRDTPVDET3Lh4k1zqnMpG3LQGmSx9Mx5+WhO4q3taBdXYvuR
        mXE2liGl1PkiCVtHolnVCwn0z5Whr6L4L6PNPdv1PObde+DwcOJ/lxa7xTb5puHsySvUCmSjUGq6o
        Ub5L9d3fv/vUjqKt6885YOrA8mRJiHKoki4vWDh9r4ZpsNbOv2j2MAfHbEZOSjyWNUOpKCPhw2g+f
        H+2GZ5qw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxNbg-003kMD-38;
        Mon, 30 Oct 2023 08:26:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E5D5300478; Mon, 30 Oct 2023 09:26:44 +0100 (CET)
Date:   Mon, 30 Oct 2023 09:26:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <20231030082644.GK26550@noisy.programming.kicks-ass.net>
References: <ZT6narvE+LxX+7Be@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6narvE+LxX+7Be@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 02:41:46PM -0400, Paul Gortmaker wrote:
> The TL;DR is that the Yocto folks encountered a regression in their
> automated QA tests (after a move from v6.4 --> v6.5) where non-KVM
> enabled boot tests on 32 bit x86 would (with ~2% frequency) splat with:

You're sure you're not running into this here:

  https://lkml.kernel.org/r/20230706170537.95959-1-richard.henderson@linaro.org

?
