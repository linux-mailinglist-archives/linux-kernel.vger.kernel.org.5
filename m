Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C47C0130
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjJJQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbjJJQHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:07:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051A1739;
        Tue, 10 Oct 2023 09:05:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223CCC433C7;
        Tue, 10 Oct 2023 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953945;
        bh=C2yJ/fRMFl+/+tPlbGcZ9mxV42oxfZteq1xQm5XbRoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lsS+ibB3w+cJpUxzyllunc+S4zHPeH38y8bjmrlx0IVtP9fknb08rRy4lRhKPa+jJ
         CrPro6r/9hr7NvaxjZYE4EpDdr8FzXsjADdy/FRPtPVNE2VRgluIIqEhEgI/aA5+Si
         0ChcvaH4ldB/CtZ/h+Rb6QSSe5k6ZNFW3Fhl8cgr3PqUCysPgPIbwSlnLb4YS/79ia
         +vZjMfJ5RPg5ieSRgssZHMPEKJls5qsbOQjyoIX/oWYU5oZs3u7eKkrMgoNKum9Vhb
         M/bjgxnWA3m+hJpLvBOuZp9WTuVoaFNeSBoT8m54+XBz3Ogzwy9y8OK8rLx6eXZp6j
         R2xyOWTHabdBA==
Date:   Tue, 10 Oct 2023 17:05:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/17] staging: iio: resolver: ad2s1210: implement
 fault events
Message-ID: <20231010170556.2e78fc7d@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-13-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-13-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:30 -0500
David Lechner <dlechner@baylibre.com> wrote:

> When reading the position and velocity on the AD2S1210, there is also a
> 3rd byte following the two data bytes that contains the fault flag bits.
> This patch adds support for reading this byte and generating events when
> faults occur.
> 
> The faults are mapped to various channels and event type in order to
> have a unique event for each fault.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
