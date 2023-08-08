Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2F27744F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbjHHScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjHHSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BF29548;
        Tue,  8 Aug 2023 10:53:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE5862969;
        Tue,  8 Aug 2023 17:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3198C433C7;
        Tue,  8 Aug 2023 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691517225;
        bh=52uuc7Z3oG44JhgCXUWkJJMkWiyyCz5MqyQlwm3ryjw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JiUdYj2WirrDHKt96EqhE6PM8xFosleaDS0TTqKtyCpJICVs9RXRrglRQlWQlQLh1
         q2ORi0c4kMujJs2N2BQYB7e9VTJGYT9YFEoS5iTUcTyErESs4+d/fEtUr2/rzvvke1
         mLterVBl54Q/FQG4l3DO5DLhrOeU4wJFnFhtUdio3tfmnAUudxSFJqdaSElOP7Yqnx
         +ylNAScvNwsI/ZPDp/CtSx0B+xyok8xPr3Qmhbk7/M4VDqNqn99Mql4xas9hmxDbFp
         YS17Q16WIxjh27MldGYFNgWunkgLHtrCEZDmu4Cfb9akbgOg72e1z1ZAmvLWX/KNsK
         ykkro310otfyQ==
Message-ID: <b34493f8-2b13-4582-9834-a1ebbe9ae836@kernel.org>
Date:   Tue, 8 Aug 2023 19:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm64: defconfig: Enable TI PRUSS
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>, nm@ti.com, vigneshr@ti.com
Cc:     Peng Fan <peng.fan@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, srk@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>
References: <20230808130131.3081482-1-danishanwar@ti.com>
From:   Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20230808130131.3081482-1-danishanwar@ti.com>
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

On 8.08.2023 15:01, MD Danish Anwar wrote:
> The Programmable Realtime Unit - Industrial Communication Subsystem
> (PRU-ICSS) known as PRUSS, is a low-latency microcontroller subsystem
> used for industrial networking and other hard real-time functions in
> the TI K3 SoCs such as AM654x, AM64x.
> 
> AM654x-EVM, AM64xx-EVM, and iot2050 use the PRUSS driver.
> 
> Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Changes from v3 to v4:
> *) Rebased on the latest next-20230808 linux-next.
> *) Modified commit-message to add details on PRUSS driver and the SoCs
>    supported. (address comments from v2 - Konard's and v3 - Nishanth's)
Thanks a lot, sounds like it's a cool piece of hardware!

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>

Konrad
