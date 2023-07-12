Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF943750DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjGLQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGLQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:15:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA22100;
        Wed, 12 Jul 2023 09:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A87F6182F;
        Wed, 12 Jul 2023 16:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC67C433C8;
        Wed, 12 Jul 2023 16:14:49 +0000 (UTC)
Date:   Wed, 12 Jul 2023 12:14:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ring-buffer: Fix deadloop issue on reading trace_pipe
Message-ID: <20230712121448.628ad188@gandalf.local.home>
In-Reply-To: <63ff741f-b781-37da-3f47-15d1a8ff76a4@huawei.com>
References: <20230708225144.3785600-1-zhengyejian1@huawei.com>
        <20230709154523.32dc89c2@rorschach.local.home>
        <63ff741f-b781-37da-3f47-15d1a8ff76a4@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 09:37:52 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> teve, IIUC, following tags should be added?
> 
> Cc: stable@vger.kernel.org
> Fixes: 48fdc72f23ad ("ring-buffer: Fix accounting of entries when 
> removing pages")
> Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages 
> atomic")

I actually added:

Fixes: a5fb833172eca ("ring-buffer: Fix uninitialized read_stamp")

-- Steve
