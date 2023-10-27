Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135827D94D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345688AbjJ0KKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjJ0KKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:10:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CFB1A1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:10:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGz243S9Vz4xWb;
        Fri, 27 Oct 2023 21:10:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231013175714.2142775-1-visitorckw@gmail.com>
References: <20231013175714.2142775-1-visitorckw@gmail.com>
Subject: Re: [PATCH] powerpc/perf: Optimize find_alternatives_list() using binary search
Message-Id: <169840079676.2701453.2337090306249839284.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2023 01:57:14 +0800, Kuan-Wei Chiu wrote:
> This patch improves the performance of event alternative lookup by
> replacing the previous linear search with a more efficient binary
> search. This change reduces the time complexity for the search process
> from O(n) to O(log(n)). A pre-sorted table of event values and their
> corresponding indices has been introduced to expedite the search
> process.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf: Optimize find_alternatives_list() using binary search
      https://git.kernel.org/powerpc/c/e08c43e6c3eb5d805b61d981f1e8286ee0dc6d1a

cheers
