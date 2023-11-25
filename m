Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8E27F8C8F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjKYQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:56:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9068B106
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:56:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F268C433C7;
        Sat, 25 Nov 2023 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700931399;
        bh=IPD5Po2zb9ZkslvDJpcIYJpLgsFXk1lDbitaI3nB7EU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QRf8irJ0QLq2+Z7Wof9rCOq2IOeb0Oq7E1KKjD4Bu8Op9vbhmytFPShygaV2HDJSf
         AR0jwuOQjKmuUs10jO4SOJqNxX9GXs610AoW98Xs3VxOXNLkopqPn8OEYpo322i4o8
         LE4ygU5VvUJP76icBhYMRFlSGf/SGgSMZXIJT+nebZm+7Nx0bzIwjGsRQNxeedGSXs
         1xgIcpBd6Qn6oSbqPXrmh5nw7FkBO7z0PoSBPULxUeE0X8ZPWBEEg/OAGCdgAiP+0q
         d3Hw0+JTFLerKOZPjX+xKdy4+dp6rd2VUuZ4CIi8zQiFYtXx2JM55STqlSnDa2bwtF
         BWx4CACk0PnFA==
Date:   Sat, 25 Nov 2023 16:56:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     mitrutzceclan <mitrutzceclan@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: add AD7173
Message-ID: <20231125165625.4f68cc49@jic23-huawei>
In-Reply-To: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 17:23:21 +0200
mitrutzceclan <mitrutzceclan@gmail.com> wrote:

> From: Dumitru Ceclan <mitrutzceclan@gmail.com>
> 
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
> 
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

An example of reference selection would be good to have. Otherwise
looks fine to me, but I'll wait for the binding experts to take another
look.

