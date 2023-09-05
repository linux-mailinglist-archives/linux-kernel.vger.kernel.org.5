Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922C792C67
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjIER3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240692AbjIER2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:28:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7075F5065F;
        Tue,  5 Sep 2023 09:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC8F4CE1288;
        Tue,  5 Sep 2023 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81B1C433C7;
        Tue,  5 Sep 2023 16:41:13 +0000 (UTC)
Date:   Tue, 5 Sep 2023 12:41:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc:     <mhiramat@kernel.org>, <bobule.chang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <cheng-jui.wang@mediatek.com>,
        <stable@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ring-buffer: Do not read at &event->array[0] if it
 across the page
Message-ID: <20230905124132.672be4c0@gandalf.local.home>
In-Reply-To: <20230905142319.32582-1-Tze-nan.Wu@mediatek.com>
References: <20230905142319.32582-1-Tze-nan.Wu@mediatek.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2023 22:23:15 +0800
Tze-nan Wu <Tze-nan.Wu@mediatek.com> wrote:

> resend again due to forget cc stable@vger.kernel.org

You don't need to Cc' stable. I'll add the Cc if I feel it is the right
patch for the solution.

-- Steve
