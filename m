Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03667EADD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjKNKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjKNKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:18:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43421199;
        Tue, 14 Nov 2023 02:18:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987C6C433C8;
        Tue, 14 Nov 2023 10:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699957129;
        bh=R9EePKZ178T6JHiy6t8sq0xmxX0EZtbrgKC4hAcSAjo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mpxs3uGNrvK+k9VMG+ASvPFepbbUnKvJv5TuYq3Hqk7Fdv9AFaavYukmM117d21sN
         hWUPBHVcjUYbbKWwmfDYtIuTrrHUIMAXctZHl4DI/3Ex9wbNAByfFskkFI3r9BhyJh
         YBSknmGirvZkSbPJDrBJ7Y4ogoP92SWjrqqFf5rMyepJ2z8F8kSiCqsSItkEE9BKKa
         vM+dxFI6Qzgay94psI+vlaHiLFMWl3hz2sMxb4PKQ3GIKcAakhhwPP0W37HoTfFHdP
         nRFR2z4D3o79zpLRFLdgQWeOCnPHri4O8QWrMqIMD+OfBIkRccTNHP7/XSzpKCgVVI
         BPQ0bK2EKgOlQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: iwlegacy: Remove the unused variable len
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231110073602.16846-1-jiapeng.chong@linux.alibaba.com>
References: <20231110073602.16846-1-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     stf_xl@wp.pl, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169995712689.3786790.11170539027648876413.kvalo@kernel.org>
Date:   Tue, 14 Nov 2023 10:18:48 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Variable len is not effectively used, so delete it.
> 
> drivers/net/wireless/intel/iwlegacy/4965-mac.c:4234:7: warning: variable 'len' set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7223
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

af3077af7c07 wifi: iwlegacy: Remove the unused variable len

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231110073602.16846-1-jiapeng.chong@linux.alibaba.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

