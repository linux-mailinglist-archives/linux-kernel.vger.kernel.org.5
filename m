Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C44776373
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHIPLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjHIPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:11:15 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 322FA210D;
        Wed,  9 Aug 2023 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
        User-Agent:Subject:To:Cc:References:From:In-Reply-To:
        Content-Type:Content-Transfer-Encoding; bh=qdAiPe8csqwuuyDj6hTE7
        PynnBwpqRO66suZ0OgkS3A=; b=GGIl5b9rBvyjp+SHD++MmiqmBvWcpFomjJE+4
        6ouGUCB/NdgjX6bhl/fKObsDaQCnPtXQHsq8zoQjxIFrNt1CpVrGfxRn0TZ1tE0S
        uWP0wT/MCYHAIW8HhhjMjOWPk4d3kcVlmR+GDlkNhchXcf4X1Idd9FJ9IoshdqaT
        Hz3fOE=
Received: from [10.193.157.69] (unknown [10.193.157.69])
        by coremail-app1 (Coremail) with SMTP id OCz+CgDn7_NirNNkLfyhDA--.28238S3;
        Wed, 09 Aug 2023 23:10:27 +0800 (CST)
Message-ID: <5aca90c4-8436-40d1-87d5-3406fdb26c47@buaa.edu.cn>
Date:   Wed, 9 Aug 2023 23:10:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG]Bluetooth: possible semantic bug when the status field of
 the HCI_Connection_Complete packet set to non-zero
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <CABBYNZLQo-WhM9jDJbk_zXu-ETdv8QkJ5UG9d+nWDBEA66Y+VQ@mail.gmail.com>
From:   Xin-Yu Liu <LXYbhu@buaa.edu.cn>
In-Reply-To: <CABBYNZLQo-WhM9jDJbk_zXu-ETdv8QkJ5UG9d+nWDBEA66Y+VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: OCz+CgDn7_NirNNkLfyhDA--.28238S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtF1kGF1fCrW8XFyUGFWxWFg_yoWxKry5pF
        WYya9FkryDJ3WSyFnrAw48CF9Fv3yktrsrJr90q340y345WrykKFsak3Z0kayUGrsav3Wj
        vF12qrZrA3Z8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Aw1UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5IksPUUUUU==
X-CM-SenderInfo: te1sjjazrrjqpexdthxhgxhubq/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your reply.

After carefully considering your feedback, we now realize that the scenario we were assuming is indeed quite exceptional. It has become clear that there is no necessity for any supplementary mechanisms to reset the Bluetooth system. In our forthcoming work, we plan to engage in an in-depth exploration of the spec and Linux Bluetooth source code, with the aim of deriving more valuable insights and outcomes.

Once again, thank you for your active engagement and for taking the time to address our queries. Your assistance has been instrumental in guiding our approach.

Wishing you all the best and looking forward to future interactions.

Warm regards,
Xin-Yu Liu

