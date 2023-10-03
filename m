Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB737B6E6B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbjJCQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240384AbjJCQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:27:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E78B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QPukRYvfqjHp1SBgnfRJAtksbv7r5H+KyrJ0oNuf0hE=; b=AiFIR1YqfZteKqvmgGGQjPq/Ym
        g63P7K7rziCFD45cB23pUdcNgzhU1r2q+dTYVoAO2Cu7mlEovMxFae/md9V/h3XwMMEQkdCHiIxAs
        89vf2PprW2rieJ1e9C9+dyt3BD8vGKlSUzwsC7OYnjtUqw2vxaxFzzbBHtQC4iScc0+jv/PWAHMc8
        tyI22Ursvz5sKQBbZWwxV1UJySpR2KL32PeWzzM7VeIk9P0s9B+pwnpB7PKFZUmCV9gEtfI5OViod
        8kKkii4XbmDtv6ZQOqq1tXnURJJgaeHgLixeBMi9jyRMdI31tEVWDkV5X2gpleTpMThNavWwleO+g
        FGNK5jtg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qniEd-00Fyam-A1; Tue, 03 Oct 2023 16:26:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3FA1300348; Tue,  3 Oct 2023 18:26:58 +0200 (CEST)
Date:   Tue, 3 Oct 2023 18:26:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     jpoimboe@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix memory leak in check.c
Message-ID: <20231003162658.GE1539@noisy.programming.kicks-ass.net>
References: <20231003161335.1403094-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003161335.1403094-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:13:35AM +0800, Kuan-Wei Chiu wrote:
> In the 'disas_funcs' function of check.c, the 'cmd' string used to store
> a command is not being freed after it's used, leading to a memory leak.
> This patch adds the necessary 'free(cmd)' statement to release the
> allocated memory.

It'll exit more or less right after doing this.
