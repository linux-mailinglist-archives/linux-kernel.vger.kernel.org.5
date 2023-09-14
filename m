Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E37A0A10
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbjINQA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjINQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DE1FF0;
        Thu, 14 Sep 2023 09:00:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F163DC43391;
        Thu, 14 Sep 2023 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707240;
        bh=EnaIB21bPAwaZJbRYjf7cNN+7kBYa36FfKNtCkd29pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aW+kINiwBU4sisq2aCPwlRIlMMigKkqY1Bk7EUlfgL34n3Ie3jGw7fGmMdfsD4pRk
         2neAsuiJXL2BIQ5YExwF8QAFcjgizmL00L2//lgjo5QTEIr/Ot3/H29S7Co4jFJfGD
         n178lE5E2bsQuMYmYED2A6cH2YnXglq5rAInEPmzhjwxoSVBgShiREyMatHAt2mHFS
         FFG0925lyj8VzCOIo8liUBev/HFALfedGZhAhfc8p4w0ziaWi9aP+1N/BVJMpEVzKv
         Xv6Fcsb1d9P1yI6qbh4C998V4HDKWa0rSZlPGWXn4h83WDSv+Ahm9C3cRQige0AaR3
         O8T/HRnyJpeug==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Thu, 14 Sep 2023 09:04:28 -0700
Message-ID: <169470744869.681825.14729680744109666454.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827211408.689076-1-luzmaximilian@gmail.com>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Aug 2023 23:14:03 +0200, Maximilian Luz wrote:
> This series adds basic support for the QSEECOM interface used to
> communicate with secure applications running in the TrustZone on certain
> Qualcomm devices. In addition to that, it also provides a driver for
> "uefisecapp", the secure application managing access to UEFI variables
> on such platforms.
> 
> For a more detailed description, see the blurb of v1.
> 
> [...]

Applied, thanks!

[1/3] lib/ucs2_string: Add UCS-2 strscpy function
      commit: e4c89f9380017b6b2e63836e2de1af8eb4535384
[2/3] firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface
      commit: 00b1248606ba3979ccae30ed11df8cdc1a84245a
[3/3] firmware: Add support for Qualcomm UEFI Secure Application
      commit: 759e7a2b62eb3ef3c93ffeb5cca788a09627d7d9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
