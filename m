Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288577D94D4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345693AbjJ0KKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345573AbjJ0KKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:10:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B318A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:10:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGz236jyhz4xWZ;
        Fri, 27 Oct 2023 21:10:35 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231019091452.95260-1-srikar@linux.vnet.ibm.com>
References: <20231019091452.95260-1-srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powerpc/paravirt: Improve vcpu_is_preempted
Message-Id: <169840079677.2701453.9938577942475657211.b4-ty@ellerman.id.au>
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

On Thu, 19 Oct 2023 14:44:52 +0530, Srikar Dronamraju wrote:
> PowerVM Hypervisor dispatches on a whole core basis. In a shared LPAR, a
> CPU from a core that is CEDED or preempted may have a larger latency. In
> such a scenario, its preferable to choose a different CPU to run.
> 
> If one of the CPUs in the core is active, i.e neither CEDED nor
> preempted, then consider this CPU as not preempted.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/paravirt: Improve vcpu_is_preempted
      https://git.kernel.org/powerpc/c/efce8422dd53fae6cdbd37741034ac4eb4730819

cheers
