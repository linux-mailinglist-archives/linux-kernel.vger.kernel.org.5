Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCD87BD55D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjJIIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjJIIjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:39:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DF9F;
        Mon,  9 Oct 2023 01:39:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABC1C433C7;
        Mon,  9 Oct 2023 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696840785;
        bh=FtkEjzcRbtlsYh6eaM0c3E6zfK54DBTflsaso2PDaac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=liAKXVmo9AnwBPBY7iA753zrNtz/sl+uX7W/61C1NyJqXC89aVs9REWiHYda8qEgN
         xmyynk4NPZOifXJZETETOHztGukFxU3lXtEN1p8H9tPn+AA0QorG2Ixo+lXoV3F0dr
         8BVHO6zk8ozWcfUhoZM6EebttFBs13w0tJ+ch7RfvstMS4M0Qeh4GNcRfxeuCzv0dR
         FxsTz2QwvTQvWDYlour0m/wRH00+iS2PkwtknrWfAqmtaDPLINTu2h5b+0fML9XqhH
         Ho8ibhn/skq6m+aOJlRTvexwXS2TJs/fo3DZ+pnOzeCYUloWiRejztd4VPqHYJ9zfj
         BIkx9ZIqs4fFw==
Date:   Mon, 9 Oct 2023 11:38:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] userfaultfd.2: briefly mention two-step feature
 handshake process
Message-ID: <20231009083851.GF3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-2-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:01:57PM -0700, Axel Rasmussen wrote:
> This process is critical for programs which depend on extra features, so
> it's worth mentioning here.
> 
> Future commits will much more fully describe it in ioctl_userfaultfd.2.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/userfaultfd.2 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 40354065c..1b2af22f9 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -200,8 +200,9 @@ the application must enable it using the
>  .B UFFDIO_API
>  .BR ioctl (2)
>  operation.
> -This operation allows a handshake between the kernel and user space
> -to determine the API version and supported features.
> +This operation allows a two-step handshake between the kernel and user space
> +to determine what API version and features the kernel supports,
> +and then to enable those features user space wants.
>  This operation must be performed before any of the other
>  .BR ioctl (2)
>  operations described below (or those operations fail with the
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
