Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ABB7CD699
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344704AbjJRIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344691AbjJRIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA10C6;
        Wed, 18 Oct 2023 01:32:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D0C433C7;
        Wed, 18 Oct 2023 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617975;
        bh=+prAov5OlbashqVGxd23DwmWrUyjOJwX2ICX0AH4eVk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CjNGqGSWvHrtKbQ8zCQwdIxW0T3ZUh4VZ0mPhRZeGATCcL2Ix/xxbr5jmNFcLAnkh
         2QR2tCY99zo5BP6mUMV8iFdkZOr7vQypBc6Bjfn1nHce/YLNSSu2bGa5KLxygL6lpd
         AoZW9A0owRuwaKaikjkw5mVdS4sR5r2sudCe77sVPPpmlFXz4AMKRV611Ldb4Nq3L1
         eOS6aFHzYuL2MayCdF5RsHwrzVIoY2Z5URWo1sJDcWMby+MM+Q1zgVIeCK+450zs04
         cz/rfPAoX1BSRhm92C1OlpLXXNFUJjgZLzWvMMRG4bMmFVjUTLBFyFc7c5MiiKHIcz
         M/f4ABa127O2Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: replace deprecated strncpy with memcpy
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com>
References: <20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761797261.48072.1075267340140520177.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:32:54 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
> 
> The affected code's purpose is to truncate strings that are too long
> with "..." like:
> foobar -> fo...
> 
> The lengths have been carefully calculated and as such this has decayed
> to a simple byte copy from one buffer to another -- let's use memcpy().
> 
> Note: build-tested only.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

40990961d983 wifi: ath6kl: replace deprecated strncpy with memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

