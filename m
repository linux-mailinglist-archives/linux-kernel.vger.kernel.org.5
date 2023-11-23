Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE80B7F6714
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjKWT0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345874AbjKWT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:26:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B9F10E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:26:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8253CC433C9;
        Thu, 23 Nov 2023 19:26:19 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm64: add dependency between vmlinuz.efi and Image
Date:   Thu, 23 Nov 2023 19:26:17 +0000
Message-Id: <170076756599.3159824.14293812187454563745.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231119053234.2367621-1-masahiroy@kernel.org>
References: <20231119053234.2367621-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 14:32:34 +0900, Masahiro Yamada wrote:
> A common issue in Makefile is a race in parallel building.
> 
> You need to be careful to prevent multiple threads from writing to the
> same file simultaneously.
> 
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") addressed such a bad scenario.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: add dependency between vmlinuz.efi and Image
      https://git.kernel.org/arm64/c/c0a857420405

-- 
Catalin

