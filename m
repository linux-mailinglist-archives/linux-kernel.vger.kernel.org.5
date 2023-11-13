Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7420B7E9E47
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKMOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjKMOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:12:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51FD59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:12:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624ABC433C8;
        Mon, 13 Nov 2023 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884759;
        bh=7n9z+cHpOQ8W91XBkYQLoFLrh4UpmQ6en6y1XeCK3Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkaNk6Od6P7WGy82NQKqBftjUJ8iuNS2PhRkdz8VnwAV3mKYJ5Mk+KaKs7KA3WSyW
         a7kDMBYayhA5IFV0P/w+CFhS/ZoaTMZcqfpbkA6jOHPAxqqvQ1REU9Iqf96v/zarno
         0nl/6qmmr22QeG8oC8jEgdkb240HiEJgXXCsWx8uiOzgIYyeHJHwjHVybLfgRwiFtb
         dhnOVdy8L+/5/fgnyO0XujxfX5xwKVFog+TAFRGKv/8vOtQR2+12oySA0AxmDcLvcJ
         9BxNQtFf2solRjysjp/cdohH23nFQvltLOmKkMADTfXAB0m5nMmO3rXjQ8co7iRdLH
         v9ElzPjCIZahw==
Date:   Mon, 13 Nov 2023 22:00:17 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add binding for Sophgo CV1800B
 reset controller
Message-ID: <ZVIr8VH+29lpSpxb@xhacker>
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-2-jszhang@kernel.org>
 <20231113-washable-elbow-629bf42b9be1@squawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231113-washable-elbow-629bf42b9be1@squawk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:36:54PM +0000, Conor Dooley wrote:
> On Mon, Nov 13, 2023 at 08:55:00AM +0800, Jisheng Zhang wrote:
> > Add devicetree binding for Sophgo CV1800B SoC reset controller.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> 
> With the unterminated ifndef that was pointed out by the robots fixed,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > +/*				0-1	*/
> > +/*				10	*/
> > +/*				13	*/
> > +/*				15	*/
> > +/*				17	*/
> > +/*				36-39	*/
> > +/*				53-57	*/
> > +/*				59-60	*/
> > +/*				63-73	*/
> > +/*				90	*/
> > +/*				94	*/
> > +/*				102-292	*/
> 
> There are quite a lot of gaps here, do you know why that is?

The tail bits are for cpusys, so I guess the SoC designer want to
seperate them with guard? I'm not sure.

> 
> Thanks,
> Conor.


