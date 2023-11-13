Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE4E7E9F81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKMPGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjKMPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:06:10 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94571D51
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:06:03 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 410E0240105
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 16:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1699887961; bh=AysCfJIOEBxPiL99wZ1Aw/KlWYK0Ft/fT6gutzSaLP4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=mDalR2aBzXSIHGPSwLs+VtxO0eZvFt1x08rnI3WKeA+r9+QdZhLWAQCsVkn5+Z3Rl
         ROyc/yW4GmXZ2cZDWCnZ8sVsDLvtzc053gzofR1L99bEl9v+un+5mwpklhIwgPaLq4
         nhdRa99J0+WSYhSfonqLpM5Ejyp0qJhGpltqTNqD40FKDdno0nvMqzrug4fRqWxw9t
         JZElx+Emi1cJzfk8CykC6QCXHp1HUwW2xDMcU3PCLrcvQL/I6hJwVQaDVYZggNCOKo
         G9jWqRBQrUACNxMF5Kbqbv6lgY5FfioQ90TFlRJsWTVfaTCj9TAVOC94/n5fZ3H5x7
         kd2g7C0vimbWw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4STXn26xbnz9rxM;
        Mon, 13 Nov 2023 16:05:58 +0100 (CET)
From:   Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH 0/8] staging: sm750fb: Multiple camel cases renames
Date:   Mon, 13 Nov 2023 15:05:05 +0000
Message-Id: <20231113150512.1210869-1-charmitro@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported by "checkpatch.pl":
	$ ./scripts/checkpatch.pl --file --terse drivers/staging/sm750fb/ddk750_dvi.c
	drivers/staging/sm750fb/ddk750_dvi.c:19: CHECK: Avoid CamelCase: <sii164GetDeviceID>
	drivers/staging/sm750fb/ddk750_dvi.c:21: CHECK: Avoid CamelCase: <sii164ResetChip>
	drivers/staging/sm750fb/ddk750_dvi.c:22: CHECK: Avoid CamelCase: <sii164GetChipString>
	drivers/staging/sm750fb/ddk750_dvi.c:23: CHECK: Avoid CamelCase: <sii164SetPower>
	drivers/staging/sm750fb/ddk750_dvi.c:24: CHECK: Avoid CamelCase: <sii164EnableHotPlugDetection>
	drivers/staging/sm750fb/ddk750_dvi.c:25: CHECK: Avoid CamelCase: <sii164IsConnected>
	drivers/staging/sm750fb/ddk750_dvi.c:26: CHECK: Avoid CamelCase: <sii164CheckInterrupt>
	drivers/staging/sm750fb/ddk750_dvi.c:27: CHECK: Avoid CamelCase: <sii164ClearInterrupt>
	total: 0 errors, 0 warnings, 8 checks, 62 lines checked

Charalampos Mitrodimas (8):
  staging: sm750fb: Rename sii164GetDeviceID to sii164_get_device_id
  staging: sm750fb: Rename sii164ResetChip to sii164_reset_chip
  staging: sm750fb: Rename sii164GetChipString to sii164_get_chip_string
  staging: sm750fb: Rename sii164SetPower to sii164_set_power
  staging: sm750fb: Rename sii164EnableHotPlugDetection to
    sii164_enable_hot_plug_detection
  staging: sm750fb: Rename sii164IsConnected to sii164_is_connected
  staging: sm750fb: Rename sii164CheckInterrupt to
    sii164_check_interrupt
  staging: sm750fb: Rename sii164ClearInterrupt to
    sii164_clear_interrupt

 drivers/staging/sm750fb/ddk750_dvi.c    | 16 +++++------
 drivers/staging/sm750fb/ddk750_sii164.c | 38 ++++++++++++-------------
 drivers/staging/sm750fb/ddk750_sii164.h | 16 +++++------
 3 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.39.2

