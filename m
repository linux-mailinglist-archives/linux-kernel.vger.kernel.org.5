Return-Path: <linux-kernel+bounces-47627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1841845070
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFF9B29580
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725CE3BB3D;
	Thu,  1 Feb 2024 04:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWmfHnAF"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEE3BB21;
	Thu,  1 Feb 2024 04:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762770; cv=none; b=OlzJqqCxKunURPIi8fohOJl1gqStf4AfsbPXHLfoOUMcdcMWuZztVdByITu6wyH3DKk9gJSpeaudilmPqQoEztTBgQTkyxIc1mXZAtxFfyvLMFr+YMc3WjyMI8PHPJjY2tgOYPZWsT8lGibTEh4fTH82zv1rcb9m33baIPWF3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762770; c=relaxed/simple;
	bh=sT31d/Dktz06hVif+GESOP/aywR9taJS8IONIS8Md1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TA8a42oygxjC8TWykkBzudqQ/0eyHKVBdG/9XDpoguivirOxXKKgbEzkJUckW35lUItWtgm4cwj5cn/tiCj8HOOwvcce9NJmCNaroVUlwslZns/hGiMunFjXGv3+VWE+YPT0Qko6IiDZnNMkXFAqBouZ31ftgg45unIz1ReND3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWmfHnAF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so764095a12.1;
        Wed, 31 Jan 2024 20:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706762767; x=1707367567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfodC9vNrDpns69W2WTDuHfGSm1HhcI9brbrkzFOKO4=;
        b=RWmfHnAFYIkUiDeZaSYv9hY9T/w57gDoZty8Tv3av6/WTCi3MITXXlfh4iMTBzwboU
         mdNjhzNz3y+vu4BChXbxvsG8c1G1gzXOMBLErutz+BnzyRe6uE7esrUBOLxNcBwIS1BE
         mqmUC8+5WYKc2v6+hIkzrlcB/dY0CvzvP24AKzpp99T23LTutjCO/dKIaj179WW4vwy1
         Y7xINe5nDJdqhODHrleMScpjBeWhE3JPSUnV38tyRjSxWmBmzIdG4LK5fScIXqys4Qs+
         yEp5izXcwlU6Z0KbH/qNbrLjjMYmiRVn5/9o5icdVa/ytp/hi4zi3cbv4NY+nCbWmHSG
         mHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762767; x=1707367567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfodC9vNrDpns69W2WTDuHfGSm1HhcI9brbrkzFOKO4=;
        b=aPimDmadIZj6J5+lohsg7EYS32S9cmWRMkJ0GCtcfnThSRqqUQk6qSP2YDecRMw4Mo
         C/11T+2BY7ldjy7OPbYNfTgxj5+wJ2jpQP2zMqOQAwHu/OGRpsNWDScSeh5yJUHADsk4
         hyUREWEOpGKhAprlXFK2yq4zoGj6YvqKtw14ahS8tmCiKYgJ8oPPBZ1Gwy/R1GE8GnV8
         H0BqrTGtRhRjCYx3T8MvxnoVk68yl1vL8Hy8SGqyysSCHJca4QEONe9gndwpVlDvSA8s
         cinLZ1/mZVxWlDDMgU8cii6ajxfRolGt5zFkuHR1uKbHAVYTIIT888RvaclK3Vl3RvEn
         hZuA==
X-Gm-Message-State: AOJu0YxjFUxknMJYB3Hq6/Uh/2fn+6pHUHpeRhrEuiVmdZivH+ii1tzV
	WyGOu8ay6ZaFQ6ycqXajYfLNvdnyLd4ovyKPsbOE+1dPeQZbe3alepmHsI7/VRFbe96qUsGSY57
	kDm5tbewF4a+7qhG3ebBGuDz/Wtw=
X-Google-Smtp-Source: AGHT+IEZJ1ezAJFk5aGlxra7BSqIZ86xefE3rE7to+yqrwkHqHw9Iw38a0NbpIHmIvKSYXbG+1CaYv50GcsXgZSXfoM=
X-Received: by 2002:a50:fb03:0:b0:55f:d39:9bb with SMTP id d3-20020a50fb03000000b0055f0d3909bbmr6379747edq.15.1706762767220;
 Wed, 31 Jan 2024 20:46:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-4-thepacketgeek@gmail.com> <Zbi+Zw2o0rDfX1pj@gmail.com>
In-Reply-To: <Zbi+Zw2o0rDfX1pj@gmail.com>
From: Packet Geek <thepacketgeek@gmail.com>
Date: Wed, 31 Jan 2024 20:45:56 -0800
Message-ID: <CADvopva+tesNHtCBOadK9x3bbqgjX+ZkkyPDeX1pto7ZUU=QVA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/8] net: netconsole: move newline trimming to function
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:16=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Fri, Jan 26, 2024 at 03:13:38PM -0800, Matthew Wood wrote:
> > Move newline trimming logic from `dev_name_store()` to a new function
> > (trim_newline()) for shared use in netconsole.c
> >
> > Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 085350beca87..b280d06bf152 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -230,6 +230,16 @@ static struct netconsole_target *to_target(struct =
config_item *item)
> >                           struct netconsole_target, group);
> >  }
> >
> > +/* Get rid of possible trailing newline, returning the new length */
> > +static void trim_newline(char *s, size_t maxlen)
> > +{
> > +     size_t len;
> > +
> > +     len =3D strnlen(s, maxlen);
> > +     if (s[len - 1] =3D=3D '\n')
> > +             s[len - 1] =3D '\0';
> > +}
>
> I am thinking about this one. Should we replace the first `\n` in the
> file by `\0` no matter where it is? This will probably make it easier to
> implement the netconsd, where we know it will be impossible to have `\n`
> in the userdata.
>
> Maybe something as:
>
>         static inline void trim_newline(char *str)
>         {
>                 char *pos =3D strchr(str, '\n');
>
>                 if (pos)
>                         *pos =3D '\0';
>         }
>
>
> All in all, this is a good clean up, which make the code easier to read.
> Thanks!

I like this idea, I agree that only accepting userdata values upto the
first newline clears up the expectations for log output and parsing on
the receiving side. I would prefer that to the case where multiple
values (delimited by newlines) are somehow attempted with a single
key, seems like just using additional key/value pairs would be
cleaner.

