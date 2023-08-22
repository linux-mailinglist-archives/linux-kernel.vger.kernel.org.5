Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF7784969
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHVSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHVSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252ACD8;
        Tue, 22 Aug 2023 11:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDBD361589;
        Tue, 22 Aug 2023 18:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5313C433C8;
        Tue, 22 Aug 2023 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692729047;
        bh=rEk92bCPJMIoV+Ag+ogIz4QIInV+lcT4q1dEQPA/SHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UZvXLLRY7qPDTcO6u6rOVlJSIy16BQJS545NyhyeQ1ZIyIYNv+i3ILUSMI08E2jiF
         jAUDHcXjeJ3R4G6zmrKV/wfIV0GiMtG0fb8f9+f++1YRJt2iP+LCglu0NBFRg45+Yg
         e5U2v11wYBUV2W3vHIANnBWSh8lQcwzHq1YqWRdJpckVqpqvB5BTIALBsL4L/+l4RB
         X+m1VJCG0hTSE7ax5ods7uk9ezJD0WpQPiAj/HFuqXJchT6bKrqR+i5//h9HPyCVSI
         SuiyC0lfH53wSkIyQpBlMpFxwIRhpQAM3ixkpFugkHf5dja0AEgIdZHJDNR+K9mGlc
         r8rQyeP11CAiQ==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
In-Reply-To: <20230613101635.77820-1-n.zhandarovich@fintech.ru>
References: <20230613101635.77820-1-n.zhandarovich@fintech.ru>
Subject: Re: [PATCH] HID: logitech-dj: Fix error handling in
 logi_dj_recv_switch_to_dj_mode()
Message-Id: <169272904561.2558202.16302570092811881723.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 20:30:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 03:16:35 -0700, Nikita Zhandarovich wrote:
> Presently, if a call to logi_dj_recv_send_report() fails, we do
> not learn about the error until after sending short
> HID_OUTPUT_REPORT with hid_hw_raw_request().
> To handle this somewhat unlikely issue, return on error in
> logi_dj_recv_send_report() (minding ugly sleep workaround) and
> take into account the result of hid_hw_raw_request().
> 
> [...]

Applied to hid/hid.git (for-6.6/logitech), thanks!

[1/1] HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()
      https://git.kernel.org/hid/hid/c/6f20d3261265

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

