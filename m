Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3A98044EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbjLECbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376510AbjLECam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:30:42 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 95CEAD4C;
        Mon,  4 Dec 2023 18:30:47 -0800 (PST)
Received: from [172.30.20.54] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id A473660598E85;
        Tue,  5 Dec 2023 10:30:22 +0800 (CST)
Message-ID: <098b1c0f-f303-3708-939a-28ecaf2185c3@nfschina.com>
Date:   Tue, 5 Dec 2023 10:30:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3] misc: mei: client.c: fix problem of return
 '-EOVERFLOW' in mei_cl_write
Content-Language: en-US
To:     alexander.usyskin@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     tomas.winkler@intel.com, arnd@arndb.de, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <2023120425-broaden-image-fdc9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/4 21:17, Greg KH wrote:
> On Mon, Dec 04, 2023 at 04:11:31PM +0300, Dan Carpenter wrote:
>> On Mon, Dec 04, 2023 at 09:00:42AM +0100, Greg KH wrote:
>>>> diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
>>>> index 7ea80779a0e2..0489bec4fded 100644
>>>> --- a/drivers/misc/mei/client.c
>>>> +++ b/drivers/misc/mei/client.c
>>>> @@ -2033,7 +2033,7 @@ ssize_t mei_cl_write(struct mei_cl *cl, struct mei_cl_cb *cb, unsigned long time
>>>>   	hbuf_slots = mei_hbuf_empty_slots(dev);
>>>>   	if (hbuf_slots < 0) {
>>>>   		rets = -EOVERFLOW;
>>>> -		goto out;
>>>> +		goto err;
>>> Please prove that this is correct, as based on the code logic, it seems
>>> very wrong.  I can't take this unless the code is tested properly.
>> Hi Greg,
>>
>> When Su Hui sent the v2 patch you sent an auto response about adding
>> stable to the CC list.
>> https://lore.kernel.org/all/2023112042-napped-snoring-b766@gregkh/
>>
>> However, it appears that you still applied the v2 patch.  It's in
>> linux-next as commit ee6236027218 ("misc: mei: client.c: fix problem of
>> return '-EOVERFLOW' in mei_cl_write").
>>
>> When I use `git am` to apply this patch, then it doesn't apply.  However,
>> when I use cat email.txt | patch -p1 then it tries to reverse the patch
>> and apply it to a different function.
> Odd, I missed that I had already applied the first one, nevermind, that
> one is correct, this one was wrong :)

Hi,

Oh, sorry...
I'm not familiar with mei device, I send this v3 patch because of Sasha' 
s suggestion.[1]
Could Sasha give some advice about this ?
Thanks a lot :)

https://lore.kernel.org/all/CY5PR11MB63668F464A281A239FA12B6AEDBDA@CY5PR11MB6366.namprd11.prod.outlook.com/


