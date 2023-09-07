Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F84797B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343922AbjIGSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbjIGSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:22:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC0BC;
        Thu,  7 Sep 2023 11:21:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17127C116A6;
        Thu,  7 Sep 2023 10:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081852;
        bh=D0YOmx6OmWNMjeQsTguLfhAxPqjOL7Fqu32QbhYTxuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xFnH3zyxOjdc/5PApRBOvRxsczKfMFO53DMNu+7ggCtE6+fkwfmdo2vpIReLjKM8r
         bgL7WDhHKggA/SmDHlNcKXhkBLk2rDDDpbTlwNGUXxPJIeoRDA9qJNTMHIQGWFsWt+
         q+YvS982eyZA9HKSi9Hwwfw4iM/RNd1MnFaKWiiE=
Date:   Thu, 7 Sep 2023 11:17:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Consider picking up "tpm: Enable hwrng only for Pluton on AMD
 CPUs" rather sooner than later
Message-ID: <2023090722-molehill-ranking-65e8@gregkh>
References: <a8d206b6-d1d8-4c9a-b82c-724c2def0491@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d206b6-d1d8-4c9a-b82c-724c2def0491@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:21:07PM +0200, Thorsten Leemhuis wrote:
> Hi stable team, JFYI, the recently mainline commit 8f7f35e5aa6f21 ("tpm:
> Enable hwrng only for Pluton on AMD CPUs") from Jarkko contains a stable
> tag, but it might be worth picking up rather sooner than later, as it
> fixes a regression that seems to annoy quite a few users of 6.1.y, 6.4.y
> and 6.5; that's why at least Fedora is already working on picking the
> fix up ahead of the stable-tree.

Now queued up, thanks.

greg k-h
