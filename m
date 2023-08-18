Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB40781072
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378676AbjHRQgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359202AbjHRQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C83AAE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30EBC621DD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C68C433C8;
        Fri, 18 Aug 2023 16:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692376583;
        bh=BFdsarLgu268paKvMg36l6+Pjvat1AuRFiaD07H2JSU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ChfoB1WyyQHv7XPWvbmHVuM5aYLsNIpA0tz++g+dq+8UyoVhhkfnzvC4gTid2Gajr
         6K/lBs6fc5c+ulD3aCh93+AoztwDS1hxodU/GPUhKHrearM8nmOesQKmDDrQcIS/Nt
         zxbBueGudgKp9+8d8GxIvMYEjve3Xuwp2ahiFRbX9WWeNAiz1l4ygAaXArmu2KtItX
         A3lfc1KBi45oHe5Qh0w1fP8Oz40AWaPGTFPFoRSZ56SjV8ep06A/OjbVqin1sYrSVa
         V7BupjTXjPRDmPpmYfXDpZF/gfJm3J++HG2tWz2MffUnLZ583DFTkem+5uQHmUfP7q
         iolEolBNH40jQ==
From:   Lee Jones <lee@kernel.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org,
        werneazc@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
In-Reply-To: <20230818083721.29790-2-andre.werner@systec-electronic.com>
References: <20230818083721.29790-2-andre.werner@systec-electronic.com>
Subject: Re: (subset) [PATCH v2 1/2] mfd: (tps65086): Read DEVICE ID
 register 1 from device
Message-Id: <169237658196.1308508.13955700873692765066.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 17:36:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 10:37:21 +0200, werneazc@gmail.com wrote:
> This commit prepares a following commit for the regulator part of the MFD.
> The driver should support different device chips that differ in their
> register definitions, for instance to control LDOA1 and SWB2.
> So it is necessary to use a dedicated regulator description for a
> specific device variant. Thus, the content from DEVICEID Register 1 is
> used to choose a dedicated configuration between the different device
> variants.
> 
> [...]

Applied, thanks!

[1/2] mfd: (tps65086): Read DEVICE ID register 1 from device
      commit: c957aecacc831c00497ee95c6984e319f7f82229

--
Lee Jones [李琼斯]

