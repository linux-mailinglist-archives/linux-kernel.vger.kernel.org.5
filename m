Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39E57BD562
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbjJIIkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbjJIIkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:40:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE449A3;
        Mon,  9 Oct 2023 01:40:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F797C433C9;
        Mon,  9 Oct 2023 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696840834;
        bh=3cJq80knLOJumaC1TiKkLnayboVzJ/sBixNDF1JSxo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nf0/wqQBKr4R3VvEWvMF4LHiXw43mi8AdznJ4Dv5g2p6JBzeEsDQjHEHEqgkUQYwL
         zTPzRjHMlRmsa0dWD+W69N8I3+71fLkqGWhULyUVt8D0G0628lQ3HsC074hy3ZMFOQ
         g7x5Ke1m9GYSVJboeZ4HMySEfcYY3Zggq0p+PERpfbFWTIZeiOfSxNIQL53iHzJSkv
         lUhi5xENTEANKBlKclxcNZuJ3XSuzFLyoQy1E4esrcLtQ1XIKmNIHYPDqOY5tklmXy
         az/eBk8H2b+9E5yPrQ632Isj/yvNrRbGK4HD7EDOCFhNccEKRrMk2D/HBCXBl8HX09
         h9+rfYVv2MDEg==
Date:   Mon, 9 Oct 2023 11:39:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>,
        linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] userfaultfd.2: reword to account for new fault
 resolution ioctls
Message-ID: <20231009083940.GG3303@kernel.org>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919190206.388896-3-axelrasmussen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 12:01:58PM -0700, Axel Rasmussen wrote:
> Basically, reword the sentence to clarify that this isn't a complete
> list. I don't believe it's worth maintaining a fully complete list here,
> instead ioctl_userfaultfd.2 is the place to do that. Let this just be an
> example.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  man2/userfaultfd.2 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
> index 1b2af22f9..00d94e514 100644
> --- a/man2/userfaultfd.2
> +++ b/man2/userfaultfd.2
> @@ -222,11 +222,12 @@ operation,
>  a page fault occurring in the requested memory range, and satisfying
>  the mode defined at the registration time, will be forwarded by the kernel to
>  the user-space application.
> -The application can then use the
> +The application can then use various (e.g.
>  .B UFFDIO_COPY ,
>  .B UFFDIO_ZEROPAGE ,
>  or
>  .B UFFDIO_CONTINUE
> +)
>  .BR ioctl (2)
>  operations to resolve the page fault.
>  .PP
> -- 
> 2.42.0.459.ge4e396fd5e-goog
> 
> 

-- 
Sincerely yours,
Mike.
