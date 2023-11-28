Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302F17FB2C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbjK1HbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjK1HbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:31:11 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A4D41;
        Mon, 27 Nov 2023 23:31:13 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id D5DDA20378;
        Tue, 28 Nov 2023 08:31:11 +0100 (CET)
Date:   Tue, 28 Nov 2023 08:31:07 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] Bluetooth: btnxpuart: remove useless assignment
Message-ID: <ZWWXOxl6XZJs2reN@francesco-nb.int.toradex.com>
References: <20231127191409.151254-1-francesco@dolcini.it>
 <20231127191409.151254-4-francesco@dolcini.it>
 <f19ac2b9-7e4c-44e8-b979-c8c4e9d627ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f19ac2b9-7e4c-44e8-b979-c8c4e9d627ab@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 06:26:56AM +0100, Jiri Slaby wrote:
> On 27. 11. 23, 20:14, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Remove useless assignment of rx_skb to NULL in case the skb is in error,
> > this is already done in h4_recv_buf() that is executed a few lines
> > before.
> 
> In case of error, nxpdev->rx_skb contains the error, not NULL, right?
correct.

The point is that we have

  if (IS_ERR(skb))
    skb = NULL;

at the beginning of h4_recv_buf(), that is called a few lines before,
making the assignment in btnxpuart.c redundant.

Francesco

