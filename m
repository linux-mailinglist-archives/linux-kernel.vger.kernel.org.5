Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321C7D6B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjJYMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjJYMRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE32D1BE;
        Wed, 25 Oct 2023 05:17:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F0C433C8;
        Wed, 25 Oct 2023 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236250;
        bh=Frn1b5dRrC7ZsJG6QtL5UUMjTPZo3tVRYX9AFBdPA3I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PTt+7/qD9efAdmNfcdF0Wh75hp9ajH+jnvpb44V3Wv0ibuCFCx6+Jq1UUhzMunpjR
         2+muL+TdGmqJ07Jzx583ilTB8uc2ohI5P/fcxTwEkSE0o9FfnbyaOe900Z5czyHJ0i
         rYMXngd2tf64NfNBl45a/3mq5ORaY7/hec3ItcaTWP1v3p3fg2BxYPl3HeZyxkdOAi
         r0vVVMnkVcAtCdwqBi7xuQPsfIBcKyCTWlX8RcQS6FC27gt7oVM5o40gzyGdUvgPNc
         jVUEDBMceOJzfPR1dqH4SYBoz03M+REDOISbjjilx629BOpajdf4gmQCMUbKFNzFnh
         oXfxkd8nin3DA==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231003152927.15000-6-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
 <20231003152927.15000-6-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 5/5] spmi: rename spmi device lookup helper
Message-Id: <169823624798.725011.11806915898011320732.b4-ty@kernel.org>
Date:   Wed, 25 Oct 2023 13:17:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2023 17:29:27 +0200, Johan Hovold wrote:
> Rename the SPMI device helper which is used to lookup a device from its
> OF node as spmi_find_device_by_of_node() so that it reflects the
> implementation and matches how other helpers like this are named.
> 
> This will specifically make it more clear that this is a lookup function
> which returns a reference counted structure.
> 
> [...]

Applied, thanks!

[5/5] spmi: rename spmi device lookup helper
      commit: 2a2aaed224d93093f4c94234c796ae3396bdceee

--
Lee Jones [李琼斯]

