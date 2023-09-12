Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6079CDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjILKRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjILKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:17:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29E272E;
        Tue, 12 Sep 2023 03:16:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A395C433C8;
        Tue, 12 Sep 2023 10:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694513809;
        bh=WSr9qSl2S1ubmYIrZpcXmHxSn6EHq34MSINK8cbXato=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DjpOBF8QYlMldwfuCfivS8FDAipLd8nz0g0k8U617/n0FwUiYh76S4/JyMVDC+rxM
         pD+JOX+mpH/G4vU6ZDawXaCgtiqlWlkWJWY47vX6cS/ZM43M53ZtMz/OQ5uRVUI1aS
         83O7dFEyD+VZ60uSh+Tphkx1fxJ+G5kBP33y8CQAXAyvKyPl5IPd69JvzxjztXG62h
         Tf/+28qObCekHDgZ88E5aNaHzBCYrLwf41vhXBO17ufRCOyUyQt4YJbzAsg15/Qn0C
         1cNvt2p0FuNr2TYL5lgU2+F2jm/ts56CDdAWUa87JZaOucBMUXMYZchy/Ciz4+Gqrh
         Af2FCuEdmf02g==
Message-ID: <351927e6-2ddf-186c-78ae-1b0d639b9ea7@kernel.org>
Date:   Tue, 12 Sep 2023 12:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Describe changes to the device
 tree
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230911083735.11795-1-daniel.matyas@analog.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230911083735.11795-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 10:37, Daniel Matyas wrote:
> Added new attributes to the device tree:

Subject: it's meaningless. You said there absolutely nothing. Instead
saying "Describe changes to the device tree" please describe the changes
you are making.

> 	- adi,comp-int
> 	- adi,alrm-pol
> 	- adi,flt-q
> 
> These modify the corresponding bits in the configuration register.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 21 +++++++++++++++++++

Please work on latest upstream, not some old vendor code. This means
that you should checkout latest mainline tree (or linux-next or
maintainer's tree) and make your edits there. Once you do it, you use
get_maintainers.pl on that tree, not on that ancient vendor's stuff.

Best regards,
Krzysztof

