Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4F7A7BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjITLyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjITLyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:54:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A81E5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:53:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A02DC433C9;
        Wed, 20 Sep 2023 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695210835;
        bh=cJdVOOK/lI8L1RqXBiHPKMeuwOZIcO45C4fhk7Z1hno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvMklHmk84WIoz+jUOS/bw4sb1tPYCaQUVRSj/J/NOUvi7x2MEPASKE6c1ZhrkBmf
         REuoydzGMnlnGGKQKfz8Psqh9cKcpeNv/glFS+/bNS7rb57s1sVFlbzReBjJOllWVs
         auwlGndb0byrbxFd6MgF7fnioYt+qVA7PThn+ENQpa9GXxLWgiyKnnq5Dazmwv8l2l
         HmzbuRp3UN+kI4wZdy9Dvn0Q1dCNJAjAkPb8nEH2AVQSSHNxwjMc62fHspnYsAdi1k
         fNIxEptJfpVg7opTSPqibWNXWCVp39SecusLbfG6N+c0vUNNYzxy/joXm85D7254bX
         Sdlx/qdzL4D5Q==
Date:   Wed, 20 Sep 2023 12:53:50 +0100
From:   Simon Horman <horms@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash_core: Remove duplicated include in
 crash_core.c
Message-ID: <20230920115350.GF224399@kernel.org>
References: <20230915055844.37935-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915055844.37935-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:58:44PM +0800, Yang Li wrote:
> ./kernel/crash_core.c: linux/kexec.h is included more than once.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

FWIIW, this seems to have been added recently, by

926f75c8a5ab ("Add linux-next specific files for 20230920")

Reviewed-by: Simon Horman <horms@kernel.org>
