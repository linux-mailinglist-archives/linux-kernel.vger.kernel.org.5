Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A509753BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGNNiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjGNNiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:38:22 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480A2D73;
        Fri, 14 Jul 2023 06:38:20 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 673AC58ECE726; Fri, 14 Jul 2023 15:38:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 66987619D0BB2;
        Fri, 14 Jul 2023 15:38:18 +0200 (CEST)
Date:   Fri, 14 Jul 2023 15:38:18 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
In-Reply-To: <20230714122111.7528-1-msuchanek@suse.de>
Message-ID: <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com> <20230714122111.7528-1-msuchanek@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 2023-07-14 14:21, Michal Suchanek wrote:

>Some distributions aim at not shipping any files in / outside of usr.
>
>The path under which kernel modules are installed is hardcoded to /lib
>which conflicts with this goal.
>
>+MODLIB	= $(INSTALL_MOD_PATH)$(KERNEL_MODULE_PREFIX)/lib/modules/$(KERNELRELEASE)

Ok, so if the problem statement is that hardcoded paths are bad, then why
continue to hardcode the "/lib/modules" fragment? Just make it so that
KERNEL_MODULE_PREFIX can be set to the exact string "/usr/lib/modules" and not
just "/usr".
