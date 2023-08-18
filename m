Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529707808E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359408AbjHRJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359404AbjHRJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:45:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C5341FC3;
        Fri, 18 Aug 2023 02:45:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B47D75;
        Fri, 18 Aug 2023 02:46:10 -0700 (PDT)
Received: from bogus (unknown [10.57.34.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CB0B3F762;
        Fri, 18 Aug 2023 02:45:27 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:44:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] power: vexpress: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <20230818094453.pc7zlzl4lvjk3zpx@bogus>
References: <20230814-void-drivers-power-reset-vexpress-poweroff-v1-1-c3d9b0107e5d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-void-drivers-power-reset-vexpress-poweroff-v1-1-c3d9b0107e5d@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:21:51PM +0000, Justin Stitt wrote:
> When building with clang 18 I see the following warning:
> |       drivers/power/reset/vexpress-poweroff.c:124:10: warning: cast to smaller integer type 'enum vexpress_reset_func' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |         124 |         switch ((enum vexpress_reset_func)match->data) {
> 
> This is due to the fact that `match->data` is a void* while `enum vexpress_reset_func`
> has the size of an int. This leads to truncation and possible data loss.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>

Hi Sebastian,

I am assuming you will pick this up.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
