Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A67EE77E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345503AbjKPT2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjKPT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ACB18B;
        Thu, 16 Nov 2023 11:27:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D571BC433C7;
        Thu, 16 Nov 2023 19:27:55 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
        id AF8EF10613A1; Thu, 16 Nov 2023 20:27:49 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, Su Hui <suhui@nfschina.com>
Cc:     r-rivera-matos@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
In-Reply-To: <20231116041822.1378758-1-suhui@nfschina.com>
References: <20231116041822.1378758-1-suhui@nfschina.com>
Subject: Re: [PATCH] power: supply: bq256xx: fix some problem in
 bq256xx_hw_init
Message-Id: <170016286968.830118.5959829920078266260.b4-ty@collabora.com>
Date:   Thu, 16 Nov 2023 20:27:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2023 12:18:23 +0800, Su Hui wrote:
> smatch complains that there is a buffer overflow and clang complains
> 'ret' is never read.
> 
> Smatch error:
> drivers/power/supply/bq256xx_charger.c:1578 bq256xx_hw_init() error:
> buffer overflow 'bq256xx_watchdog_time' 4 <= 4
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq256xx: fix some problem in bq256xx_hw_init
      commit: b55d073e6501dc6077edaa945a6dad8ac5c8bbab

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

