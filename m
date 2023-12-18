Return-Path: <linux-kernel+bounces-3399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AA816BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB6C1F236DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2E199A0;
	Mon, 18 Dec 2023 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lo5y1CEn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9618E00
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33662243274so616307f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702897388; x=1703502188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Drw+eEw0bKG1NerarLyZz6szuI6XjIyA1Y5nawkeBVk=;
        b=lo5y1CEnm2ctz6haf1+g+Q4p7QmrLLQxAK92/IptKSwfzjR1F0DeTznw45RYNNqRIT
         hbKisqGi5C70Di6Ug6C3bdkE8hF1gDwqCSs08PlVgoEk1zDEyl55y7/IcQa9uCTIXNK0
         D+3jsiE6BHZvLxoYy2vNIp3jXX9ZfqyH0JOqn15dLnUkFD8uYjx60LoNsZyoeKRo2lt6
         GXxqQosEf27S5qOOvCex9Mr27bYvELsRLSgaGR0be9kaN10v/2c8DRfXZjQZATS0Auek
         k+WlNDwPN7I1ZeWQHGWh2S07jHSQMH0SsfyUwaeUT2UtIKwegwXztZUgfmRWM7jjIP26
         OjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702897388; x=1703502188;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Drw+eEw0bKG1NerarLyZz6szuI6XjIyA1Y5nawkeBVk=;
        b=h5qv3QB1Ga6o6j/JxocCR0tykGGbrFYZ+fpf1+x0nMZ3xvXz0MafcVc+nMXfZkTbpe
         I6XmwzlpebO68LsbF/Qhxq8OvLp84h0nsrU//pAdxTiDHPmtk9B45wuMg1zMdnDama4A
         p6NCTMHmHu9UEym3Anp2FVFcP3WHwQNQo7AUlLhn/BW9VDRi3tq8FOqzpiqZGPHqaDbc
         2F7xn0vD6tiODUE5W4WzCtIG0ByURNou7E8eWo+TH7YnTIAQjfiAK4Ludw1qIivKDAg+
         tBFzX+U21VXqhbolwLIDjOsmBoCVXsor6SGKESRuzSE8Ih72BNJjp3n+4cdIshY/I73p
         1k9g==
X-Gm-Message-State: AOJu0YwwOTI9e6Bixcs7DUOIc2EL/wCP6it3E1dmbNSZpwLkUjfaQGj8
	zjwKXt2RDkLS107HkkYNhMPDKiObHul2UoLsO2U=
X-Google-Smtp-Source: AGHT+IE9ftK4zNSoDF9ZZdAHfmKKoCSOr+hOFAOIMPuXf3RKwwFH8thprBDvIOlmiwgclQAXqFu+rw==
X-Received: by 2002:a7b:cd8e:0:b0:40c:269c:518f with SMTP id y14-20020a7bcd8e000000b0040c269c518fmr8041416wmj.115.1702897388039;
        Mon, 18 Dec 2023 03:03:08 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:4e1c:b20d:6bfc:b0d4])
        by smtp.gmail.com with ESMTPSA id u23-20020adfa197000000b0033666096650sm3613638wru.42.2023.12.18.03.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 03:03:07 -0800 (PST)
References: <20231106104013.704356-1-jbrunet@baylibre.com>
 <CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com>
 <1jil4zq2on.fsf@starbuckisacylon.baylibre.com>
 <CACb=7PXkaKYupZafD2BTiqusHZ1nEFq8AfWVot7VL07kxm0uWw@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Hsin-Yi Wang <hsinyi@google.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Zhengqiao Xia
 <xiazhengqiao@huaqin.corp-partner.google.com>, Mark Brown
 <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: hdmi-codec: register hpd callback on component probe
Date: Mon, 18 Dec 2023 11:28:46 +0100
In-reply-to: <CACb=7PXkaKYupZafD2BTiqusHZ1nEFq8AfWVot7VL07kxm0uWw@mail.gmail.com>
Message-ID: <1j5y0v22ol.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Fri 15 Dec 2023 at 14:55, Hsin-Yi Wang <hsinyi@google.com> wrote:

