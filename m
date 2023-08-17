Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A399F77EF72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbjHQDSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbjHQDST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A631724
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 20:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29DC363850
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E49C433C7;
        Thu, 17 Aug 2023 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692242297;
        bh=i5UDWEST6Iodtn/RFBSq3TRb/25kRWUgxsnalcwMP8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pyVZap/wkaI9ku8a6GySSBKjpB7GFAME2V7JaWykuEv0vn97ZfNF0hh4Srj+xcFv9
         BOjHIzm+TF9x5J9XBzC9phrMRxsCe9t9eBRLl1ZTzk1bqNI9J+uYUJU1VaogbevVrm
         LUkAIiHjsmEgvHGwVRPqNf7PGXTTJYRNsoW2iPBWrWxFuDBRloWxeH7oqc9oxWnLkX
         nceoSH2UHWHaVne1bERgtq/J4O0eUSir1NY9SZDXIF/sKYLlYVwpXsPXNSzNRIS66y
         AFzbRZcXd2lgdKBo9j/7c903EhDNBYCvpUNqf70yg/nzMaeN/C8x8ALi/ItF91g2dp
         OsLJ/VOpPUoQA==
Date:   Wed, 16 Aug 2023 20:18:16 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, sgarzare@redhat.com,
        AVKrasnov@sberdevices.ru
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <20230816201816.29bea470@kernel.org>
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
References: <20230815001323.24739-1-l00g33k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 17:13:23 -0700 Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.

I'll apply this instead of the v4:

https://lore.kernel.org/all/20230815220453.32035-1-l00g33k@gmail.com/

since you dropped Andrew's tag :( Please make sure you keep the tags
you were given.
