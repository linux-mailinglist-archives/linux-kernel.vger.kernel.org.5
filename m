Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616047BC7E0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjJGM5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbjJGM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:57:05 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43629B6;
        Sat,  7 Oct 2023 05:57:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DECE07C0;
        Sat,  7 Oct 2023 12:57:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DECE07C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696683424; bh=Q/1XW57KSxFZsvTueCHp+MJQ8+S0TrgP3bKSsrznURk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E6s5KCew+0oR5T02HoU+z/vbCC4hlRj58p3KKnR99rYHbGyESaGnU9KkXmQtGNVZd
         qy1HVSqaqvGQAmJW3LCa/JSfkeHihd6GfTIpQ9Fqz2EnRYWeGfT9mCy0l3dNi9mTi+
         NlTbvhjjsxBZZCHg1yMc49znmFkBF5p4XiFgkTIST2c7FGZNypEGZigqhhEUWAJpg4
         +9bov3mOOEr4aOPwhBXXB8joULig7bn/RJD4G39/IoceyTud2uCoH3f/XGc6Sc838O
         pGb0dDwNNkU7vPmFYUcjqzeicHQ4a05S3WbTxY1ajtr+/a1y5F9cDQdDp+EC1oE27/
         UHPMNGMRL9jTA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Submitting Co-Author <sub@coauthor.example.org>
Subject: Re: [PATCH] docs: submitting-patches: Introduce Test: tag
In-Reply-To: <20231007-topic-test_tag-v1-1-513cd9e577ed@linaro.org>
References: <20231007-topic-test_tag-v1-1-513cd9e577ed@linaro.org>
Date:   Sat, 07 Oct 2023 06:57:03 -0600
Message-ID: <8734ymvbds.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Dybcio <konrad.dybcio@linaro.org> writes:

> Currently, we blindly trust the submitters that they both compiled their
> code at all, tested it on a relevant device, and have done so in a manner
> that made sense for a given changeset.
>
> If at least two of these three things were always true, the review
> workflow would be much more exciting.
>
> Introduce a new Test: tag to help submitters express the way the patch
> was tested, making it easier to understand for reviewers and maintainers
> whether it was tested, and if so, whether that test was sufficient.
>
> I originally found something like this on Google's Android kernel repos
> and loved the concept.
>
> Test: make htmldocs and manual examination
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Do we really want to do this?  To me, it almost seems like it codifies
the idea that sending *untested* patches is OK as long as you leave out
the tag.

Others may disagree, but I don't think we need yet another tag for this.
Testing of patches before sending them should be the norm; if special
notes about testing are needed, they can go in or below the changelog,
as appropriate.

Thanks,

jon
