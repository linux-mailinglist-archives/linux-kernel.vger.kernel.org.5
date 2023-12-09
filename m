Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C5C80B6E0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjLIWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIWeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B66100
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:34:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44937C433C7;
        Sat,  9 Dec 2023 22:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702161259;
        bh=XsuMwPIsmzIChD8ndzu9XynHImam+pakPevqcPXRNtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+3ya32iasF+Y/ixGjJWRb6MVRkCX7SUQSlOC7QcPVmApdwOw8RsA8eKFvh3qbP7S
         qurGC4BZ7+i6bSPwU0DlnsrWqZIH5edTjZK1gJcsz1xuzDcGKFKhsQBdtd2EjljejQ
         EBBBXu+OIRpADiQ9c+pKSlLavInXYnnt2LwNDXDc=
Date:   Sat, 9 Dec 2023 14:34:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] crash_core: Fix the check for whether crashkernel is
 from high memory
Message-Id: <20231209143418.92f02de6b6c6db2b7b3b1815@linux-foundation.org>
In-Reply-To: <20231209141438.77233-1-ytcoode@gmail.com>
References: <20231209141438.77233-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Dec 2023 22:14:38 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> If crash_base is equal to CRASH_ADDR_LOW_MAX, it also indicates that
> the crashkernel memory is allocated from high memory. However, the
> current check only considers the case where crash_base is greater than
> CRASH_ADDR_LOW_MAX. Fix it.
> 
> This patch also includes some minor cleanups.

Can we please include a description of the runtime effects of this
change?  ie, what happens now and under what circumstances, and how
does the fix alter these things?
