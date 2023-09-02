Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FAD79059B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351671AbjIBGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:36:51 -0400
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC11702;
        Fri,  1 Sep 2023 23:36:47 -0700 (PDT)
References: <20230825050618.never.197-kees@kernel.org>
User-agent: mu4e 1.10.6; emacs 30.0.50
From:   Sam James <sam@gentoo.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Salvatore Mesoraca <s.mesoraca16@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, kernel@gentoo.org
Subject: Re: [PATCH] hardening: Provide Kconfig fragments for basic options
Date:   Sat, 02 Sep 2023 07:35:07 +0100
Organization: Gentoo
In-reply-to: <20230825050618.never.197-kees@kernel.org>
Message-ID: <87ledpcc92.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees Cook <keescook@chromium.org> writes:

> Inspired by Salvatore Mesoraca's earlier[1] efforts to provide some
> in-tree guidance for kernel hardening Kconfig options, add a new fragment
> named "hardening-basic.config" (along with some arch-specific fragments)
> that enable a basic set of kernel hardening options that have the least
> (or no) performance impact and remove a reasonable set of legacy APIs.
>
> Using this fragment is as simple as running "make hardening.config".
>
> More extreme fragments can be added[2] in the future to cover all the
> recognized hardening options, and more per-architecture files can be
> added too.
>
> For now, document the fragments directly via comments. Perhaps .rst
> documentation can be generated from them in the future (rather than the
> other way around).
>

This is likely to make life a bit easier for us downstream in Gentoo,
where we currently supply a patch for KSPP:
https://gitweb.gentoo.org/proj/linux-patches.git/tree/4567_distro-Gentoo-Kconfig.patch?h=6.4#n237.

> [1] https://lore.kernel.org/kernel-hardening/1536516257-30871-1-git-send-email-s.mesoraca16@gmail.com/
> [2] https://github.com/KSPP/linux/issues/14

best,
sam
