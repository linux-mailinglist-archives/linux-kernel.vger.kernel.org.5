Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4B7BC51F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343591AbjJGGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbjJGGob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:44:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84CBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:44:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7842AC433C7;
        Sat,  7 Oct 2023 06:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696661069;
        bh=/UithT0SHHNlkQBneXRuPm4dZa1q7Z47U1p0EtVjkFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h+/H2A/ryLltte4AKxm6lAct0kOE2L9MdXkGn/qY2b9L3/FNs9j8QrmVsJmR3k8sV
         adZ1M9wd3xgCiutn1uLbhKR9ds939NOLrY/HUcsgShiUOH94oTRaFgbIltzVi04azh
         gNScDXoNAD+9xCSjvowJJY2/4xqZoXSjfNxJvmrc=
Date:   Sat, 7 Oct 2023 08:44:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     gregkh@google.com, cmllamas@google.com, surenb@google.com,
        arve@android.com, joel@joelfernandes.org, brauner@kernel.org,
        tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: add mutex_lock for mmap and NULL when free
Message-ID: <2023100715-blade-valiant-714d@gregkh>
References: <20231007034046.2352124-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007034046.2352124-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 11:40:46AM +0800, Kassey Li wrote:
> Enforce alloc->mutex in binder_alloc_mmap_handler when add
> the entry to list.
> 
> Assign the freed pages/page_ptr to NULL to catch possible
> use after free with NULL pointer access.
> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  drivers/android/binder_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
