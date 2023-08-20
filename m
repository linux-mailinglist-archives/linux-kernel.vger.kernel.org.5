Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3691782036
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjHTVdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjHTVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:33:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D990
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 14:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429AE60F13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDAFC433C7;
        Sun, 20 Aug 2023 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692567229;
        bh=S1IrQ4hoeiRotUJV27mOZokmHBBCVXOveNE1Aikto+g=;
        h=Date:From:To:Cc:Subject:From;
        b=BQshnP7OkQT+biDFmAshC7BPU/dlEXMxf9+oynonnB2l27Qzhz8GXRufLvTwWpaLG
         ZvdTIBKe0Miv/HogpS2PHz+O+jKrivT23G57X0+pMvF/P5YR5ZzHIVS4UFNZqQQhvR
         awGhtFsfiuic/H8GTrRyyKZrSAPrqpiV/jNAfOqol2oiB8J4olGkMexRQpfk7RqeXb
         53IDsMf7pQU2ZhP2ZPpCAEJRXtermToItaovtR/MJ7Nma6YnAiuhbhNolOHakHnE/3
         9RsVxNtIzmYxHu3/mezc1PmZKfQ3ZCiqysHH3CUHaNrBcw21jnqMR4pn7Vy1+ZKLgS
         43C+NwUrZ44Ww==
Message-ID: <bff3dd48-5e06-870e-860a-70554fd14ad0@kernel.org>
Date:   Mon, 21 Aug 2023 06:33:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for 6.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.6. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.6

for you to fetch changes up to d20a3a8a32e3fa564ff25da860c5fc1a97642dfe:

  extcon: cht_wc: add POWER_SUPPLY dependency (2023-08-05 15:42:15 +0900)

----------------------------------------------------------------
Update extcon next for v6.6

Detailed description for this pull request:
- Remove unused deprecated exported function
 : extcon_register_interest/extcon_unregister_interest are replaced with
 extcon_register_notifier/extcon_unregister_notifier.

- Add missing property for extcon max77843 / sm5502 devicectree binding doc
 : max77843 / sm5502 extcon driver uses the 'schemas/connector/usb-connector.yaml'
 for device binding. So add the missing property information.

- Add mising POWER_SUPPLY config depencenty to extcon-intel-cht-wc.c in order to
remove build error.
----------------------------------------------------------------
Arnd Bergmann (1):
      extcon: cht_wc: add POWER_SUPPLY dependency

Krzysztof Kozlowski (2):
      dt-bindings: extcon: maxim,max77843: restrict connector properties
      dt-bindings: extcon: siliconmitus,sm5502-muic: document connector

YueHaibing (1):
      extcon: Remove unused inline functions

 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml |  1 +
 .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml |  4 ++++
 drivers/extcon/Kconfig                                       |  1 +
 include/linux/extcon.h                                       | 12 ------------
 4 files changed, 6 insertions(+), 12 deletions(-)
