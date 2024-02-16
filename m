Return-Path: <linux-kernel+bounces-69367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516ED858804
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7581E1C21C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD0C146003;
	Fri, 16 Feb 2024 21:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn3S/VeN"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62E1E865;
	Fri, 16 Feb 2024 21:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118921; cv=none; b=k9U6Q9/lKC9pwldSZOIdsI1/N4Zr8GaG078x33TbOj2gyQZZtCU2H8suSn/ioN68s2QJ8R8NX3vt5SP3Dx3Y8hGxfJIdhpIjOnvwuezXGoXL8E/byqcc4fcnSss9I/C68oB/ossTpDqOSvv7EI3UOtACVsVXhkZx2uF9MD5ySEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118921; c=relaxed/simple;
	bh=CakZ8rLH4Q8tYWNtFVaFBsBmXTH1Vx4ffT1IPV1mVUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyV9OYMVQy8gNNUNtYq+9lD3ljWz7AcLccGbGOltX120F+FCpJq2bX7FbjSHY099gMeP0tE1/QFRPyO/T2WBZZ+ZPHMbyEj7bXxSb6+YL6pgcgCH9nkzvbFBv75yc61iSjOTuacKDtPISvLfKdN2uV3RV/0oBNcPFgY2Tlbs36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn3S/VeN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so16348001fa.1;
        Fri, 16 Feb 2024 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708118918; x=1708723718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hliKFRDXKPhqHxR2ESvoVhsJQyAtG81w6UEsGEBNTVM=;
        b=Fn3S/VeNDQtO9V0redHZoyeHZlqfPVy3eyMaI5avvjeBvGpO+TBq2fHgvTHvyg+l0l
         cFX9DLR75v6IpIF5rp59EYwMqma+vpM7jSaXZvaWFFMRgACrKEGMHkBzNjhCRd508DnD
         maPgC1Y+w4FtL36CHg9+w+9d+DnHw5xltrFGROu4M4dfKVYtxagYf5ggNs3DdCZXHVRd
         G4eZlvl3aoOCqf/cAeCWi9rqNoJDFVCyR1KvZ8s2OklLSMsUAqbQMObrsacuSv94KMb0
         k7oa1dMrD0qPNsOldIbuUw6Pj/wfnOvgOzQ/yoxts9ZpD8lhnTV87/YP2XKYdkErnhHs
         h9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708118918; x=1708723718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hliKFRDXKPhqHxR2ESvoVhsJQyAtG81w6UEsGEBNTVM=;
        b=iQ7R3tic/fq37x8jVhPIs+PliUCXJz1DTeSli54BNenhg7rAJGSVtvVwXcgN5lBTVR
         aCGs/z0Fr1B+bOQKE84he7AcukGCUSu/MHKfRoVI47wVqcVRyDl19JLb4XE27Rkt+Jla
         xgAeiOygIut35qqIAZ1qXQTUkXPC3SwlfnTgXARwNZR75sqxWv0v1leBcD4XNLtx7ygS
         nMTb3Bs71dmpfs81BUUBSknLH4AfwJ6/5BYnhuy6RVXYn8gZw0vTAlICjSuyA0dHaU5V
         D5RUrSCn8GlmJKUbivHaTtMB5r3Jqrv/gKRuw3mD+I2qyET88vGp72IzQq6o369RgOKv
         5MZg==
X-Forwarded-Encrypted: i=1; AJvYcCX5N5LlQpOzSpKtQpslOxtSOtI9XL7JJZvLmuelptt/rDYaWfm9/WXJy0TlkH5rRzV+Tui7AoNud2+ijXT9q76hHjbkkoD6sGZtlil8A0FtYt/qV0napjSe/rOJ43wjA9MDDdifDhxFGhDm7pPT
X-Gm-Message-State: AOJu0YzSmrM+rAEx2MF2aW6n5BnxTnEK78USjGb1cQakTUMPPvsXesd7
	rDX4zpFfgdjew3vVtBsZ64mJ5M6m68g84p9TJ0Dacdfgc6mi0iyqExFz/snZ+swlhneJ72T0AQH
	dYRvM7GU36BpqQAqZjJrJ5IYCjQA=
