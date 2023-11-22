Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7756B7F4521
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343697AbjKVLve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjKVLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:51:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E31A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:51:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1869C433C7;
        Wed, 22 Nov 2023 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700653887;
        bh=m43drHXqcgBGQSr49HbXEUB8692aCABtdbfAIv8Lw4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkMC/TAcG2mo6eTLcfuIGqWZXXSVTHu60Rxxif/4VrS7AEZPoUpOkgR0atrtvgS79
         ThJN+YRqHKbADLTeLtDgINkTJvo/923ExOwLYm6lbNFPS4qOBHYonRJkyREsDvfGOZ
         ebHGpaqk9V8/oydGW5u/nbp55SMw0PVb9G0+TleTaANnbRhE4sRRBqmUJ+28to5bg0
         kxafyHaHCeoBVv99qYiFDjRqSOBcdFeCNDNXr+KXvpYMljRAS6F6D44iZN5rYFrf77
         ZXY7yPkLkbmqF/ACdWIcazCjACWlDPAd4bBTFeihsi5N3wNHDsEWUB4xVREGP7L7qA
         Z4FEA4FABXAWQ==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] soc: sifive: shunt ccache driver to drivers/cache
Date:   Wed, 22 Nov 2023 11:50:48 +0000
Message-Id: <20231122-crucial-umbilical-1e7f08c9c4f9@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012-mooing-refined-ad1ab421c0d3@spud>
References: <20231012-mooing-refined-ad1ab421c0d3@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=391; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CVsonUKAfn2TbOpnWsQF3eZnPZymVybzFLXKZlGamhE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmxr0VtWD9VbatoXHlep67t5AK7km+b/jMd+WJc++Xeu 6jL5fLrO0pZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRE8kM/4sE7GOE5y4sZtnf sVo85vrM3epTfEKmxZ/5n73fS/3XdgVGhk1Ly7a1mhzU3v9+utvt2F8rb/NN2CQiu1VHkTH94eZ 5L/kB
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 12 Oct 2023 10:22:09 +0100, Conor Dooley wrote:
> Move the ccache driver over to drivers/cache, out of the drivers/soc
> dumping ground, to this new collection point for cache controller
> drivers.
> 
> 

[1/1] soc: sifive: shunt ccache driver to drivers/cache
      https://git.kernel.org/conor/c/971f128bb2d9

Thanks,
Conor.
