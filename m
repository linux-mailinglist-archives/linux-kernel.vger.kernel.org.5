Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47B17BB650
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjJFLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJFLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:20:13 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAF1119;
        Fri,  6 Oct 2023 04:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696591198;
        bh=oWIxnG2J+Jy/dMyxMYG3xUlceaQ+HsSfWnd1NKXS+fw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=HvIqtxBm3oQMs8oFAO8wFLYtDIr7RAf9U0XC+4R/WGDiKz8a2QSFidbmcqWLpHrJr
         HD/e9P78sDXPhtiYZNpy2wdXvUtIJXNuzeQnc/1OyQLkkX0+MWE17Q6/qD8J+pCtDb
         3tFdykT5J792IGIWglBJFMILOf/3RTEzScQRW5xM=
Received: from [10.255.201.129] ([122.14.229.79])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 4D906841; Fri, 06 Oct 2023 19:19:25 +0800
X-QQ-mid: xmsmtpt1696591165t6inxp8yd
Message-ID: <tencent_B2B6C2C0E43CB415F6506B24B66ED26BB909@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznDRsIcsNQ+c8SApwT/aeO2z0Gmtae0OnHojt/PWMwiJrUAFbnj0
         mA/lVdwN2n9K9h/e2nieBg1QjnDXgN4YREP5/+MvhYFqWV34B/vkPYWtOu1CzyMwqPpcccIKDWzl
         E5CTqO5GkYvpTfpCjjfkz+aGNsDmPOR19PrOD0lHp/lY7VlF5Sox6YL2GKMiBeNAM814qLeOUQdi
         UHRi2T8Qf7e/1Bvz9NFACZfI2sWST6jjPeDZi0V+mAqUQ2qupLph6Wi2ntFys21xVdTgS+RB6pQd
         bmutlMiYuI9ZR1BwCRj8zO3ojbZ3/8AQxvqLiiEvs0DjQDRrgE7sPY0LF6m4uKOiw0DeOhpaVb4U
         EM10JFzHcf1Y0vdNBI5ytzajDptk3hq2kddK34Tw2+guWVglnN69O8NidJhOfO9Ge9zhh1Jbz1Nk
         Axqdp0rQWdXlMfQKB6jxrhJeErNhSf5MUSC5o/NW9tIe5XokSGBL6MRPgB6apq01IfHU8Q1G1GuP
         Ic+uoDQXLk8K1uOuXge9dIG4/XAaCpCzjj+bAkmVZgN9cbOYCAZR3N8kgGRwRaeCNVr2CvtRCDAg
         gj89CtUYENULRkbBmeuz7iraUgPd7D1V6kXBYFB7GkQtghEIKi/mXz3qVG8aQs4XYE2fcuTW1b1d
         fAbEdmmRWp3EhKnHOaJj58gH7l2lSqVCPWIdqEXNhI7gZfS/HkXP0JBQOMoBed4+ZqteDUL18eZc
         ES2C1M2F1ieky+JVDetTawztUg/lFmbrVdkH+fkPoLmyx3/cyeCQUrNbw0SLs6kqMeMDJcbwENFi
         jsiYzJCdUXAn5pPgmhpuFiNpVHOwe+EYXV1YrCu2clJbKzdHZNkTMteZBD03+jHlwyE9RxMijIrn
         XBtUcZhnq0utcurPsjeGR1qZb3Eu635NTECXgkOGNVwK9+lPX+i9VaUo6KilSPeDsFcPJTYEXMiM
         ek8zx5jSGSWxpp9XDxdrMm6EoKMmoqFX1CbD2BNlpe3KfwOVMlLo2CRDgsgtHvP2sFLJT+3Q3BW7
         Gn1QY8GJhGmyISynz4
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-OQ-MSGID: <2fc26726-9db8-466c-9760-ce2fc57e3338@foxmail.com>
Date:   Fri, 6 Oct 2023 19:19:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: fbdev: arkfb: fix possible object reference leak
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     tzimmermann@suse.de, jiapeng.chong@linux.alibaba.com,
        javierm@redhat.com, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <tencent_55C1A344A101B55762ECA6A6366D0B0F8C05@qq.com>
 <b9e51034-bc6c-81d8-39ef-9fc74fa09c62@gmx.de>
From:   Zhang Shurong <zhang_shurong@foxmail.com>
In-Reply-To: <b9e51034-bc6c-81d8-39ef-9fc74fa09c62@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the graphic card in question is quite old, I haven't had the 
opportunity
to personally test it yet.

I decided to send the patch because, upon careful consideration,
I couldn't find any compelling reasons not to include the call to
pci_disable_device(). However, I completely understand your point,
and I agree that if there is no definitive explanation for why
it should be ignored, it would be prudent to locate the actual hardware
and conduct proper testing.

I genuinely appreciate your thorough review and valuable feedback on
this matter. Maybe I will find this old card and test this patch.


Thank you and best regards,

Shurong

On 2023/10/6 16:09, Helge Deller wrote:
> On 10/5/23 09:01, Zhang Shurong wrote:
>> Add missing pci_disable_device() in error path in ark_pci_probe().
>
> Do you have this hardware and tested your patch?
> I'm sure there is a reason, why "pci_disable_device()" was commented
> out in the original submission in commit 681e14730c73c...
>
> Additionally I'm wondering why your patch doesn't show up in
> the fbdev patchwork, although you added linux-fbdev mailing list.
> Probably a vger issue.
>
> Helge
>
>
>> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
>> ---
>>   drivers/video/fbdev/arkfb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
>> index 60a96fdb5dd8..6c4e5065646f 100644
>> --- a/drivers/video/fbdev/arkfb.c
>> +++ b/drivers/video/fbdev/arkfb.c
>> @@ -1064,7 +1064,7 @@ static int ark_pci_probe(struct pci_dev *dev, 
>> const struct pci_device_id *id)
>>   err_dac:
>>       pci_release_regions(dev);
>>   err_request_regions:
>> -/*    pci_disable_device(dev); */
>> +    pci_disable_device(dev);
>>   err_enable_device:
>>       framebuffer_release(info);
>>       return rc;
>> @@ -1085,7 +1085,7 @@ static void ark_pci_remove(struct pci_dev *dev)
>>
>>           pci_iounmap(dev, info->screen_base);
>>           pci_release_regions(dev);
>> -/*        pci_disable_device(dev); */
>> +        pci_disable_device(dev);
>>
>>           framebuffer_release(info);
>>       }
>


