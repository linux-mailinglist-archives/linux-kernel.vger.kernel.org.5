Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41ECC800D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379185AbjLAOjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379206AbjLAOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:39:29 -0500
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2AD1711
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:39:30 -0800 (PST)
Received: from [172.23.111.174] (unknown [111.52.6.202])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 2C3B6800094;
        Fri,  1 Dec 2023 22:39:02 +0800 (CST)
Message-ID: <b118c12f-b94d-46aa-ab72-55ac2ce7813f@link.tyut.edu.cn>
Date:   Fri, 1 Dec 2023 22:39:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/show_delta: reformat code
Content-Language: en-US
To:     Nicolas Schier <n.schier@avm.de>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
References: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
 <ZWmB67THrLcztb-3@buildd.core.avm.de>
From:   Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <ZWmB67THrLcztb-3@buildd.core.avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEtDVhhLTB1IS0tIT0lIQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKSlVOSVVNVUlLSVlXWRYaDxIVHRRZQVlPS0hVSkhKTk1JVUpLS1VLWQY+
X-HM-Tid: 0a8c25d19942b03akuuu2c3b6800094
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6HCo4Sjw*QxQCGiFICzcf
        CDRPCRhVSlVKTEtKT09KTk9IS01NVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
        V1kSC1lBWUpKSlVOSVVNVUlLSVlXWQgBWUFITkxINwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/1 14:49, Nicolas Schier wrote:
> On Fri, Dec 01, 2023 at 01:35:40PM +0800, Hu Haowen wrote:
>> Correct some lines in irregular coding style to make them look more
>> harmonious and fit the common coding regulations in Python.
>>
>> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
>> ---
>>   scripts/show_delta | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/scripts/show_delta b/scripts/show_delta
>> index 291ad65e3089..33446adce74b 100755
>> --- a/scripts/show_delta
>> +++ b/scripts/show_delta
>> @@ -13,7 +13,7 @@ import sys
>>   import string
>>   
>>   def usage():
>> -	print ("""usage: show_delta [<options>] <filename>
>> +	print("""usage: show_delta [<options>] <filename>
> Hi,
>
> thanks for your patch.  What Miguel already noticed for v1 is valid for
> v2, too: there are still inconsistencies in the coding style, e.g.
> `print (...)` and `print(...)`.
>
> To simplify a consistent coding style for future work on the script,
> using an external tool for reformatting (and mentioning it in the commit
> message) would be helpful.  Miguel suggested Black or Ruff, I think this
> is a good idea.


Just got a glimpse on the usage of Black and realized the convenience
it provides and strictness of code style it supplies. It is pretty
feasible for code style analysis series of Python scripts within the
kernel source.

However, here comes the issue that this tool binds itself to its own
bunches of rules how the code should be formatted by default, resulting
in some kind of scenes which do not match what we want when doing kernel
programming, or more exactly this tool may not follow the rules regulated
by the kernel developers or mentioned within kernel documentation,
which means we are obliged to conduct a programming standard for Python
coding within kernel source internally, and then ask Black to review and
reformat the code accordingly. But this programming standard is absent
currently, consequently it should be specified initially from my
perspective. What is your idea on this?

(The Black code style: 
https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html)

Thanks,
Hu Haowen


>
> Kind regards,
> Nicolas
