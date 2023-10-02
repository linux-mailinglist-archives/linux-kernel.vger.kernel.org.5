Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153C7B5D22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjJBWa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:30:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78EE0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:30:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E63C433C7;
        Mon,  2 Oct 2023 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696285822;
        bh=79cFsXTH0qYAJS5Y5EHSRryuk0cU8c3bNjf376YvJYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IzZEajQcdtcOlQdu0t+KOWccV9I8tJNmfAc0TXNtJ0FOSGdn1gwaVVo89k2r6hVHD
         Im9qUf5syLC2SonUXONxJSOqGeJxVST1RK+jylYg31ZKd3BWzCdGMcpaazSphXpCEI
         uqrdnU5LAbQsE8NwpR1Bf/V1Yxj0aHH9uWB2iJ0tpbNDu4B+nzYZgF+gusbfgXqdql
         Gou0cP8aURCwJarjT07+UpBq6Nr5LomJoyG/U/nHvfD4prPTaOiyiIBGJKEyY26mio
         OqHuP0bIQImFy4us2DonJeZW5o5GZGwPR6rCTDIby9S9RVA36aT10kKQT9JOLO0Bpx
         ZHk/vOLb/NsXA==
Date:   Mon, 2 Oct 2023 15:30:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     minyard@acm.org, joel@jms.id.au, andrew@aj.id.au,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mctp: Add MCTP-over-KCS transport binding
Message-ID: <20231002153011.5444fd83@kernel.org>
In-Reply-To: <20231002143441.545-4-aladyshev22@gmail.com>
References: <20231002143441.545-1-aladyshev22@gmail.com>
        <20231002143441.545-4-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Oct 2023 17:34:41 +0300 Konstantin Aladyshev wrote:
> This change adds a MCTP KCS transport binding, as defined by the DMTF
> specificiation DSP0254 - "MCTP KCS Transport Binding".
> A MCTP protocol network device is created for each KCS channel found in
> the system.
> The interrupt code for the KCS state machine is based on the current
> IPMI KCS driver.

Still doesn't build, please make sure W=1 C=1 build is clean with both
GCC and Clang (you can point them at a specific path to avoid building
the entire kernel with the warnings enabled).
-- 
pw-bot: cr
