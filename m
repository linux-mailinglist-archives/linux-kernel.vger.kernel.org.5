Return-Path: <linux-kernel+bounces-59377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818084F613
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702421C223DB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AB43C46A;
	Fri,  9 Feb 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaA0JUn9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADD20311;
	Fri,  9 Feb 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485819; cv=none; b=p9EJ2We1Y0xtNGC8QXojTHZpwu0dC3yjUc6/1hVwHv4oJonkIHo/HfcoOrv9UdLAFlA04t/34VSPpNtLidrM0Usr5W/hvVCBr4adVY6qPYWEF6P+mdARLVemYIKKRfwJm5bltFwc9/JrEqRFT0Od8c16hnA21yVuIaPA3tHqFXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485819; c=relaxed/simple;
	bh=3vm8auiZrQRj+iHUNDAT7zCm22vZjMeBQJLQWdgtyVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEqCjnOHqTbg0mCK1akmQcSfjUpnx9FwB3qgHD9WDiswbhChTqWpo6XBjzAAsdli/6JG7JAEDvCxpKtV5v7sF8h8f2Afm9fgEVIykURvZriwxEti5j4PO0GPPYFeeTAzKcw5KPYTlPQok6ECvLs8msdAHvOZ+RGBiwP0ZIOHdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaA0JUn9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cf206e4d56so11692181fa.3;
        Fri, 09 Feb 2024 05:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707485815; x=1708090615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YBOdfp2b7bzt886CyrnblZUzTFAd78HV3pYIFWbcGE=;
        b=VaA0JUn9Rz93z+O7P62bdIoxH6zBKeD/WcxRaYDBqkqqpRzW66kL/Ng+GaKnfccXIO
         CZwVPvu2nQTWcl9ATsw1koPcAQC5STtXvy4eqilG7tFVdh01aqlSmDoi94p+/LJ6xKQ7
         HbC8iMQ+SJonFbAp8hXf4wfpHJZsBiv01POv8DOdzE+L6Eb4mkrvKztnMfLxwFZfIBwL
         I11GdZJoW917tFmNQFLDm89Zsso5gHOKzahWZIe2t8cViu2h7xv19wKsivM656Cvdqkd
         d7c8O1uf4n5Vr5HlLWV0x0gajZNUo6NEDylQxMZ64gUaepQSsssPErqVLDvV44lukyD4
         Gt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485815; x=1708090615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YBOdfp2b7bzt886CyrnblZUzTFAd78HV3pYIFWbcGE=;
        b=Ij4QdTLy31LbkOreHZPPcRzN2XZdYg2utKByl0imn5JHbjy7seezMhKqlyUm9H5w0m
         8r8pZlIPNNSblMIhs/w04v0sBJkqwOHgEqPhWLPTiyN7MEJErIe7sd+9rRGm9GHLhctR
         IywsK2eN+mn35+poZqmZjEK45lIxrnu5ZvRrpwYi1wf7MBdjJcGEpjz4mjwAZ0OvcCk3
         7Kb4l9vwRs5orcGtXyV1UU9G8TEwjtsOndRbdGP4/3thF7fcBp0bUWB9IWDf3ydKKbMh
         YGB8Xzbvo/wEDGJ6NfZBjezPVAKszObCOKSdKQXSnjfwgjUUiC+JpRNCqyUyIMdTPPiY
         q0zw==
X-Gm-Message-State: AOJu0Yx0uSyIBoCkTwqGPrj1bzMfWZXz0xvTVau/sIq9JkuG+FAqb4yT
	9i6ebk7p9/8cMzlAc8PyXCUduFXki71mwy6cSeDPB7KBdiuGrhG7cMtcyptEyixfFYp88Uw4MOh
	zwQ4inTxsLI+WA/eLuhT8+cKa+zI=
X-Google-Smtp-Source: AGHT+IFWbfm8yzzLHy8h1HaTWTuCPBjb9QKibp82QsvcenBLb2iBnaU79IcF9ZxbCy7QaaBICwG9tXFYPNNOE8TcwCo=
X-Received: by 2002:a2e:9813:0:b0:2cf:5119:95cb with SMTP id
 a19-20020a2e9813000000b002cf511995cbmr1267882ljj.26.1707485815098; Fri, 09
 Feb 2024 05:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000007cea730610e083e8@google.com> <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
