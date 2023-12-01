Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7708D8009EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378539AbjLAL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378502AbjLAL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:28:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD1C4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:28:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5904FC433C7;
        Fri,  1 Dec 2023 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701430098;
        bh=uvMHIZgiQxy6ho9nUbJyQac6XPj97lP3/ykgmr3gue4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S0zTgqRbjQqDw0qP9V9F40QB8vgp9BKpXWU1yYp3As7xlsFebDl9uDq1e77EYjKJ+
         rVB7iMCLahIu+lmrBaHbtpktC/DS3Fqi72ftCd55Eal1raJyJlMtSCATf+1tO/mcdp
         8U7FTC2FDhDQrbqeQetUlo5Ty9nOVBUIh5ow4xR0zOOa3G+86VMEydjcvt0fGkhmDR
         llLuBWrrRq0xApKtoJ6mKGJHldNSmyXQX5XXiv3SsrVlW4Ynv8L3l/thJgBxsGZUz0
         N1gmHWQF1vzgrnvmkHwVWgGvDiscBzKfsmIsPvhiJESL7yWSNwhNl2ztOwPpjzvl9C
         2u+8iTbBA58vA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
References: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 1/2] mfd: cs42l43: Correct SoundWire port list
Message-Id: <170143009710.3372247.16198521213807802982.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:28:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 11:57:11 +0000, Charles Keepax wrote:
> Two ports are missing from the port list, and the wrong port is set
> to 4 channels. Also the attempt to list them by function is rather
> misguided, there is nothing in the hardware that fixes a particular
> port to one function. Factor out the port properties to an actual
> struct, fixing the missing ports and correcting the port set to 4
> channels.
> 
> [...]

Applied, thanks!

[1/2] mfd: cs42l43: Correct SoundWire port list
      commit: 9498ccf50edaba2f21ed209af22adf9a0ca8d1c3

--
Lee Jones [李琼斯]

