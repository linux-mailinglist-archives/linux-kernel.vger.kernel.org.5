Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80E772D42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjHGRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjHGRse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:48:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132E610D2;
        Mon,  7 Aug 2023 10:48:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9a828c920so73545671fa.1;
        Mon, 07 Aug 2023 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691430511; x=1692035311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrGvRWh9RSqDH14rxZjW9oT1sHqJ1ms+qPPvJzGNms4=;
        b=VtryM6sem7phiyVNPheUXk5MPP+daA9hIc+FH9dpEPDjQLZysuMKhHGXObHZth90za
         l9y0FsQeLiHQzMoDX+Nu80Kl3tWERI6c56eczaPZTK8eVopyB0AEp9BxUP+FjDWk21+z
         OHxjkRYox+KvU8sMxnCeNk2/uLmDeUf07h3b6XA7IOTcx1S2M+iwhONnWVQGYoG0iPJ1
         xMSGj2eYEmHL2xxLoh0MJHIo24wcBAimmps8QPhdfSEWhwp4Xz3iwluo68UMa44qU55G
         v32zkZxYNIig6hBOPd36dWf8/9bL3TzMT+DVIJEuXWP/ii4EL/trYbhOKJvllUYwcDOc
         aC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691430511; x=1692035311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrGvRWh9RSqDH14rxZjW9oT1sHqJ1ms+qPPvJzGNms4=;
        b=N6WPX7vRyq1sfoXJXEWWC1NGtmB7UbafL8Eo5iNHMj7AuDKzuNBZ4L7eCt6Pi8LbJ/
         HK8lx6WcRmWCqaCWBl6V+WNxslJf6Q4iQUfxGm36HSrdSypRBQYzD0mdxbZKXhPjOkBB
         e//NW29QFVjd1MSgCn/T7yCcaLKibtV2Pvja82+1Vq88el/cItFlO7jL0m8UiyJAAE5N
         phmbgs1lCq1W4stusta74Pjkh4js8KfeA6MRXWGsr6lzN+5zZn9wUpAZ+q3Xvjzrx2xh
         mEQ+8/T8GpRDkNbcvZJ9G/dCYNPnbQsjKpgwAdtlo8EZZFoeDTdqvLBcI57Nj4F1D+rg
         Jl0Q==
X-Gm-Message-State: AOJu0YwzIF/xtx6ZvA0c7XqUJsay90QSUtXQHQkZEH1UMkuGd+goaGgv
        8bSB7jq0ZYf406+L1iMwAFuBlopotqMF48xgqZ0=
X-Google-Smtp-Source: AGHT+IHLh71dLppBcDeJERt7vwCNTp0PJVm+Vkx/AuubHXt8MByWMEhbnbu4vMWCCWuZuHHJjZvwTgmyeuxgBzCDgMU=
X-Received: by 2002:a2e:90c2:0:b0:2b5:81bc:43a8 with SMTP id
 o2-20020a2e90c2000000b002b581bc43a8mr6861726ljg.0.1691430510882; Mon, 07 Aug
 2023 10:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZJZbiyhnary2F7iZMKg5xSFKNV0iRVJ6ye7NayS-z-a0Q@mail.gmail.com>
 <451e5766-e39e-37fb-6ee6-fd42d7d96720@buaa.edu.cn>
In-Reply-To: <451e5766-e39e-37fb-6ee6-fd42d7d96720@buaa.edu.cn>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 7 Aug 2023 10:48:18 -0700
Message-ID: <CABBYNZLQo-WhM9jDJbk_zXu-ETdv8QkJ5UG9d+nWDBEA66Y+VQ@mail.gmail.com>
Subject: Re: [BUG]Bluetooth: possible semantic bug when the status field of
 the HCI_Connection_Complete packet set to non-zero
To:     =?UTF-8?B?5YiY5bCP5paw?= <LXYbhu@buaa.edu.cn>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        baijiaju1990@gmail.com, sy2239101@buaa.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 7, 2023 at 8:17=E2=80=AFAM =E5=88=98=E5=B0=8F=E6=96=B0 <LXYbhu@=
buaa.edu.cn> wrote:
>
> Hello,
>
> Thanks for your reply.
>
> I apologize for my previous unclear statement, which may have misled you.
>
> Let me rephrase our question:
>
> When a Bluetooth device initiates a connection to another device, its hos=
t sends an HCI_Create_Connection command (OGF: 0x01, OCF: 0x0005) to the co=
ntroller. Once the connection is established, the controller sends an HCI_C=
onnection_Complete event (Event Code: 0x03) back to the host. If a valid HC=
I_Connection_Complete event has its parameter "Status" altered (with all ot=
her parameters unchanged), changing 0x00 to any value between 0x01 and 0xFF=
 for example, the host will considerd that the connection fails to complete=
.
>
> In reality, if the HCI_Connection_Complete event's parameter "Connection_=
Handle" is valid and unaltered, it means the handle resource exists and has=
 not been released. The observations we made support this statement:

Well according to the spec we can only assume the handle is valid if
the status is set to 0x00, so I am not really sure how we can possibly
check if the handle is valid if the status indicates a connection
failure?

> (a) When the tampered HCI_Connection_Complete event with altered "Status"=
 is sent to the host, if we attempt to reconnect to the same device by send=
ing another HCI_Create_Connection command, the controller will send an HCI_=
Command_Status event (Event Code: 0x0F) to the host, with the "Status" para=
meter set to 0x0B, indicating "CONNECTION ALREADY EXISTS" and leading to th=
e connection failure.
>
> (b) When the tampered HCI_Connection_Complete event is sent to the host, =
if we manually send an HCI_Disconnect command, with the "Connection_Handle"=
 parameter set to the same value as the previous HCI_Connection_Complete ev=
ent's "Connection_Handle," and the "Reason" parameter set to 0x15, indicati=
ng "REMOTE DEVICE TERMINATED CONNECTION DUE TO POWER OFF," we receive a pro=
per response, signifying that the Connection_Handle is valid and exists. Ad=
ditionally, the issue described in (a) disappears.

Just read again the sentence above: 'TERMINATED CONNECTION', it can't
possible mean the handle is valid and exists, I'm afraid you are
arguing based on a controller implementation that doesn't comply with
the spec text above, it shall either disconnect the link so we
invalidate the handle on the host, then later we can reconnect, or
indicate the status is 0x00.

> Well we can't do much about the dangling connection if we don't know
> its handle to be able to disconnect since there is no command to
> disconnect by address if that is what you were expecting us to do, so
> the bottom line seems to be that sending 0x0b to the controller is
> useless since we can't do anything about at the host, well other than
> reset but would likely affect other functionality as well.
>
> With knowledge of the handle, we think we can manually send an HCI_Discon=
nect command to deal with the dangling connection, just as we mentioned in =
(b).

Assuming the handle is valid on status !=3D 0x00 would probably not work
with most controllers following the spec to the letter, in which case
the HCI_Disconnect would fail and in the meantime we have an hci_conn
with invalid state, so I don't think it is worth going sideways just
to get it working under special circumstances, where this special
circumstances might be a bug in the way status is used.

> We believe that, in the situation we mentioned, the handle is valid but i=
s rendered useless. Implementing an automated mechanism to handle the relea=
se of the handle (e.g., by sending an HCI_Disconnect command) might be a be=
tter choice.

Sorry but I have to disagree, in that case HCI_Disconnect would need
to be sent every time, which can also fail if the link-layer had
terminated the connection as indicated in the status.

> Best wishes,
> Xin-Yu Liu
>
> =E5=9C=A8 2023/8/5 13:09, Luiz Augusto von Dentz =E5=86=99=E9=81=93:
>
> Hi,
>
> On Fri, Aug 4, 2023 at 9:35=E2=80=AFPM Xinyu Liu <LXYbhu@buaa.edu.cn> wro=
te:
>
> Hello,
>
> Our fuzzing tool finds a possible semantic bug in the Bluetooth system in=
 Linux 6.2:
>
> During the connection process, the host server needs to receive the HCI_C=
onnection_Complete packet from the hardware controller. In normal cases, th=
e status field of this packet is zero, which means that the connection is s=
uccessfully completed:
>
> However, in our testing, when the status field was set to non-zero, 47 fo=
r instance, the Bluetooth connection failed. After that, when we attempt to=
 reestablish a Bluetooth connection, the connection always fails. Upon anal=
yzing the event packets sent from the controller to the host server, we obs=
erved that the Status field of the HCI_Command_Status packet becomes 0B, in=
dicating that the controller believes the connection already exists. This s=
ituation has been causing the connection failure persistently:
>
> That seems like a link-layer issue, the controller is saying the
> connection had failed, and 0x0b also doesn't help either except if you
> are saying that the other parameters are actually valid (e.g. handle),
> that said the spec seems pretty clear about status other than 0x00
> means the connection had failed:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 2170
>
> 0x01 to 0xFF Connection failed to Complete. See [Vol 1] Part F,
> Controller Error Codes
> for a list of error codes and descriptions.
>
> In our understanding, it would be more preferable if a single failed Blue=
tooth connection does not result in subsequent connections also failing. We=
 believe that having some mechanism to facilitate Bluetooth's recovery and =
restoration to normal functionality could be considered as a potentially be=
tter option.
>
> We are not sure whether this is a semantic bug or implementation feature =
in the Linux kernel. Any feedback would be appreciated, thanks!
>
> Well we can't do much about the dangling connection if we don't know
> its handle to be able to disconnect since there is no command to
> disconnect by address if that is what you were expecting us to do, so
> the bottom line seems to be that sending 0x0b to the controller is
> useless since we can't do anything about at the host, well other than
> reset but would likely affect other functionality as well.
>
>


--=20
Luiz Augusto von Dentz
