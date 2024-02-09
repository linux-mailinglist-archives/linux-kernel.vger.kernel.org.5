Return-Path: <linux-kernel+bounces-59481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B2684F7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E7C1C23021
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC66F095;
	Fri,  9 Feb 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQJdh4j5"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A96EB4A;
	Fri,  9 Feb 2024 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489469; cv=none; b=p1NyQXwNTZ6KqtVY282gQ3TrN+w7hXqwgtWFgtFvUIzzkYo+3oJlVk5chLLvNiQKh1eoukk44JItCTxCG9tu9QwaJBKTq5ZjJuQpNuK0dtcyiNBXuwAFkseKexrkMsNizVGPF5O/jJT0aA+sNTVPDyeE3vDnNrsxEMyjSs6/ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489469; c=relaxed/simple;
	bh=8yJ/tmDXR4RZPdenfUZjzryKPR24G4VB9nfSLxysEYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ropz4PYIm6hR8opQA0V0/EGG/JKrBZr/YIktMAcbxhJ2iM/+WRoPxUGsfiq1r4E6qqZUacEE20GWcmkB56l7cAnkb7exQh88kPXtEdZwy81svlAW0lltkkzpijSu3Btpjc0jml4f8+gDnteBEbF5HKtqoK6FLF6bsclrX/9E74s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQJdh4j5; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d066b532f0so14429341fa.1;
        Fri, 09 Feb 2024 06:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707489465; x=1708094265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2q5FAm9/EenLzzRVkbIiynIYd7YyHOUHU8wwmN+aQI=;
        b=dQJdh4j5Dwjd24z22HQ4go/EfjXa9dbA2CbaSfJENO0CkNvnN7/kkGjI1BUZeIr0Zf
         FFuofUV92NqGaas5ujnia8OrYL5un6muAKNQgn3LwT+ClxeoM7v545cG11yYey7Ebzo0
         6JJg1sizSxrByvLcbAIbYKEF6La9shUQGeXoS3/WZ+GZ7o28hdoOLGMlXmt5e72oAHNZ
         egTj4wGa1GzK5TN6u4hWTKMHAgFnD1WxhkCy3PP/4LXSwmH1Myyv42lJbtSFsRRMp8aI
         a8LMVnXwTqV+Jz9cvaQ8BREkKSz7wV2ZXJVrYJdMmu2I5rJ5pm1/wRv+2Mx4JIKBu9Jy
         GTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707489465; x=1708094265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2q5FAm9/EenLzzRVkbIiynIYd7YyHOUHU8wwmN+aQI=;
        b=qVddDch+3ExF+dPEVuheID1duzbuKQ2PWnLu4wL3IHnIEXXgAtLDziy9fpSA2wpEBe
         0aoJgvP43/plUyydR6mV469ze4nal1eHekVmLB1cQByCHOzsWY1S92+0HWoGVFBZTFs3
         rqhacSCgWxiCQMHKDCjwvLHkLUt3K8ovGwKgX+IA8DC3nxeQiv7mkcQfOyfHajl7XLSa
         J117QflbQqWAtXhCgoBfOiuAW/kW3egaF5RodX00LRNRFe05oXrxAqgJ6uKrbB82zl80
         EAxM/qKDeUBWf/6fm6UWYQiuKir9crS96zOY0DXW6BkVQsoGgo6aDB7TCqsrXYjSOMHh
         hm/g==
X-Gm-Message-State: AOJu0YwfrRKCY0rqCLT8rBC2RqaPQqWOBif0wvzmTIw3zl19qozi/IEX
	MpTarFhZWFc/QwQ8YObdZSy4uwQPuKcO09mynR5n1/Kl+YhfPu/RPTradrD/q8nxOToI63LD0qn
	lDM5J3Fj+rKb+tYC0h0IlB4SAtQM=
X-Google-Smtp-Source: AGHT+IE9V3dWwIf2os07sed0l9BJcm+dMUBuo7/9Jje0cFJ0Ur5sVtyhZORapmbWhQYxOk1lZvwBaxj3o1jZaUGi49Y=
X-Received: by 2002:a2e:a4c6:0:b0:2d0:b750:514c with SMTP id
 p6-20020a2ea4c6000000b002d0b750514cmr1484382ljm.9.1707489465133; Fri, 09 Feb
 2024 06:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007cea730610e083e8@google.com> <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
 <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com>
