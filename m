Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB97CF1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJSHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJSHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:51:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAEB124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hdmxkyx4i9SyDB0WhK7r4B7CZdTyhseaIQqNI+PeQKM=; b=O5mf/qxwDhkC4R7xVs8sWoCorc
        6J+bJpIW3wxzyKeYvM/7belpvFHOD6ghLxPe+ylwno0UWU5qC2KRh/BU/Y/3Ah5LQwc7wx3x18OSY
        20h34x8vsrM9bhAoGnvJfD76SxOlx54ETfhgrqQG8th4YvidqEM9ISo1X1OtEPvmHHAvjna9+fT2o
        5xmNKXPkDhTZKAvj2AK5KjidHVVLROx45k+SGEijyHKqnnJCUwT4wXOhnCKWvfDY7mWAv9QhcCDKM
        HM0U7Qy39g7WaSoxGCbTGK7FoiKjHF1cpII4ztY/gDkMx98ImDJmXWkwEe+csWn6+lbQfmjg9Zl8m
        XNOVFC0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtNoV-005qlN-C7; Thu, 19 Oct 2023 07:51:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EDEC300392; Thu, 19 Oct 2023 09:51:27 +0200 (CEST)
Date:   Thu, 19 Oct 2023 09:51:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] powerpc/smp: Add read_mostly attribute
Message-ID: <20231019075127.GO33217@noisy.programming.kicks-ass.net>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-6-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018163751.2423181-6-srikar@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:07:45PM +0530, Srikar Dronamraju wrote:
> There are some variables that are only updated at boot time.
> So add read_mostly attribute to such variables

You don't have __ro_after_init ?
