Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44BC7F7791
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbjKXPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjKXPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:21:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E2CC1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:21:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FD1C433C9;
        Fri, 24 Nov 2023 15:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700839311;
        bh=LkiNqv5TLRrCYY7WjHKTVSxGQ3WbJ9zRq3lhvDB/w5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/9coW4PM7Gn/qWd0DzK4w2XzWyxbcALDAI5l6Vb2vdjqsWYlAtul/n2JQvGF7Dw+
         TnnrLfjHc+CfBl588vn97XZvfe81pG0VEKW3urDahIVGfzyJl+NNMPQvcDpwq536bV
         G4wvoFiR0jBlzzHOjQSV0rcj2GClWAnaxHPRP4sVX0NdAzd7RlOpc1N5hsCkyNFE1h
         Si4S82K8eiKJLRWLp3naWVPkbUF7M/NivzWBPjOygxZm5Om0Iu88zVZLY845pC+X5S
         aCd0rn+ZN5BKKygLea38GB1+cbjvhtC0k4mPdyLOv/fXtDTULPpi+Ccn/0/xg+G0Kq
         OYcW5MMQ48eLA==
Date:   Fri, 24 Nov 2023 16:21:46 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/clone3: Make test names for set_tid test stable
Message-ID: <20231124-eintagsfliege-brennen-385b1d96defe@brauner>
References: <20231115-kselftest-clone3-set-tid-v1-1-c1932591c480@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115-kselftest-clone3-set-tid-v1-1-c1932591c480@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:43:02PM +0000, Mark Brown wrote:
> The test results reported for the clone3_set_tid tests interact poorly with
> automation for running kselftest since the reported test names include TIDs
> dynamically allocated at runtime. A lot of automation for running kselftest
> will compare runs by looking at the test name to identify if the same test
> is being run so changing names make it look like the testsuite has been
> updated to include new tests. This makes the results display less clearly
> and breaks cases like bisection.
> 
> Address this by providing a brief description of the tests and logging that
> along with the stable parameters for the test currently logged. The TIDs
> are already logged separately in existing logging except for the final test
> which has a new log message added. We also tweak the formatting of the
> logging of expected/actual values for clarity.
> 
> There are still issues with the logging of skipped tests (many are simply
> not logged at all when skipped and all are logged with different names) but
> these are less disruptive since the skips are all based on not being run as
> root, a condition likely to be stable for a given test system.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

May I already acked this. Not sure,
Acked-by: Christian Brauner <brauner@kernel.org>
