Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DD07A9FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjIUU1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIUU0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:26:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA80B8920A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:39:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrqlJ0WbVz4xGC;
        Thu, 21 Sep 2023 19:26:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
References: <7ab513546148ebe33ddd4b0ea92c7bfd3cce3ad7.1694705016.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/82xx: Select FSL_SOC
Message-Id: <169528828845.872767.11854325574941404037.b4-ty@ellerman.id.au>
Date:   Thu, 21 Sep 2023 19:24:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 17:23:45 +0200, Christophe Leroy wrote:
> It used to be impossible to select CONFIG_CPM2 without selecting
> CONFIG_FSL_SOC at the same time because CONFIG_CPM2 was dependent
> on CONFIG_8260 and CONFIG_8260 was selecting CONFIG_FSL_SOC.
> 
> But after commit eb5aa2137275 ("powerpc/82xx: Remove CONFIG_8260
> and CONFIG_8272") CONFIG_CPM2 depends on CONFIG_MPC82xx instead
> but CONFIG_MPC82xx doesn't directly selects CONFIG_FSL_SOC.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/82xx: Select FSL_SOC
      https://git.kernel.org/powerpc/c/6901a9f9ef1561111283a0d8c8d1cea634d089ef

cheers