> On Fri, Dec 15, 2023 at 12:40=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.=
com> wrote:
>>
>>
>> On Fri 15 Dec 2023 at 12:51, Zhengqiao Xia
>> <xiazhengqiao@huaqin.corp-partner.google.com> wrote:
>>
>> > Hi Jerome,
>> >
>> > After my testing, I found that this patch will cause the audio on the =
external display to not work properly after
>> > restart.
>> > You move the plugged_cb to run in hdmi_probe, at this time hcp- > jack=
 =3D NULL, the driver cannot report `SND_JACK_LINEOUT
>> > ` normally.
>> > static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
>> >                                  unsigned int jack_status)
>> > {
>> >       printk("xzq-866 hdmi_codec_jack_report: jack=3D%x, jack_status=
=3D%d", hcp->jack, jack_status !=3D hcp->jack_status);
>> >       if (hcp->jack && jack_status !=3D hcp->jack_status) {
>> >               snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LIN=
EOUT);
>> >               hcp->jack_status =3D jack_status;
>> >       }
>> > }
>> > So we must call  plugged_cb  in hdmi_codec_set_jack,  Can you make som=
e changes?
>>
>> Hi Zhengqiao,
>>
>> That is unfortunate. Sorry.
>>
>> This patch has changed when the hpd callback is registered, no when it
>> comes in effect. This is still dependent on calling .set_jack() and it
>> is not happening any later than it was before. So, in theory, it should
>> not have changed anything, if your driver actually relies on the HPD
>> event.
>>
>> Trying to guess what is happening for you, I suppose your HDMI driver is
>> "faking" an HPD event to report the initial jack status when the
>> hook_plugged_cb() is called. Could you point me to the hdmi driver you
>> are using so I can have a look ?
>>
>> My reference when testing this was dw-hdmi-i2s-audio and it does not do
>> that, it just registers the callback. I think this is what it supposed
>> to do TBH.
>>
>> An idea I have been thinking about for a while is have the hdmi-codec
>> insert the jack in the card itself, instead of the card doing. That
>> would give the jack "for free" to any user of the HDMI codec and might
>> also solve your issue. It would require a small rework of the cards doing
>> the hdmi jack register, but there are not many of these AFAIK.
>>
>
> The driver is it6505. The implementation of hook_plugged_cb():
> 1. register plugged_cb
> 2. call plugged_cb(bool plugged)
>
> bridge detect callback it6505_detect would also call plugged_cb, but
> only on the first time hpd status changed (eg. changed from connect
> <--> disconnect)
> it6505_detect() {
>   status =3D it6505->hpd_state ...
>   ...
>   if (it6505->connector_status !=3D status) {
>     it6505->connector_status =3D status;
>     it6505_plugged_status_to_codec(it6505); // this will call plugged_cb
>   }
> }
>
> Unfortunately the first time after boot that hpd status changed was
> detected before set_jack. If we replug hdmi, the plugged_cb() was
> called by bridge_detect, which is expected.
>
> Prior to this patch, the initial plugged_cb() was called by hook_plugged_=
cb().
> After the patch, plugged_cb() should be called by hpd change (by
> bridge detect), but due to the driver logic only calling it on the
> first hpd state change, it fails to call plugged_cb() again when jack
> is set.

This is what thought=20

>
> I checked the dw-hdmi.c's bridge_detect, and it's similar in that it
> also checks the last_connector_result, so maybe it's due to a timing
> difference?

No, I have overlooked that.
I'm preparing a fix. I'll Cc you.

Eventually, I still would like to make it easier for cards to use the
HDMI jack and have to codec do that registration on its own. It will
require some rework of cards already doing it.

I've only seen 2 cards doing that at the moment:
* imx-hdmi.c
* mt8188-mt6359.c

Could you point me to yours ?

>
>> >
>> > On Mon, Nov 6, 2023 at 6:40=E2=80=AFPM Jerome Brunet <jbrunet@baylibre=
.com> wrote:
>> >
>> >  The HDMI hotplug callback to the hdmi-codec is currently registered w=
hen
>> >  jack is set.
>> >
>> >  The hotplug not only serves to report the ASoC jack state but also to=
 get
>> >  the ELD. It should be registered when the component probes instead, s=
o it
>> >  does not depend on the card driver registering a jack for the HDMI to
>> >  properly report the ELD.
>> >
>> >  Fixes: 25ce4f2b3593 ("ASoC: hdmi-codec: Get ELD in before reporting p=
lugged event")
>> >  Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> >  ---
>> >   sound/soc/codecs/hdmi-codec.c | 27 +++++++++++++++++++--------
>> >   1 file changed, 19 insertions(+), 8 deletions(-)
>> >
>> >  diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-co=
dec.c
>> >  index 09eef6042aad..20da1eaa4f1c 100644
>> >  --- a/sound/soc/codecs/hdmi-codec.c
>> >  +++ b/sound/soc/codecs/hdmi-codec.c
>> >  @@ -877,18 +877,13 @@ static int hdmi_codec_set_jack(struct snd_soc_c=
omponent *component,
>> >                                 void *data)
>> >   {
>> >          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata=
(component);
>> >  -       int ret =3D -ENOTSUPP;
>> >
>> >          if (hcp->hcd.ops->hook_plugged_cb) {
>> >                  hcp->jack =3D jack;
>> >  -               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev-=
>parent,
>> >  -                                                   hcp->hcd.data,
>> >  -                                                   plugged_cb,
>> >  -                                                   component->dev);
>> >  -               if (ret)
>> >  -                       hcp->jack =3D NULL;
>> >  +               return 0;
>> >          }
>> >  -       return ret;
>> >  +
>> >  +       return -ENOTSUPP;
>> >   }
>> >
>> >   static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
>> >  @@ -982,6 +977,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_c=
omponent *component,
>> >          return ret;
>> >   }
>> >
>> >  +static int hdmi_probe(struct snd_soc_component *component)
>> >  +{
>> >  +       struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata=
(component);
>> >  +       int ret =3D 0;
>> >  +
>> >  +       if (hcp->hcd.ops->hook_plugged_cb) {
>> >  +               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev-=
>parent,
>> >  +                                                   hcp->hcd.data,
>> >  +                                                   plugged_cb,
>> >  +                                                   component->dev);
>> >  +       }
>> >  +
>> >  +       return ret;
>> >  +}
>> >  +
>> >   static void hdmi_remove(struct snd_soc_component *component)
>> >   {
>> >          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata=
(component);
>> >  @@ -992,6 +1002,7 @@ static void hdmi_remove(struct snd_soc_component=
 *component)
>> >   }
>> >
>> >   static const struct snd_soc_component_driver hdmi_driver =3D {
>> >  +       .probe                  =3D hdmi_probe,
>> >          .remove                 =3D hdmi_remove,
>> >          .dapm_widgets           =3D hdmi_widgets,
>> >          .num_dapm_widgets       =3D ARRAY_SIZE(hdmi_widgets),
>>
>>
>> --
>> Jerome


--=20
Jerome

