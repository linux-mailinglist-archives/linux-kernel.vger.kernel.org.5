Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335EE768797
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjG3Tno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjG3Tna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:30 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Jul 2023 12:43:27 PDT
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE910D8;
        Sun, 30 Jul 2023 12:43:27 -0700 (PDT)
Received: from UM-350.Speedport_W_723V_1_49_000 (p5def86e0.dip0.t-ipconnect.de [93.239.134.224])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id B2C9B3FC3C;
        Sun, 30 Jul 2023 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1690745843;
        bh=rfsSdu/SRPCMxy/F0ky1OyFS3VXCS/m3pibBNtkJLEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/78LVuq1C9QKcKMXOqGZ0MHHtBVOVBEnb/13YcPc7HZ9+O9BTikeq9G857B51yZ2
         VwWb1IpX769Edr6jr32uZBL9PqVqNQcdsg+DTeZQfS7pRI/vWqdpJ3eiPeuYHViNjq
         sfHhR11M+r79eB/bM+bzymOv5hNciLIR4KD1OnL5Q6D3HPwZpNaKz1H8N0Vro8l7EB
         ZTDCcWuSChLn7z7cQbV50/Q1xAPGtePOrAwpBBFGzbb5EWJxAmmivnQFg3HtSrURyE
         XlDoOVhxTRYREgLTJbL8LMoW28vVY5a9JgSpJNpsp6wEwgczrQ//axyKQfn4Qxh7GV
         ZEl/ArMEj3ndw==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     christophe.jaillet@wanadoo.fr
Cc:     andi.shyti@kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, johannes@gnu-linux.rocks,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@it-klinger.de
Subject: Re: [PATCH] hid-mcp2200: added driver for GPIOs of MCP2200
Date:   Sun, 30 Jul 2023 21:37:12 +0200
Message-ID: <20230730193712.379694-1-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <df1acc44-62c3-1ac6-103e-561baf8e38e4@wanadoo.fr>
References: <df1acc44-62c3-1ac6-103e-561baf8e38e4@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi, hello Christophe,

thanks for the feedback and the hints. I will add most of your suggestions to
the driver and submit a new patch, this time with a correct Version Label.

I need to use dynamic memory allocation for the data passed to 
hid_hw_output_report, overwise the function doesn't work, 0 bytes will be sent.
The memory has to be allocated dynamically because of the DMA usage in the
background. 

But all the over feedback looks good and will be added to the driver.

Best regards,
Johannes
