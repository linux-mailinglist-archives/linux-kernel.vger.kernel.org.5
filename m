Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3427723D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjHGMYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjHGMY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:24:27 -0400
X-Greylist: delayed 432 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 05:24:22 PDT
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F959130;
        Mon,  7 Aug 2023 05:24:22 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id B3EA92802BA;
        Mon,  7 Aug 2023 14:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691410629;
        bh=MoMY1SFtkbtEUBwIL7en7e2435l5MQq5o7TXLrJFqPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OtkTggzs+tvxWYj2I7pXxg2LkseYu2TNyjMFfy6jbmuoFD/4TxvnrV1Kt4aVTxL32
         cC/4eKMOWdCCo2Iw7i3FzN+S3jxQWacSeYK4c6mVsQd9Y4/q6crstdMUrN6Yg6OZ+9
         JXDt/2cUJ4CKcgeTBYU3YsWzevTJiT2GyXJDWaN8neg3f5KEMOSoIVqM/zX7V24Jc+
         Qj8EeW3tgNzumUI8T1C8nZZdR+L3YZ22hxGfOtKNF2cE0+GWJbR6N+v4RyKspefl39
         xjo77kXV5IOfkRuvPCfOM6wDCMa+BpwJB1mWLzVq9Vy4St7xyNT38PyWsG3ZrYYpNo
         eUjK2JRU/qPHA==
Date:   Mon, 7 Aug 2023 14:17:06 +0200
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>
Cc:     "fshao@chromium.org" <fshao@chromium.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jianjiao Zeng =?utf-8?B?KOabvuWBpeWnoyk=?= 
        <Jianjiao.Zeng@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        Chengci Xu =?utf-8?B?KOiuuOaJv+i1kCk=?= 
        <Chengci.Xu@mediatek.com>,
        YF Wang =?utf-8?B?KOeOi+S6kemjnik=?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Mingyuan Ma =?utf-8?B?KOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v12 0/7] MT8188 IOMMU SUPPORT
Message-ID: <ZNDgwh2r02SXZEG4@8bytes.org>
References: <20230602090227.7264-1-yong.wu@mediatek.com>
 <CAC=S1nhgkj5zh-Oa+OJjZKmkNMfG63+WjSefB2swybm29KxDXA@mail.gmail.com>
 <cc910b5c3ec130f092a37049d71bb35c20b278a6.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc910b5c3ec130f092a37049d71bb35c20b278a6.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 12:53:29PM +0000, Yong Wu (吴勇) wrote:
> Your A-b always is expected before Joerg applies.

It is time to make some progress on the MTK driver patch flow. I just
applied this series, thanks.
