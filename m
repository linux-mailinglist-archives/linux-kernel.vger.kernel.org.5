Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31037F5C29
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjKWKUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjKWKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:20:44 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A6F1BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:20:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0EAB14245E;
        Thu, 23 Nov 2023 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1700734849; bh=TnIpe5+vYibOehFo39KJIQUXdlzRb5h5RBqVCFGk+Hg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f9vhNyIeRFEF+Rjf46M9ZYxGk9Ln13zWMZnIx8lXeQlaIHQMETwK96em/GykOzW5+
         LuLZNOnMcLh4uOsI3FSrGV3aGiz8dIZwjHWUUgq5u7HjNkiE1yU6pPngRsNOKvHozE
         yjpNE2KP4qyFyQPlLzyJAcNV4hB9w3mdaN5Xbe/gXyKZe4b1hwiDrr4g+e+B/WlJtU
         9wFlmMhxbG0uBeyDUAbUG7sAmGZIBUpq7D8Ff6ROqEF+npYU50Z/9Bc5T3BfQlfXbq
         rXBwrCY6Fz8WabnFEYG2NMauWVsADpAwdGH7tSu6VztGqDf6a1/uP2hnRrc/Nr7FEF
         6KDCcJ6A7yuwA==
Message-ID: <e8aef878-bd70-4dba-856c-61d9065ca327@marcan.st>
Date:   Thu, 23 Nov 2023 19:20:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] soc: apple: mailbox: Add explicit include of
 platform_device.h
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231030142620.818663-2-robh@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20231030142620.818663-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/30 23:26, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other and pull in various other headers. In
> preparation to fix this, adjust the includes for what is actually needed.
> 
> platform_device.h is implicitly included by of_platform.h, but that's going
> to be removed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note this was added in the merge window and missed the last round.
> 
> Arnd, Can you apply this directly.

Just noticed this but I'm confused. I never sent Arnd the pull for this,
so it's not upstream nor on the way yet. I've applied it to
asahi-soc/mailbox though. Thanks for reminding me, I'll send the pull now :)

- Hector
