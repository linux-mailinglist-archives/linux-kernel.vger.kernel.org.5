Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FA480CA2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjLKMtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKMtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:49:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13161B8;
        Mon, 11 Dec 2023 04:49:25 -0800 (PST)
From:   Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702298963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KqyDGuj/w90Sx5xoRurtUb6bEnCDz+4edCPtCIkEmrY=;
        b=Ou/7GHgSj9OC6v5cZHEAucYkp8ZgWC7PIRySJJUMuuB0QxMY6kRftjmpGRCaweTVMs6aZM
        HRhNSBNBj4RgtbKvda4SmmHBuKIbKMtk9xR+8VmA3w+RhMEfH3TLLjH0yUk3sL8JECjOXd
        U5k6hDtWXwO+ubt3F8V2F75SmBiOei1gN2WBPAMyq+FbvpCZeSHkiOtOplP43JseLDA8is
        OmTDrSYj5Vu11n3q4hyb5e7EmUxx0kGpXWzAE1OqTx1nazQd6hb2Xuj0SRgS7qAnxa+NK9
        p07QLbnuEOpvLDgNqb/g1SnYVgXBDym4iEMM0cu0IHHxkA8PS/whGpMfcAJlbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702298963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KqyDGuj/w90Sx5xoRurtUb6bEnCDz+4edCPtCIkEmrY=;
        b=SCXzl3uy5iPrX9/PncfXnfqjDYhldsZUhj+dasLW8ugUN8aZRFX4zSHW6mscyoQQNExx7d
        ok0rkCJbEzWw31CA==
To:     linus.walleij@linaro.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] spi: pl022: clean up some unused variables
Date:   Mon, 11 Dec 2023 13:49:13 +0100
Message-Id: <cover.1702298527.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was refactored in 9b2ef250b31d ("spi: spl022: switch to use
default spi_transfer_one_message()"), and some variables are now unused
because of that. Clean them up.

Nam Cao (2):
  spi: pl022: delete unused cur_gpiod in struct pl022
  spi: pl022: delete unused next_msg_cs_active in struct pl022

 drivers/spi/spi-pl022.c | 9 ---------
 1 file changed, 9 deletions(-)

--=20
2.39.2

