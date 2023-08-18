Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7441F7804EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357761AbjHRDrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjHRDqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:46:35 -0400
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 20:46:33 PDT
Received: from out-59.mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830C3592
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 20:46:32 -0700 (PDT)
Message-ID: <2f77080c-6ac2-69cc-fd38-5d71a6cdc8df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692329884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FjJKtE8F8ZIEABqxYxO8DTnV0r5bB4/9fLe/dED26Rw=;
        b=Ww/U1WPJeiE6zjV2BKmgx/AQsBJ8ggHs/e9Wwm91qrUIiFMUUicq3RNaMqTXLyAu4QbP1L
        eBY1JbsiUYnC/MFyCSveDrGt73DsnFX2KDl5/4DnkQpJ0tnYmHtppp2nd9IKlMETbbqBC2
        54DrECSMdgA7J57VH+iP4f4tp7/l0gg=
Date:   Thu, 17 Aug 2023 20:37:59 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 20/20] ARC: pt_regs: create seperate type for ecr
Content-Language: en-US
To:     Pavel.Kozlov@synopsys.com, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
References: <20230815004813.555115-21-vgupta@kernel.org>
 <20230817120935.59181-1-kozlov@synopsys.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <20230817120935.59181-1-kozlov@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/23 05:09, Pavel.Kozlov@synopsys.com wrote:
> Hi Vineet,
>
> I'm testing your updates and ran into the same build issue reported by the build
> robot.
> http://lists.infradead.org/pipermail/linux-snps-arc/2023-August/007522.html
>
>> #define MAX_REG_OFFSET offsetof(struct pt_regs, event)
> This change causes a build issue for ARC700, as the event field has been
> removed and the MAX_REG_OFFSET macro hasn't been updated.

I've posted v2 for 3 patches. Please reapply/retest the whole series.

Thx,
-Vineet

