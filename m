Return-Path: <linux-kernel+bounces-1797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48902815403
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2ED6B2185A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D71718EC1;
	Fri, 15 Dec 2023 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVo//VYG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9B18EAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c236624edso12459805e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702680928; x=1703285728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfWah5pIv+cdtVmyxWmUY/L3xG6Co4HLc34UhFBOkUw=;
        b=CVo//VYGbi9pLAeIFn9fgLxxdHQbN1ln00GLrcLj/cozX4Lj2IkuGXfuPFeEqpWHGA
         Z37JyhHofhl9HRAZtwa6vrTtQsO233GODak7A+yySNxjF7G4zEeW1tkVdT6vUSsnOOfS
         4Fndi1FjKnH7vBPzuga+eW4uZv6WmEExZSp8h601OFWRPYO8lBS5yrx4eAW3wn6xuvQz
         +Up0xTaZiCjwfG2S9G7SKZY0SONBp7IiEjqn+Vy5Zstzl2nXN5p2eSY+qn9Z/uG4M+G/
         pI/r3eMnYEhWAU+6SVCeJ7Znw8lwS9GVYe3Y8jjtYp+b/5oGfOGF1jOkXTh97HMBdQgL
         oqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702680928; x=1703285728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfWah5pIv+cdtVmyxWmUY/L3xG6Co4HLc34UhFBOkUw=;
        b=LEIw43TqvsKJ85sDzGJqJIyi47Xezq69+ENmsb0tT0KkYpyqAZRKPW1s+yPtxoYzOJ
         dg9i1lHxgGfGYAvi2y1Op0TOd1RVFJ5GpqxxOsin3SVd6/NItPKk3FWGsrRARBo/wAvm
         9wOAP3wkXOlHW/jXZCXfo41iZnlNJEiCCIojIQgpAbG3/AebjgYTlG65xleDn+vE57MR
         ncvMa8O3SLK/jpGfR1x+aZHx65lPV/PPjksNci80sGZdCdZ1Wq6y4KvtawXtv27XcPO3
         dmANCLFDu0I12kid5ma6zGzpPCDZTUPUQUcJVbJbvuZ8ZzvC+KfPOS8LkWzVsENrJBfl
         ekYA==
X-Gm-Message-State: AOJu0YxQGLRUYoFDNHrzpd7omG1Fl1ONmloaW8y5iyiL4O9FisbM5GBK
	MxXoT3E3wWGTay41pW19cFbCo4/QYzySDHHSlenIdzYl3ZVU/1b4kG989Q==
X-Google-Smtp-Source: AGHT+IFIB5xNMOQoGlg74oNU/TZnz/9PWSKGUJ3pLK/UQ1Nqs6+/vrrIi0CB3YqMFOOPJKuW3z2k6ksi5MjBtn5J/9M=
X-Received: by 2002:a05:600c:4507:b0:40b:5e21:cc15 with SMTP id
 t7-20020a05600c450700b0040b5e21cc15mr6325717wmo.64.1702680928219; Fri, 15 Dec
 2023 14:55:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106104013.704356-1-jbrunet@baylibre.com> <CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com>
 <1jil4zq2on.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jil4zq2on.fsf@starbuckisacylon.baylibre.com>
From: Hsin-Yi Wang <hsinyi@google.com>
Date: Fri, 15 Dec 2023 14:55:00 -0800
Message-ID: <CACb=7PXkaKYupZafD2BTiqusHZ1nEFq8AfWVot7VL07kxm0uWw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: register hpd callback on component probe
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>, 
	Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:40=E2=80=AFAM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
>
>
> On Fri 15 Dec 2023 at 12:51, Zhengqiao Xia <xiazhengqiao@huaqin.corp-part=
ner.google.com> wrote:
>
> > Hi Jerome,
> >
> > After my testing, I found that this patch will cause the audio on the e=
xternal display to not work properly after
> > restart.
> > You move the plugged_cb to run in hdmi_probe, at this time hcp- > jack =
=3D NULL, the driver cannot report `SND_JACK_LINEOUT
> > ` normally.
> > static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> >                                  unsigned int jack_status)
> > {
> >       printk("xzq-866 hdmi_codec_jack_report: jack=3D%x, jack_status=3D=
%d", hcp->jack, jack_status !=3D hcp->jack_status);
> >       if (hcp->jack && jack_status !=3D hcp->jack_status) {
> >               snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINE=
OUT);
> >               hcp->jack_status =3D jack_status;
> >       }
> > }
> > So we must call  plugged_cb  in hdmi_codec_set_jack,  Can you make some=
 changes?
