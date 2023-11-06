Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB67E31A7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjKFXvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFXvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A667692
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 15:51:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4237C433C7;
        Mon,  6 Nov 2023 23:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699314678;
        bh=ug7V1tbLRIildaS+c6ipgNYbpP3MEP1leM3HDA/pNkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g/J1Ta1DDq5rM2T0i0r2i8ySnmYDnynAyI8MgLPEtC83Sc1yqctCBvAM7mV58yjpV
         XAlZcJOR/lZ0+6KLOLaVgfnoH849vWznNg2tLTK8OpJJ8c4fSpX6dSNyVIH4BoFJ56
         Z8dZb0HzliYqJH3ScFvBR7mCPYAbw9GldSFgHbJ46E1jCkLxw77XQXpkP6XUDA7d5a
         c1MjSrTqnkRAr9syYUW3CtFskcFDtKzAGC49s39p1nhOFbTQqNK6zQorbxSPAgj9Tp
         CFxYonO+6HMVOF0L1d0a3xpRF7g0uhces3+/XJugNe71DetWe/QMl9ViY4Mmmutupj
         oJfmMudJysf1w==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon/sysfs: fix unhandled return values
Date:   Mon,  6 Nov 2023 23:51:16 +0000
Message-Id: <20231106235116.95842-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106233408.51159-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 23:34:05 +0000 SeongJae Park <sj@kernel.org> wrote:

> Some of DAMON sysfs interface code is not handling return values from
> some functions.  As a result, confusing user input handling or
> NULL-dereference is possible.  Check those properly.
> 
> Please note that these patches are not cleanly applicable on mm-unstable
> since mm-unstable has dropped the mainline-merged patches and rebased on
> v6.6, while some DAMON patches that these patches are depend on are
> merged in the mainline after v6.6.  I confirmed these patches can
> cleanly applied on latest mainline, or mm-stable-2023-11-01-14-33.

I just checked mm-unstable has just updated, and confirmed these patches can
cleanly applied.


Thanks,
SJ

[...]
