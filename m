Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EE4782A43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjHUNQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHUNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:16:37 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B77139
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:16:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso436311cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692623743; x=1693228543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnSB4QbuCs2L6o1hVVPxHfaphrL2l/lk2QJ6apgrG4E=;
        b=4pUCD503HaLMzhbdwRIvap/zbRa1LXu/iQU0cWYjedob1cWikSPlvoG/eVzQrzyDqD
         Yn2HrFl+SuNxHjqb0NOQ8uVQriWnLMknRO7HOkg2Cd1RO/Nj1G4tNNJnWn9uDgkcAGs1
         6u7aoOP6wkb1CTaK4Nb7TpArBN9XGG/SflZ8scvYZH8CbHN0dkwJzsMBY38a6LUHiNWf
         Z+EoqfPKOttegPq46S4f/5Sk/HEcTgB3KR3Nc3pJHzDlXz1q+N7dG32nesECZTcZRYGO
         kSGFv5cjxouIi7KwMWK39JtZln1jxt8iV6SQqJzjXF3kh4/q/jeJDF5ATZ7jgQf93r7A
         o0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623743; x=1693228543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnSB4QbuCs2L6o1hVVPxHfaphrL2l/lk2QJ6apgrG4E=;
        b=MT8DroYmiZEQb3o93RK9tbeU/cvfDL4iUtelLEO2hFGPb1/maurLK/OZWIaEcbNafZ
         W8A6Ux87cZM69Q98MG4axGLkW69lKYAet/B1NTPt0GAT0SJ3lkQFE9eE6xB6SytppTmR
         MeBFWp5U5C7//6DF/4XEqNCLZdqEqHCmiCyuYLdFFBh362PMY5IoNjL/nqFYmrcckWNY
         JA9cozizYjCzR22/GbHP0Xm9S6eiNwNxX6Nog1jdpTH2AEvqmERp3WLVH4polPBc5917
         QWJ5KpR59jq35UKwPI3vd7CDKTB8s675yEKSp8ayrDOBLT0XEsMbu6wS7WCq51axjLnJ
         YJDg==
X-Gm-Message-State: AOJu0YwnboiRCI4aE/M1H4T+GzydTYT699z9wws9N6d0bE13B/dl3xS6
        INLHSoR3G1m3W1YmhNGlxeN0YA22v+yQdPz2CIxSxg==
X-Google-Smtp-Source: AGHT+IH4XJZUBCEpS7xwhb553C3R2A2vLKwXbPhQkBSvPkXEmMejADowiIsZUdBnPNAxTNb4joqq5lmdAKTYN8aw+I8=
X-Received: by 2002:ac8:7e93:0:b0:40f:c60d:1c79 with SMTP id
 w19-20020ac87e93000000b0040fc60d1c79mr565484qtj.28.1692623742367; Mon, 21 Aug
 2023 06:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814043140.1108917-1-rekanorman@chromium.org>
 <20230814043140.1108917-8-rekanorman@chromium.org> <a834b202-7d5c-2a04-fc69-1913cd063a67@xs4all.nl>
