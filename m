Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10207FE3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjK2XIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:08:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F54D50
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:08:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16772C433C7;
        Wed, 29 Nov 2023 23:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701299338;
        bh=qxv5vNqKTDsGEa5/kL6eZhnYZ5V78CNQhvavc4eImz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecdoHEJfKgQSRR/QTdXiIJXQ/gO5GOuwvC/XZ2E78a6Mn9b66cWYJFxlf8OmnOnk8
         09naAjWfCt+O5TIhgGAPKnijH5n2xQfIqBLjeKxKxj8K66/i+AkLvi6/7ONneDNkIS
         imDCl1ZRQ1vIG7sD9sqScVGZoZnrzaceaoybuY8tcTSBOjHpdoTkoAPdcGTZLXZOL3
         kfM2xYGtaqQ6/77Z02oMcWQsKTYWajt+XXi7e/X2yzpk8nkp9k6/PlUoNRZRc8SwfW
         EFcOkkUnnw8vHDxx4OSwjqvXbOgxBnY59pfC3N7onucYLxrak33aXpzFpq9gzldhrR
         aYPy25q3rz0Pg==
Date:   Thu, 30 Nov 2023 00:08:53 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 18/24] i2c: designware: Consolidate PM ops
Message-ID: <20231129230853.rv6hn722fg3whv5v@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-19-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-19-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:42:00PM +0200, Andy Shevchenko wrote:
> We have the same (*) PM ops in the PCI and plaform drivers.
> Instead, consolidate that PM ops under exported variable and
> deduplicate them.
> 
> *)
> With the subtle ACPI and P-Unit behaviour differences in PCI case.
> But this is not a problem as for ACPI we need to take care of the
> P-Unit semaphore anyway and calling PM ops for ACPI makes sense as
> it might provide specific operation regions in (however there are
> no known devices on market that are using it with PCI enabled I2C).
> Note, the clocks are not in use in the PCI case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

The comment in the "prepare" function is a bit cryptic, though it
took me some time to disentangle from the double/triple negations :-)

Thanks,
Andi
