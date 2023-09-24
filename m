Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ADF7AC71E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjIXIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjIXIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 04:05:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85FD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 01:05:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qkK6y-0006Y0-An; Sun, 24 Sep 2023 10:05:04 +0200
Message-ID: <af272e77-5a9c-476f-ba21-df50a97c0d17@leemhuis.info>
Date:   Sun, 24 Sep 2023 10:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mainline build failure due to ace6d1448138 ("mfd: cs42l43: Add
 support for cs42l43 core driver")
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        regressions@lists.linux.dev
References: <ZO8oNb2hpegB6BbE@debian>
 <CADVatmNY=KB-KCpMAGU_krpoX-eKxha3BSHT0u9XfcPuEoOMPQ@mail.gmail.com>
 <20663b9e-8ff3-4e50-ba89-6cc028ab0981@leemhuis.info>
In-Reply-To: <20663b9e-8ff3-4e50-ba89-6cc028ab0981@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695542707;9fa25b97;
X-HE-SMSGID: 1qkK6y-0006Y0-An
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.23 09:58, Thorsten Leemhuis wrote:
> On 23.09.23 17:02, Sudip Mukherjee wrote:
>> On Wed, 30 Aug 2023 at 12:29, Sudip Mukherjee (Codethink)
>> <sudipm.mukherjee@gmail.com> wrote:
>>>
>>> The latest mainline kernel branch fails to build alpha, csky and s390
>>> allmodconfig with the error:
>>>
>>> drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
>>>  1138 | static int cs42l43_runtime_resume(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~~~~~~
>>> drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
>>>  1124 | static int cs42l43_runtime_suspend(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
>>>  1106 | static int cs42l43_resume(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~
>>> drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
>>>  1076 | static int cs42l43_suspend(struct device *dev)
>>>       |            ^~~~~~~~~~~~~~~
>>>
>>> git bisect pointed to ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
>>
>> Since its almost time for v6.6-rc3, so just a quick reminder that this
>> build failure is still not fixed.
> 
> Are you sure? I had expected eb72d5207008db ("mfd: cs42l43: Use correct
> macro for new-style PM runtime ops")[1] that was merged this week would
> have fixed this. Or am I mixing different problems up here?

Ahh, sorry, just noticed Linus merged that fix a few hours after your
mail, so I guess everything should be settled now. Ciao, Thorsten
