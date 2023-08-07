Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B9A7725DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHGNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjHGNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:34:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30479E43;
        Mon,  7 Aug 2023 06:34:04 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:33:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691415235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hz0gYCAV1vfwJhYxEbaXlG58dTr+zk4pcu3k3XpTAdk=;
        b=vh8puwqxCRMEBtjAWenhgT7Q35gwDj1a5Up7mLuPa6zf7/v16YHeDidCHYZmG9v3BosqZ5
        snT4UmoOl/wwYK7BzxMAtyzuRQmqxjU2wU1KsJ8WAv9mt59dyZNRL4RZFDq9RqZW3pQddf
        aO7cPiSMp9p6c46+8iIEcLQ+fs9FBKr2MG2u1dMaGCiWLgrfAa8sJrADi2+bvTOBAX0GTh
        kSLdhTIdzhVI2UiBsV8PuSgotQk/j4I165JRN7xTWvjmcwThIN41b/OQBNHicNV5kMsjpx
        VAaoWjOSo1bNsD47iYE8hjdanYCJIqXA1hdYBRZ3fWIgG2g6IgZGPJsR/nqKFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691415235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hz0gYCAV1vfwJhYxEbaXlG58dTr+zk4pcu3k3XpTAdk=;
        b=OZ7BRtHbOjUfsRckUF9YYE9NSrJmI2O9ZvIGwktqOO+zbRYkIU28KaNOKxzZkgVWvVc/vb
        +6qEfiou6mhu/pDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "John B. Wyatt IV" <jwyatt@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jlelli@redhat.com,
        vschneid@redhat.com, pauld@redhat.com, rt-maint@redhat.com
Subject: Re: [preempt-rt] BUG: sleeping function called from invalid context
 at drivers/gpu/drm/i915/gt/uc/intel_guc.h
Message-ID: <20230807133354.-t5iv19T@linutronix.de>
References: <ZKyngsXKztAU9J3r@thinkpad2021>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKyngsXKztAU9J3r@thinkpad2021>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-10 20:51:14 [-0400], John B. Wyatt IV wrote:
> Hello everyone, I am a new kernel developer with the Red Hat real-time team.
> 
> I am seeing two different call traces with 6.4-rt6 on my 12th Gen
> Intel Framework Laptop with i915 emit the same bug. Both of them
> occurred in the same boot. This kernel was built and tested on RHEL8.
> [1] occurs only once. [2] occurs ~50 times in a boot and log in to the
> gnome desktop.

Could you try v6.4.6-rt8+ and check if it still there or gone?

Sebastian