In-Reply-To: <216c95d9-db1f-487a-bf3d-17a496422485@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Feb 2024 08:36:42 -0500
Message-ID: <CABBYNZKPaMLK5+HnsRWR9jwpdZWvbbai6p9XbePhMYdKSYUPPg@mail.gmail.com>
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

On Fri, Feb 9, 2024 at 7:37=E2=80=AFAM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Hi everyone!
>
> On 08.02.24 16:32, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 456561ba8e495e9320c1f304bf1cd3d1043cbe7b
> > Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
> > Date:   Tue Feb 6 11:08:13 2024 +0000
> >
> >      Bluetooth: hci_conn: Only do ACL connections sequentially
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D154f8550=
180000
> > start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
> > git tree:       linux-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D174f8550=
180000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D134f8550180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb693ba1956=
62a06
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3f0a39be7a203=
5700868
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d95147e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D107c2d8fe80=
000
> >
> > Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com
> > Fixes: 456561ba8e49 ("Bluetooth: hci_conn: Only do ACL connections sequ=
entially")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
>
> Hmm, looking at the backtraces, I think the issue that the introduction o=
f the
> sequential connect has introduced another async case: In hci_connect_acl(=
), when
> we call hci_acl_create_connection_sync(), the conn state no longer immedi=
ately
> gets set to BT_CONNECT, but remains in BT_OPEN or BT_CLOSED until the hci=
_sync
> queue actually executes __hci_acl_create_connection_sync().

Need to double check but I think we do set BT_CONNECT in case of LE
when it is queued so which shall prevent it to be queued multiple
times.

> This means that now hci_connect_acl() is happy to do multiple
> hci_acl_create_connection_sync calls, and the hci_sync machinery will hap=
pily
> execute them right after each other. Then the newly introduced hci_abort_=
conn_sync()
> in __hci_acl_create_connection_sync() calls hci_conn_del() and frees the =
conn
> object, so the second time we enter __hci_acl_create_connection_sync(),
> things blow up.
>
> It looks to me like in theory the hci_connect_le_sync() logic is prone to=
 a
> similar issue, but in practice that's prohibited because in hci_connect_l=
e_sync()
> we lookup whether the conn object still exists and bail out if it doesn't=
.
>
> Even for LE though I think we can queue multiple hci_connect_le_sync() ca=
lls
> and those will happily send HCI_OP_LE_CREATE_CONN no matter what the conn=
ection
> state actually is?
>
> So assuming this analysis is correct, what do we do to fix this? It seems=
 to me
> that
>
> 1) we want a BT_CONNECT_QUEUED state for connections, so that the state
> machine covers this additional stage that we have for ACL and LE connecti=
ons now.

BT_CONNECT already indicates that connection procedure is in progress.

> 2) the conn object can still disappear while the __hci_acl_create_connect=
ion_sync()
> is queued, so we need something like the "if conn doesn't exist anymore, =
bail out"
> check from hci_connect_le_sync() in __hci_acl_create_connection_sync(), t=
oo.

Btw, I'd probably clean up the connect function and create something
like hci_connect/hci_connect_sync which takes care of the details
internally like it was done to abort.

> That said, the current check in hci_connect_le_sync() that's using the co=
nnection
> handle to lookup the conn does not seem great, aren't these handles re-us=
ed
> after connections are torn down?

Well we could perhaps do a lookup by pointer to see if the connection
hasn't been removed in the meantime, that said to force a clash on the
handles it need to happen in between abort, which frees the handle,
and connect, anyway the real culprit here is that we should be able to
abort the cmd_sync callback like we do in LE:

https://github.com/bluez/bluetooth-next/blob/master/net/bluetooth/hci_conn.=
c#L2943

That way we stop the connect callback to run and don't have to worry
about handle re-use.

> Cheers,
> Jonas



--=20
Luiz Augusto von Dentz

