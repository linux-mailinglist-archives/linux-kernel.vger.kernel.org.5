Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1E792AE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjIEQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354465AbjIELye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:54:34 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659881AD;
        Tue,  5 Sep 2023 04:54:29 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693914866; bh=Pu2KNtGCQ86ffRJyUfxaDeikppAYD/s1xk4Qr01so6I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZYUThqiZhV4p7gMinoJpme0FNkMm3UhLBM73juawldAPB85UFn1A5CDfRp7Jnsll6
         8amEQ0DyeYyzqRALHR6wGZK2e5l32pWuf9RQkYuB1t8wTRq3APJRQx80spZxd3tq0Z
         EzMmZNoMdXQbQhyKxJxJMn8S2mXM3c28sKsvUDuMfoWBNYA2uYVTRI1iW2O8/EN1+K
         BHulHezcNlJzSVMwxoJ7/BqkzY4na8EqmSIwZcjyD0DT6XHwhBaOlUTR3GUwnS4scB
         fx73aK0zz+XrDpXaYyRFlLp/TYhwgK4ucWv9/O4wrPCHIIgknC9Xw2I0ok5/EmFR41
         u1J+nDa68QEvw==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath9k: clean up function ath9k_hif_usb_resume
In-Reply-To: <20230905013556.2595854-1-dzm91@hust.edu.cn>
References: <20230905013556.2595854-1-dzm91@hust.edu.cn>
Date:   Tue, 05 Sep 2023 13:54:26 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87r0ncq1hp.fsf@toke.dk>
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

Dongliang Mu <dzm91@hust.edu.cn> writes:

> In ath9k_hif_usb_resume, the error handling code calls
> ath9k_hif_usb_dealloc_urbs twice in different paths.
>
> To unify the error handling code, we move the else branch before
> the if branch and drop one level of indentation of the if branch.
>
> In addition, move the ret variable at the end of variable declarations
> to be reverse x-mas tree order.
>
> Note that this patch does not incur any functionability change.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

So it seems this didn't make it to the lists; could you please try
re-sending?

-Toke
