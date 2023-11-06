Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03407E2E17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjKFUUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjKFUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:20:38 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8E010D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:20:33 -0800 (PST)
Message-ID: <b6f134e7-cc2f-49f2-8c52-8ff0bacc3941@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699302032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Czz03c7B8Ipf+ig640Okg2kezVH+J+rO2vcFaPEA8SI=;
        b=DUfW9aQoAa6yKtr/cSFLVHgtZXmLbklWuRO7WXE/j1JrkjsJsNMrdL9JM/X5hyc4CvQVgc
        VKZrg1bf4JGwU5MYJfFY67bBfbpXqWaEufPekT2By+ItH2VeISDVk4PeVAUU4p0qQYS3j1
        s7fWM2zNpy7lyxKrwsA0maqUNITNcR8=
Date:   Mon, 6 Nov 2023 23:20:30 +0300
MIME-Version: 1.0
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: question about ZRAM_HUGE flag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZRAM_HUGE flag doubles most significant bit in zram size.
I had an idea to redefine it, but do not fully understand how to do it correctly.
I'm sure that MSB = PAGE_SHIFT on BIG_ENDIAN but do not understand what's happen on LITTLE_ENDIAN?
Is MSB = 0 in this case? Could it have some other unpredictable value?
In any case I think we can always replace ZRAM_HUGE bit check by BIT(PAGE_SHIFT) test.

Thank you,
	Vasily Averin
