Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3A7C00D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbjJJPzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbjJJPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:55:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434FF93;
        Tue, 10 Oct 2023 08:55:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08681C433C8;
        Tue, 10 Oct 2023 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953314;
        bh=lRp8nSZvmE6CN6byLrcUKrdyad3jSUmUt/On76xWubc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q6K/1EAWm/DryR9Fl1MJ8aA0eaJ8Lg902y3wtGs34ael6oHqYfYqrhYGa3DvNVxro
         M5mNUrIN9lATDy1CCuNcLE7YqokJx0rNZ/MSVOdhBHM4MTNnWA7WBa1+HGbNeNqxc8
         5fTcDkjMHB5Tr9vzb/hY/uIu4mEPL49Chf2xckVGVxLUKRZIeMy0+lxALJhWAeJ2Tl
         mUo1Xg9wOlWBnmOJDlORvhxIp09cWE6QEOVlPLA6mt0Sf80GXeByo7IXAJPM7LsSGD
         gKY2VTqvKr/Xf58v+L00FYShx6jkea5A948xX3n1z0S+fr1Un9PMxj0tPSCjKHS/Wa
         Bxjlr/DLk8Ydw==
Date:   Tue, 10 Oct 2023 16:55:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/17] staging: iio: resolver: ad2s1210: convert DOS
 overrange threshold to event attr
Message-ID: <20231010165528.70f07e35@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-9-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-9-ec00746840fc@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Oct 2023 19:50:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 has a programmable threshold for the degradation of signal
> (DOS) overrange fault. This fault is triggered when either the sine or
> cosine input rises above the threshold voltage.
> 
> This patch converts the custom device DOS overrange threshold attribute
> to an event rising edge threshold attribute on the monitor signal
> channel.
> 
> The attribute now uses millivolts instead of the raw register value in
> accordance with the IIO ABI.
> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied
