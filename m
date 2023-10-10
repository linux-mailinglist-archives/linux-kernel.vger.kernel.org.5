Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4847C013D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJJQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjJJQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:09:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D95B7;
        Tue, 10 Oct 2023 09:09:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73F8C433C8;
        Tue, 10 Oct 2023 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954148;
        bh=VLi55CcTcM0KgnOau/gbeJ9eXnvitesGKRn8dvJeGqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XwmdmFvXDm/37DAyjeysBeCrNBRZCfyB8+XBizMzjP0in0Xgh5TlWu82JDOd0C/5x
         HMnff1m5DCOO4QuRQVJrlYf6M7l6CzvioiHyI6Qz6zKkr+lOxhaA840P+oxQWS5/rW
         Q6Zza84u3Nd/sOpBslWOfmtiIHSaDLSxbxlAG/TA71t1ug5R9TYCwwpwIuhRNd+0p8
         7+nKPRfcXHsh23hBVG1H9pmMZRARbCJTb7Y/mFkODk+/Orgz+tADpIa89wOXM83IxM
         7r5uZI3MwuF25AhtS9nVM7O0xCRd9mNOVPAf8WPDYyEqENFKf6tdD21kJjdT7HiMEt
         jyzvIp/8FthtQ==
Date:   Tue, 10 Oct 2023 17:09:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/17] staging: iio: resolver: ad2s1210: remove fault
 attribute
Message-ID: <20231010170918.5f2d2595@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-16-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-16-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:33 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Faults have been converted to events and we are now polling the fault
> register each time we read a sample, so we no longer need the fault
> attribute.
> 
> This attribute was not suitable for promotion out of staging anyway
> since it was returning multiple values in a single attribute.
> 
> The fault clearing feature should not be needed unless we need to
> support the fault output pins on the chip which is not currently
> supported. So we can add this feature back in if we need it later.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied
