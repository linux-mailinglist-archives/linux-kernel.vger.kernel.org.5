Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAA7BA24C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjJEP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJEP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:27:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB488E97
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:48:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0F9C32788;
        Thu,  5 Oct 2023 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696504154;
        bh=pMx5pqQeQDjrMnqS2Ak24EVeDg8+F9nrpir675DqlrA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mO3QatlovJ1Y2buxaCKbEVfM0NU7/nT9U+XbwOch583bi3zBhSU0sMEvXip87qE2M
         y+owKp3cAfSU3ExAdWhd6r93T5SjFHugE5uIMRJ0fbG4Y8mLJbaSC1UxnMjoybiJFy
         E37VRRvtwnalMCHyVgwUlH4Z7XqUuskXWiY8ZtUr3V6lVOLZcl9Z5KMQOBrTnjEd3E
         feB0Snrbi/J1AmoMi5ryqmN3CcOfx9AGItI2CDTB9kiS086av0YVnN0obHwZRK1PP+
         zBLAWY7NSk76SCnYCf1SToTSDoz6NYQphvK9BxElH7qpFOKPR7JKUxLVZNX0/9BVAC
         2NrTbCPOqD8CQ==
From:   Lee Jones <lee@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
References: <20230927-strncpy-drivers-mfd-db8500-prcmu-c-v1-1-db9693f92a68@google.com>
Subject: Re: (subset) [PATCH] mfd: db8500-prcmu: replace deprecated strncpy
 with strscpy
Message-Id: <169650415311.686763.14245532826620345084.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 12:09:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2023 05:10:54 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect project_name to be NUL-terminated based on its use with
> pr_info:
> | 	pr_info("PRCMU firmware: %s(%d), version %d.%d.%d\n",
> | 		fw_info.version.project_name,
> | 		fw_info.version.project,
> | 		fw_info.version.api_version,
> | 		fw_info.version.func_version,
> | 		fw_info.version.errata);
> 
> [...]

Applied, thanks!

[1/1] mfd: db8500-prcmu: replace deprecated strncpy with strscpy
      commit: 5f0c4e32e8da434a83dd74a08e477c11e7efc6f7

--
Lee Jones [李琼斯]