>
> Hi Zhengqiao,
>
> That is unfortunate. Sorry.
>
> This patch has changed when the hpd callback is registered, no when it
> comes in effect. This is still dependent on calling .set_jack() and it
> is not happening any later than it was before. So, in theory, it should
> not have changed anything, if your driver actually relies on the HPD
> event.
>
> Trying to guess what is happening for you, I suppose your HDMI driver is
> "faking" an HPD event to report the initial jack status when the
> hook_plugged_cb() is called. Could you point me to the hdmi driver you
> are using so I can have a look ?
>
> My reference when testing this was dw-hdmi-i2s-audio and it does not do
> that, it just registers the callback. I think this is what it supposed
> to do TBH.
>
> An idea I have been thinking about for a while is have the hdmi-codec
> insert the jack in the card itself, instead of the card doing. That
> would give the jack "for free" to any user of the HDMI codec and might
> also solve your issue. It would require a small rework of the cards doing
> the hdmi jack register, but there are not many of these AFAIK.
>

The driver is it6505. The implementation of hook_plugged_cb():
1. register plugged_cb
2. call plugged_cb(bool plugged)

bridge detect callback it6505_detect would also call plugged_cb, but
only on the first time hpd status changed (eg. changed from connect
<--> disconnect)
it6505_detect() {
  status =3D it6505->hpd_state ...
  ...
  if (it6505->connector_status !=3D status) {
    it6505->connector_status =3D status;
    it6505_plugged_status_to_codec(it6505); // this will call plugged_cb
  }
}

Unfortunately the first time after boot that hpd status changed was
detected before set_jack. If we replug hdmi, the plugged_cb() was
called by bridge_detect, which is expected.

Prior to this patch, the initial plugged_cb() was called by hook_plugged_cb=
().
After the patch, plugged_cb() should be called by hpd change (by
bridge detect), but due to the driver logic only calling it on the
first hpd state change, it fails to call plugged_cb() again when jack
is set.

I checked the dw-hdmi.c's bridge_detect, and it's similar in that it
also checks the last_connector_result, so maybe it's due to a timing
difference?

> >
> > On Mon, Nov 6, 2023 at 6:40=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.=
com> wrote:
> >
> >  The HDMI hotplug callback to the hdmi-codec is currently registered wh=
en
> >  jack is set.
> >
> >  The hotplug not only serves to report the ASoC jack state but also to =
get
> >  the ELD. It should be registered when the component probes instead, so=
 it
> >  does not depend on the card driver registering a jack for the HDMI to
> >  properly report the ELD.
> >
> >  Fixes: 25ce4f2b3593 ("ASoC: hdmi-codec: Get ELD in before reporting pl=
ugged event")
> >  Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >  ---
> >   sound/soc/codecs/hdmi-codec.c | 27 +++++++++++++++++++--------
> >   1 file changed, 19 insertions(+), 8 deletions(-)
> >
> >  diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-cod=
ec.c
> >  index 09eef6042aad..20da1eaa4f1c 100644
> >  --- a/sound/soc/codecs/hdmi-codec.c
> >  +++ b/sound/soc/codecs/hdmi-codec.c
> >  @@ -877,18 +877,13 @@ static int hdmi_codec_set_jack(struct snd_soc_co=
mponent *component,
> >                                 void *data)
> >   {
> >          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(=
component);
> >  -       int ret =3D -ENOTSUPP;
> >
> >          if (hcp->hcd.ops->hook_plugged_cb) {
> >                  hcp->jack =3D jack;
> >  -               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev->=
parent,
> >  -                                                   hcp->hcd.data,
> >  -                                                   plugged_cb,
> >  -                                                   component->dev);
> >  -               if (ret)
> >  -                       hcp->jack =3D NULL;
> >  +               return 0;
> >          }
> >  -       return ret;
> >  +
> >  +       return -ENOTSUPP;
> >   }
> >
> >   static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
> >  @@ -982,6 +977,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_co=
mponent *component,
> >          return ret;
> >   }
> >
> >  +static int hdmi_probe(struct snd_soc_component *component)
> >  +{
> >  +       struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(=
component);
> >  +       int ret =3D 0;
> >  +
> >  +       if (hcp->hcd.ops->hook_plugged_cb) {
> >  +               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev->=
parent,
> >  +                                                   hcp->hcd.data,
> >  +                                                   plugged_cb,
> >  +                                                   component->dev);
> >  +       }
> >  +
> >  +       return ret;
> >  +}
> >  +
> >   static void hdmi_remove(struct snd_soc_component *component)
> >   {
> >          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(=
component);
> >  @@ -992,6 +1002,7 @@ static void hdmi_remove(struct snd_soc_component =
*component)
> >   }
> >
> >   static const struct snd_soc_component_driver hdmi_driver =3D {
> >  +       .probe                  =3D hdmi_probe,
> >          .remove                 =3D hdmi_remove,
> >          .dapm_widgets           =3D hdmi_widgets,
> >          .num_dapm_widgets       =3D ARRAY_SIZE(hdmi_widgets),
>
>
> --
> Jerome

