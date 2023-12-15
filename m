Return-Path: <linux-kernel+bounces-631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665F8143DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC7F1C22774
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722E19455;
	Fri, 15 Dec 2023 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qGIva2UR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636B1946E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3333074512bso842096f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702629610; x=1703234410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YtVAfSplXJke0Lc4PMkOXYv6bL4Yj/HkhXbIEQJcK4=;
        b=qGIva2URjNFEI9h9gt95v8HZZJP/NOlO435Gr2jk/gOrUTdGshtKVv6hit9Nt8K4St
         QFxvx8a6yp3z8v3PnsapLyd8CE+1BM0btq/8XuCb4NCRmgb1KdRXs7J4YS19Qy7f6I4c
         nRlGJgoYfIMSQHoPVU6k20Cd8bNGwr4gA7/Mz+5wOJEJkyoPWwG/XmxWtBCu61p+d29e
         H9gZPkBO5AuM990wqW+q4kN8U43EZnYmNEUFiXPFC+WrtI1Ii/pwpk26Z0wYb53QcAdl
         hM2aKmtUDzh45B9BIw7NZ/vGkMOvO6U0Y66zpEENx+JbomCIR3sOCsj2a3/kJ1V0noCX
         kmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702629610; x=1703234410;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7YtVAfSplXJke0Lc4PMkOXYv6bL4Yj/HkhXbIEQJcK4=;
        b=vwFhDQgSEWoQdJ3aZqpkaQRWMajN634gLwPH96EY+KLabS+PRJ+R/DACXzQGNhHMIQ
         V44g/SkOwIDf6iVny5ks0p0KADYZ/zXQLSXs4VFza3rbrshnGOozIM83UQOV+v0edGUc
         1Wj8w1yvCN54560yhceWNlfRhluC51YXKPH25iEv+1hmYsBv/giqnyaw+ZdvE3FVCXXU
         XmCVMRasjJHKbPnz/EyELOVK2BqyLI5qmfLIQbNfFz3cNl8dEo+2kzaUd89etUa+N+57
         XkRwQKAr9+eBXYty/bNsib2pUt/Q2Op6d3m2MxqYRN1XU1p3dmo3+tbvDlP1OCv+XGW0
         nlVw==
X-Gm-Message-State: AOJu0YxCinYJp0DkGPVmODqDYEb3C3uebbPOvQUJ/7eiy9krWMh0DxQu
	Ye76IEysixei1dubV/B258/uw4GbmFfCW9stYtCXeQ==
X-Google-Smtp-Source: AGHT+IGFZfTLkMYS21w0oGbQOTfR0aJ4jsw/dLyqHOqHoVp9u5QTN/Jj53IQ/SW0XSMaY6Xrcsnb0A==
X-Received: by 2002:a05:600c:34ce:b0:40c:6cbe:aacf with SMTP id d14-20020a05600c34ce00b0040c6cbeaacfmr168118wmq.165.1702629609931;
        Fri, 15 Dec 2023 00:40:09 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:95b3:332a:9768:b3f2])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b0040c42681fcesm21307104wmb.15.2023.12.15.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:40:09 -0800 (PST)
References: <20231106104013.704356-1-jbrunet@baylibre.com>
 <CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Hsin-Yi Wang
 <hsinyi@google.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: register hpd callback on component probe
Date: Fri, 15 Dec 2023 08:57:39 +0100
In-reply-to: <CADYyEwTNyY+fR9SgfDa-g6iiDwkU3MUdPVCYexs2_3wbcM8_vg@mail.gmail.com>
Message-ID: <1jil4zq2on.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Fri 15 Dec 2023 at 12:51, Zhengqiao Xia <xiazhengqiao@huaqin.corp-partne=
r.google.com> wrote:

> Hi Jerome,
>
> After my testing, I found that this patch will cause the audio on the ext=
ernal display to not work properly after
> restart.=20
> You move the plugged_cb to run in hdmi_probe, at this time hcp- > jack =
=3D NULL, the driver cannot report `SND_JACK_LINEOUT
> ` normally.
> static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> 				   unsigned int jack_status)
> {
> 	printk("xzq-866 hdmi_codec_jack_report: jack=3D%x, jack_status=3D%d", hc=
p->jack, jack_status !=3D hcp->jack_status);
> 	if (hcp->jack && jack_status !=3D hcp->jack_status) {
> 		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
> 		hcp->jack_status =3D jack_status;
> 	}
> }
> So we must call  plugged_cb  in hdmi_codec_set_jack,  Can you make some c=
hanges?

