Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A45175B9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGTViN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGTViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:38:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF82735
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC43F61C5B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 21:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D396C433C7;
        Thu, 20 Jul 2023 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689889084;
        bh=nV9JT8DD9nQlYv5u7d4JlV2xPYXbAPq+BOUSU7hHlow=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Knv69iMjNrm8SWaPTvyAb6eK/rRaF39bxTpb6R6KBHl7FybaQamR4oVh+OMiRwLfY
         ATv96ZTLrniHpR8WQp4d34lr1ls5x7O28e0cV2xXceraddwERRMpZITNW8il+M5oDT
         EUlXw1O3J8kOnkDCN81ezkwo3EVJykwohpHCZFfnYbk3NjDcSvbARbbZXb1Y7AP3+D
         szifROxwQ+cJNoFJFetW+7yMktE7pioJ358NKiA3DXMmEl4BTQyjyRrMZ4/wibMz/c
         wk+SthmErIHwcaI1nXAzlA20ETQQk+EDYKC0DGa9SBKnE5U/2iLbyL2F+hu7+zS0W5
         8lqMn5qTeB00Q==
Message-ID: <69800c58-2df8-25e5-09e0-c9929bae2193@kernel.org>
Date:   Thu, 20 Jul 2023 23:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
To:     Tomasz Jeznach <tjeznach@rivosinc.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
 <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org>
 <CAH2o1u6pMF3MN=oFBcs9kOf-nwnEYfD2Vv=89+DzUanV59R5dw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAH2o1u6pMF3MN=oFBcs9kOf-nwnEYfD2Vv=89+DzUanV59R5dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 20:30, Tomasz Jeznach wrote:
u.h"
>>> +
>>> +#define sysfs_dev_to_iommu(dev) \
>>> +     container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iommu)
>>> +
>>> +static ssize_t address_show(struct device *dev,
>>> +                         struct device_attribute *attr, char *buf)
>>
>>
>> Where is the sysfs ABI documented?
>>
> 
> Sysfs for now is used only to expose selected IOMMU memory mapped
> registers, with complete documentation in the RISC-V IOMMU Arch Spec
> [1], and some comments in iommu-bits.h file.
> LMK If it would be better to put a dedicated file documenting those
> with the patch itself.

I meant, you created new sysfs interface. Maybe I missed something in
the patchset, but each new sysfs interface required documenting in
Documentation/ABI/.

Best regards,
Krzysztof

