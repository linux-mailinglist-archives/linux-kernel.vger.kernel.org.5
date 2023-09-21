Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188C97A96A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIURJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjIURJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:17 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA259E5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-79dc081ab8dso46899639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695315891; x=1695920691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wcs3HzZ31G3yJHKvNS30Y61xFRSAlRNAEiq/xuG55A=;
        b=CHheC4oZFjvmGq/GtbH/XAONBWYAtgXCJdTIMrl/8FbvHCWaTCw393qehQjkYYS1fG
         JXg7+aDAu3m40kYu/GqJgT+FjY8qJyP2HGKC4G+vBJLOd5Pu3PuSKPQuOBjTDFINnxYZ
         n/J5236LehRZDR5wqxYVUZeODwiW8LrnqYOz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315891; x=1695920691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3wcs3HzZ31G3yJHKvNS30Y61xFRSAlRNAEiq/xuG55A=;
        b=kYKbBMomheUXG1xtUF9u9bXcsNKPF+6ZDEk1DYnvogEpt1WJ2v/v3bejL0shmTHQoj
         2tjPX89gBNxAw7F9xs73uRT4gGtq48XUOfJrNu7CLmmoOBSTLsxUppn9cytizDMgQQr6
         IyTdFjW5Bhz6y6rpqV23RnYNFwr9DQx+EJEf18NvE25At2ltwyel2M5DMfq6nzCRnHGZ
         7nsJLsy0yyWaTLtqHf8w2mfdh5qrLdEkuHujnv0qXhf0Yofpd2pTUYsJjrK4Gr8Q5q6d
         X0ygLI5SgX9qEUtxR/BSLokNfJ/YwkbeeCEV6WnbXUKHVuA1LhLOZ1zZ22h7pVUGb78L
         ju4g==
X-Gm-Message-State: AOJu0YyN3u2n+uiFJmM0R5vBnuejebnTzjo0ael0dyj0VWSLOe1i9VrQ
        Ya/CMIlvjHGr/H808a4rhOC+lOzPeP+Mv/IQF2E=
X-Google-Smtp-Source: AGHT+IE+KoubEPVAyC6ZhfyogTyjtsFMyuD7rSPY8oqheDH6XOnLZh4JB3LXin4OgzQj2SOoyOc3uw==
X-Received: by 2002:ac8:5881:0:b0:417:9ee1:800e with SMTP id t1-20020ac85881000000b004179ee1800emr4815211qta.37.1695267867253;
        Wed, 20 Sep 2023 20:44:27 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id bx13-20020a05622a090d00b00417da5a5edesm258236qtb.19.2023.09.20.20.44.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 20:44:23 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-415155b2796so147911cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 20:44:23 -0700 (PDT)
X-Received: by 2002:a05:622a:11c5:b0:403:fdf1:e05e with SMTP id
 n5-20020a05622a11c500b00403fdf1e05emr100304qtk.19.1695267863107; Wed, 20 Sep
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230829053201.423261-1-brpol@chromium.org> <20230829053201.423261-8-brpol@chromium.org>
 <393d65d0-8886-6663-5521-ba495d711750@collabora.com>
In-Reply-To: <393d65d0-8886-6663-5521-ba495d711750@collabora.com>
From:   Brandon Ross Pollack <brpol@chromium.org>
Date:   Thu, 21 Sep 2023 12:44:10 +0900
X-Gmail-Original-Message-ID: <CALWYx-ZSe0MO7Lhp=DVG3LNUU5ZnDWA1PjOL1nWm6n-Aj8TYkg@mail.gmail.com>
Message-ID: <CALWYx-ZSe0MO7Lhp=DVG3LNUU5ZnDWA1PjOL1nWm6n-Aj8TYkg@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/vkms Add hotplug support via configfs to VKMS.
To:     Helen Koike <helen.koike@collabora.com>
Cc:     marius.vlad@collabora.com, mairacanal@riseup.net,
        jshargo@chromium.org, hamohammed.sa@gmail.com,
        rodrigosiqueiramelo@gmail.com, linux-doc@vger.kernel.org,
        hirono@chromium.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, melissa.srw@gmail.com,
        mduggan@chromium.org, mripard@kernel.org, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, these tests are actually running in the chromeOS infrastructure
