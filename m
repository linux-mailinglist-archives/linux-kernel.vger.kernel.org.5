Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44779449B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbjIFUhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjIFUh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:37:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4655E9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:37:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96EAB106F;
        Wed,  6 Sep 2023 13:38:03 -0700 (PDT)
Received: from [10.57.5.192] (unknown [10.57.5.192])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCC9F3F67D;
        Wed,  6 Sep 2023 13:37:23 -0700 (PDT)
Message-ID: <9e48fb7c-72a5-241a-004a-5f6791a81475@arm.com>
Date:   Wed, 6 Sep 2023 21:37:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Content-Language: en-GB
To:     Geraldo Nascimento <geraldogabriel@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <ZPelHaX/Lt++kkOm@linaro.org> <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com> <ZPjGuCdmPgqznc5t@linaro.org>
 <ZPjM7op/B/CGCF/N@geday>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZPjM7op/B/CGCF/N@geday>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 20:03, Geraldo Nascimento wrote:
> On Wed, Sep 06, 2023 at 03:36:40PM -0300, Antonio Terceiro wrote:
>> On Wed, Sep 06, 2023 at 01:49:16PM +0100, Robin Murphy wrote:
>>> On 2023-09-06 07:10, Takashi Iwai wrote:
>>>> On Wed, 06 Sep 2023 00:01:01 +0200,
>>>> Antonio Terceiro wrote:
>>>>>
>>>>> Hi,
>>>>>
> 
> Hi Antonio, my 2 cents:
> 
>>>>> I'm using an arm64 workstation, and wanted to add a sound card to it. I bought
>>>>> one who was pretty popular around where I live, and it is supported by the
>>>>> snd-cmipci driver.
> 
> Specifically, which arm64 workstation? I'm guessing Compute Module 4 IO
> Board + Raspbery Pi CM4? This detail is important because the stack
> trace you provided only references generic PCI calls and there's a need
> to know exactly which PCIe driver could be failing. Is it pcie-brcmstb?

Bit bigger than a Pi... ;)

 > [  +0,006259] Hardware name: ADLINK AVA Developer Platform/AVA 
Developer Platform, BIOS TianoCore 2.04.100.07 (SYS: 2.06.20220308) 
09/08/2022

They look like pretty nice boxes - https://www.ipi.wiki/pages/com-hpc-altra


Robin.
