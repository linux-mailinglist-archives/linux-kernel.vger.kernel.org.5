Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CE17B3FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbjI3KLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjI3KLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:11:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70461A5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 03:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
 t=1696068689; x=1696673489; i=daggs@gmx.com;
 bh=U8mJ977ngWJQx/0rMVR2wpYC/CtyKa/JE57NogQDcdU=;
 h=X-UI-Sender-Class:From:To:Subject:Date;
 b=LFw4yND9MkYyBXWI7NB6jScbyx8/O9bXFud02i6Fv/6fzWTI+eHhOr2G1UFI3cP1CCN2LmIOtJM
 Kh05Hc2t9w8eogBkVbkswM4enSPU825mvR/O0FJAFUVEOQhXln8LuGGHLRW0Nw33Xu9DfNF77keYz
 RUpYQth05xMd7TZJ3EQzjXf9j9EjCXBADGyqqeAZ4KE3kfLQdf9O0+Lu41KhQqHZwRxWsyaP/H+WA
 yj05gCcHCkyXxGsJMzCajWyzg0Z9ZFhqx+oRkFwl+PMIlDQuB9t7yj9cttqahqhI/3Ff8tooeyq/N
 xMxQIKLSn//uK71MEU2xghoqeN2+HB5GRoCQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [176.231.7.11] ([176.231.7.11]) by web-mail.gmx.net
 (3c-app-mailcom-bs15.server.lan [172.19.170.183]) (via HTTP); Sat, 30 Sep
 2023 12:11:29 +0200
MIME-Version: 1.0
Message-ID: <trinity-c4c6b25b-8372-453e-b5e5-5d4003282d7c-1696068689143@3c-app-mailcom-bs15>
From:   daggs <daggs@gmx.com>
To:     linux-kernel@vger.kernel.org
Subject: question regarding coding convention
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 30 Sep 2023 12:11:29 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:7Ys1+4NyHXoYdvT2dULbeKHCUTMkshTMeO//f8Gw+HFilblPs88USEI1am3Inrzx2amCC
 NspDW3mQ4b+5+4udunXajJ2GxdkZ2PN33+PNtDaSgAbRN9g81BqAU2oTBrwWVgy/t7RsBSGp5RMJ
 Ui9jGRGeEdA44z+txemPEibzGfWcpReuJAm7lyayB9pUYZiTntGvjI/yLzCt8LGA+dKJCGMuvgsr
 eoHPazoXzPq1+WJ/8kC8t5A3rVbh53K+jaHb+C/91o+v2U+17nV5C7e5kN9tofpfL6Yb+DRt3NcH
 GU=
UI-OutboundReport: notjunk:1;M01:P0:aAot45z6qxI=;8DFym5phfhtfc8dtQQQG8Ax/480
 PU4zBozSHKV129p8dVyhK63sjzmqj8px0PGn7m7ihp5uV/d68igBb0fh+tNrMXwtnnr0hQZVU
 dID/Y8VxuSpXklhgnfp93Xc+oRfx1vFG3/REIXIKtSe0F2fjJVFK5yFit0qYvW3x6UkAzUet+
 yXr09JDlb5D3FENkzV4Vwtvv2ztGKpmsGslvfHSV2By9jcrurI0vSwdEa7hJfx23PDwrJkFbn
 tMxvsPgrrmrX3Tj16utacOc4jJXe6IDSzC5pGq/HRdwNA/XxACtsSYHgutSyEykPE0P0diD0b
 3J9gK0z8d+TtjJenyiGEvvxPI22DUQKzGzW/CRL5yuiSuDwt0EecVQ5ABOSa/XDOWlN9xz45A
 0ZTcfvH5kc0f0MMrmiO6QH6djoEUb8Fr20Bw4sIAytxA6jOLO7w4rBbrA7ODbAigBr2vbbv+C
 X7kIGljEbKXHcSLxlfibCFa4efKQzkjIjoIDgHshtLs3hgxVCUguKCoIA1U2WYTmfdbb801/m
 rk8LkeQ3HfPGZ1d5hvUal7XowZR019vP1Vr9IkWw2p/X+iq5zco3aS+XrqjCgtdD3ehFqAU5N
 K7Pkf/yBp9S2bHSE4NcvkQQ4CMvAiH8pTa2awLvkTZ32wzOWG+pWM72D+2mSgcokf62eEAoM8
 y0qpyBZMLx1Xxe80ja7I4JYeuUUrNQ3EZP7bDjxYxzMcrS3gMBZajKTXe5oiHamXdRGaAX3mg
 Agj1HxTvkYRSIk+C/o4VoiReHuvwrU/HulbSDrPUPfXC2slCpKQ9OealaBRvbMMFgEauKbjK4
 eIT8azrZZpNLjPIqUqN0RJkvysOsNkqoJBSWk7oHIKfUE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a question regarding the kernel coding convention.
lets say I want to add a new arch named foo and there is a func named goo which all other archs are implementing but foo isn't.
what is the proper way to handle it? as the kernel code is quite big, I didn't found any example.

Thanks,

Dagg