X-Google-Smtp-Source: AGHT+IE/CC4Iv9yFHqi35+Mtb6h+PMX1XLongJ5YBRJdNo7ukCUhPsKKzSq2XH2QMRJfF5ajlL4slLb4LXnLhA19SQg=
X-Received: by 2002:a2e:331a:0:b0:2d1:2bd7:6d84 with SMTP id
 d26-20020a2e331a000000b002d12bd76d84mr4088430ljc.5.1708118917444; Fri, 16 Feb
 2024 13:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
 <CABBYNZ+MJRSAWHjgNTNwcWCdq5y0zBU5f8XJvr1tv3LCqvdKJw@mail.gmail.com>
 <CADg1FFfgNHF9q+dSn=K9qjVMKx1zaBpG=NoeM_3Gr942Zj7_bA@mail.gmail.com>
 <CABBYNZJXxYJKR3zxSwO8xuWTTgkSJjdGgZbJYqgJzmpPfwUcWA@mail.gmail.com> <CADg1FFe09dXWr51OFKutAf=ax0TFXa5HN=6J+AX9QHbb1QiO+Q@mail.gmail.com>
In-Reply-To: <CADg1FFe09dXWr51OFKutAf=ax0TFXa5HN=6J+AX9QHbb1QiO+Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 16 Feb 2024 16:28:24 -0500
Message-ID: <CABBYNZKcfupm1HDrPJ1rSiUy+Z_ONoEXnSLPjF15dhgUF=2V3Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if
 hci_request is pending
To: Hsin-chen Chuang <chharry@google.com>
Cc: Hsin-chen Chuang <chharry@chromium.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org, Ying Hsu <yinghsu@google.com>, 
	Joe Antonetti <joeantonetti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Fri, Feb 16, 2024 at 11:47=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> Good point. I found the hdev->req_skb is actually not read at all in the
> current code base, so perhaps we could remove the legacy code entirely,
> and reuse it for solving the problem we're facing now. This approach
> seems cleaner to me. WDYT?
>
> OTOH the below snippet in hci_event_packet (also another similar one in
> hci_le_meta_evt) needs redesign as well. It distinguishes LE/Classic
> event per hdev->sent_cmd, so the hci_req_cmd_complete for LE command
> would never be called after a classic command is sent, vice versa.
>
> /* Only match event if command OGF is not for LE */
> if (hdev->sent_cmd &&
>     hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) !=3D 0x08 &&
>     hci_skb_event(hdev->sent_cmd) =3D=3D event) {
>         hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
>                              status, &req_complete, &req_complete_skb);
>         req_evt =3D event;
> }

Yeah, Ive fixed that, but there are some mgmt-tester test that don't
seem to be running for some reason, anyway this actually fixes tests
like Pair Device - Sec Mode 3 Reject 1 since that happens to receive
events that requires commands as responses which was taking 20+
seconds to complete since that would be overwrite the sent_cmd.


