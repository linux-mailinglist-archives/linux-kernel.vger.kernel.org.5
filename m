Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA947F574A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjKWEGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjKWEFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:05:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE96D56
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:04:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DAC433CB;
        Thu, 23 Nov 2023 04:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700712268;
        bh=KmxTa8bVp0SFdeKiJ3bvpxAg995JDczqNvga4SYbSWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CWK1r8kh8zewWnlPSjyTYqxCXOjrG492jjJasW8HH+LiH2BwuJ3cKJuOnFmfORvdb
         Bk+rD1TfYwoZDtM76N0tdNhceFfAnA4guuvM+NakVWb1OQ3wXcctHJnmyj5VZDDfC3
         vCC1CNM4LZvTKpgxnAKrMw1UVieLbxe6OoWsQwzjxwDEHvd2Z96AvJdQY0TlO/bnT/
         EoGk6Yingh+qkilpGD5eaUQXP1qK7qPx2NegTe2t6D+X/0x6rXK/3OR45fIJp3p/l3
         9Mm8rcZFKmoxYhBkRsFEvNSYsU3c9Pxn/uffceJLfG+hkIbia1p1h+UrnfMQb1gw30
         zU37POF3C+gvA==
Date:   Wed, 22 Nov 2023 20:04:26 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20231122200426.390e0068@kernel.org>
In-Reply-To: <20231123134545.3ce67bd4@canb.auug.org.au>
References: <20231123134545.3ce67bd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:45:45 +1100 Stephen Rothwell wrote:
> include/net/page_pool/types.h:73: warning: Function parameter or member 'STRUCT_GROUP(' not described in 'page_pool_params'

Yes, sorry, the script is confused when group contains only private
fields. I'll add a public field there any day now (tm) so the warning
will go away.
