Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5137880F3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243164AbjHYHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbjHYHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:35:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6052109;
        Fri, 25 Aug 2023 00:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA75A614B3;
        Fri, 25 Aug 2023 07:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545EAC433C7;
        Fri, 25 Aug 2023 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692948940;
        bh=XPNtAfyvKj/g+y5Rpwes+9pS9wajftJiM2gsLqx24fc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UHWYhGuVuMmm4aqV+hto3J1sYBnTWnIolq8A5PUKDau/MfCY53auUc8nnT0aiG27z
         SN2vXKbFq56z6V4zJMYRM0nPF5M8H6NSqyKQ5bMwiApCpW82t6CM8b5mvOaMHMNjxG
         o3AEHtDvgnXypMQmp7Y4PBt5NDmLW6HWPp8vVb//QBlLez+BZwu9AITBDl0FYWIBHt
         fcl4Eaaa+V5sNEA40/15msmV4qXhRF1j2s3mC/51CBN95vkX9iQ8V+H/EivLGuj39P
         OOHDh+AbIuYOQJG9n7IYnla8KF4/B9Xxf15z9ne+277CBbBMbOJPk4NLziAlGoYw+Q
         wldoIfBQ0gxpA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net:wireless:Fix an NULL vs IS_ERR() bug for
 debugfs_create_dir()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230713030358.12379-1-machel@vivo.com>
References: <20230713030358.12379-1-machel@vivo.com>
To:     Wang Ming <machel@vivo.com>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Rajkumar Manoharan <rmanoharan@atheros.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Sujith Manoharan <Sujith.Manoharan@atheros.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169294893610.1674223.1208799816873106062.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 07:35:38 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> wrote:

> The debugfs_create_dir() function returns error pointers,
> it never returns NULL. Most incorrect error checks were fixed,
> but the one in ath9k_htc_init_debug() was forgotten.
> 
> Fix the remaining error check.
> 
> Fixes: e5facc75fa91 ("ath9k_htc: Cleanup HTC debugfs")
> Signed-off-by: Wang Ming <machel@vivo.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1e4134610d93 wifi: ath9k: use IS_ERR() with debugfs_create_dir()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230713030358.12379-1-machel@vivo.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