Hi Zhengqiao,

That is unfortunate. Sorry.

This patch has changed when the hpd callback is registered, no when it
comes in effect. This is still dependent on calling .set_jack() and it
is not happening any later than it was before. So, in theory, it should
not have changed anything, if your driver actually relies on the HPD
event.

Trying to guess what is happening for you, I suppose your HDMI driver is
"faking" an HPD event to report the initial jack status when the
hook_plugged_cb() is called. Could you point me to the hdmi driver you
are using so I can have a look ?

My reference when testing this was dw-hdmi-i2s-audio and it does not do
that, it just registers the callback. I think this is what it supposed
to do TBH.

An idea I have been thinking about for a while is have the hdmi-codec
insert the jack in the card itself, instead of the card doing. That
would give the jack "for free" to any user of the HDMI codec and might
also solve your issue. It would require a small rework of the cards doing
the hdmi jack register, but there are not many of these AFAIK.

>
> On Mon, Nov 6, 2023 at 6:40=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.co=
m> wrote:
>
>  The HDMI hotplug callback to the hdmi-codec is currently registered when
>  jack is set.
>
>  The hotplug not only serves to report the ASoC jack state but also to get
>  the ELD. It should be registered when the component probes instead, so it
>  does not depend on the card driver registering a jack for the HDMI to
>  properly report the ELD.
>
>  Fixes: 25ce4f2b3593 ("ASoC: hdmi-codec: Get ELD in before reporting plug=
ged event")
>  Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>  ---
>   sound/soc/codecs/hdmi-codec.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
>  diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec=
.c
>  index 09eef6042aad..20da1eaa4f1c 100644
>  --- a/sound/soc/codecs/hdmi-codec.c
>  +++ b/sound/soc/codecs/hdmi-codec.c
>  @@ -877,18 +877,13 @@ static int hdmi_codec_set_jack(struct snd_soc_comp=
onent *component,
>                                 void *data)
>   {
>          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(co=
mponent);
>  -       int ret =3D -ENOTSUPP;
>
>          if (hcp->hcd.ops->hook_plugged_cb) {
>                  hcp->jack =3D jack;
>  -               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev->pa=
rent,
>  -                                                   hcp->hcd.data,
>  -                                                   plugged_cb,
>  -                                                   component->dev);
>  -               if (ret)
>  -                       hcp->jack =3D NULL;
>  +               return 0;
>          }
>  -       return ret;
>  +
>  +       return -ENOTSUPP;
>   }
>
>   static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
>  @@ -982,6 +977,21 @@ static int hdmi_of_xlate_dai_id(struct snd_soc_comp=
onent *component,
>          return ret;
>   }
>
>  +static int hdmi_probe(struct snd_soc_component *component)
>  +{
>  +       struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(co=
mponent);
>  +       int ret =3D 0;
>  +
>  +       if (hcp->hcd.ops->hook_plugged_cb) {
>  +               ret =3D hcp->hcd.ops->hook_plugged_cb(component->dev->pa=
rent,
>  +                                                   hcp->hcd.data,
>  +                                                   plugged_cb,
>  +                                                   component->dev);
>  +       }
>  +
>  +       return ret;
>  +}
>  +
>   static void hdmi_remove(struct snd_soc_component *component)
>   {
>          struct hdmi_codec_priv *hcp =3D snd_soc_component_get_drvdata(co=
mponent);
>  @@ -992,6 +1002,7 @@ static void hdmi_remove(struct snd_soc_component *c=
omponent)
>   }
>
>   static const struct snd_soc_component_driver hdmi_driver =3D {
>  +       .probe                  =3D hdmi_probe,
>          .remove                 =3D hdmi_remove,
>          .dapm_widgets           =3D hdmi_widgets,
>          .num_dapm_widgets       =3D ARRAY_SIZE(hdmi_widgets),


--=20
Jerome

