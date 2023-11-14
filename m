Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155877EBA1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjKNXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjKNXLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:11:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBCBD0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:11:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13A0C433C7;
        Tue, 14 Nov 2023 23:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700003490;
        bh=ba2QEom3zbODMTWcx71buWKgRzMLEZXyjXkHeEHpgz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LyzijmPhOQb2u4vq5ci8XuVjNiR5GxxH4XZGeEoVQErbQDm1Ih/KyAjkS4dWkhQt4
         NHZ93D8M/55ZeaKExJL2vAlBKilRxzkkOWyOOkP1Xe40ZQZcRF09y225tcjbl19qfk
         QiLfUa3rP9+T1zj4cyxO8J8orWvzLQJhgSt7MRc0=
Date:   Tue, 14 Nov 2023 15:11:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Paul =?ISO-8859-1?Q?Heidekr?= =?ISO-8859-1?Q?=FCger?= 
        <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
Message-Id: <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org>
In-Reply-To: <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
        <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
        <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 12:00:49 +0100 Marco Elver <elver@google.com> wrote:

> +Cc Andrew (get_maintainers.pl doesn't add Andrew automatically for
> KASAN sources in lib/)

Did I do this right?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: MAINTAINERS: add Andrew Morton for lib/*
Date: Tue Nov 14 03:02:04 PM PST 2023

Add myself as the fallthough maintainer for material under lib/

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 MAINTAINERS |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/MAINTAINERS~a
+++ a/MAINTAINERS
@@ -12209,6 +12209,13 @@ F:	include/linux/nd.h
 F:	include/uapi/linux/ndctl.h
 F:	tools/testing/nvdimm/
 
+LIBRARY CODE
+M:	Andrew Morton <akpm@linux-foundation.org>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
+F:	lib/*
+
 LICENSES and SPDX stuff
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_

