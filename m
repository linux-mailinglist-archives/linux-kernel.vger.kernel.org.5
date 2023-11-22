Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3439D7F50E7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjKVTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjKVTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:50:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495412A;
        Wed, 22 Nov 2023 11:50:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c320a821c4so179704b3a.2;
        Wed, 22 Nov 2023 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700682616; x=1701287416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZASW/NxUIZqXUUKRYMqyvVP2D1QPoNwHA+TLUkJHq+s=;
        b=HI+TVzPgRDhSV9Ef0sB94mOwHfFnsG1yd2m13Xh0UQG1+gY2FGAoG0vmbnc4f6gSJb
         iwDs/Rpu5Z0Ux/A+iLrju/8beD4kZYjTVD01epCVSEXOppNpAGfIKYaylG7Heoq++BJo
         uFswI+WQtIgES9I/Fy867Llab5OW5PgUC3JxG6qHb2bYkWph/Rh+l9tQGZtxxsHP7N1F
         F7qtuu++yipJ+Gdm6q0PN6zf1kJj4f0+e6d8vYNxDHubS4WXBOkuEZ66Wv+6tG17XvOb
         /qfJbUGNXQy+yUANMd+5k4ntO2/X49Uayy0IlZmju7xjIaw14cxiFOETKFDeQG1LkEz6
         kS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700682616; x=1701287416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZASW/NxUIZqXUUKRYMqyvVP2D1QPoNwHA+TLUkJHq+s=;
        b=bhYwxQ16Q5legBae+rj2iWec6zMMnt+2BaxOWWbdygrM1i5A/DQeZPBRtfFrMGD77v
         NeFFDWbma6pEEs7LwPBgHu2q2bKZyH757OJN76xbHpu1Vc/7kxdQO2hqaKbeCMvL4xm9
         ynRI3xzstOHGmDaohmFJAS+1tDWhh18QsnB5sGs8EM0MrPbsAcfUi0Jpjbw3+lhERHDF
         OivY3CfegT4ctADMVly+GLNqLWVEZjx0p6AtPZYiB5OGiUv9D+u8deopoCh8NoR9Wv6g
         +0mcYXwES6UavOjRVCD9AvlOK20vxZUyrEKIrqIfHXcJToUlON7tSpISY6/2yDZ33bF/
         H6Lw==
X-Gm-Message-State: AOJu0YzjsczV4l6WNeiyHDbUp1J2L41lJmYz5eWJ5DN4NEqJ6uATyYTp
        NIjwXfp0std/Jy92BrOTGgtWi4KilhrF54Pv6Wc=
X-Google-Smtp-Source: AGHT+IGhK+5RIplC3qKoGFpL3ax4qOXBwNweP+RamoTthupEv3WfObOKZwZqSzWqPovFvxpcGSh7nsOpkLLt5Vz9jE4=
X-Received: by 2002:a05:6a20:914f:b0:18a:d8a3:d56c with SMTP id
 x15-20020a056a20914f00b0018ad8a3d56cmr3444086pzc.57.1700682615709; Wed, 22
 Nov 2023 11:50:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Nov 2023 11:50:15 -0800
From:   Amit Dhingra <mechanicalamit@gmail.com>
References: <20231105143932.3722920-2-u.kleine-koenig@pengutronix.de>
 <233689d7-9409-406b-9383-49f10cd29336@web.de> <CAO=gReGA17gHSr4ftN1Jwrjt5t76oAgaL6+n6X4wD0osJnuq4g@mail.gmail.com>
 <53db2c8f-7b9b-47f7-89ba-d78584c12d7b@web.de> <20231121075716.it3cpwhwymkaqjrh@pengutronix.de>
 <3e4c0c06-9681-43df-be12-b2bbc599fdfb@web.de> <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20231121083246.wg5qtej6cll3snlg@pengutronix.de>
Date:   Wed, 22 Nov 2023 11:50:15 -0800
Message-ID: <CAO=gReH0DaqXn-AJK904rwKmnFaB9UsO=UoaOGDPR_YB5d=guQ@mail.gmail.com>
Subject: Re: spi: cadence-xspi: Drop useless assignment to NULL
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Markus Elfring <Markus.Elfring@web.de>, kernel@pengutronix.de,
        kernel-janitors@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:32:46AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> They are syntactically fine as they don't change the semantic of the
> code. But assignments to NULL (and still more to 0) also serve the human
> reader as documentation.

Agree on the face that explicit assignment in most cases is good documentat=
ion
and is done on purpose by the author. I believe most of the assignments
fall in that category.

There are a few(a dozen or so) that seem to assign all members to NULL.
These can be good candidates for simplification and might be the easy
ones. A few examples below.

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c..39fcccec53ee 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -274,10 +274,6 @@ static int s5p_mfc_ctx_ready(struct s5p_mfc_ctx *ctx)
}

static const struct s5p_mfc_codec_ops decoder_codec_ops =3D {
- .pre_seq_start =3D NULL,
- .post_seq_start =3D NULL,
- .pre_frame_start =3D NULL,
- .post_frame_start =3D NULL,
};

diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.=
c
index 26c385582c3b..f4e71a5a8f84 100644
--- a/arch/microblaze/kernel/timer.c
+++ b/arch/microblaze/kernel/timer.c
@@ -190,7 +190,6 @@ static u64 xilinx_read(struct clocksource *cs)
}

static struct timecounter xilinx_tc =3D {
- .cc =3D NULL,
};

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 739298d2dff3..8c2ccd33bf2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -500,8 +500,6 @@ static uint32_t dce_aux_configure_timeout(struct
ddc_service *ddc,
}

static struct dce_aux_funcs aux_functions =3D {
- .configure_timeout =3D NULL,
- .destroy =3D NULL,
};

diff --git a/drivers/media/i2c/lm3560.c b/drivers/media/i2c/lm3560.c
index 05283ac68f2d..0bf25cead4c4 100644
--- a/drivers/media/i2c/lm3560.c
+++ b/drivers/media/i2c/lm3560.c
@@ -337,7 +337,6 @@ static int lm3560_init_controls(struct lm3560_flash *fl=
ash,

/bin /boot /dev /etc /home /lib /lib64 /mnt /opt /proc /root /run
/sbin /srv /sys /tmp /usr /var initialize device bin/ build/ develop/
go/ mytmp/ notmuchmail/ oldbuild/ smatch_stuff/
static const struct v4l2_subdev_ops lm3560_ops =3D {
- .core =3D NULL,
};

diff --git a include/linux/qed/qed_ll2_if.h b/include/linux/qed/qed_ll2_if.=
h
index 5b67cd03276e..f4f8b66b5d36 100644
--- a/include/linux/qed/qed_ll2_if.h
+++ b/include/linux/qed/qed_ll2_if.h
@@ -268,11 +268,6 @@ int qed_ll2_alloc_if(struct qed_dev *);
void qed_ll2_dealloc_if(struct qed_dev *);
#else
static const struct qed_ll2_ops qed_ll2_ops_pass =3D {
- .start =3D NULL,
- .stop =3D NULL,
- .start_xmit =3D NULL,
- .register_cb_ops =3D NULL,
- .get_stats =3D NULL,
};

- Amit
