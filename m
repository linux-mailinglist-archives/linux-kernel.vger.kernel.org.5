Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169E76D6CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHBSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjHBSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:23:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA80BA;
        Wed,  2 Aug 2023 11:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D265661AA0;
        Wed,  2 Aug 2023 18:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5489EC433C8;
        Wed,  2 Aug 2023 18:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691000606;
        bh=v7hq7FeZtaf/kJ+hTvesuISlZhktfFix0bKvyjiDK1A=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JJiKTcQCxhGuYSfSrBd3pA0FHRLtvBii0EnE1kl8uhcV+h8Q0o/m7QviZYZZOurUY
         cQXuR6auCpB/vi6ldNAa6AkgfLfdZ3WRregvGvB1A9b3NWGExIReVHxTQhx+0c54eq
         O4lDYkXMlg2g/Sr7/EAXJepW2RnhyANAR0PSD3OaNKN6p0UFkZ5onmF6pb9z6696BL
         ZrnBn1Rem5uBkHq32412F048hPur3VOhd0pn1b4NZsX3aH5TJxorxB6gcOh0Xpe+Zm
         VvyEacYzUOWeOCkXNmC32rNEW5sMJBzep9Kcv8aGQjMDQ5Cm2AARa3DlEY9ykpU+cm
         7M/C4wFrFlLCQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: Fix debugfs_create_dir error checking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230731024542.27248-1-rauji.raut@gmail.com>
References: <20230731024542.27248-1-rauji.raut@gmail.com>
To:     Atul Raut <rauji.raut@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169100060344.669727.8392314523199758602.kvalo@kernel.org>
Date:   Wed,  2 Aug 2023 18:23:25 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atul Raut <rauji.raut@gmail.com> wrote:

> The debugfs_create_dir function returns ERR_PTR
> in case of error and the correct way to check an
> error is 'IS_ERR' inline function.
> This patch will replace the null-comparison with IS_ERR
> 
> This issue was found with the help of Coccinelle.
> ./drivers/net/wireless/ath/ath6kl/debug.c:1796:6-21: Wrong debugfs call error processing on line 1796
> 
> Signed-off-by: Atul Raut <rauji.raut@gmail.com>

This has been already fixed:
https://git.kernel.org/kvalo/ath/c/1301783c8def

Patch set to Rejected.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230731024542.27248-1-rauji.raut@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

