Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68F77C387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjHNWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjHNWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0EAB;
        Mon, 14 Aug 2023 15:33:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7A4664B01;
        Mon, 14 Aug 2023 22:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04615C433C8;
        Mon, 14 Aug 2023 22:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692052420;
        bh=wucllKs3sBBWi3/TESmbyIF4E7TLR7lcxIjXe6mBVj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2kxxAv3285i5N4BOywPZAeFfWe5Hdh2DHc0pUiJwWEfe+BopgSu2y14g88VA7Lg76
         kRKGrBF9cWLBm1vv5kQ2IY1SX/Chsyx7Eg5YD21Cphc485OmlwkZTBaOF+mxSQXPfC
         nK37MUXJlS18ocGFI28dJud5OS7jGuHDoIcCcgCk=
Date:   Mon, 14 Aug 2023 15:33:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, vgoyal@redhat.com,
        dyoung@redhat.com, lf32.dev@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot
 un/plug
Message-Id: <20230814153338.79164562f1d2810a18f495dd@linux-foundation.org>
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 17:44:38 -0400 Eric DeVolder <eric.devolder@oracle.com> wrote:

> This series is dependent upon "refactor Kconfig to consolidate
> KEXEC and CRASH options".
>  https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/
> 
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.

Thanks, I updated branch mm-nonmm-unstable to this version.
