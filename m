Return-Path: <linux-kernel+bounces-59308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393084F527
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29D61F23026
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009F633CDF;
	Fri,  9 Feb 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sU+GlcAX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BF1DFE8;
	Fri,  9 Feb 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481523; cv=none; b=dAFJxvnjhA/IMtKXAvSkJZG7zJgOQwcdjJKVRSfk2mA1SpnNth1pGIBGkw5hE3hOKNOF296z3B/+kT2kXiMw9GnkopiIwIWLgunYP16mCnm2lRLLs7J1Xoq89Y9VQ8n5G8rgkpitfuEoD8/2ALj346E1h2o55eUqLn1wGH8Cb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481523; c=relaxed/simple;
	bh=hRVlKXf2yacLO4M+lrkCWA9/Q2DQ9DL7E/DWm0kUQcI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=nZPLFEZ2RWkt1gi5dmHOdt110b5Aai/zW4I50+2Ql0VJW92ejsx31FwBzwIQd1lPWspH81q4kQGX6KY9WCH03ZbxeiHB+g1zdVgBO3f/umIyKWWx782dBZdqXwE6mi6+szmq0QyI14CFFozqazvjNrqKhg+C0rOUSj2EX07WWHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sU+GlcAX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BCA69B6;
	Fri,  9 Feb 2024 13:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707481426;
	bh=hRVlKXf2yacLO4M+lrkCWA9/Q2DQ9DL7E/DWm0kUQcI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sU+GlcAXQDeMfNOFwYfjiEFxGizTCs3aoTL12WWWK1uuQVPywUniAg+FG8oJRsuvW
	 KX6H1UHqOb9xJr7whi7ZogUs+pRJ8idR4GWAcI3DmN++gcsXX9W/wGeZBKfrDV/ej2
	 4yM44c1eWeqDmtGbed8doYaPdoCWaUQTDN6df+rg=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <MAZPR01MB6957B9B109854FED3106A3DEF24B2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20240102142729.1743421-1-bhavin.sharma@siliconsignals.io> <16ef7746-d038-4607-8e2f-8f7cef5a8b48@xs4all.nl> <MAZPR01MB695711E70CEDFC41DE5C2C8DF2462@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM> <ae539786-f73a-41ba-97a4-ea409fb88e2f@xs4all.nl> <MAZPR01MB6957B9B109854FED3106A3DEF24B2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] media: adv7180: Fix cppcheck warnings
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-media@vger.kernel.org <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org
Date: Fri, 09 Feb 2024 12:25:09 +0000
Message-ID: <170748150921.721346.13310424783139362841@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Bhavin Sharma (2024-02-09 09:11:22)
> Hi Hans,
>=20
> > On 06/02/2024 06:05, Bhavin Sharma wrote:
> >> Hi Hans,
> >>
> > >> Hi Bhavin,
> >>
> >>> On 02/01/2024 15:27, Bhavin Sharma wrote:
> >>>> WARNING: Missing a blank line after declarations
> >>>>
> >>>> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> >>>> ---
> >>>>=EF=BF=BD=EF=BF=BD drivers/media/i2c/adv7180.c | 27 +++++++++++++++++=
+---------
> >>>>=EF=BF=BD=EF=BF=BD 1 file changed, 18 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180=
c
> >>>> index 54134473186b..0023a546b3c9 100644
> >>>> --- a/drivers/media/i2c/adv7180.c
> >>>> +++ b/drivers/media/i2c/adv7180.c
> >>>> @@ -335,8 +335,9 @@ static u32 adv7180_status_to_v4l2(u8 status1)
> >>>>=EF=BF=BD=EF=BF=BD static int __adv7180_status(struct adv7180_state *=
state, u32 *status,
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD v4l2_std_id *std)
> >>>>=EF=BF=BD=EF=BF=BD {
> >>>> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int status1 =3D adv7180_read(s=
tate, ADV7180_REG_STATUS1);
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int status1;
> >>>>
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD status1 =3D adv7180_read(state=
, ADV7180_REG_STATUS1);
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD if (s=
tatus1 < 0)
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD return s=
tatus1;
> >>>>
> >>>> @@ -356,7 +357,9 @@ static inline struct adv7180_state *to_state(str=
uct v4l2_subdev *sd)
> >>>>=EF=BF=BD=EF=BF=BD static int adv7180_querystd(struct v4l2_subdev *sd=
, v4l2_std_id *std)
> >>>>=EF=BF=BD=EF=BF=BD {
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD struc=
t adv7180_state *state =3D to_state(sd);
> >>>> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int err =3D mutex_lock_interru=
ptible(&state->mutex);
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int err;
> >>>> +
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD err =3D mutex_lock_interruptib=
le(&state->mutex);
> >>
> >>> The problem here is the missing empty line, not that 'int err =3D <so=
mething>;' part.
> >>> So just add the empty line and don't split up the variable assignment.
> >>
> >> Yes, the error is of missing empty line and I only resolved that parti=
cular error in the first version
> >> of this patch.
> >>
> >> But I was recommended to keep the conditional statement close to the l=
ine it is associated with
> >> and to make changes in the code wherever similar format is followed.
> >
> >> So I followed the advise of Kieran Bingham and made changes accordingl=
y.
> >>
> >> Below is the link of the full discussion : https://lore.kernel.org/lkm=
l/MAZPR01MB695752E4ADB0110443EA695CF2432@MAZPR01MB6957.INDPRD01.PROD.OUTLOO=
K.COM/T/
>=20
> > Kieran said this:
>=20
> >>> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *s=
d, v4l2_std_id *std)
> >>>=EF=BF=BD {
> >>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD struct adv7180_state *state =3D to_state(sd);
> >>
> >> Personally, I would keep the if (err) hugging the line it's associated
> >> with.
> >>
> >>
> >>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD int err =3D mutex_lock_interruptible(&state->mutex);
> >>> +
> >>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD if (err)
> >>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
 return err;
> >>>
>=20
> > which I interpret as saying that he doesn't like adding the extra empty=
 line.
>=20
> >>
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD if (e=
rr)
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD return e=
rr;
> >>>>
> >>>> @@ -388,8 +391,9 @@ static int adv7180_s_routing(struct v4l2_subdev =
*sd, u32 input,
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD u32 output, u32 config)
> >>>>=EF=BF=BD=EF=BF=BD {
> >>>>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD struc=
t adv7180_state *state =3D to_state(sd);
> >>>> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int ret =3D mutex_lock_interru=
ptible(&state->mutex);
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD int ret;
> >>>>
> >>>> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ret =3D mutex_lock_interruptib=
le(&state->mutex);
>=20
> > I don't believe he meant doing this.
>=20
> > In any case, none of this is worth the effort, just leave this driver a=
s-is.
>=20
> I appreciate your comments.=20
> My intention is to make linux kernel source as per kernel code style. In =
this approach I found these warnings "missing a blank line after declaratio=
ns"  and made changes accordingly.=20
> Also, there should be blank line after declaration of a variable, correct=
 me here if I am wrong.
> As per the suggestions of Kieran Bingham, he recommended to keep the if(e=
rr) hugging the line it's associated. So to adopt this change I made change=
s accordingly.

Yes, I stated keep the if (err) hugging the line that sets err:


  >         struct adv7180_state *state =3D to_state(sd);

  Personally, I would keep the if (err) hugging the line it's associated
  with.


  >         int err =3D mutex_lock_interruptible(&state->mutex);
  > +
  >         if (err)
  >                 return err;


To me the if (err) is directly associated with the
mutex_lock_interruptible(). That's the error it's checking, so they
should stay together.

Which you can do by using the following if it's clearer:

	struct adv7180_state *state =3D to_state(sd);

	int err =3D mutex_lock_interruptible(&state->mutex);
	if (err)
		return err;

That may not even remove the checkpatch warning though.

As Hans says, there's little reward here, except for learning how to get
patches into the kernel and bumping your kernel stats.

If you're a junior trying to learn how to get into kernel development, I
think that's reasonable to some degree. (Which was my assumption when I
responded, and on that note, It seems that your replies are coming
through really badly formatted to me, which I assume is your mail client
needing some checking through).


I see your updated patch now makes unrelated changes which confuse
matters. This was partially at my request, but I think it was
mis-understood, so I'm sorry for not being more clear and direct:


      >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D state->chip_info->se=
lect_input(state, input);
      >>> -
      >
      >> Why remove this empty line? It has nothing to do with what you are=
 trying
      >> to fix.
      >
      >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0)


And I agree with Hans, now you have a commit title that states:

 WARNING: Missing a blank line after declarations

And you are making changes which bear no direct relation ship to that.
I suggested if you are making one change through out it should be in
it's own full patch, but that patch must be able to stand out right on
it's own. So the commit message but clearly say what the patch does and
it should do only one thing.



If you're really trying to work through the whole kernel with cleanups,
then I think there's a kernel janitors project you should post to. But
I'm not sure if that's still a thing. Otherwise, this is indeed taking
rare and valuable review time away from more substantial topics.

--
Regards

Kieran

