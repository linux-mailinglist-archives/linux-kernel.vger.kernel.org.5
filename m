Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814EE800B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378901AbjLAMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378899AbjLAMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:38:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1261729
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:39:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7840C433C9;
        Fri,  1 Dec 2023 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701434344;
        bh=35D2snuMpVehcg+ViRKqORPYjANnyd0dWZydo9aQjGQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NmOMEFfW6fJYpHz4HPWPs01Kdiw9UkXJlzEdrOuD5JqZaYVuO0EDaw1fynUZXiQh/
         hbEAjKNi0Pwgm+nLj3zAYSZJIZrWxm1Q1lc/dLirL2phsLIEg6Od3fJlN8r6VLhcw7
         BCiamNIgbUrWDteWyqzbt1IUNhkXRcS0FehssX2g1dY1Fii1ZEbdDzxJXP9LRh9WaL
         pTAi3UTr3Cl8m8hkIG6T1vjf/JmcG5NZFl9i8z/9Vl68WTGZpsCu4ALXx4lXTwRMRy
         zsRRLQc1mEor6+rXAaXQUBM5jrcB1YSgBjypU0YyICzR35akLHy6XBv3rTFx8A8unC
         ZLoIlHUQd1esg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143434079.2072551.9169872706121192136.kvalo@kernel.org>
Date:   Fri,  1 Dec 2023 12:39:02 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Moreover, since this seems to cross the file boundary let's NUL-pad to
> ensure no behavior change.
> 
> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
> it.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

70582e26f5d9 wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

