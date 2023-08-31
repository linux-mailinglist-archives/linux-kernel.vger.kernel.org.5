Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684B78E915
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243296AbjHaJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjHaJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:07:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BBCE6;
        Thu, 31 Aug 2023 02:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693472783; x=1694077583; i=deller@gmx.de;
 bh=qiP5UOqA+gzhfcaF5sKr/vdJh4CV+yEqs4zNd7JpAfk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DvEgzH9UIlq+M8K6CV42j6Kus0WxSgNMO9xSludqbxL3il6qtnA3+aIZ2bdbQ9PTDDntBfd
 cEPP22hsKypIA3QkGCOyrZDiGuu1w5ZJ+H0xC3D7WdevgUCxnIQvb27xxrd20G+YoyKTPY/CN
 DSpoI2omtWjNZ5HJD5ITn6F5nO6ab4YysSZMKJIFc9+imIOkVvsAo7vxvcGAHTHd+FBy/kmRp
 2H7GjTqixeoEK4amMg9M3lOUckL0aD0+TXtpfoRuLwqJXz9cQ5VIU2ru66aEKsW7EpbgF3FPe
 jQmX6hZtLe0z53gE5z4n/E4TWtHif9+flK1iE6Y3IGEtUP9XlQrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1qOjTa1kZ7-00DVAW; Thu, 31
 Aug 2023 11:06:23 +0200
Message-ID: <c9284441-be6e-d2a0-9283-9e90c9d2da41@gmx.de>
Date:   Thu, 31 Aug 2023 11:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Content-Language: en-US
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
 <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
 <20230830221814.GB30121@willie-the-truck>
 <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cAVDVAOnVNvhXMayZoHPCd7B1NYhu9/J3S2XaNDuHqLBSZ2Xx3d
 +yc5uObfitVsYb93qeQbxC/E4jE9c4NM19/mILdb6FiH7kxcYaB6cGD/QitOlRO/buB9xgy
 DvWKqrvVQGuXyoTvMyPP2DV/P+k9HZYw5zN6HJBZx9pLm1tsca0aOdZfu30IPWzaJkzMVwQ
 ax3bCDqEQd0Enrgw1QVJw==
UI-OutboundReport: notjunk:1;M01:P0:/svm5qatxX0=;tEZyNlkJFn4TR6HgnZiFCQF8uAW
 ZV7/6AF2ZLaM57Uxjxgyr9jaogETchQ/NQm0EGaufZmxOE9qeuccQwoAYcvutV5+iIvfvWXHO
 0cgw5chPvGySDXw01m3sMbOtdHZoz+A4q6ez9N3+ajZJALphBBgY420z4Bq72nVlyObzu/lMg
 kXqaVG5AS9fnSWnGjztqwD9shUcdCVlyVI2JBQOrYXQvh/t3gXZ0v2e/yFj2WoybNSvdqLysO
 T8WuHJMArzNFWmmvPbpx601t3Ptb/JyF+0mawokNyNGIBjmEpEa+tuoGeAv0QhcqhCFCgK7B9
 mYtNRQi4cxJACcvi7jpAeoIYSxIJ5tnoJR0iL2Pfy6nl1+SIgCLHII29Hu9hApuPWioFjj2m5
 pb+0Pq+MXvXhUMFoJ5HejaH8Y/0w3TFHYiDigH+CQ+3hSlZYfWN1w09uaQPssKeIE7qluNi4D
 ithEQ4bMXI4JpbgbRaHfHMbXq28wswWYn+sVlgx8rysmqHNgs2mOD4Qk9jb1HSqyYEjB9Ynih
 9X0HTvXZTRRW/LPMdQGciHmnGbp1lnCRTudk1HkWI5qf01hGbsFm7uaCzMKYkeXZ6QKZzu6Eq
 LZqSJvUecaysnNLmKDro3qQnwXPyl1AG5on/ZXuqrrL+gCQevXXMvHvXt/pwLHPoCC9Z5fwZX
 03xVE1PEGpEeUBPvLsYHRv29RHit7rYVBkNOB9bIfyp7f30unSbUKuW4hh3NOGP+SySMtbG/K
 ohVjtoV9uwyt2cKw8jy1pJxhwUVTjYcF6DUIZ4+Vhg6Yo2EiT5RnjeJZXEgTR/1d4A64Rjro9
 nSCOTxlSgtUBg/4o0+mE43OhVyrq/G96B89N3Yqd/fmpDAh6hDpnNqsN3GVT9xeQBxWjQDXG8
 /TJ1oEwL5Q09wts+QQsw2K1SmXenxt5F5kdGZfkPmjmp3as1Yg2FY+LFrz8S/imheGk2nW6JT
 Wqa/fA==
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 05:29, Shuai Xue wrote:
> On 2023/8/31 06:18, Will Deacon wrote:
>> On Mon, Aug 28, 2023 at 09:41:55AM +0800, Shuai Xue wrote:
>>> On 2023/8/22 09:15, Shuai Xue wrote:
>>>> On 2023/8/21 18:50, Will Deacon wrote:
>>>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>>>> index 3fe516b32577..38e2186882bd 100644
>>>>>> --- a/arch/arm64/mm/fault.c
>>>>>> +++ b/arch/arm64/mm/fault.c
>>>>>> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned lon=
g far, unsigned long esr,
>>>>>>   	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)=
) {
>>>>>>   		unsigned int lsb;
>>>>>>
>>>>>> +		pr_err("MCE: Killing %s:%d due to hardware memory corruption fau=
lt at %lx\n",
>>>>>> +		       current->comm, current->pid, far);
>>>>>>   		lsb =3D PAGE_SHIFT;
>>>>>>   		if (fault & VM_FAULT_HWPOISON_LARGE)
>>>>>>   			lsb =3D hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>>>>>
>>>>> Hmm, I'm not convinced by this. We have 'show_unhandled_signals' alr=
eady,
>>>>> and there's plenty of code in memory-failure.c for handling poisoned=
 pages
>>>>> reported by e.g. GHES. I don't think dumping extra messages in dmesg=
 from
>>>>> the arch code really adds anything.
>>>>
>>>> I see the show_unhandled_signals() will dump the stack but it rely on
>>>> /proc/sys/debug/exception-trace be set.
>>>>
>>>> The memory failure is the top issue in our production cloud and also =
other hyperscalers.
>>>> We have received complaints from our operations engineers and end use=
rs that processes
>>>> are being inexplicably killed :(. Could you please consider add a mes=
sage?
>>
>> I don't have any objection to logging this stuff somehow, I'm just not
>> convinced that the console is the best place for that information in 20=
23.
>> Is there really nothing better?

> I agree that console might not the better place, but it still plays an i=
mportant role.
> IMO the most direct idea for end user to check what happened is to check=
 by viewing
> the dmesg. In addition, we deployed some log store service collects all =
cluster dmesg
> from /var/log/kern.

Right, pr_err() is not just console.
It ends up in the syslog, which ends up in a lot of places, e.g. through s=
yslog forwarding.
Most monitoring tools monitor the syslog as well.

So, IMHO pr_err() is the right thing.

Helge



>
> Hi, Will,
>



>
> Do you have any better choice?
>
> + @Tony for ERST
> I found that after /dev/mcelog driver deprecated, both x86 and ARM64 pla=
tform does not
> support to collect MCE record of previous boot in persistent storage via=
 APEI ERST.
> I propose to add a mechanism to do it for rasdaemon. Do you have any sug=
gestion?
>
> Thank you.
> Best Regards,
> Shuai
>

