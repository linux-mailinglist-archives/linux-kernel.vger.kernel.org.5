Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBC57F856E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKXV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:28:19 -0500
X-Greylist: delayed 2385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 13:28:25 PST
Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D4CD41;
        Fri, 24 Nov 2023 13:28:25 -0800 (PST)
Received: from [121.99.247.178] (port=12167 helo=creeky)
        by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
        (envelope-from <mcree@orcon.net.nz>)
        id 1r6d5c-0003Ui-0D; Sat, 25 Nov 2023 09:47:52 +1300
Date:   Sat, 25 Nov 2023 09:47:50 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] remove the last bits of a.out support
Message-ID: <ZWEL9r5nqyRSfB-t@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
 <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzzu1w0.fsf@email.froward.int.ebiederm.org>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:00:15AM -0600, Eric W. Biederman wrote:
> Dimitri John Ledkov <dimitri.ledkov@canonical.com> writes:
> If it is old code like aboot it may be that it is
> difficult to test any changes.  If memory serves you have to flash your
> firmware to change/test aboot.

No, aboot is written to the first sectors of the boot disk. Yes, there
is a special utilty in the aboot tools to write aboot to the boot
sectors and make sure that there is no overlap with the first
partition.

Cheers
Michael.


