Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87987F5756
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjKWEKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjKWEKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:10:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E545100
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:11:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50803C433C7;
        Thu, 23 Nov 2023 04:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700712659;
        bh=vEGs5HAbjF1IAM1gT6KyCx139kNtp9F8hRI7yxkVjjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ob/WMaSz5Puzesg6kIs0WCLO0Ey5+KAdsoLiBDcp/oMg2ahAG2r/ibJLtOD+W6iJn
         n279jAkbaKCxO5BeXXxQQoabBZg652kQ0j4V73Oouz36u2S9z95o5EpwRHKuh22gOQ
         F5ItVw5kQEhfxeDVdsI1aDUsSp4x1kurKleSiJt1vKL0gcK1tjyBm/KzEwX4/SlxQQ
         NU0aKWXCX0iZj04V+SLPfREzoJj5FEs7Nb4fQo8mJK9+NUq7hevNJBNpwvdJhZ2bfF
         hPPBHqNAA84FNqbubT3znkYm6kD5VpoYgU0vToxP11vB05s80+kJ71L5WvpGJNdkXu
         /HvGmk+0tNhUw==
Date:   Wed, 22 Nov 2023 20:10:58 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sagi Maimon <maimon.sagi@gmail.com>
Cc:     richardcochran@gmail.com, reibax@gmail.com, davem@davemloft.net,
        rrameshbabu@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maheshb@google.com
Subject: Re: [PATCH v1] ptp: add PTP_MULTI_CLOCK_GET ioctl
Message-ID: <20231122201058.0bfb07a9@kernel.org>
In-Reply-To: <20231122074352.473943-1-maimon.sagi@gmail.com>
References: <20231122074352.473943-1-maimon.sagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 09:43:52 +0200 Sagi Maimon wrote:
>         Some user space applications need to read some clocks.
>         Each read requires moving from user space to kernel space.
>         This asymmetry causes the measured offset to have a significant error.

Please CC maheshb@google.com on v2, he was doing something similar
recently.
