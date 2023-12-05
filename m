Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC528053CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442342AbjLEMHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442195AbjLEMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:07:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9307A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:07:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA3C433C7;
        Tue,  5 Dec 2023 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701778049;
        bh=lnKGDBAxB8eBxYMZ/Jm5VaF2xsTMrWs6Ne8f9Aw7vjQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FeIL0PFp9XGF5OiflZcnKBgpJ//p36iYTkX/bRoAle2kHEzcDvrUZCHdpOhhr5D3+
         ldQAE4WtTVYfd2PGV9YOfKswfZdtnGpHsYGbfYEpvQkfw1/7IwUHsyp8sRAaXQrA8Q
         UojGTHrerdAC6owGBFQpmABMzdXyZGpsmi7pK7D+pLMsJgEsniRpmd81ake4f5uQla
         dkx9nvEIUp3QCzUtueyQoPwEGW+owYCBivuQkRGbdUyI6CZ4egK7S1zogzSe1pdqVg
         QYIgrreNVZhXj2Yjhc7l9YUU2NEs6EnPjviUhmL8wih+v4NtgFP+qA541saOL87hXd
         w7IkezvhTO8mg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
References: <20231205111515.21470-1-jirislaby@kernel.org>
Date:   Tue, 05 Dec 2023 14:07:25 +0200
In-Reply-To: <20231205111515.21470-1-jirislaby@kernel.org> (Jiri Slaby's
        message of "Tue, 5 Dec 2023 12:15:15 +0100")
Message-ID: <874jgwrgxu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jiri Slaby (SUSE)" <jirislaby@kernel.org> writes:

> clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
> unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
> parsing and add missing calibration data") added it, but did not use it
> in any way. Neither, there is a later user.
>
> So remove that unused member.
>
> [1] https://github.com/jirislaby/clang-struct

clang-struct looks really nice, especially if it can also find unused
structures. What about unused defines or enums, any chance to find those
in the future? :)


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
