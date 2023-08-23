Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6D786096
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbjHWT0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjHWT0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:26:08 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F210C8;
        Wed, 23 Aug 2023 12:26:06 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae831.dynamic.kabel-deutschland.de [95.90.232.49])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DDABA61E5FE01;
        Wed, 23 Aug 2023 21:25:02 +0200 (CEST)
Message-ID: <3a9bf7a1-1664-401d-8cff-3a5d553bdd77@molgen.mpg.de>
Date:   Wed, 23 Aug 2023 21:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: checkpatch complains about Reported-by block (was: [PATCH v3] tpm:
 Enable hwrng only for Pluton on AMD CPUs)
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: +Andy, +Joe]


Dear Jarkko, dear Andy, dear Joe,


Am 23.08.23 um 19:40 schrieb Jarkko Sakkinen:
> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:

>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
>>> reported systems the TPM doesn't reply at bootup and returns back the
>>> command code. This makes the TPM fail probe.
>>>
>>> Since only Microsoft Pluton is the only known combination of AMD CPU and
>>> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
>>> aware of this, print also info message to the klog.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Mario’s patch also had the three reporters below listed:
>>
>> Reported-by: Patrick Steinhardt <ps@pks.im>
>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> 
> The problem here is that checkpatch throws three warnings:
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #19:
> Reported-by: Patrick Steinhardt <ps@pks.im>
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #20:
> Reported-by: Ronan Pigott <ronan@rjp.ie>
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> 
> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
> #21:
> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Since bugzilla is not part of the documented process afaik, I used this
> field as the guideline:
> 
> Reported:	2023-08-17 20:59 UTC by Todd Brandt
> 
> How otherwise I should interpret kernel bugzilla?

How is the proper process to add more than one reporter (so they are 
noted and also added to CC), so that checkpatch.pl does not complain?


Kind regards,

Paul


> In any case new version is still needed as the commit message must
> contain a mention of "Lenovo Legion Y540" as the stimulus for doing
> this code change in the first place.
> 
> BR, Jarkko
