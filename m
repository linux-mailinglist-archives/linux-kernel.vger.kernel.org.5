Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75080CC61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbjLKOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbjLKN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:59:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131744ED0;
        Mon, 11 Dec 2023 05:57:53 -0800 (PST)
Date:   Mon, 11 Dec 2023 14:57:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702303071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OtPxZyAIr0q83FqrgnW8CYSUeZdYcDZKkr11TEUXgqA=;
        b=s88WWIed5p6L5JcEQ/6gDQ2ADsNQdVFa5zQ9DxTsSn8kHBjUfI8PG7QdHjl6o7h15GIiCP
        qlExyefE+anTl/jrQ6zkQiFTnGGZ0nIiZD4+gY0o6cV2YG5KIS0COsWq+nz9ZRq9UDuFIB
        brmGahG8dkRaJUjhtph6ut/Ysq66wGfjXvQIMLxX2HTjxSkziasXSjhIjY+le2eF2tfU0m
        9dN1LPFf2oNGIuU7Ju09/Sbup9npASkOAfM7KmkZNX98gyMbrGNZGqbQaJe4thK9UuEKmO
        KivqoQ8TpOLwc4w8ygDFG7f9B7Ty2lVS4egXittG/CD+tXnN01itv5K0mRUJrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702303071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OtPxZyAIr0q83FqrgnW8CYSUeZdYcDZKkr11TEUXgqA=;
        b=Y1ZfO36DL0bvoLPgjRbH8hoQDThICl2d/0+e4QHrF8t71kuYefcKZhfxiEc+lYm+dpiDPK
        b53MOh73dLtA4LAA==
From:   Nam Cao <namcao@linutronix.de>
To:     stable@vger.kernel.org
Cc:     jiajie.ho@starfivetech.com, palmer@rivosinc.com,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Backport riscv kconfig for v6.6
Message-ID: <20231211145750.7bc2d378@namcao>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please backport 78a03b9f8e6b ("riscv: Kconfig: Add select ARM_AMBA to
SOC_STARFIVE") to v6.6

Without this, it is not possible to configure the kernel with SPI drivers
for the Visionfive 2 board.

This one depends a1a5f2c88725 ("dmaengine: pl330: rename _start to prevent
build error"), which is already in stable.

It should be backported to v6.1 too, but it does not apply cleanly. So I
will send a patch for that.

Best regards,
Nam
