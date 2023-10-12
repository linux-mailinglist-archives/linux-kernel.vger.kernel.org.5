Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1537C681D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377702AbjJLH7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbjJLH7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:59:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BAA9;
        Thu, 12 Oct 2023 00:59:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B96C433C7;
        Thu, 12 Oct 2023 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097555;
        bh=lhJ0mABYqusmJwDzlvcyUF3yYu3BzZ0v1uLfQprQBNs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V1zYE4tIiqS5kPTew9ChTnNex2WSFFzks2Gb9aYTSNuV0stTrkyL5bUqMyUTFlxBp
         yqpSdE01jvChrNqEA19iQhfLhx9Y0XC+c9mODlbT0fPKuXV6ySqrIk3duNx2B1KL44
         hXATxkv/7tOrvTtbgAN6mBv2kjHgFnJHXRY3K8YhCz8iZSe3LTI3CDAuVG4Wi8KylE
         mnpc5e58nJqjxlB5ELcOi3X2Z9e1FWuBgUxcYwxONXlgESSs+rgCv1eNgkTg4AyB1/
         cG44q3DIYFb+/yueXP6QyiHM5sklWLkVJphbdnmbwpmcnjzGu9Jlxvb1SFCgZEcONh
         5zChIRomWiRGg==
Date:   Thu, 12 Oct 2023 08:59:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] staging: iio: resolver: ad2s1210: clear faults
 after soft reset
Message-ID: <20231012085926.2104251a@jic23-huawei>
In-Reply-To: <20231010-ad2s1210-mainline-v5-2-35a0f6ffa04a@baylibre.com>
References: <20231010-ad2s1210-mainline-v5-0-35a0f6ffa04a@baylibre.com>
        <20231010-ad2s1210-mainline-v5-2-35a0f6ffa04a@baylibre.com>
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

On Tue, 10 Oct 2023 16:12:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> When a software reset is performed on the AD2S1210 to make the selected
> excitation frequency take effect, it always triggers faults on the
> input signals because the output signal is interrupted momentarily.
> So we need to clear the faults after the software reset to avoid
> triggering fault events the next time a sample is read.
> 
> The datasheet specifies a time t[track] in Table 27 that specifies the
> settle time in milliseconds after a reset depending on the selected
> resolution. This is used in the driver to add an appropriate delay.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied
