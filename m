Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D007C6851
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378185AbjJLIBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378212AbjJLIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:01:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2CCF;
        Thu, 12 Oct 2023 01:01:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C45C433C8;
        Thu, 12 Oct 2023 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097663;
        bh=4bm9Oe6eauMqGsfo8NuDGjzg2j6K20kXnmsJNdIG000=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tDttq06gKUul26yHhCrKsEKmy+r8THeGlb1ONLXVU0k6bFFZmn3cmxse/u9OQMJ8+
         wo3btVKpeF/QoymLLqR2nTCMSE2lC0W7QyYdiCq6XGTTSr+ZiMYiaEz/6YEEkNnBWH
         7OoOodgeSDSIdDM+hE07SNMJpbuVmExapHgaMvUOfidwlaPncV8wYfjVfNcdhqaDyF
         O0pXHH3mHS+LgtPUTGfT099WPLqt2r++Y9XEOfK8mZOb89wyorT9ldNqNs6gLL7XrY
         lEFCGX/6MDh3QqHwTZkVjbXlbQu6RbZEaHk+w8pElG6Rt1Yi0ErI8ZPhbJH95P7JTq
         tedMrucX/TDOQ==
Date:   Thu, 12 Oct 2023 09:01:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] staging: iio: resolver: ad2s1210: simplify code
 with guard(mutex)
Message-ID: <20231012090113.212342cf@jic23-huawei>
In-Reply-To: <20231010-ad2s1210-mainline-v5-3-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
        <20231010-ad2s1210-mainline-v5-3-35a0f6ffa04a@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 16:12:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can simplify the code and get rid of most of the gotos by using
> guard(mutex) from cleanup.h.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
