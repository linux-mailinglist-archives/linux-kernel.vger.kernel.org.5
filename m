Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7580476763A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjG1TWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1TWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097819A1;
        Fri, 28 Jul 2023 12:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453DB621D2;
        Fri, 28 Jul 2023 19:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFAC433C7;
        Fri, 28 Jul 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690572127;
        bh=kBgYBa52i0BtQ59SDR0Dcs0/lOoa0eFmpWZx7LXp6hQ=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=aMrNxQ8Zg1+2r7I8qh5K3VWTxhKn23neTeFfXex9ClA8kw3t25gUu3gokcR0kAXEQ
         dfRqv3AGj3HEkD2YOH8/UNrkPMSkfDVBPmFEAHGaefxi1UuIbvxmTNqXmZqUXf3Odb
         2adYWC8bQHJciA6qFvnar2tbsBK2gZ9RJV1eHD2n33GyzW8Hvx1CxmeX/tPDQLhKoM
         x4KIkR9iDaxyJab5RTLgFNPnIml+lQFhskeW0Icj2pT16dTjfzrJiD4RTcCks49xYK
         SRhlR5dBpCG+9LiYG6UivIds+RJS+RB2awPU+FkFTn89wcAps8vShy9w0dCOoV9+WQ
         QiviOBbjuKtig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:22:04 +0000
Message-Id: <CUE1SWKWLXPX.46QZ3KU4UAWL@seitikki>
Cc:     <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 5/5] selftests/sgx: Enclave freestanding compilation +
 separate linker options.
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>,
        <linux-sgx@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230724165832.15797-1-jo.vanbulck@cs.kuleuven.be>
 <20230724165832.15797-6-jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <20230724165832.15797-6-jo.vanbulck@cs.kuleuven.be>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 24, 2023 at 4:58 PM UTC, Jo Van Bulck wrote:
> Fixes "'linker' input unused [-Wunused-command-line-argument]" errors whe=
n
> compiling with clang.
>
> Additionally pass -ffreestanding to prohibit memset/memcpy stdlib calls f=
or
> optimized enclave code.

Should be split into two patches. Please describe the motivation for the
second paragraph in the patch, which adds '-ffreestanding'.


BR, Jarkko
