Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB03753CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjGNOM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGNOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:12:25 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7946730C4;
        Fri, 14 Jul 2023 07:12:24 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id EFCDA58740D43; Fri, 14 Jul 2023 16:12:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id EE00360C22668;
        Fri, 14 Jul 2023 16:12:22 +0200 (CEST)
Date:   Fri, 14 Jul 2023 16:12:22 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 3/4] kmod: Add config command to show compile
 time configuration as JSON
In-Reply-To: <20230714140229.GJ9196@kitsune.suse.cz>
Message-ID: <23n92nss-8571-77p8-3026-7344145414o@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <20230712140103.5468-3-msuchanek@suse.de> <429o975-ro63-o94r-qs96-76ro6o28on5@vanv.qr> <20230714140229.GJ9196@kitsune.suse.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 2023-07-14 16:02, Michal Suchánek wrote:
>> 
>> What about doing it like systemd and generate a .pc file instead 
>> that can then be queried like so, e.g.:
>> 
>> $ pkg-config kmod --variable=modulesdir
>
> - .pc files would be shipped with libkmod development package, not the
>   kmod tool in a binary distribution

On that point: No, they would not.
Again, confer with systemd: systemd.rpm(SUSE) provides systemd.pc,
systemd-devel.rpm provides libsystemd.pc. kmod.rpm would provide
kmod.pc, kmod-devel.rpm would continue to provide libkmod.pc as
it does today.
