Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B597753B72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235901AbjGNNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjGNNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E630D7;
        Fri, 14 Jul 2023 06:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9BDD61D12;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20175C433C7;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689339843;
        bh=inXxnXQ/Z52rcwIHwMcs8kHBBJmTFZPs88JABaXwQzU=;
        h=From:To:Cc:Subject:Date:From;
        b=ZV1mcBUvMyyudY7N7L9HDkThtT3bK+m2/nWhHZsHRebVsD6nKnfE8aRg+WkHelmip
         x71jGE68/bf3QbDXrSAMMa0W4Q6ujyLqP3f36Pk7gHj59K647rcy5iuFgwm2POPPoc
         QGnrMpQ+kiQXon+BYABG4/nMQKIyq09R7usgTgD1oDb7F68RE1iPRvZhgXULFju+X3
         9ymUW2LnFmN5qBGCWTJJHbUgmPvw9PBm9Z21TtFVTs2CP1u/CrW3i6D6AEo3/hSTHX
         TZN4gXtnQTcluVbyjfKszvDmz5kZA5SMMk/XASSHFDBAdiEf+EhviZ5EPYk4UiYOcp
         o+G3jvpm2EqBA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qKISq-0003ni-1b;
        Fri, 14 Jul 2023 15:04:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] serial: qcom-geni: fix opp vote on shutdown
Date:   Fri, 14 Jul 2023 15:02:12 +0200
Message-ID: <20230714130214.14552-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes the missing opp vote removal when closing a serial
port, which, for example, can lead to wasted power when a UART connected
Bluetooth controller is not in use.

Included is also a clean up of a related debug printk.

Johan


Johan Hovold (2):
  serial: qcom-geni: fix opp vote on shutdown
  serial: qcom-geni: clean up clock-rate debug printk

 drivers/tty/serial/qcom_geni_serial.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.41.0