2023/8/8 1:48, Luiz Augusto von Dentz :
> Hi,
>
> On Mon, Aug 7, 2023 at 8:17 AM Xin-Yu Liu <LXYbhu@buaa.edu.cn> wrote:
>> Hello,
>>
>> Thanks for your reply.
>>
>> I apologize for my previous unclear statement, which may have misled you.
>>
>> Let me rephrase our question:
>>
>> When a Bluetooth device initiates a connection to another device, its host sends an HCI_Create_Connection command (OGF: 0x01, OCF: 0x0005) to the controller. Once the connection is established, the controller sends an HCI_Connection_Complete event (Event Code: 0x03) back to the host. If a valid HCI_Connection_Complete event has its parameter "Status" altered (with all other parameters unchanged), changing 0x00 to any value between 0x01 and 0xFF for example, the host will considerd that the connection fails to complete.
>>
>> In reality, if the HCI_Connection_Complete event's parameter "Connection_Handle" is valid and unaltered, it means the handle resource exists and has not been released. The observations we made support this statement:
>>
> Well according to the spec we can only assume the handle is valid if
> the status is set to 0x00, so I am not really sure how we can possibly
> check if the handle is valid if the status indicates a connection
> failure?
>
>> (a) When the tampered HCI_Connection_Complete event with altered "Status" is sent to the host, if we attempt to reconnect to the same device by sending another HCI_Create_Connection command, the controller will send an HCI_Command_Status event (Event Code: 0x0F) to the host, with the "Status" parameter set to 0x0B, indicating "CONNECTION ALREADY EXISTS" and leading to the connection failure.
>>
>> (b) When the tampered HCI_Connection_Complete event is sent to the host, if we manually send an HCI_Disconnect command, with the "Connection_Handle" parameter set to the same value as the previous HCI_Connection_Complete event's "Connection_Handle," and the "Reason" parameter set to 0x15, indicating "REMOTE DEVICE TERMINATED CONNECTION DUE TO POWER OFF," we receive a proper response, signifying that the Connection_Handle is valid and exists. Additionally, the issue described in (a) disappears.
> Just read again the sentence above: 'TERMINATED CONNECTION', it can't
> possible mean the handle is valid and exists, I'm afraid you are
> arguing based on a controller implementation that doesn't comply with
> the spec text above, it shall either disconnect the link so we
> invalidate the handle on the host, then later we can reconnect, or
> indicate the status is 0x00.
>
>> Well we can't do much about the dangling connection if we don't know
>> its handle to be able to disconnect since there is no command to
>> disconnect by address if that is what you were expecting us to do, so
>> the bottom line seems to be that sending 0x0b to the controller is
>> useless since we can't do anything about at the host, well other than
>> reset but would likely affect other functionality as well.
>>
>> With knowledge of the handle, we think we can manually send an HCI_Disconnect command to deal with the dangling connection, just as we mentioned in (b).
> Assuming the handle is valid on status != 0x00 would probably not work
> with most controllers following the spec to the letter, in which case
> the HCI_Disconnect would fail and in the meantime we have an hci_conn
> with invalid state, so I don't think it is worth going sideways just
> to get it working under special circumstances, where this special
> circumstances might be a bug in the way status is used.
>
>> We believe that, in the situation we mentioned, the handle is valid but is rendered useless. Implementing an automated mechanism to handle the release of the handle (e.g., by sending an HCI_Disconnect command) might be a better choice.
> Sorry but I have to disagree, in that case HCI_Disconnect would need
> to be sent every time, which can also fail if the link-layer had
> terminated the connection as indicated in the status.
>
>> Best wishes,
>> Xin-Yu Liu
>>
>> 2023/8/5 13:09, Luiz Augusto von Dentz :
>>
>> Hi,
>>
>> On Fri, Aug 4, 2023 at 9:35 PM Xinyu Liu <LXYbhu@buaa.edu.cn> wrote:
>>
>> Hello,
>>
>> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in Linux 6.2:
>>
>> During the connection process, the host server needs to receive the HCI_Connection_Complete packet from the hardware controller. In normal cases, the status field of this packet is zero, which means that the connection is successfully completed:
>>
>> However, in our testing, when the status field was set to non-zero, 47 for instance, the Bluetooth connection failed. After that, when we attempt to reestablish a Bluetooth connection, the connection always fails. Upon analyzing the event packets sent from the controller to the host server, we observed that the Status field of the HCI_Command_Status packet becomes 0B, indicating that the controller believes the connection already exists. This situation has been causing the connection failure persistently:
>>
>> That seems like a link-layer issue, the controller is saying the
>> connection had failed, and 0x0b also doesn't help either except if you
>> are saying that the other parameters are actually valid (e.g. handle),
>> that said the spec seems pretty clear about status other than 0x00
>> means the connection had failed:
>>
>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>> page 2170
>>
>> 0x01 to 0xFF Connection failed to Complete. See [Vol 1] Part F,
>> Controller Error Codes
>> for a list of error codes and descriptions.
>>
>> In our understanding, it would be more preferable if a single failed Bluetooth connection does not result in subsequent connections also failing. We believe that having some mechanism to facilitate Bluetooth's recovery and restoration to normal functionality could be considered as a potentially better option.
>>
>> We are not sure whether this is a semantic bug or implementation feature in the Linux kernel. Any feedback would be appreciated, thanks!
>>
>> Well we can't do much about the dangling connection if we don't know
>> its handle to be able to disconnect since there is no command to
>> disconnect by address if that is what you were expecting us to do, so
>> the bottom line seems to be that sending 0x0b to the controller is
>> useless since we can't do anything about at the host, well other than
>> reset but would likely affect other functionality as well.
>>
>>
>

