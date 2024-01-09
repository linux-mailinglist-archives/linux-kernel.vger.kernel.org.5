Return-Path: <linux-kernel+bounces-21474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12074828FF3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAC71F25062
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F43E469;
	Tue,  9 Jan 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiANMjao"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71A8486;
	Tue,  9 Jan 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbd6e37a9bso3285594b6e.0;
        Tue, 09 Jan 2024 14:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704839483; x=1705444283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LM2tcpDQbe/VXeTrQ3vh6Aow7A9aPJshodbKcPZnx4=;
        b=PiANMjao7EPdO4WA/f/79xw0yosXRwGFFeTijmpmct6hPhymvgl5wfTSUhgogVTQXb
         YOFNNGtbsrb5sKi/1cROiI+1lY7Cp1ris1cUYq6mHTFdXX+6GjRESbEuyeV8wERYho0W
         oKfQTd+aSGaU7GmG4bIHLlsu4ID4+1YDZ2kYFN/zsSMgRs+XtPUlPnU7AQkyCpvxNSKh
         9HyzvQ6plCeEeli5MVB3dbOfi9WUuqUCEUR7kO3CNkr/tZia7LUSOgMJmLw6uwtA0ot1
         FwWhhIBEq4MZCOWdrzAFs/wcM8ms6O+jjD1Zk13/+uqwDiYI+2wtEVMF/LbVacG1ZEzi
         bYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839483; x=1705444283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LM2tcpDQbe/VXeTrQ3vh6Aow7A9aPJshodbKcPZnx4=;
        b=JdvwEiBPUYEuvDkTbwiAY0VJzx65R8OI21ojcolMmps4WIFX1xDcNpFlxoNd/6Wej+
         Q0KtzoVRm8+ldq0LDsF/l4A7FCtLQmgHssJ0SAf2bYl5mCYSijU8noAbRWvietnItpCd
         eumwvBzYItsKhHzyP3wArZRjXRc8frAHy0CpS+DBwcIvqIwoZkgmySmbgbNKXbXVPuvm
         DQ3NrxO4+N+hd1X+dMD2uM3B6Rio8SYXU71uBkwkGH/cpUt8/uhZ2e1ZwgMYwT+gMV+h
         Ki2hhX+v4xoTzRpsSEHWmEUxmfpB1dJN2o75zUMm4uZJNKeFzoj6PMsPGlddN97ki+qK
         S/Bw==
X-Gm-Message-State: AOJu0YxnbfXW9hbFmmXWHBMGVJSoleCemChnxijNouNGa7uyliKSnSD6
	oWBS/tU9p1GYwMuury98UNjo61py6aI=
X-Google-Smtp-Source: AGHT+IFeGOFa6xfy0pKzOnBFaLp6N/drKJ3QnkjdLOsdi4+3g8yIJf4CeMOPwWpjFyp77eA+1TnhMA==
X-Received: by 2002:a05:6808:e83:b0:3bd:3a51:f6dd with SMTP id k3-20020a0568080e8300b003bd3a51f6ddmr110101oil.70.1704839483464;
        Tue, 09 Jan 2024 14:31:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1135:ca4a:123c:5e53])
        by smtp.gmail.com with ESMTPSA id q24-20020aa79838000000b006daf6892afesm2211283pfl.144.2024.01.09.14.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:31:22 -0800 (PST)
Date: Tue, 9 Jan 2024 14:31:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: James Ogletree <James.Ogletree@cirrus.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <Fred.Treven@cirrus.com>,
	Ben Bright <Ben.Bright@cirrus.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	James Schulman <James.Schulman@cirrus.com>,
	David Rhodes <David.Rhodes@cirrus.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Peng Fan <peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Shuming Fan <shumingf@realtek.com>,
	Shenghao Ding <13916275206@139.com>,
	Ryan Lee <ryans.lee@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"open list:CIRRUS LOGIC HAPTIC DRIVERS" <patches@opensource.cirrus.com>,
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	"moderated list:CIRRUS LOGIC AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <ZZ3JNuLp-ZfGOQRF@google.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
 <ZZoFUwOEF6NByIp2@google.com>
 <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <564A2601-4933-4BD7-B4E6-C973A585CA61@cirrus.com>

On Tue, Jan 09, 2024 at 10:03:02PM +0000, James Ogletree wrote:
> Hi Dmitry,
> 
> Thank you for your excellent review. Just a few questions.
> 
> > On Jan 6, 2024, at 7:58 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > On Thu, Jan 04, 2024 at 10:36:37PM +0000, James Ogletree wrote:
> 
> >> +
> >> + info->add_effect.u.periodic.custom_data = kcalloc(len, sizeof(s16), GFP_KERNEL);
> >> + if (!info->add_effect.u.periodic.custom_data)
> >> + return -ENOMEM;
> >> +
> >> + if (copy_from_user(info->add_effect.u.periodic.custom_data,
> >> +   effect->u.periodic.custom_data, sizeof(s16) * len)) {
> >> + info->add_error = -EFAULT;
> >> + goto out_free;
> >> + }
> >> +
> >> + queue_work(info->vibe_wq, &info->add_work);
> >> + flush_work(&info->add_work);
> > 
> > I do not understand the need of scheduling a work here. You are
> > obviously in a sleeping context (otherwise you would not be able to
> > execute flush_work()) so you should be able to upload the effect right
> > here.
> 
> Scheduling work here is to ensure its ordering with “playback" worker
> items, which themselves are called in atomic context and so need
> deferred work. I think this explains why we need a workqueue as well,
> but please correct me.
> 
> > 
> >> +
> >> +static int vibra_playback(struct input_dev *dev, int effect_id, int val)
> >> +{
> >> + struct vibra_info *info = input_get_drvdata(dev);
> >> +
> >> + if (val > 0) {
> > 
> > value is supposed to signal how many times an effect should be repeated.
> > It looks like you are not handling this at all.
> 
> For playbacks, we mandate that the input_event value field is set to either 1

I am sorry, who is "we"?

> or 0 to command either a start playback or stop playback respectively.
> Values other than that should be rejected, so in the next version I will fix this
> to explicitly check for 1 or 0.

No, please implement the API properly.

> 
> > 
> >> + info->start_effect = &dev->ff->effects[effect_id];
> >> + queue_work(info->vibe_wq, &info->vibe_start_work);
> > 
> > The API allows playback of several effects at once, the way you have it
> > done here if multiple requests come at same time only one will be
> > handled.
> 
> I think I may need some clarification on this point. Why would concurrent
> start/stop playback commands get dropped? It seems they would all be
> added to the workqueue and executed eventually.

You only have one instance of vibe_start_work, as well as only one
"slot" to hold the effect you want to start. So if you issue 2 request
back to back to play effect 1 and 2 you are likely to end with
info->start_effect == 2 and that is what vibe_start_work handler will
observe, effectively dropping request to play effect 1 on the floor.

> 
> > 
> >> + } else {
> >> + queue_work(info->vibe_wq, &info->vibe_stop_work);
> > 
> > Which effect are you stopping? All of them? You need to stop a
> > particular one.
> 
> Our implementation of “stop” stops all effects in flight which is intended.
> That is probably unusual so I will add a comment here in the next
> version.

Again, please implement the driver properly, not define your own
carveouts for the expected behavior.

Thanks.

-- 
Dmitry

