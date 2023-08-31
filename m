Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2256C78EFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbjHaOyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHaOyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B25D1B1;
        Thu, 31 Aug 2023 07:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 107D16231D;
        Thu, 31 Aug 2023 14:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E78C433C7;
        Thu, 31 Aug 2023 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693493643;
        bh=orCWnUTSmyPAPaQhLOGsKYZEN1WXeEMObFp3b6zPbFQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QVylxvqHwzBF/GWkVMrSQO7/V3/VnS7Q2fJHg72ZqG+ufAGks9g+3YdF9QEib9+I+
         JyTkLdZB0JU3aQrXYoQQGSr8pA/l2IqFaghrGVSrgA/9ZFPJffURz1y8F73OrLaep5
         0fXZ2WD299T/JWMTovSa5KdkHSS30x9LH0zeQyjV8bU/V0eAL5UGJ/d9JTJL2Lg0JR
         3QI4DZ7zrD/ziBSSRxAwCYXfDzcuQgXi3y2idXx+P6+Hw94KojbfuPYVW5sRkn+N2B
         YKnMLwmDrNDvU05jKmp+os+Rcy2g/q1JmM4KhzYFlfUOc3WqpTJ38HjVy5ZsT7Vm5l
         /jdgFcyt+E1mw==
Message-ID: <708d8cfb-054a-9bf6-df35-4eed57311fc3@kernel.org>
Date:   Thu, 31 Aug 2023 16:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Content-Language: en-US
To:     =?UTF-8?B?0KDQsNC90LQg0JTQtdC10LE=?= <deeb.rand@confident.ru>,
        Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     lvc-project <lvc-project@linuxtesting.org>,
        =?UTF-8?B?0JLQvtGB0LrRgNC10YHQtdC90YHQutC40Lkg0KHRgtCw0L3QuNGB0LvQsNCyINCY?=
         =?UTF-8?B?0LPQvtGA0LXQstC40Yc=?= 
        <voskresenski.stanislav@confident.ru>
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <ac040329-25a9-121b-b2b4-843b6a8d2a29@kernel.org>
 <763366419.1280837.1693491918477.JavaMail.zimbra@confident.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <763366419.1280837.1693491918477.JavaMail.zimbra@confident.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2023 16:25, Ранд Дееб wrote:
> Dear Krzysztof,
> 
> Thank you for your response, now I see, but we already used the standard 
> tool git send-email to send the patch. It seems we have to set the 
> transfer-encoding manually (not default), we will fix it next time.
> It's our first time trying to send a patch.
> 

Again, do not top post.

If you used git send-email, then where is X-Mailer header saying it was
git send-email? That's why I doubt you used it.

Best regards,
Krzysztof

