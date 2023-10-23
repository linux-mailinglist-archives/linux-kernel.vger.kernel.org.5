Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB07D413B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjJWUrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJWUrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:47:39 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD73D7C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:47:38 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1qv1pm-0002sT-ES
        for linux-kernel@vger.kernel.org; Mon, 23 Oct 2023 22:47:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias()
 and create_pnp_modalias()
Date:   Mon, 23 Oct 2023 22:47:28 +0200
Message-ID: <34f67950-f35c-02f2-b93a-306ee14457ac@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <CAJZ5v0h9mfQoiok6URGaw7OHjHCFxPWDxiP68NGe9Ow-8PY0jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
In-Reply-To: <CAJZ5v0h9mfQoiok6URGaw7OHjHCFxPWDxiP68NGe9Ow-8PY0jA@mail.gmail.com>
Cc:     linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/10/2023 à 22:09, Rafael J. Wysocki a écrit :
> On Mon, Oct 23, 2023 at 7:32 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> All issues have been introduced by the same commit, 8765c5ba1949 ("ACPI
>> / scan: Rework modalias creation when "compatible" is present")
>>
>> The first 2 patches fixe some issues related to string truncation checks
>> and to computation of the available space in the output buffer.
>>
>> The 2 others are just some clean-ups.
>>
>> Christophe JAILLET (4):
>>    ACPI: sysfs: Fix the check for a potential string truncation
>>    ACPI: sysfs: Fix a potential out-of-bound write in
>>      create_of_modalias()
>>    ACPI: sysfs: Remove some useless trailing NULL writes
>>    ACPI: sysfs: Remove some dead code
>>
>>   drivers/acpi/device_sysfs.c | 18 ++++++++----------
>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> --
> 
> Thanks for the fixes!
> 
> I would combine patch [1/4] with patch [2/4] and patch [3/4] with
> patch [4/4], though.
> 
> If that's OK, I can do that while applying the patches.
> 

Hi,

up to you.
Either way is fine for me.

CJ

