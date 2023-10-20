Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497227D06AC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbjJTC7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJTC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:59:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A3E7318C;
        Thu, 19 Oct 2023 19:59:44 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id B8284604C5033;
        Fri, 20 Oct 2023 10:59:41 +0800 (CST)
Message-ID: <f9d9860c-0446-faea-2a69-0b2516ba7dcf@nfschina.com>
Date:   Fri, 20 Oct 2023 10:59:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] net: lan78xx: add an error code check in
 lan78xx_write_raw_eeprom
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <aa78dff4-d572-4abc-9f86-3c01f887faf1@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/19 18:34, Dan Carpenter wrote:
> On Thu, Oct 19, 2023 at 04:40:23PM +0800, Su Hui wrote:
>> check the value of 'ret' after call 'lan78xx_read_reg'.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>
>> Clang complains that value stored to 'ret' is never read.
>> Maybe this place miss an error code check, I'm not sure
>> about this.
> There are a bunch more "ret = " assignments which aren't used in this
> function.
Yep, same problem  exists at lan78xx_read_raw_eeprom().
I try to send v2 patch to fix this.

Su Hui

