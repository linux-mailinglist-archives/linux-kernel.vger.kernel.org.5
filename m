Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E278B785
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjH1Sr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjH1SrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:47:22 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B1E50;
        Mon, 28 Aug 2023 11:46:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0034E7DB;
        Mon, 28 Aug 2023 18:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0034E7DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693248351; bh=uuwNUsKa+07qHiL8wjK8m2Q/MC3k7AlfdXxYxxsGMck=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O8lmtmy2pPaKPZVPj1+prUdAHojspj5oESo7u1AZb9vGSXufLNhldL+Bzx6PXuNh9
         CXg61jAA0s0z2CTPKK/JcnzdfRbL2IqPxZ+hL8nYEUQkp3RWVx42Um6jNjtg9hVab9
         f8zVFlVPrixbNLxClUQf++vnkoCYwDy4+tzwxzZ+1sMu6k3vd6J17P98bJNNkW/Jn6
         xBaSWxA3CamDDbEOOgk8SaZ2ttriWlTLjCsLxfb96BFR0TBtQXwSwIC/84VYjHArUr
         Yclp+IXgWzyTnTh04NnKuXaNX3KWpcalw6iUJRh3iC6IjE1kwTCroL+IBAkcBk6Qxf
         afUjO03kP3GhA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: Re: [PATCH] Docu: genericirq.rst: fix irq-example
In-Reply-To: <20230824110109.18844-1-pstanner@redhat.com>
References: <20230824110109.18844-1-pstanner@redhat.com>
Date:   Mon, 28 Aug 2023 12:45:50 -0600
Message-ID: <8735030zvl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Stanner <pstanner@redhat.com> writes:

> A code example was missing the pointer to dereference a variable.
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  Documentation/core-api/genericirq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
> index f959c9b53f61..4a460639ab1c 100644
> --- a/Documentation/core-api/genericirq.rst
> +++ b/Documentation/core-api/genericirq.rst
> @@ -264,7 +264,7 @@ The following control flow is implemented (simplified excerpt)::
>              desc->irq_data.chip->irq_unmask();
>          desc->status &= ~pending;
>          handle_irq_event(desc->action);
> -    } while (status & pending);
> +    } while (desc->status & pending);
>      desc->status &= ~running;

Applied, thanks.

jon
