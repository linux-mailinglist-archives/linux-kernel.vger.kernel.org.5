Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20FB7977FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbjIGQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbjIGQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:38:20 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB264694;
        Thu,  7 Sep 2023 09:26:29 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F19E12E0;
        Thu,  7 Sep 2023 12:48:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F19E12E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694090892; bh=JysPJRxXrczQoAPmvqIYhM9DcAdktvVPirtxUtRrSuU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gq1rdGWSBptK8bB4PeNqahqtX1h9qLqu+1xycBkYyqsLa4s2keClWk6Y2GMOTUJx3
         /4TUy131r9C92oxQ9pcn9PAmArhMmEE6h3ANtn+nx6bTAwu2KCGdBPSXvltnsLKev5
         WRjrdoqmsi6U+YAfOww83Z4m9Mj803LQhWu9aaGZDeWL09HBFquwqIfwtpVfJj+nmM
         3orype6boAO/OJSe38ttkzvGjXPa+hk1wRP0lTs2PRBz5eZrjo/ZOnqJD/wyxm9iaV
         eHeJAHoUIT3J8xMWyecyLz+LdemPc9Ku8+En66auar1NkZUVrk8XmacEkblgQranzJ
         gdfvZWjzzwyBg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, jesper.juhl@gmail.com
Subject: Re: [PATCH] Documentation: Process: Add a note about git way of
 applying patch
In-Reply-To: <20230907115420.28642-1-unixbhaskar@gmail.com>
References: <20230907115420.28642-1-unixbhaskar@gmail.com>
Date:   Thu, 07 Sep 2023 06:48:11 -0600
Message-ID: <87bkee40ac.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

> cc: jesper.juhl@gmail.com
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/process/applying-patches.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
> index c269f5e1a0a3..201b9900bffe 100644
> --- a/Documentation/process/applying-patches.rst
> +++ b/Documentation/process/applying-patches.rst
> @@ -6,6 +6,13 @@ Applying Patches To The Linux Kernel
>  Original by:
>  	Jesper Juhl, August 2005
>
> +
> +.. applying patch by Git::
> +
> +    You can use the below syntax to patch in git repository
> +    git-apply --whitespace=error-all <patchfile>
> +
> +
>  .. note::
>
>     This document is obsolete.  In most cases, rather than using ``patch``

So why are you sending a patch ... with no changelog ... adding a
useless label ... and Sphinx syntax errors ... to a document that is
explicitly marked as being obsolete?

jon
