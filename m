Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0097CF8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjJSMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjJSM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:29:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49710D7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:29:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB288C433CA;
        Thu, 19 Oct 2023 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697718587;
        bh=MXuTYoWhiJr7Ev1aRTa8qGNL7Kx3FansRdsI17NX7Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KbwOMCSdsRL2fpG8RdQEe+7eHj2ZhJPEJBlVVA97RLAGdbCJkX0Ny5+oHbSwaqIJb
         Ajg1uXocMJzd0lS07KMgSBAQVbGKVlrozAf0ejNcTiBwKra1hrigCXUOUFvr+zfKC+
         Qkagj6GXU2oq9gaeAF0NFWdqvg3UnsY3CrSsRREDP5N97jW7QoEyHiHbnD3Lts9JWK
         xqZQo0n39Gp1es4Ylnwkjc0ei8fQ8RjDMI0WN8s6hq2mlxzAyRVuPXNu1obD7j1/E9
         CswR/hnPX7mEO5DAlyYwAJ0jDcQT1rjRxSSfwSSH4093ySwxu1tXSATt0wBz+l4rru
         5kuHqHaHWV8Dg==
Date:   Thu, 19 Oct 2023 14:29:43 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 2/2] staging: qlge: Prefer using the BIT macro
Message-ID: <20231019122943.GH2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <1bab82b0406a0206f8c85f7cc87e5ea554a9781b.1697657604.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bab82b0406a0206f8c85f7cc87e5ea554a9781b.1697657604.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 12:47:01PM -0700, Nandha Kumar Singaram wrote:
> Replace the occurrences of (1<<x) by BIT(x) in the files under qlge driver
> to get rid of checkpatch.pl "CHECK" output "Prefer using the BIT macro"
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Thanks,

These changes look correct to me.
And I do not see any other similar cases left in these files.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/staging/qlge/qlge_main.c | 8 ++++----
>  drivers/staging/qlge/qlge_mpi.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

...