environment!  A similar test can be written in IGT (and I think is in
the other chain that Marius published)

On Thu, Sep 21, 2023 at 3:03=E2=80=AFAM Helen Koike <helen.koike@collabora.=
com> wrote:
>
> Hello!
>
> Thanks for the patch.
>
> On 29/08/2023 02:30, Brandon Pollack wrote:
> > This change adds the ability to read or write a "1" or a "0" to the
> > newly added "connected" attribute of a connector in the vkms entry in
> > configfs.
> >
> > A write will trigger a call to drm_kms_helper_hotplug_event, causing a
> > hotplug uevent.
> >
> > With this we can write virtualized multidisplay tests that involve
> > hotplugging displays (eg recompositing windows when a monitor is turned
> > off).
>
> Are these tests going to be added in igt?
>
> I was just wondering if it requires any special thing for drm ci:
>
> https://lists.freedesktop.org/archives/dri-devel/2023-September/423719.ht=
ml
>
> (btw, it would be awesome of you could test your changes with drm ci :)
>
> Regards,
> Helen
>
> >
> > Signed-off-by: Brandon Pollack <brpol@chromium.org>
> > ---
> >   Documentation/gpu/vkms.rst           |  2 +-
> >   drivers/gpu/drm/vkms/vkms_configfs.c | 68 ++++++++++++++++++++++++++-=
-
> >   drivers/gpu/drm/vkms/vkms_drv.h      | 11 +++++
> >   drivers/gpu/drm/vkms/vkms_output.c   | 47 ++++++++++++++++++-
> >   4 files changed, 123 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> > index c3875bf66dba..7f715097539c 100644
> > --- a/Documentation/gpu/vkms.rst
> > +++ b/Documentation/gpu/vkms.rst
> > @@ -145,7 +145,7 @@ We want to be able to manipulate vkms instances wit=
hout having to reload the
> >   module. Such configuration can be added as extensions to vkms's Confi=
gFS
> >   support. Use-cases:
> >
> > -- Hotplug/hotremove connectors on the fly (to be able to test DP MST h=
andling
> > +- Hotremove connectors on the fly (to be able to test DP MST handling
> >     of compositors).
> >
> >   - Change output configuration: Plug/unplug screens, change EDID, allo=
w changing
> > diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkm=
s/vkms_configfs.c
> > index bc35dcc47585..d231e28101ae 100644
> > --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> > +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0+
> >
> > +#include "drm/drm_probe_helper.h"
> >   #include <linux/configfs.h>
> >   #include <linux/mutex.h>
> >   #include <linux/platform_device.h>
> > @@ -40,6 +41,7 @@
> >    *   `-- vkms
> >    *       `-- test
> >    *           |-- connectors
> > + *                `-- connected
> >    *           |-- crtcs
> >    *           |-- encoders
> >    *           |-- planes
> > @@ -89,6 +91,14 @@
> >    *
> >    *   echo 1 > /config/vkms/test/enabled
> >    *
> > + * By default no display is "connected" so to connect a connector you'=
ll also
> > + * have to write 1 to a connectors "connected" attribute::
> > + *
> > + *   echo 1 > /config/vkms/test/connectors/connector/connected
> > + *
> > + * One can verify that this is worked using the `modetest` utility or =
the
> > + * equivalent for your platform.
> > + *
> >    * When you're done with the virtual device, you can clean up the dev=
ice like
> >    * so::
> >    *
> > @@ -236,7 +246,58 @@ static void add_possible_encoders(struct config_gr=
oup *parent,
> >
> >   /*  Connector item, e.g. /config/vkms/device/connectors/ID */
> >
> > +static ssize_t connector_connected_show(struct config_item *item, char=
 *buf)
> > +{
> > +     struct vkms_config_connector *connector =3D
> > +             item_to_config_connector(item);
> > +     struct vkms_configfs *configfs =3D connector_item_to_configfs(ite=
m);
> > +     bool connected =3D false;
> > +
> > +     mutex_lock(&configfs->lock);
> > +     connected =3D connector->connected;
> > +     mutex_unlock(&configfs->lock);
> > +
> > +     return sprintf(buf, "%d\n", connected);
> > +}
> > +
> > +static ssize_t connector_connected_store(struct config_item *item,
> > +                                      const char *buf, size_t len)
> > +{
> > +     struct vkms_config_connector *connector =3D
> > +             item_to_config_connector(item);
> > +     struct vkms_configfs *configfs =3D connector_item_to_configfs(ite=
m);
> > +     int val, ret;
> > +
> > +     ret =3D kstrtouint(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (val !=3D 1 && val !=3D 0)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&configfs->lock);
> > +     connector->connected =3D val;
> > +     if (!connector->connector) {
> > +             pr_info("VKMS Device %s is not yet enabled, connector wil=
l be enabled on start",
> > +                     configfs->device_group.cg_item.ci_name);
> > +     }
> > +     mutex_unlock(&configfs->lock);
> > +
> > +     if (connector->connector)
> > +             drm_kms_helper_hotplug_event(connector->connector->dev);
> > +
> > +     return len;
> > +}
> > +
> > +CONFIGFS_ATTR(connector_, connected);
> > +
> > +static struct configfs_attribute *connector_attrs[] =3D {
> > +     &connector_attr_connected,
> > +     NULL,
> > +};
> > +
> >   static struct config_item_type connector_type =3D {
> > +     .ct_attrs =3D connector_attrs,
> >       .ct_owner =3D THIS_MODULE,
> >   };
> >
> > @@ -264,7 +325,7 @@ static ssize_t plane_type_show(struct config_item *=
item, char *buf)
> >       plane_type =3D plane->type;
> >       mutex_unlock(&configfs->lock);
> >
> > -     return sprintf(buf, "%u", plane_type);
> > +     return sprintf(buf, "%u\n", plane_type);
> >   }
> >
> >   static ssize_t plane_type_store(struct config_item *item, const char =
*buf,
> > @@ -319,6 +380,7 @@ static struct config_group *connectors_group_make(s=
truct config_group *group,
> >                                   &connector_type);
> >       add_possible_encoders(&connector->config_group,
> >                             &connector->possible_encoders.group);
> > +     connector->connected =3D false;
> >
> >       return &connector->config_group;
> >   }
> > @@ -500,7 +562,7 @@ static ssize_t device_enabled_show(struct config_it=
em *item, char *buf)
> >       is_enabled =3D configfs->vkms_device !=3D NULL;
> >       mutex_unlock(&configfs->lock);
> >
> > -     return sprintf(buf, "%d", is_enabled);
> > +     return sprintf(buf, "%d\n", is_enabled);
> >   }
> >
> >   static ssize_t device_enabled_store(struct config_item *item, const c=
har *buf,
> > @@ -557,7 +619,7 @@ static ssize_t device_id_show(struct config_item *i=
tem, char *buf)
> >
> >       mutex_unlock(&configfs->lock);
> >
> > -     return sprintf(buf, "%d", id);
> > +     return sprintf(buf, "%d\n", id);
> >   }
> >
> >   CONFIGFS_ATTR_RO(device_, id);
> > diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkm=
s_drv.h
> > index 2b9545ada9c2..5336281f397e 100644
> > --- a/drivers/gpu/drm/vkms/vkms_drv.h
> > +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> > @@ -3,6 +3,7 @@
> >   #ifndef _VKMS_DRV_H_
> >   #define _VKMS_DRV_H_
> >
> > +#include "drm/drm_connector.h"
> >   #include <linux/configfs.h>
> >   #include <linux/hrtimer.h>
> >
> > @@ -147,7 +148,9 @@ struct vkms_config_links {
> >
> >   struct vkms_config_connector {
> >       struct config_group config_group;
> > +     struct drm_connector *connector;
> >       struct vkms_config_links possible_encoders;
> > +     bool connected;
> >   };
> >
> >   struct vkms_config_crtc {
> > @@ -220,6 +223,10 @@ struct vkms_device {
> >   #define item_to_configfs(item) \
> >       container_of(to_config_group(item), struct vkms_configfs, device_=
group)
> >
> > +#define connector_item_to_configfs(item)                              =
       \
> > +     container_of(to_config_group(item->ci_parent), struct vkms_config=
fs, \
> > +                  connectors_group)
> > +
> >   #define item_to_config_connector(item)                               =
     \
> >       container_of(to_config_group(item), struct vkms_config_connector,=
 \
> >                    config_group)
> > @@ -279,4 +286,8 @@ int vkms_enable_writeback_connector(struct vkms_dev=
ice *vkmsdev,
> >   int vkms_init_configfs(void);
> >   void vkms_unregister_configfs(void);
> >
> > +/* Connector hotplugging */
> > +enum drm_connector_status vkms_connector_detect(struct drm_connector *=
connector,
> > +                                             bool force);
> > +
> >   #endif /* _VKMS_DRV_H_ */
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index 0ee1f3f4a305..1a1cd0202c5f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -1,5 +1,6 @@
> >   // SPDX-License-Identifier: GPL-2.0+
> >
> > +#include <drm/drm_print.h>
> >   #include <drm/drm_atomic_helper.h>
> >   #include <drm/drm_connector.h>
> >   #include <drm/drm_crtc.h>
> > @@ -8,10 +9,12 @@
> >   #include <drm/drm_plane.h>
> >   #include <drm/drm_probe_helper.h>
> >   #include <drm/drm_simple_kms_helper.h>
> > +#include <linux/printk.h>
> >
> >   #include "vkms_drv.h"
> >
> >   static const struct drm_connector_funcs vkms_connector_funcs =3D {
> > +     .detect =3D vkms_connector_detect,
> >       .fill_modes =3D drm_helper_probe_single_connector_modes,
> >       .destroy =3D drm_connector_cleanup,
> >       .reset =3D drm_atomic_helper_connector_reset,
> > @@ -19,6 +22,48 @@ static const struct drm_connector_funcs vkms_connect=
or_funcs =3D {
> >       .atomic_destroy_state =3D drm_atomic_helper_connector_destroy_sta=
te,
> >   };
> >
> > +static const struct vkms_config_connector *
> > +find_config_for_connector(struct drm_connector *connector)
> > +{
> > +     struct vkms_device *vkms =3D drm_device_to_vkms_device(connector-=
>dev);
> > +     struct vkms_configfs *configfs =3D vkms->configfs;
> > +     struct config_item *item;
> > +
> > +     if (!configfs) {
> > +             pr_info("Default connector has no configfs entry");
> > +             return NULL;
> > +     }
> > +
> > +     list_for_each_entry(item, &configfs->connectors_group.cg_children=
,
> > +                         ci_entry) {
> > +             struct vkms_config_connector *config_connector =3D
> > +                     item_to_config_connector(item);
> > +             if (config_connector->connector =3D=3D connector)
> > +                     return config_connector;
> > +     }
> > +
> > +     pr_warn("Could not find config to match connector %s, but configf=
s was initialized",
> > +             connector->name);
> > +
> > +     return NULL;
> > +}
> > +
> > +enum drm_connector_status vkms_connector_detect(struct drm_connector *=
connector,
> > +                                             bool force)
> > +{
> > +     enum drm_connector_status status =3D connector_status_connected;
> > +     const struct vkms_config_connector *config_connector =3D
> > +             find_config_for_connector(connector);
> > +
> > +     if (!config_connector)
> > +             return connector_status_connected;
> > +
> > +     if (!config_connector->connected)
> > +             status =3D connector_status_disconnected;
> > +
> > +     return status;
> > +}
> > +
> >   static const struct drm_encoder_funcs vkms_encoder_funcs =3D {
> >       .destroy =3D drm_encoder_cleanup,
> >   };
> > @@ -280,12 +325,12 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> >               struct vkms_config_connector *config_connector =3D
> >                       item_to_config_connector(item);
> >               struct drm_connector *connector =3D vkms_connector_init(v=
kmsdev);
> > -
> >               if (IS_ERR(connector)) {
> >                       DRM_ERROR("Failed to init connector from config: =
%s",
> >                                 item->ci_name);
> >                       return PTR_ERR(connector);
> >               }
> > +             config_connector->connector =3D connector;
> >
> >               for (int j =3D 0; j < output->num_encoders; j++) {
> >                       struct encoder_map *encoder =3D &encoder_map[j];
