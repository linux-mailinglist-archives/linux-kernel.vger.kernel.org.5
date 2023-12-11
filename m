Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419B780C253
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjLKHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjLKHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:46:57 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89B3F4;
        Sun, 10 Dec 2023 23:47:03 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 6FFCD2033B;
        Mon, 11 Dec 2023 08:47:01 +0100 (CET)
Date:   Mon, 11 Dec 2023 08:47:00 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: fix STA cannot connect to AP
Message-ID: <ZXa+dHwPe0D4p0pn@francesco-nb.int.toradex.com>
References: <20231208234127.2251-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208234127.2251-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 07:41:27AM +0800, David Lin wrote:
> AP BSSID configuration is missing at AP start.
> Without this fix, FW returns STA interface MAC address after first init.
> When hostapd restarts, it gets MAC address from netdev before driver
> sets STA MAC to netdev again. Now MAC address between hostapd and net
> interface are different causes STA cannot connect to AP.
> After that MAC address of uap0 mlan0 become the same. And issue
> disappears after following hostapd restart (another issue is AP/STA MAC
> address become the same).
> This patch fixes the issue cleanly.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
> Cc: stable@vger.kernel.org

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

