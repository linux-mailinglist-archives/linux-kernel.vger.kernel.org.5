Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7E761BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGYOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjGYOcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8596510DC;
        Tue, 25 Jul 2023 07:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A9E96177C;
        Tue, 25 Jul 2023 14:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B5AC433C8;
        Tue, 25 Jul 2023 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690295512;
        bh=YosH8SfwlkT1e2RagDaWUEiwWFWG2YRJM54/ZBoEHII=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Yp3b9KmI+WelkGJ0KwcyxpF4R0528rZa1cU10k5eOrsd7dQmuv9CnX0fr4yTrHrlt
         oZbEBPbOeO8FHGrfOkAqSsJQycFy16x3grA1+mecKlLvtdFU6fQkAjmwj5qZLF8e1F
         61Lity2LHSQU1Ryei5IdcIBy9Oc95LBEyvMm66xznm6i1pyKvGqrO0a0nA8N++nmj5
         SGDOfc5itLG+sHKEuVATd05vG8RcS9HE0NgIf7Z8BrS6vsJ2Z/TabX+iR6Pe5Jx8uT
         Nq+0KJKspf4/K763C/Kw7A37vu5/AKLwlK7/S7shfFRld9tdq6V3ngzZIlI5DrM98n
         YnEAwlo7d736g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] wifi: ath9k: fix printk specifier
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230723040403.296723-1-dzm91@hust.edu.cn>
References: <20230723040403.296723-1-dzm91@hust.edu.cn>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029550891.3210124.11487387565117969944.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:31:50 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> wrote:

> Smatch reports:
> 
> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
> 
> Fix it by modifying %lx to %p in the printk format string.
> 
> Note that with this change, the pointer address will be printed as a
> hashed value by default. This is appropriate because the kernel
> should not leak kernel pointers to user space in an informational
> message. If someone wants to see the real address for debugging
> purposes, this can be achieved with the no_hash_pointers kernel option.
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

061115fbfb2c wifi: ath9k: fix printk specifier

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230723040403.296723-1-dzm91@hust.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

