Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBE7572B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjGREMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGREMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:12:49 -0400
Received: from codesynthesis.com (codesynthesis.com [188.40.148.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BF21B5;
        Mon, 17 Jul 2023 21:12:47 -0700 (PDT)
Received: from brak.codesynthesis.com (unknown [105.186.254.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 646F160C3C;
        Tue, 18 Jul 2023 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codesynthesis.com;
        s=mail1; t=1689653566;
        bh=e+Ak/C0qRRg7BR1HQiAOxhJWiRhFimBTDg1Cm5i3ntY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:From;
        b=re443lPEd0v3/aMy2HfgW9VkAShYcmbtyMhriYIG3Q5z8X1wOGLfI+1oj41+bKhHQ
         mvMDZGve91qqI3OaM6UqPaMkQqAN1JbNrfRXd6EIvIROGLUW8rq/N1E43qX8jDaLmK
         WLqHZHytDXzei0bTeGy7OMMj3OiDEAuAewCBR2qO+T4Ti7zj5/vmFL2ymOM2cztftf
         mHSAAAyGMNyY88LllqYT/m+pfxjZhiPzsZgQzt3RCm0yxBZyskj3ToTi4PEGC2zDUC
         iqx68DypJPFuR36L6L60dMl6laI5msazTz2/VqFE6a/Blx3YY3zr79/iUiQ4E2uDpU
         LmzHMXBpEC03w==
Received: by brak.codesynthesis.com (Postfix, from userid 1000)
        id 074F4145944; Tue, 18 Jul 2023 06:13:09 +0200 (SAST)
Date:   Tue, 18 Jul 2023 06:13:09 +0200
From:   Boris Kolpackov <boris@codesynthesis.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Qt6 port of kconfig qconf
Message-ID: <boris.20230718060325@codesynthesis.com>
References: <boris.20230717111132@codesynthesis.com>
 <CAK7LNATAYqG+Y-XubnU9EJqc3R9QhWCn1nfiGMLU63W7k0vpxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATAYqG+Y-XubnU9EJqc3R9QhWCn1nfiGMLU63W7k0vpxQ@mail.gmail.com>
Organization: Code Synthesis
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> I like 1 or 2, depending on the size of #if soup.

Looks like it won't be too dense if we are willing to only care about
the latest version of Qt5 (i.e., 5.15.0 or later) since most of the
changes appear to also work in the latest Qt5 (they may also work in
earlier versions, but I don't have easy access to those to check).

Should we go with support for "latest Qt5" and Qt6?
