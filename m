Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5307AE7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbjIZIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjIZIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:15:30 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6C510A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:15:20 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 1C88E207A2;
        Tue, 26 Sep 2023 10:15:16 +0200 (CEST)
Date:   Tue, 26 Sep 2023 10:14:54 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Joe Hung <joe_hung@ilitek.com>
Subject: Re: [PATCH v2 2/2] Input: ilitek_ts_i2c - add report id message
 validation
Message-ID: <ZRKS/tlg8NwukkUD@francesco-nb.int.toradex.com>
References: <20230920074650.922292-1-ghidoliemanuele@gmail.com>
 <20230920074650.922292-3-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920074650.922292-3-ghidoliemanuele@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:46:50AM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Ilitek touch IC driver answer to plain i2c read request, after it has
> generated an interrupt request, with a report id message starting
> with an identifier and a series of points.
> If a request is sent unsolicited by an interrupt request the answer
> do not contain this identifier.
> Add a test to discard these messages, making the driver robust to
> spurious interrupt requests.
> 
> Fixes: 42370681bd46 ("Input: Add support for ILITEK Lego Series")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

