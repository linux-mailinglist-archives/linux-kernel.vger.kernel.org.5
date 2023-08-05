Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38A771268
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHEVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHEVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9E1BCA;
        Sat,  5 Aug 2023 14:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E70D60F3C;
        Sat,  5 Aug 2023 21:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EADFC433C8;
        Sat,  5 Aug 2023 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691271507;
        bh=S420Jp3noijPO33VAPxKsjX9jKoQBlgGUHnNfSpqMTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsSSWjPLh02PC/C3W5pntdrkUWEFyfpnspeDV2c5Su5REmVuEyfbbhMRMXQIFTGO2
         i1VBoKbrXlCVjxJwPleQs4xQ+OcCN/4OZHThxrcqc0Upu1Sao8Ie6RoanBIu0tRYI6
         wCu5KK7Ynow7VWUlvAvcdEJTaNcFuXDLsORQ3Cc4OS4sN9WiWxnx01Jxz6+KOz/tgR
         uNqxfnpridRqtI6/U2VbZRyz+ElUm5OCyeyOalZSJZEsznSmG1bTLj32kMPi6FooFh
         fNXHyw2QIr4I1K+Zj1ce1wrAGpbTmmb1o5d5q9aij2OnwYI3/OgkEFsmbOghl6I3kL
         DxDnRixaumX7A==
Date:   Sat, 5 Aug 2023 23:38:24 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Anton Eliasson <anton.eliasson@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Message-ID: <20230805213824.ol7sr3b52rwrsfs6@intel.intel>
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

On Thu, Aug 03, 2023 at 01:26:42PM +0200, Anton Eliasson wrote:
> At least freeze, restore and thaw need to be set in order for the driver
> to support system hibernation. The existing suspend/resume functions can
> be reused since those functions don't touch the device's power state or
> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.

and why do we need hibernation in this device?

Andi
