Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E77C4079
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjJJT7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbjJJT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:59:12 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49F793;
        Tue, 10 Oct 2023 12:59:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 87B1444A;
        Tue, 10 Oct 2023 19:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87B1444A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696967950; bh=JA8hjFFFGYf/T57XN4WlJmox2mL5lMtyjwDlvY9UAZc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IBPIE+3pHmYQYIGc/SAGBL/1/FqkBmg98WQpN89EYW0pC2igNp1+tRaBcWIKnL3I1
         qQnEL/mv1C/doKNzoa56NXXzjULcLirMS/4pdoGoFahaYnAqE/V+0KXQSvIiJhvZcM
         AEt8JlLrjXuZWyMl3SlGRJ0gmNseZ48hTWfMMcL8PpWPJpYWanpDOKOnSCAmnJIMlt
         9Qq7e0vTVtR/vvB5OP/rfUgioUUuTkp7eTtojp7fv2f9IfVQbc9oYIkvRY+DX8qhjn
         DUAq/rvDsTkjHsM+/gnN3P3hKeJOpinlbSB58say6PK0sbcsn0ruD8CWIouR0e0ypR
         DZqv4meHQu0vA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2] docs: submitting-patches: encourage direct
 notifications to commenters
In-Reply-To: <20231003-docs-cc-reviewer-v2-1-f93fb946e21e@weissschuh.net>
References: <20231003-docs-cc-reviewer-v2-1-f93fb946e21e@weissschuh.net>
Date:   Tue, 10 Oct 2023 13:59:09 -0600
Message-ID: <8734yi5jw2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> Commenters may not receive new versions of patches via the lists.
> Without a directed notification to them they might miss those new
> versions.
>
> This is frustrating for the patch developers as they don't receive their
> earned Reviewed-by.
> It is also frustrating for the commenters, as they might think their
> review got ignored or they have to dig up new versions from the archive
> manually.
>
> So encourage patch submitters to make sure that all commenters get
> notified also when no Reviewed-by was issued yet.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - s/reviewer/commenter/ to avoid ambiguity (Christoph)
> - Link to v1: https://lore.kernel.org/r/20230927-docs-cc-reviewer-v1-1-2a=
f46ceb2d3c@weissschuh.net
> ---
>  Documentation/process/submitting-patches.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation=
/process/submitting-patches.rst
> index efac910e2659..3245b7b38b98 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -327,6 +327,8 @@ politely and address the problems they have pointed o=
ut.  When sending a next
>  version, add a ``patch changelog`` to the cover letter or to individual =
patches
>  explaining difference against previous submission (see
>  :ref:`the_canonical_patch_format`).
> +Notify people that commented on your patch about new versions by adding =
them to
> +the patches CC list.

Applied, thanks.

jon
