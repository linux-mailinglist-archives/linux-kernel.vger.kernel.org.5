Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715007B100E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjI1AaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI1AaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:30:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6088F5;
        Wed, 27 Sep 2023 17:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342DAC433CD;
        Thu, 28 Sep 2023 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695861005;
        bh=mADzmhR0WfSJpY+TxsIk5ESzAgjDkZcDjKss6S44Hgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqUbQX/pEf5mk2bFsl6aCkx3D9yqZt1sbYFdTYyw1TOzQJvAZ4Zc9T0eOQXyNHeVl
         QVoLTLI9a7fclQH9mFHFAHL0nG1veibwdALbc/5IAFBhUcZlniTOX1kobD118tkcBW
         jsNHn8WzvgiVqLDUrIh2wB7a6HRbTkliukUw/17GAiQ3c6RmSDSyp5M4XbiryMk5Ht
         lTRfjVq4SZ+EtCLqsQnxPJhw+JR5viunYAwUmqFfIHV2bS5BVYftKFa19iy0naY4nd
         Epe9yYG4UuVNz4ycC8OuXjopJSPURYrJ7IYbktJL31pdTlwEzZzMJWGLgqt6w1lfjk
         lQXWMBiUc6ROw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit
Date:   Wed, 27 Sep 2023 17:34:10 -0700
Message-ID: <169586125040.1226038.6973458146206642205.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925-scm-v3-1-8790dff6a749@quicinc.com>
References: <20230925-scm-v3-1-8790dff6a749@quicinc.com>
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


On Mon, 25 Sep 2023 13:59:22 +0530, Kathiravan Thirumoorthy wrote:
> Per the "SMC calling convention specification", the 64-bit calling
> convention can only be used when the client is 64-bit. Whereas the
> 32-bit calling convention can be used by either a 32-bit or a 64-bit
> client.
> 
> Currently during SCM probe, irrespective of the client, 64-bit calling
> convention is made, which is incorrect and may lead to the undefined
> behaviour when the client is 32-bit. Let's fix it.
> 
> [...]

Applied, thanks!

[1/1] firmware: qcom_scm: use 64-bit calling convention only when client is 64-bit
      commit: 3337a6fea25370d3d244ec6bb38c71ee86fcf837

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
