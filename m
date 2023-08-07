Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAB771ED8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjHGKwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjHGKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:52:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50590E70;
        Mon,  7 Aug 2023 03:52:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSxqG-00086H-9t; Mon, 07 Aug 2023 12:52:04 +0200
Message-ID: <f0870e8f-0c66-57fd-f95d-18d014a11939@leemhuis.info>
Date:   Mon, 7 Aug 2023 12:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kurt Garloff <kurt@garloff.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: Drop 0fc6fea41c71 ("drm/i915: Disable DC states for all commits")
 from the 6.0.y series?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691405527;a50531da;
X-HE-SMSGID: 1qSxqG-00086H-9t
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg! Months ago you picked up mainline commit a2b6e99d8a6
("drm/i915: Disable DC states for all commits") for the 6.1.23 release
as commit 0fc6fea41c71. It causes issues vor a few people (at least
three, two of which are CCed) -- apparently because it depends on some
change that wasn't picked up for 6.1.y. This is known for a while now,
but nobody has yet found which change that is (Al found something that
worked for him, but that didn't work for others). For the whole story
skim this ticket:

https://gitlab.freedesktop.org/drm/intel/-/issues/8419

I wonder if it might be better if you revert that commit for 6.0.y; I
asked already in the ticket if this is likely to cause regressions for
users of 6.0.y, but got no answer from the i915 devs (or did I miss
something?). :-/

Ciao, Thorsten
