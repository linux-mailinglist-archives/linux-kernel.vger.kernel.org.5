Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30797B6E53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjJCQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbjJCQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:23:51 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC8A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:23:46 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4S0NRf3F6Lz1sB7V;
        Tue,  3 Oct 2023 18:23:40 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4S0NRb4yb1z1qqlS;
        Tue,  3 Oct 2023 18:23:39 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id aP66i6RqkI-7; Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
X-Auth-Info: DEcWQ3O3Q8oqxyW+2oC9tHdwulLSJUIRdEt3IUmb5jjP2Lci+dS0J9Uj4ULe5Ygi
Received: from igel.home (aftr-62-216-205-214.dynamic.mnet-online.de [62.216.205.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 690602C0052; Tue,  3 Oct 2023 18:23:37 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Ding, Shenghao" <shenghao-ding@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Lu, Kevin" <kevin-lu@ti.com>,
        "13916275206@139.com" <13916275206@139.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "mengdong.lin@intel.com" <mengdong.lin@intel.com>,
        "Xu, Baojun" <baojun.xu@ti.com>,
        "thomas.gfeller@q-drop.com" <thomas.gfeller@q-drop.com>,
        "Gupta, Peeyush" <peeyush@ti.com>,
        "Navada Kanyana, Mukund" <navada@ti.com>,
        "tiwai@suse.de" <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoC: tas2781: fixed compiling issue
 in m68k
In-Reply-To: <CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
        (Geert Uytterhoeven's message of "Tue, 3 Oct 2023 14:15:36 +0200")
References: <20231002090434.1896-1-shenghao-ding@ti.com>
        <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
        <79c4d534ad20452c992d8ace138e4384@ti.com>
        <CAMuHMdXRGxnGpVHiB+Zvxq+G4K-BL8JsJGbG+7CNtJiqGwHOsQ@mail.gmail.com>
X-Yow:  I am covered with pure vegetable oil and I am writing a best seller!
Date:   Tue, 03 Oct 2023 18:23:37 +0200
Message-ID: <87v8bn3cae.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 03 2023, Geert Uytterhoeven wrote:

> Looks like the compiler is sharing the jump table at L95 for two
> different switch() statements, but the PC-relative offset to refer to
> the table is too large when using -m68000.  It works fine with -m68020.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104028

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
