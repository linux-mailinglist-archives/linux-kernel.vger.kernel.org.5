Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67FC75AA13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjGTI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGTIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:34:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C3268C;
        Thu, 20 Jul 2023 01:34:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D3A46732D; Thu, 20 Jul 2023 10:34:23 +0200 (CEST)
Date:   Thu, 20 Jul 2023 10:34:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Huanpeng Xin <xinhuanpeng9@gmail.com>, minchan@kernel.org,
        ngupta@vflare.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xinhuanpeng <xinhuanpeng@xiaomi.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] zram: set zram bio priority to REQ_PRIO.
Message-ID: <20230720083422.GA7112@lst.de>
References: <20230718071154.21566-1-xinhuanpeng9@gmail.com> <20230718074929.GD955071@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718074929.GD955071@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People really need to stop randomly using REQ_PRIO.  It was added
back then because I did not want to overload REQ_META for WBT
priorisation, but it looks other added this somewhat bogus
priorisation back anyway.  If that is to stay it should probably
just go away entirely, but certainly not added for magic boosters
for normal data I/O.

