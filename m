Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC917FAA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjK0TXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0TXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:23:13 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21133D5A;
        Mon, 27 Nov 2023 11:23:20 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 32EDF206D2;
        Mon, 27 Nov 2023 20:23:18 +0100 (CET)
Date:   Mon, 27 Nov 2023 20:23:14 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Bluetooth: fix recv_buf() return value
Message-ID: <ZWTsoot/kAprNFz0@francesco-nb.int.toradex.com>
References: <20231127191409.151254-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127191409.151254-1-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jiri,

On Mon, Nov 27, 2023 at 08:14:05PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Serdev recv_buf() callback is supposed to return the amount of bytes
> consumed, therefore an int in between 0 and count.

I have also a patch ready to convert the return value of serdev
recv_buf() from int to size_t.

I would be inclined to wait for this series to go though first, given
that these are fixes, while the change from int to size_t is just a
cleanup to prevent future mistakes. Do you agree of would you do it
differently?

Francesco

