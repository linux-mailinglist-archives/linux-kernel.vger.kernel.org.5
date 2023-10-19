Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641697CF133
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjJSH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:27:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93858124;
        Thu, 19 Oct 2023 00:27:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12326C433C8;
        Thu, 19 Oct 2023 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700427;
        bh=gkhzeSvzdT7GKnROjs+cU4Uc7mETvT4C/OTy7XDhonw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ShfhV0Bh0n44nLPfHzt+fH8YQOx2IBVAdaxhG87X1P+TZT2qWOLkkK/3MiI1JRza8
         DIQpk/k2zXLAlNP6R2DC5Dv/t0HPChp79anmxdZ1GNrjldYHtbP71IRRkYuHSrDVCO
         GuRmcvLyzgw6F4KDGKM6pAdyNkv8gFkw8cZbGoFATzLmTo8knG09dMNLk0xMf51yMq
         NHipZyNAB9ZSZm7SwFds1ispBSMQx3lPpeAVJJufyauytLCnHU2RsZ4/gIO+36NhfI
         31lt43U3EkvTLdfGdnQU3fTsmnEEjO5ikTdDdYZ80Q7H02GNtGXnpYi75ZMYg66cWA
         UjZwKC7KII8Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ssb: relax SSB_EMBEDDED dependencies
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231012220856.23260-1-rdunlap@infradead.org>
References: <20231012220856.23260-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770042381.117236.16561280619854125537.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:27:05 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:

> This is a kconfig warning in a randconfig when CONFIG_PCI is not set:
> 
> WARNING: unmet direct dependencies detected for SSB_EMBEDDED
>   Depends on [n]: SSB [=y] && SSB_DRIVER_MIPS [=y] && SSB_PCICORE_HOSTMODE [=n]
>   Selected by [y]:
>   - BCM47XX_SSB [=y] && BCM47XX [=y]
> 
> This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
> selecting SSB_EMBEDDED when CONFIG_PCI is not set.
> 
> This warning can be prevented by altering SSB_EMBEDDED to allow for
> PCI=n or the former SSB_PCICORE_HOSTMODE.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Michael Büsch <m@bues.ch>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>

Patch applied to wireless-next.git, thanks.

a86a8ca798e9 ssb: relax SSB_EMBEDDED dependencies

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231012220856.23260-1-rdunlap@infradead.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

