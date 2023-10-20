Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08CE7D063E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346823AbjJTBwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjJTBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:52:13 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 86FA211B;
        Thu, 19 Oct 2023 18:52:10 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 59F47604BCB73;
        Fri, 20 Oct 2023 09:52:07 +0800 (CST)
Message-ID: <1d380712-2d08-9ac5-fff9-f13fb4e9aaa9@nfschina.com>
Date:   Fri, 20 Oct 2023 09:52:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] scsi: snici: Remove dead code in
 snic_dr_clean_pending_req
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <15081b01-2915-42a4-bcda-0d8243741baa@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/19 18:09, Dan Carpenter wrote:
> On Thu, Oct 19, 2023 at 04:30:27PM +0800, Su Hui wrote:
>> Value stored to 'ret' is never read, remove it to save space.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> Could you do this a bit more thouroughly and remove all the
> "ret = FAILED;" and "ret = 0;" assignments.  Just "return FAILED;"
> and "return 0;" directly.
Yes, this is better, thanks for your advice.
I will send v2 later.

Su Hui