In-Reply-To: <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2024 09:37:32 -0500
Message-ID: <CABBYNZKe+ncj9psXEuX9W2RG6GtgnFbX9Gy+H_LnPX4bND6hoA@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com, 
	kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Fri, Feb 9, 2024 at 8:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jonas,
>
> On Fri, Feb 9, 2024 at 7:37=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl=
> wrote:
> >
> > Hi everyone!
> >
> > On 08.02.24 16:32, syzbot wrote:
> > > syzbot has bisected this issue to:
> > >
> > > commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
> > > Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> > > Date:   Tue Feb 6 11:08:13 2024 +0000
> > >
> > >      Bluetooth: hci_conn: Only do ACL connections sequentially
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D154f85=
50180000
> > > start commit:   b1d3a0e70c38 Add linux-next specific files for 202402=
08
> > > git tree:       linux-next
> > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D174f85=
50180000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D134f85501=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba19=
5662a06
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0a39be7a2=
035700868
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d9514=
7e80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D107c2d8fe=
80000
> > >
> > > Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
> > > Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections se=
quentially")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bi=
section
> >
> > Hmm, looking at the backtraces, I think the issue that the introduction=
 of the
> > sequential connect has introduced another async case: In hci_connect_ac=
l(), when
> > we call hci_acl_create_connection_sync(), the conn state no longer imme=
diately
> > gets set to BT_CONNECT, but remains in BT_OPEN or BT_CLOSED until the h=
ci_sync
> > queue actually executes __hci_acl_create_connection_sync().
>
> Need to double check but I think we do set BT_CONNECT in case of LE
> when it is queued so which shall prevent it to be queued multiple
> times.
>
> > This means that now hci_connect_acl() is happy to do multiple
> > hci_acl_create_connection_sync calls, and the hci_sync machinery will h=
appily
> > execute them right after each other. Then the newly introduced hci_abor=
t_conn_sync()
> > in __hci_acl_create_connection_sync() calls hci_conn_del() and frees th=
e conn
> > object, so the second time we enter __hci_acl_create_connection_sync(),
> > things blow up.
> >
> > It looks to me like in theory the hci_connect_le_sync() logic is prone =
to a
> > similar issue, but in practice that's prohibited because in hci_connect=
_le_sync()
> > we lookup whether the conn object still exists and bail out if it doesn=
't.
> >
> > Even for LE though I think we can queue multiple hci_connect_le_sync() =
calls
> > and those will happily send HCI_OP_LE_CREATE_CONN no matter what the co=
nnection
> > state actually is?
> >
> > So assuming this analysis is correct, what do we do to fix this? It see=
ms to me
> > that
> >
> > 1) we want a BT_CONNECT_QUEUED state for connections, so that the state
> > machine covers this additional stage that we have for ACL and LE connec=
tions now.
>
> BT_CONNECT already indicates that connection procedure is in progress.
>
> > 2) the conn object can still disappear while the __hci_acl_create_conne=
ction_sync()
> > is queued, so we need something like the "if conn doesn't exist anymore=
, bail out"
> > check from hci_connect_le_sync() in __hci_acl_create_connection_sync(),=
 too.
>
> Btw, I'd probably clean up the connect function and create something
> like hci_connect/hci_connect_sync which takes care of the details
> internally like it was done to abort.
>
> > That said, the current check in hci_connect_le_sync() that's using the =
connection
> > handle to lookup the conn does not seem great, aren't these handles re-=
used
> > after connections are torn down?
>
> Well we could perhaps do a lookup by pointer to see if the connection
> hasn't been removed in the meantime, that said to force a clash on the
> handles it need to happen in between abort, which frees the handle,
> and connect, anyway the real culprit here is that we should be able to
> abort the cmd_sync callback like we do in LE:
>
> https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_con=
n.c#L2943
>
> That way we stop the connect callback to run and don't have to worry
> about handle re-use.

https://patchwork.kernel.org/project/bluetooth/patch/20240209141612.3554051=
-1-luiz.dentz@gmail.com/

>
> > Cheers,
> > Jonas
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