In-Reply-To: <a834b202-7d5c-2a04-fc69-1913cd063a67@xs4all.nl>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 21 Aug 2023 06:15:30 -0700
Message-ID: <CABXOdTdkBM70i=cbBak99ph=P0roaRvhiRpE8O7t4JNkGWUDAw@mail.gmail.com>
Subject: Re: [PATCH 7/9] media: cros-ec-cec: Allow specifying multiple HDMI connectors
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Reka Norman <rekanorman@chromium.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Stefan Adolfsson <sadolfsson@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 2:12=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> Hi Reka,
>
> On 14/08/2023 06:29, Reka Norman wrote:
> > Update the cec_dmi_match_table to allow specifying multiple HDMI
> > connectors for each device.
> >
> > Signed-off-by: Reka Norman <rekanorman@chromium.org>
> > ---
> >
> >  .../media/cec/platform/cros-ec/cros-ec-cec.c  | 47 +++++++++++--------
> >  1 file changed, 28 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers=
/media/cec/platform/cros-ec/cros-ec-cec.c
> > index c68ed5d4bda0..f2f397d9a6d8 100644
> > --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> > @@ -284,38 +284,41 @@ static SIMPLE_DEV_PM_OPS(cros_ec_cec_pm_ops,
> >  #if IS_ENABLED(CONFIG_PCI) && IS_ENABLED(CONFIG_DMI)
> >
> >  /*
> > - * The Firmware only handles a single CEC interface tied to a single H=
DMI
> > - * connector we specify along with the DRM device name handling the HD=
MI output
> > + * Specify the DRM device name handling the HDMI output and the HDMI c=
onnector
> > + * corresponding to each CEC port. The order of connectors must match =
the order
> > + * in the EC (first connector is EC port 0, ...), and the number of co=
nnectors
> > + * must match the number of ports in the EC (which can be queried usin=
g the
> > + * EC_CMD_CEC_PORT_COUNT host command).
> >   */
> >
> >  struct cec_dmi_match {
> >       const char *sys_vendor;
> >       const char *product_name;
> >       const char *devname;
> > -     const char *conn;
> > +     const char *conns[EC_CEC_MAX_PORTS];
>
> Since EC_CEC_MAX_PORTS is 16, this will waste a lot of space here.
>
> I would suggest creating a separate define (CEC_MAX_PORTS?) that is set
> to 2 and is the max port that is actually used.
>

Possibly it could also be declared as const char * const ** and be
terminated with NULL (though that would require {{ "Port B", NULL } in
the declarations). Not sure which one is better.

Guenter

> When you get the actual number of ports from the EC you can check if
> CEC_MAX_PORTS isn't too small and return an error if it is.
>
> You can use CEC_MAX_PORTS here and in the ports array of struct cros_ec_c=
ec.
>
> Regards,
>
>         Hans
>
> >  };
> >
> >  static const struct cec_dmi_match cec_dmi_match_table[] =3D {
> >       /* Google Fizz */
> > -     { "Google", "Fizz", "0000:00:02.0", "Port B" },
> > +     { "Google", "Fizz", "0000:00:02.0", { "Port B" } },
> >       /* Google Brask */
> > -     { "Google", "Brask", "0000:00:02.0", "Port B" },
> > +     { "Google", "Brask", "0000:00:02.0", { "Port B" } },
> >       /* Google Moli */
> > -     { "Google", "Moli", "0000:00:02.0", "Port B" },
> > +     { "Google", "Moli", "0000:00:02.0", { "Port B" } },
> >       /* Google Kinox */
> > -     { "Google", "Kinox", "0000:00:02.0", "Port B" },
> > +     { "Google", "Kinox", "0000:00:02.0", { "Port B" } },
> >       /* Google Kuldax */
> > -     { "Google", "Kuldax", "0000:00:02.0", "Port B" },
> > +     { "Google", "Kuldax", "0000:00:02.0", { "Port B" } },
> >       /* Google Aurash */
> > -     { "Google", "Aurash", "0000:00:02.0", "Port B" },
> > +     { "Google", "Aurash", "0000:00:02.0", { "Port B" } },
> >       /* Google Gladios */
> > -     { "Google", "Gladios", "0000:00:02.0", "Port B" },
> > +     { "Google", "Gladios", "0000:00:02.0", { "Port B" } },
> >       /* Google Lisbon */
> > -     { "Google", "Lisbon", "0000:00:02.0", "Port B" },
> > +     { "Google", "Lisbon", "0000:00:02.0", { "Port B" } },
> >  };
> >
> >  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> > -                                             const char **conn)
> > +                                             const char * const **conn=
s)
> >  {
> >       int i;
> >
> > @@ -332,7 +335,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(str=
uct device *dev,
> >                       if (!d)
> >                               return ERR_PTR(-EPROBE_DEFER);
> >                       put_device(d);
> > -                     *conn =3D m->conn;
> > +                     *conns =3D m->conns;
> >                       return d;
> >               }
> >       }
> > @@ -346,7 +349,7 @@ static struct device *cros_ec_cec_find_hdmi_dev(str=
uct device *dev,
> >  #else
> >
> >  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> > -                                             const char **conn)
> > +                                             const char * const **conn=
s)
> >  {
> >       return ERR_PTR(-ENODEV);
> >  }
> > @@ -388,7 +391,7 @@ static int cros_ec_cec_get_write_cmd_version(struct=
 cros_ec_cec *cros_ec_cec)
> >  static int cros_ec_cec_init_port(struct device *dev,
> >                                struct cros_ec_cec *cros_ec_cec,
> >                                int port_num, struct device *hdmi_dev,
> > -                              const char *conn)
> > +                              const char * const *conns)
> >  {
> >       struct cros_ec_cec_port *port;
> >       int ret;
> > @@ -406,7 +409,13 @@ static int cros_ec_cec_init_port(struct device *de=
v,
> >       if (IS_ERR(port->adap))
> >               return PTR_ERR(port->adap);
> >
> > -     port->notify =3D cec_notifier_cec_adap_register(hdmi_dev, conn,
> > +     if (!conns[port_num]) {
> > +             dev_err(dev, "no conn for port %d\n", port_num);
> > +             ret =3D -ENODEV;
> > +             goto out_probe_adapter;
> > +     }
> > +
> > +     port->notify =3D cec_notifier_cec_adap_register(hdmi_dev, conns[p=
ort_num],
> >                                                     port->adap);
> >       if (!port->notify) {
> >               ret =3D -ENOMEM;
> > @@ -435,10 +444,10 @@ static int cros_ec_cec_probe(struct platform_devi=
ce *pdev)
> >       struct cros_ec_cec *cros_ec_cec;
> >       struct cros_ec_cec_port *port;
> >       struct device *hdmi_dev;
> > -     const char *conn =3D NULL;
> > +     const char * const *conns =3D NULL;
> >       int ret;
> >
> > -     hdmi_dev =3D cros_ec_cec_find_hdmi_dev(&pdev->dev, &conn);
> > +     hdmi_dev =3D cros_ec_cec_find_hdmi_dev(&pdev->dev, &conns);
> >       if (IS_ERR(hdmi_dev))
> >               return PTR_ERR(hdmi_dev);
> >
> > @@ -460,7 +469,7 @@ static int cros_ec_cec_probe(struct platform_device=
 *pdev)
> >
> >       for (int i =3D 0; i < cros_ec_cec->num_ports; i++) {
> >               ret =3D cros_ec_cec_init_port(&pdev->dev, cros_ec_cec, i,
> > -                                         hdmi_dev, conn);
> > +                                         hdmi_dev, conns);
> >               if (ret)
> >                       goto unregister_ports;
> >       }
>
