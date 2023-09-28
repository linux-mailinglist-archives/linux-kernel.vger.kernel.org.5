Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06977B0FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjI1AaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1AaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C7BF;
        Wed, 27 Sep 2023 17:30:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8232FC433C8;
        Thu, 28 Sep 2023 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861000;
        bh=9VotLMsBI791Z3ShJpdyU424mV4uO4FeE3QubwCoWCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Np2y57woLdUA6+YYern+0oWaH42mD0IB71IpVAbD2NIKSD3WRxkfGvnTrA1Rl5d+K
         eoFoLyOs2rt9n1uC0K9ueitqVpLBMeFYd8RD69jdBjePfd6W+9gPL92MPqyH9LJ9K+
         tuPwwRr/36zdZFQs22PBdD4tWI0Se4WAlAZ26Ghv88VCxMvol07cy5y2chOro/GuBc
         KMjTA6N+XPRnQsSSfNIXRWB3fXdvi0redKorEkqfbArJ8ATVtk0ku5uCegiUjAIDb3
         6EqC4q963ewtvQgw0j7QGl75HmosbUWszi8urAGP5uwSgk2rtw6i1Rh6/iTlFn/6Z2
         n5OucDH7BYbmQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-arm-msm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: smem: Annotate struct qcom_smem with __counted_by
Date:   Wed, 27 Sep 2023 17:34:04 -0700
Message-ID: <169586125035.1226038.13396484485587961268.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922175413.work.929-kees@kernel.org>
References: <20230922175413.work.929-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 10:54:14 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct qcom_smem.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: smem: Annotate struct qcom_smem with __counted_by
      commit: 433ce46a97116f431ee114b4607143860aad4054

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
