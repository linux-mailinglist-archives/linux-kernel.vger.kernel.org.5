Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9EB7C696E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjJLJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjJLJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:25:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA791
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F379AC433C8;
        Thu, 12 Oct 2023 09:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102718;
        bh=3o/uhFcS8U5My0ncKTRyBUAftV0QIu/f9pc+SI5HXpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsvPuBD/rrWE1AeYn7+5FE19/KcPiFkNJZziMK8YOEOxEwaE9TZmNJ1HUEUWtbT/A
         zGFvS0SYWa0M0++LHJXso3yGv7Cc1pjLJ2ZvErmiTPbqFmUgynkCoKwz264n+4Ekww
         ShAdotCHEWWArlh6+M+JWLxcQ2FGdNXYgnLsYQfMVQLbGvtMZHywDZB+UfWChtYTZX
         KArKuldJtUcQ9AqXq/FhmKvTWpWCxH913X0Hb/prTKdCihKYrrlvv6e/puEDKf4hTn
         DodPx9GlLL+VRgdL/0Apo1l+EfX+IpW8FcwueKSX432onFjnqPx3O8kJQC2jGHj3Tv
         4HMfdd7rF+0oA==
From:   Conor Dooley <conor@kernel.org>
To:     kernel@esmil.dk, conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        william.qiu@starfivetech.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcao@linutronix.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2] riscv: dts: starfive: visionfive 2: correct spi's ss pin
Date:   Thu, 12 Oct 2023 10:24:18 +0100
Message-Id: <20231012-pointless-underpaid-649da93b1762@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012091729.3fzfDD1I@linutronix.de>
References: <20231012091729.3fzfDD1I@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=363; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=DCkp2TXqDwPuDa0wCN1QofJuZaPRdyQxX+0vez7hCxE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnqux32OYa82eP9YBbPY1XuNY/ytLbnn7zco8WgML8v6 rl+8fXXHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI5X1GhvmvVv0Wcrghz5eY 9k/lZMzFDyt9a9dGzfm62qhN5+tHtX6Gv1KagSFWEf7f3oXsOcb+e8q9W/u+cHrnabzkaLt3RO9 AHjMA
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

On Thu, 12 Oct 2023 11:17:29 +0200, Nam Cao wrote:
> The ss pin of spi0 is the same as sck pin. According to the
> visionfive 2 documentation, it should be pin 49 instead of 48.
> 
> 

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: starfive: visionfive 2: correct spi's ss pin
      https://git.kernel.org/conor/c/cf98fe6b579e

Thanks,
Conor.
