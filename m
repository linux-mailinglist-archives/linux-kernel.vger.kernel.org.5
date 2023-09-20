Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BDA7A83AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjITNmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjITNml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:42:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E1CE;
        Wed, 20 Sep 2023 06:42:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48616C433C8;
        Wed, 20 Sep 2023 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217355;
        bh=4VZ2d49H7sr9rWHygFCjye19MowJnLLFSJFfbWTj9ys=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Vyv2x2GYTtyai6iEOn85f2Wrj3TEznKggifWFV/zogAhZaNgBRhySwvoYpq83BjEM
         08QgEV9tO1VdSbGPCqNqCSwoXiPpNZYIdOQXVG2mQeEKdpyHVSYWt4PNU0ihPNpWj9
         MP+n/TOb9dAJd2eFSYcwZRNxJ03byJV+swXPpKRnGmKm0cHb1UUz3oYhFI0TDG6Yyi
         ESzXRyHt86kWp1WgFTC8QujZKdq5TuKh4m1tpCnJNNvoeY3Qkfh28xriZWyYp/rAnt
         WDUqCmu9nCsASquz5OFMiHopKGb88AUt6NfcYabjQjY/rP/7bDOk91INmDokrp138u
         tSCxUtJec4kDg==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        linux-leds@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Lu Hongfei <luhongfei@vivo.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230915201059.never.086-kees@kernel.org>
References: <20230915201059.never.086-kees@kernel.org>
Subject: Re: (subset) [PATCH] leds: qcom-lpg: Annotate struct lpg_led with
 __counted_by
Message-Id: <169521735205.3443473.3273251476364082094.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:42:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:11:00 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct lpg_led.
> 
> [...]

Applied, thanks!

[1/1] leds: qcom-lpg: Annotate struct lpg_led with __counted_by
      commit: 3a2a14ad346d60da60aef0a2afc1fb256a56c83c

--
Lee Jones [李琼斯]

