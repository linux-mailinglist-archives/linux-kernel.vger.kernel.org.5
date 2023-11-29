Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D797FE2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjK2WPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjK2WPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:15:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B61A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:15:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57631C433C7;
        Wed, 29 Nov 2023 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701296143;
        bh=plgOXsBw6Cgzi7c+sOMbPbteFDD/cEFFdXdKvhv6+P4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zexjm4Co0EhbtqVufBP3QVY5t/FKctGeVJLCxYNrdXXGByHewpU1LSj2DZ412YRXs
         mT6+LLpxo81J1C8HyW3PRtesuArvpT+ocnvARABWCODRJ+D/rCMN1X+4Mh339MGFjK
         GgEFdo6cTQWzLyo7bLsyjdcIN75ceQHfteCUres8=
Date:   Wed, 29 Nov 2023 14:15:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, casper.li@mediatek.com,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        linux-mm@kvack.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] scripts/gdb/tasks: Fix lx-ps command error
Message-Id: <20231129141542.56d76170d38f2f6ee6b9ece3@linux-foundation.org>
In-Reply-To: <20231129081009.GF22743@redhat.com>
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
        <20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
        <20231129081009.GF22743@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 09:10:09 +0100 Oleg Nesterov <oleg@redhat.com> wrote:

> > Fixes: 8e1f385104ac ("kill task_struct->thread_group")
> > Cc: stable@vger.kernel.org
> 
> Is it possible to merge this simple change before v6.7 ?
> Then "cc: stable" can be removed.

Yes, I shall do all that.
