Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1198F751464
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGLXXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjGLXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:23:04 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E81BD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:22:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9E1A1A327D;
        Wed, 12 Jul 2023 19:22:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
        0165xUKuhFx6oX5PHMQjF2TMBsaTDaVi5RGHkyOeIhE=; b=ZB29vdN+H6nhBFqN
        tU+deVNXRLnQKWA4yV2U4fxV2LnPew3U2mQeUSMj84CxUh5EK6ai/Rd4S6Yc9hJb
        v1FnXc3HvwAJ0xQEJbsOrsz5oXDCOnanjt2iS/xdApJo8chKMlEEgA3H+VcOC8BU
        0M+3KIQOm42rraGHVRGeQUgDSTQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFE891A327C;
        Wed, 12 Jul 2023 19:22:56 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=darkphysics.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2019-09.pbsmtp; bh=0165xUKuhFx6oX5PHMQjF2TMBsaTDaVi5RGHkyOeIhE=;
 b=el/hpON9uneIM1+RIfDS1KdybBl45LKGqr02f9mhShWQbNcJPf24kIJC5WBMfbBjz/nUBhyvKz1d2Vwdhmv19z4EgWJhb8RPvJtYTWujxujVCHLv36NqWbfUzsxtriw7sR0ddVp9rxPj0AJCu6qkV/1UblVy2EJih8I6hRLiF44=
Received: from basil (unknown [76.146.178.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A7B71A327B;
        Wed, 12 Jul 2023 19:22:55 -0400 (EDT)
        (envelope-from tdavies@darkphysics.net)
Date:   Wed, 12 Jul 2023 16:23:44 -0700
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca, error27@gmail.com
Cc:     tdavies@darkphysics.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] Staging: rtl8192e: Style Guide Cleanup
Message-ID: <ZK82AIxHctHFc27N@basil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Pobox-Relay-ID: 0824F012-210B-11EE-96F5-307A8E0A682E-45285927!pb-smtp2.pobox.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes checkpatch CamelCase warnings
in regard to drivers/staging/rtl8192e/rtl819x_BAProc.c

Tree Davies (12):
  Staging: rtl8192e: Rename function ActivateBAEntry
  Staging: rtl8192e: Rename function DeActivateBAEntry
  Staging: rtl8192e: Rename function TxTsDeleteBA
  Staging: rtl8192e: Rename function TsInitAddBA
  Staging: rtl8192e: Rename function TsInitDelBA
  Staging: rtl8192e: Rename function BaSetupTimeOut
  Staging: rtl8192e: Rename function TxBaInactTimeout
  Staging: rtl8192e: Rename function RxBaInactTimeout
  Staging: rtl8192e: Rename variable pBA
  Staging: rtl8192e: Rename variable Time
  Staging: rtl8192e: Rename variable pTxTs
  Staging: rtl8192e: Rename variable TxAdmittedBARecord

 drivers/staging/rtl8192e/rtl819x_BAProc.c | 186 +++++++++++-----------
 drivers/staging/rtl8192e/rtl819x_TS.h     |   2 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c |  20 +--
 drivers/staging/rtl8192e/rtllib.h         |  12 +-
 drivers/staging/rtl8192e/rtllib_tx.c      |  18 +--
 5 files changed, 119 insertions(+), 119 deletions(-)

-- 
2.41.0

