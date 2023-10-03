Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A37B6F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjJCRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJCRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:04:59 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B77C6;
        Tue,  3 Oct 2023 10:04:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D52552B4;
        Tue,  3 Oct 2023 17:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D52552B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696352697; bh=yfhmtqCCvv97Y2SWhdu1bHhleLPoOqHF30l72GJ9Ltk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H/05ERPWSImHNqwm9Zq8R0utmS9epf+7PtA/NbNBp4uw/BxS+wjtzIi0PldP1COFh
         MkFuhIiYlGzA58hMCRpnhYT5MUDBXHantIdnjEiplg+OBqAEsbXvvdgy4czrH+ws4p
         YLDpwrBc1/Rvx1rEYKMJ56nADEEsKnSW1JZQb/PVzQZEJn3lTRoxWvyLNvAumh3cFm
         KJyTT8cdpe34bWGRJEi1aah7eQR3VXKs6OV3qlkDqmUP4qyZigGvkn8xXUhGKAiDGP
         F4fn3Jth6eje/gFxZlir+3YpF5isP2V7b0KhqOw/oxfmagBXBH3RDYsDfqU6Nwr3hO
         j6nN5q8SIfUbQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christian =?utf-8?Q?K?= =?utf-8?Q?=C3=B6nig?= 
        <christian.koening@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?utf-8?Q?Ma=C3=ADra?= Canal <mairacanal@riseup.net>,
        Arthur Grillo <arthurgrillo@riseup.net>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        David Gow <davidgow@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: add documentation for drm_buddy_test kUnit test
In-Reply-To: <da7e150c65b85b414f2f9790e04442408678877d.1693550658.git.mchehab@kernel.org>
References: <cover.1693550658.git.mchehab@kernel.org>
 <da7e150c65b85b414f2f9790e04442408678877d.1693550658.git.mchehab@kernel.org>
Date:   Tue, 03 Oct 2023 11:04:56 -0600
Message-ID: <87lecjd4cn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One other little thing...

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> As an example for the new documentation tool, add a documentation
> for drm_buddy_test.
>
> I opted to place this on a completely different directory, in order
> to make easier to test the feature with:
>
> 	$ make SPHINXDIRS=3D"tests" htmldocs
>
> Acked-by: Christian K=C3=B6nig <christian.koening@amd.com>
> Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  Documentation/index.rst                |  2 +-
>  Documentation/tests/index.rst          |  6 ++++++
>  Documentation/tests/kunit.rst          |  5 +++++
>  drivers/gpu/drm/tests/drm_buddy_test.c | 12 ++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/tests/index.rst
>  create mode 100644 Documentation/tests/kunit.rst
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9dfdc826618c..80a6ce14a61a 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -60,7 +60,7 @@ Various other manuals with useful information for all k=
ernel developers.
>     fault-injection/index
>     livepatch/index
>     rust/index
> -
> +   test/index

Since you called the directory "tests", this generates a couple of
warnings in the htmldocs build.

(but, again, I think it should be dev-tools/tests, and perhaps
referenced from the selftest docs already there)

jon
