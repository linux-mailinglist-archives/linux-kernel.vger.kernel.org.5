Return-Path: <linux-kernel+bounces-13882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39406821432
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BABF1F21330
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5932613D;
	Mon,  1 Jan 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="um9n6pCm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB0610B;
	Mon,  1 Jan 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 389412B3;
	Mon,  1 Jan 2024 16:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704122518;
	bh=3H0pGVXkmvQq4iSjto9/8c7JIW0F+uQywqKCqLYStOw=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=um9n6pCmOvk/UMif8+aDf7Uuna+aDZ0+wPeo5oOcpu9+mo1r+J8BATXwsRdB1fqs/
	 RFw4dTAyibv09tjoWYoj37oWat0zT0SBh0sG6cqaAkUPhVYzZ4/8XaeG7UVQIHMsCL
	 lGideJzYOaDAGdnZWXj41HrDXCUsiZ8kUCLGKWCU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <MAZPR01MB695797DF964AA599AF2D7D05F29DA@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io> <170376380893.2881109.11558061738942135116@ping.linuxembedded.co.uk> <MAZPR01MB695797DF964AA599AF2D7D05F29DA@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] media: adv7180: Fix cppcheck warnings and errors
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>, lars@metafoo.de, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org
Date: Mon, 01 Jan 2024 15:22:53 +0000
Message-ID: <170412257392.923098.3453218353962810283@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Bhavin Sharma (2023-12-29 13:37:14)
> Thanks for the reply,=EF=BF=BDKieran
>=20
> >> WARNING: Missing a blank line after declarations
> >> ERROR: else should follow close brace '}'
> >>=20
> >> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
> >>=20
> >> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> >> index 54134473186b..91756116eff7 100644
> >> --- a/drivers/media/i2c/adv7180.c
> >> +++ b/drivers/media/i2c/adv7180.c
> >> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd=
, v4l2_std_id *std)
> >>=EF=BF=BD {
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD struct adv7180_state *state =3D to_state(sd);
>=20
> >>Personally, I would keep the if (err) hugging the line it's associated
> with.
>=20
> If we follow the code base pattern for this diver, we are getting same on=
line space in conditional if statements.
> So, we need to make changes there also.

If there are multiple places in a file for the same fixup, then indeed -
make them all in a single patch as a single cleanup.


> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD int err =3D mutex_lock_interruptible(&state->mutex);
> >> +
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD if (err)
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
 return err;
> >>=EF=BF=BD=20
> >> @@ -411,6 +412,7 @@ static int adv7180_g_input_status(struct v4l2_subd=
ev *sd, u32 *status)
> >>=EF=BF=BD {
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD struct adv7180_state *state =3D to_state(sd);
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD int ret =3D mutex_lock_interruptible(&state->mutex);
> >> +
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD if (ret)
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
 return ret;
> >>=EF=BF=BD=20
> >> @@ -1046,8 +1048,7 @@ static int adv7182_init(struct adv7180_state *st=
ate)
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ADV7180_REG_EXTENDED_OUTPUT_C=
ONTROL,
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD 0x17);
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD }
> >> -=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD else
> >> +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD } else
>=20
> >>I think kernel code style requires an else clause following a multiline
> scope to also have its scope enclosed in braces even if it's a single
> statement.
>=20
> On many places in driver there is single statement after else without clo=
sing=EF=BF=BD
> So, we have to make changes in those places also.
>=20
> So, better I should make changes in all places and make version V2 patch.

Yes, but you should probably tackle both cleanups as two patches
covering the whole file for each cleanup.

--
Kieran


>=20
> Please give your suggestions.
>=20
> --
> Bhavin Sharma
>=20
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ad=
v7180_write(state,
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD ADV7180_REG_EXTENDED_OUTPU=
T_CONTROL,
> >>=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD 0x07);
> >> --=20
> >> 2.25.1
> >>

