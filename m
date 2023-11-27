Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D297F9F95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjK0McK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 07:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjK0McE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:32:04 -0500
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 04:32:09 PST
Received: from deferred-out-02.cmp.livemail.co.uk (deferred-out-02.cmp.livemail.co.uk [213.171.216.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC6187;
        Mon, 27 Nov 2023 04:32:09 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by deferred-out-02.cmp.livemail.co.uk (Postfix) with ESMTP id A23FDD0C5B;
        Mon, 27 Nov 2023 12:25:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at deferred-out-02.cmp.livemail.co.uk
Received: from deferred-out-02.cmp.livemail.co.uk ([127.0.0.1])
        by localhost (deferred-out-02.cmp.livemail.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eP-kny6QKGuP; Mon, 27 Nov 2023 12:25:04 +0000 (GMT)
Received: from smtp.livemail.co.uk (smtp-auth-out-04.cmp.livemail.co.uk [10.44.166.53])
        by deferred-out-02.cmp.livemail.co.uk (Postfix) with ESMTP id 46FEFD0C59;
        Mon, 27 Nov 2023 12:25:04 +0000 (GMT)
Received: from laptop.lan (host-78-146-56-151.as13285.net [78.146.56.151])
        (Authenticated sender: malcolm@5harts.com)
        by smtp.livemail.co.uk (Postfix) with ESMTPSA id EE7DBC5A53;
        Mon, 27 Nov 2023 12:24:59 +0000 (GMT)
Message-ID: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
Subject: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
From:   Malcolm Hart <malcolm@5harts.com>
To:     broonie@kernel.org
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        regressions@lists.linux.dev,
        Sven Frotscher <sven.frotscher@gmail.com>,
        stable@vger.kernel.org
Date:   Mon, 27 Nov 2023 12:24:59 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other ASUS models the Asus Vivobook E1504FA requires an entry in
the quirk list to enable the internal microphone.

Showing
with 7 additions and 0 deletions.
7 changes: 7 additions & 0 deletions 7
sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id
yc_acp_quirk_table[] = {
			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
		}
	},
	{
		.driver_data = &acp6x_card,
		.matches = {
			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER
INC."),
			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
		}
	},
	{



I have this laptop and I have tested this patch successfully.

Malcolm