>
> On Fri, Feb 16, 2024 at 11:54=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Thu, Feb 15, 2024 at 11:21=E2=80=AFPM Hsin-chen Chuang <chharry@goog=
le.com> wrote:
> > >
> > > +Some Googlers who would be interested in
> > >
> > > Hi Luiz,
> > >
> > > How about moving the hci_req-related data out from sent_cmd? This all=
ows sending HCI commands while hci_req data would not be overwritten.
> >
> > I have something like the following in the works:
> >
> > https://gist.github.com/Vudentz/251275bb688fac32585f90ac0076c407
> >
> > It is not stable yet, but I think we can get away with it since it
> > just means we can keep the pending request stored in the req_skb, that
> > said we might need to overhaul this design since it is not very clean
> > in my opinion.
> >
> > > On Fri, Feb 16, 2024 at 5:37=E2=80=AFAM Luiz Augusto von Dentz <luiz.=
dentz@gmail.com> wrote:
> > >>
> > >> Hi Hsin-chen,
> > >>
> > >> On Tue, Feb 13, 2024 at 12:24=E2=80=AFPM Hsin-chen Chuang <chharry@c=
hromium.org> wrote:
> > >> >
> > >> > hci_cmd_work overwrites the hdev->sent_cmd which contains the requ=
ired
> > >> > info for a hci_request to work. In the real world, it's observed t=
hat
> > >> > a request from hci_le_ext_create_conn_sync could be interrupted by
> > >> > the authentication (hci_conn_auth) caused by rfcomm_sock_connect. =
When
> > >> > it happends, hci_le_ext_create_conn_sync hangs until timeout; If t=
he
> > >> > LE connection is triggered by MGMT, it freezes the whole MGMT inte=
rface.
> > >> >
> > >> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > >> > ---
> > >> >
> > >> >  net/bluetooth/hci_core.c | 7 +++++--
> > >> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >> >
> > >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > >> > index 34c8dca2069f..e3706889976d 100644
> > >> > --- a/net/bluetooth/hci_core.c
> > >> > +++ b/net/bluetooth/hci_core.c
> > >> > @@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct=
 *work)
> > >> >         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
> > >> >                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->c=
md_q));
> > >> >
> > >> > -       /* Send queued commands */
> > >> > -       if (atomic_read(&hdev->cmd_cnt)) {
> > >> > +       /* Send queued commands. Don't send the command when there=
 is a pending
> > >> > +        * hci_request because the request callbacks would be over=
written.
> > >> > +        */
> > >> > +       if (atomic_read(&hdev->cmd_cnt) &&
> > >> > +           !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
> > >> >                 skb =3D skb_dequeue(&hdev->cmd_q);
> > >> >                 if (!skb)
> > >> >                         return;
> > >> > --
> > >> > 2.43.0.687.g38aa6559b0-goog
> > >>
> > >>
> > >> This seems to be causing some mgmt-tester failures:
> > >>
> > >> Pair Device - Sec Mode 3 Success 1                   Timed out   22.=
753 seconds
> > >> Pair Device - Sec Mode 3 Reject 1                    Timed out   22.=
533 seconds
> > >> Pair Device - Sec Mode 3 Reject 2                    Timed out   22.=
526 seconds
> > >>
> > >> I think this is because we need to respond to an event with a comman=
d like:
> > >>
> > >> < HCI Command: Create Conn.. (0x01|0x0005) plen 13  #241 [hci0] 16:2=
5:38.699066
> > >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> > >>         Packet type: 0x0018
> > >>           DM1 may be used
> > >>           DH1 may be used
> > >>         Page scan repetition mode: R2 (0x02)
> > >>         Page scan mode: Mandatory (0x00)
> > >>         Clock offset: 0x0000
> > >>         Role switch: Allow peripheral (0x01)
> > >> > HCI Event: Command Status (0x0f) plen 4           #242 [hci0] 16:2=
5:38.701881
> > >>       Create Connection (0x01|0x0005) ncmd 1
> > >>         Status: Success (0x00)
> > >> > HCI Event: Link Key Request (0x17) plen 6         #243 [hci0] 16:2=
5:38.702375
> > >>         Address: 00:AA:01:01:00:00 (Intel Corporation)
> > >>
> > >> But because Create Connection is pending we cannot respond to Link K=
ey
> > >> Request, so it is actually a design problem if we cannot send comman=
ds
> > >> because something is pending so perhaps we need to redesign how we
> > >> store cmd_sent so we can have multiple outstanding commands rather
> > >> than just one.
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Best Regards,
> > > Hsin-chen
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

