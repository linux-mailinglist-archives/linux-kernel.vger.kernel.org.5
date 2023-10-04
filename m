Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22397B8D32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbjJDTIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245502AbjJDTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:08:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD713AAF;
        Wed,  4 Oct 2023 12:04:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DF5C433C8;
        Wed,  4 Oct 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446279;
        bh=FOugjPZCYbC6WkKaxY/8HY2+LvaEd3TPVgFIsSpXr24=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cRutD2LzikJC6PvYyFmcgbzU23EDNbIdZ8ON2fYHiUi5wg8ZZ4VkfXx62LCVWIIL/
         LEUHPTInUrhUWMFPWyeD+gOuMMa24oyUADQ8jtgH5ruwbz73eKPoq0gqILrbvZQMKX
         Z6sglB54DxsVxpcNaJvfUdA3OOP0AiKOXAZzE+EZJU+BWXMYl0nEuXrVboQYpbCH/p
         7/5SOwanq/MiZGRDeRuCRVJFlscMKpksJEwwKK62LP07Q1DpIjyR9Cfmfhn4pfHqw8
         ShijCM5sP8YTQNwy59xtFE0Rb/4n7yyo9BDYbiIsH25T5n7xPgLCji5y6keVPfMWzC
         CTaoyQW/A89SQ==
Date:   Wed, 4 Oct 2023 21:04:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Martino Fontana <tinozzo123@gmail.com>
cc:     djogorchock@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] HID: nintendo: reinitialize USB Pro Controller after
 resuming from suspend
In-Reply-To: <20230924140927.9844-2-tinozzo123@gmail.com>
Message-ID: <nycvar.YFH.7.76.2310042104270.3534@cbobk.fhfr.pm>
References: <20230924140927.9844-2-tinozzo123@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023, Martino Fontana wrote:

> When suspending the computer, a Switch Pro Controller connected via USB will
> lose its internal status. However, because the USB connection was technically
> never lost, when resuming the computer, the driver will attempt to communicate
> with the controller as if nothing happened (and fail).
> Because of this, the user was forced to manually disconnect the controller
> (or to press the sync button on the controller to power it off), so that it
> can be re-initialized.
> 
> With this patch, the controller will be automatically re-initialized after
> resuming from suspend.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216233
> 
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

