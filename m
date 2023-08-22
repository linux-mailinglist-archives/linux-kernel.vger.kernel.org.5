Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D9F784221
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbjHVNe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjHVNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83874184;
        Tue, 22 Aug 2023 06:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14DC465652;
        Tue, 22 Aug 2023 13:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5246C433C8;
        Tue, 22 Aug 2023 13:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692711263;
        bh=SU/d1YCjTvRh2VFwt7CnplnIencfzF2S32D8BVpFSPo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KPKtoNKvi0Vm5Ej5mGmJhp8XYyVZGeR74YVC8uyqRiZpwfHkYEpX7eZ7znZYaHgz/
         Yr6OSmxoz1at6o4YnU4VznUwCr0gbggXX0Ttn+0R6gUvYJLZf2bloh9Qq0uKa+eKzQ
         +oUWTv78uvWq1x/ULTrM16ZOtTJzeDySBkFJnYDZMASbmEYtrk3+huFpv4JvAab7vx
         CkKoqz/uYz4th4aa8pFXZO8L+mRGRmGt76C2VAJp9GUN+lLoVmfTc444AL2ma9pEnz
         93gtgx1ulSKefa9dhol+pKq8gp+VSNy2u/ziVBlJ5krT+leKRBuHJLJ9l8+n5QsL/N
         xcFH3lq0KK90w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH -next] wifi: ath5k: Remove redundant dev_err()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230726171235.2475625-1-ruanjinjie@huawei.com>
References: <20230726171235.2475625-1-ruanjinjie@huawei.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     <jirislaby@kernel.org>, <mickflemm@gmail.com>, <mcgrof@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ruanjinjie@huawei.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169271125961.680890.14414046179999031714.kvalo@kernel.org>
Date:   Tue, 22 Aug 2023 13:34:21 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ruan Jinjie <ruanjinjie@huawei.com> wrote:

> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as it is
> going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f708ed71775d wifi: ath5k: Remove redundant dev_err()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230726171235.2475625-1-ruanjinjie@huawei.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

