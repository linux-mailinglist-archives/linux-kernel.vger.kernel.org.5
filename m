Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93117BE8D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377443AbjJISDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377093AbjJISDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:03:16 -0400
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D2994;
        Mon,  9 Oct 2023 11:03:13 -0700 (PDT)
Received: from [192.168.42.20] (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 84E6E2FC004D;
        Mon,  9 Oct 2023 20:03:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1696874590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DEQGnVx8hbvZWQkMlmilp4GaBGWuTv5fZMYoAWWF/1o=;
        b=GObj8nm2EfjBN5NU7qSFcJ0XM3R9Xe0xwV2rZjNPM+AEZEiHdaeBgjU+mjIUm4CGoCeef4
        XXCvGd071p3rxVA2VbkXgTKIgvicGUWgcK9jsZCYIdusXC4hO1vJmq7lRt+E5SBQfi52GR
        EHgn1KLG94Q6EJk9dliKa0CatCAGpWo=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <b12aa1b4-6a68-4403-b9d5-46c179ca4d96@tuxedocomputers.com>
Date:   Mon, 9 Oct 2023 20:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GMxXGxx
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230929134010.25644-1-wse@tuxedocomputers.com>
 <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com>
 <5d82fcac-a360-2d8b-8f6a-9b5cecb08ca2@tuxedocomputers.com>
 <CAJZ5v0gO77ydCfs8m4w3Juwg2B85ZZ=zY-zQptB0UmKvxBnd3w@mail.gmail.com>
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAJZ5v0gO77ydCfs8m4w3Juwg2B85ZZ=zY-zQptB0UmKvxBnd3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 06.10.23 um 21:30 schrieb Rafael J. Wysocki:
> On Wed, Oct 4, 2023 at 11:38 AM Werner Sembach <wse@tuxedocomputers.com> wrote:
>> Hi,
>>
>> Am 03.10.23 um 20:39 schrieb Rafael J. Wysocki:
>>> On Fri, Sep 29, 2023 at 3:40 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>>> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
>>>> for the keyboard to work. Adding an entry for this laptop to the
>>>> override_table makes the internal keyboard functional again.
>>> You said "again", so it used to work.  Do you know which commit broke it?
>> Sorry that "again" is a bit misleading. I Copied it from here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7592b79ba4a9
>>
>> I actually only tested the direct predecessor of this Notebook on older kernels:
>> https://bugzilla.kernel.org/show_bug.cgi?id=216698
>>
>> I suspected that it's the same issue and since the same fix worked I now even
>> more believe so, but I actually never tested a kernel before the breaking change.
>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: <stable@vger.kernel.org>
>>> What's the oldest kernel version you want this to be applied to?
>> 5.15 because Ubuntu 22.04
> So first of all Hans posted this:
>
> https://patchwork.kernel.org/project/linux-acpi/patch/20231006123304.32686-1-hdegoede@redhat.com/
>
> and I'm wondering if it addresses the problem for you too.
Thanks for the link. That patch seems to do the same, but for a different board 
name so it wont work for the GMxXGxx.
>
> If it doesn't, the patch will need to be rebased on top of the new
> acpi-resource material in linux-next and retested.

Sure, no problem, v2 incoming soon.

Kind regards,

Werner

>
> Thanks!
