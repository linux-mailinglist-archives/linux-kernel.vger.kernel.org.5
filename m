Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F161A7B406F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbjI3NTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3NTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 09:19:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041A6E6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 06:19:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F3C433C8;
        Sat, 30 Sep 2023 13:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696079947;
        bh=TkJccJDta5ELpn2APXWKrpLmjnFVEgfNbXdHwnS1A48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prjRe/hp5ipBDD2VrPfn7Y262AKGszVcJxK1PYvUyF55UjcL9DBoaauzrNri8P8j9
         FLAgxmAxBLxiC/wGxLLlcCa8ZQYCKKu71ysKk7vZdukPFg9c28C3UGbcwI7bVKJCMx
         jcIvGhaPTBydQL2n9niLuJTHP//SHlUTAxLxy0ymYcQbPnbb4Q7bmJWoSKIwhsJ5HA
         xfp/bsRIFyMzTOL1axA/8DRMKM+7TD1eFyPFYVRZI23wlhd+NtabSELBw1sENEuRMs
         odu6X7ueSEpUu2W44HurRkb8KmnvhbdFnmQ43YIOxX7KhkycqgcWi42cxc+sbwJFH7
         IMKKuH77KCG6g==
Date:   Sat, 30 Sep 2023 15:19:03 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lin Ma <linma@zju.edu.cn>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 net] net: nfc: llcp: Add lock when modifying device
 list
Message-ID: <20230930131903.GA92317@kernel.org>
References: <20230925192351.40744-1-jeremy@jcline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925192351.40744-1-jeremy@jcline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:23:51PM -0400, Jeremy Cline wrote:
> The device list needs its associated lock held when modifying it, or the
> list could become corrupted, as syzbot discovered.
> 
> Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> Fixes: 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by nfc_llcp_find_local")
> Signed-off-by: Jeremy Cline <jeremy@jcline.org>

Reviewed-by: Simon Horman <horms@kernel.org>

