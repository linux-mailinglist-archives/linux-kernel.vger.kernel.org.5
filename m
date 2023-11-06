Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16B7E1FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKFLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:10:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEBBBE;
        Mon,  6 Nov 2023 03:10:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99BDC433C7;
        Mon,  6 Nov 2023 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699269010;
        bh=Bw6MnMTTrDr7uSxkR5WanV+zHgmO66ylaD0/WXM95VQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAiBlpReuCecGSGvVCXXIv3WzDStlrN6NBjeVSBpjKCsZhXBczwrwqFYQ3v4NCDFQ
         velTv7qtQ2gjJfdY3nxVMVjZTBuBjG1AB88+jHq/qTvALkmSYZuD89arf0i3zhXbRG
         ll3eBoJFf9EOneOswnTb+s2RrINRnd5G7c9pais1+/FRhMEbGv42oG2e4kWh0U0807
         EuyZK/sAFLGBlAGbx3dxeimO4sx9/b92cEzfXrRDeUk5r0lOdkdExa2DEKOKXLcf2o
         ASoCJt2e8faoGt1kz0UjVRybQPaYdWpv7zXi8FqQNl6/qkxT3ExaC4w8iau0wmWnc8
         lG9G2otmx5MIQ==
Date:   Mon, 6 Nov 2023 11:10:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ana-Maria Cusco <anamaria.cuscoo@gmail.com>
Cc:     Ana-Maria Cusco <ana-maria.cusco@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add ADRF5740 driver
Message-ID: <20231106111005.6fd278fd@jic23-huawei>
In-Reply-To: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
References: <20231103150130.1090246-1-anamaria.cuscoo@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 17:01:28 +0200
Ana-Maria Cusco <anamaria.cuscoo@gmail.com> wrote:

> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
Hi Ana-Maria,

If you do a v2, then make it clear in the title that this is adding support
to an additional driver rather than a whole new one.


> 
> This patch series adds support for ADRF5740 Attenuator.
> 
> The ADRF5740 is a silicon, 4-bit digital attenuator with 22 dB
> attenuation control range in 2 dB steps.
> It offers parallel control mode through four digitally controlled inputs.
> 
> Ana-Maria Cusco (2):
>   iio: amplifiers: adrf5740: Add Support ADRF5740 4-bit Attenuator
>   dt-bindings: iio: hmc425a: add entry for ADRF5740
> 
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  |  4 ++++
>  drivers/iio/amplifiers/hmc425a.c              | 23 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 


