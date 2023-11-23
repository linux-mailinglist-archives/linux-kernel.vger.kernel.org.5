Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488497F63DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjKWQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKWQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:24:49 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24647B0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1700756692; x=1701015892;
        bh=UtahpTMUIkzRRkLLl/RDgccHpG8+Tv/LRGhCg/01Fe8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=KFKx8LXc6AFb6BvzMma3qYOE4eoj8SHnsCn8MEICv6IajMp7hSDIs0omOsTCGSesW
         ku0WtE3pWlIQLMaiJiPZDclndKyxkJTG+wgRCG0VMFMmWT+pWQQyrpelITxeoWyGW2
         nNgm+cSSOqXNEU21VW3sR7uk2SQbPm4zao3spvUYTcvJc1MZRSHUL5HOW+GkB9w9nd
         x/4UzvPVq2Zot6S1SzyCvRHNcn6vPfB2uH1TpyHs+vbd3DmZpfRCx0Tc3hewHlZwvd
         9OE3tqbPBJM4gEzUqTz5+NKMdZBHicZ8qRUQ9SN09YmrDcWd5h2r2dECYEgeap7CnC
         C5cGpakrBNnsQ==
Date:   Thu, 23 Nov 2023 16:24:36 +0000
To:     =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        pierre-eric.pelloux-prayer@amd.com,
        =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        intel-gfx@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>, xaver.hugl@gmail.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pekka Paalanen <ppaalanen@gmail.com>,
        dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
        alexander.deucher@amd.com, christian.koenig@amd.com
Subject: Re: [PATCH v9 0/4] drm: Add support for atomic async page-flip
Message-ID: <WG-nBy-xqSEAQQX1ASB9Gw7Ra0aZ-qFYDQq1mXjQdOTwxlM1wEROginNiWbnM9CZE9idUyE6P5urNZ8q8kFMswbPt5ewbk3ocuIVnajQpAQ=@emersion.fr>
In-Reply-To: <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
References: <20231122161941.320564-1-andrealmeid@igalia.com> <cc10f6b0-e26e-4021-85ca-33cb1e58e937@amd.com> <50ff86d4-5ce1-4ae5-aafb-ce3bc0069629@igalia.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! This iteration of the first 3 patches LGTM, I've pushed them to
drm-misc-next. I've made two adjustments to make checkpatch.pl happy:

- s/uint64_t/u64/
- Fix indentation for a drm_dbg_atomic()
