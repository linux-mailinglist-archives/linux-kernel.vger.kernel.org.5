Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAFD7B1E21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjI1NZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjI1NZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:25:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FE5CCB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:23:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE437C433C8;
        Thu, 28 Sep 2023 13:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907419;
        bh=AW7dHkRQzx5w/sq3kpZwJmYTqaOBZOIX9xTY92Ig2Y8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QOtchHqZn1CmEVA5W3aiLlIdl3+qOTFuHZAVGibOYbGX6q//etgkDH+NqZYut6qFM
         fnLnxdSwmza+l49+j98oBfH1GRqVRJ7wSS7HREgCMjo1CTmdaviaaa9f8oLyxKQJdL
         mx3vMa4YVI1jpLqRli7qNh6RkgQf3u56pYIO06GDo+Dg9XnYs0m3gSmTxyrSyJHacF
         0AgPl68kTiw/XwwdFn7CkEzm6eorZH4NBAEi9ERWtS7b/4Lp1T4/QcEXvYbI3MCVVf
         O5uVb5pRDy3RUIMV6WrLkWHtdPWJJwl/dNcdygIlgW7vVsNl0QuWagLXfiegS3V1VY
         8DEs7Je0gYckw==
From:   Lee Jones <lee@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Lee Jones <lee@kernel.org>, Qiang Ning <qning0106@126.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230925024134.9683-1-dinghao.liu@zju.edu.cn>
References: <20230925024134.9683-1-dinghao.liu@zju.edu.cn>
Subject: Re: (subset) [PATCH] mfd: dln2: Fix double put in dln2_probe
Message-Id: <169590741844.1593952.14473081444893949061.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:23:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 10:41:33 +0800, Dinghao Liu wrote:
> The dln2_free() already contains usb_put_dev(). Therefore,
> the redundant usb_put_dev() before dln2_free() may lead to
> a double free.
> 
> 

Applied, thanks!

[1/1] mfd: dln2: Fix double put in dln2_probe
      commit: 20890756e8753844de76afdf757cb74c6bab3e8b

--
Lee Jones [李琼斯]

