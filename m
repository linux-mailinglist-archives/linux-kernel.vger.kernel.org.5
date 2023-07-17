Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56559755F77
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGQJh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGQJg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:36:58 -0400
X-Greylist: delayed 523 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 02:35:39 PDT
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D23268F;
        Mon, 17 Jul 2023 02:35:39 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 5FC5B60C3E;
        Mon, 17 Jul 2023 09:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1689586014;
        bh=vep3U0FI1kAok0X1qvpl7BpLfpnW97N1GFHQbWmFZ+o=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=g5uCok//2pOr5ZnpMB/0oLKgDrdrILkGAE8lYl+Rk8yVrw8XQIrlutxr/rThAGPi1
         EjY5xrndbHxyAT1nQTnefGJGhpgahEuB2o2poaXayHHnDNyxvupWkAoEBZj9XFQfIX
         YGo5s2H56Vz86T4iXvwjJUkKGMk4TFrfLyX00gtGNd4fBFmmdXAKzAhqofvwYrZu8d
         boqHQfc6Y1F/vgRlflT6OpsWLjj6o4I72hCmgksBWgwiRtR5f0XrX9v1WRa83LYccy
         dfpNpGI3gLOv0003ZKXX9m5O6lTFc+/TRSS6vXiws4EygxtsGfy9IdJujSWvlGTxmx
         fRWuxq19tTjFQ==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 354421458E8; Mon, 17 Jul 2023 11:27:16 +0200 (SAST)
Date:   Mon, 17 Jul 2023 11:27:16 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Qt6 port of kconfig qconf
Message-ID: <boris.20230717111132@codesynthesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Code Synthesis
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there interest in the Qt6 port of qconf (which is currently Qt5)?

I took an exploratory stab at it and I've managed to make it compile
and run with relatively few changes, though there are quite a few
warnings about using deprecated stuff.

I can see three possible approaches here:

1. Drop Qt5 support and port qconf to be exclusively Qt6. This should
   allow cleaning up all the deprecated stuff.

2. Support Qt5 and Qt6 in the same qconf.cc. With this approach it's
   unlikely we will be able to cleanup the deprecated stuff without
   turning it into an #if soup.

3. Leave qconf.cc to be Qt5-only and make the changes in the qconf6.cc
   copy. This will allow us to clean up all the deprecated stuff but
   will require applying further changes to two files until we drop
   support for Qt5.

Thoughts?
