Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63A77E842
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345370AbjHPSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345386AbjHPSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4E1BE6;
        Wed, 16 Aug 2023 11:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B7AF62C94;
        Wed, 16 Aug 2023 18:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7590C433C7;
        Wed, 16 Aug 2023 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692209136;
        bh=JQl0mn2XbpDCEfJ6yKECy2b46XphKoK5Ye0vfvkPGyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+MJsvU+60YJXTdsqr3/24XqNkK1HICJgFUZnAryhRfsU4blmqty/7M845sHTnEY6
         /SfkR3u7Adw5zyN9l63r+fuLdiTGVczt6eifAzPqLEhPyUMUP+x3k+16RfcJUIRhV+
         t+mOINXt/KIxHqPdHDfBccJy5p0QuDZpGByX0koFPEgvT9wnMXSJa8NEjxSjcXBDzk
         bwBrdVakd0wr1M3HV+3veIcMxFyz7PcvXyKQ+Kd9Om+8UdZKSAa8QXUZ6OxsfU5XD3
         83k72thMAWeK8FpXBxUXOEmZY1VUzrKZjCs9TGTBloY0n2JdrQm4N572nqtAnRBuEI
         24VdYoLEs1TAA==
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Drew Fustini <dfustini@baylibre.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] riscv: dts: change TH1520 files to dual license
Date:   Wed, 16 Aug 2023 19:05:28 +0100
Message-Id: <20230816-feminism-catatonic-e7ce62ef85ca@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724182129.843687-1-dfustini@baylibre.com>
References: <20230724182129.843687-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=307; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=TQJs0EVZotMHGriusZQX5DXuev+izxQ2z84pDBNZFLU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCl3+Z8rGc1aNHOnZ9ukbblWKeaPPku45uhk6yh6caj0c W+9rVHdUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIl8DGb4p1SdE/evKsOws1xF Iowpd9q7rx9+TG5+cN0kz/qIu0z1VkaGNToqCYeW1Kg0nSqyskvP3bew+YP7VndeC2/z9ODv3HM 5AA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 24 Jul 2023 11:21:29 -0700, Drew Fustini wrote:
> Modify the SPDX-License-Identifier for dual license of GPL-2.0 OR MIT.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: change TH1520 files to dual license
      https://git.kernel.org/conor/c/a3ce3ff28385

Thanks,
Conor.
