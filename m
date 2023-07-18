Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528377581E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGRQR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjGRQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:17:23 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78206F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:17:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7653bd3ff2fso653446385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689697040; x=1692289040;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwQeZoCBMlO2Kz9cPAUDfovWZN7cjEESeJtt2btWvEY=;
        b=1eHilmKEnyQiqMv8Vo6ArdJMQyWDT7b5OrKeph5FOePQbpe27HYRND4s5PxjJHb3Kr
         38sAu73YLvSHdWxzirJ/UstU9D8ql+FldVj0SKZKp/37WDKdxik44GTIYjWdKG0PGP0i
         vq5WzVx88Rntfu3uUOGGvzXvQlZB7zLcAMcut4prXI+nYCVfHpR/VC0CHm4ziLuXX8Jn
         bf0/jQDMSfgH2dJ+RxbT545sPQF3lw8V+802mi/tuVrqphVtkDeuZWQIyFn2yojo3+Db
         NMmP+5DRKJ/CCanbcR1RdiunIQhPdEj21G4RBJ87j3uD+lK8zxf3u/qW5nqDSJDNxzyD
         WF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689697040; x=1692289040;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwQeZoCBMlO2Kz9cPAUDfovWZN7cjEESeJtt2btWvEY=;
        b=dWoijmBsIot9zRPT/d1cXfhxoXOYi6o3zw7ea1qPD1H1fsQq+7dUzcFkAcUNjNNuX/
         yQMunAMAWFJbdczqbPPnWmT36Wf+yeW8YHlYSquukM3T+1+S/Er9DTQvhT5WujvXnVMY
         MVBkVmvSa5EyN63+xot4jyV7pK3UrSI5Vw0qeOSkqdIsmRyWWOz/Y4ZTo2I+jg9D08L4
         p2trnS0RZYypesAMlSAlxpq5xDerB+xqCdM8WCgc0vQc2VAfqfgNH7IHjnRPyG5OuuMJ
         fBhaTTzepZMUvBXwjg9k6MVx3K4bAbgxN/p7HWaucMOKBbKSbYnNdzI5awj6jPWgVx62
         17jg==
X-Gm-Message-State: ABy/qLY0FpUPDn2VBRcxg6LwRwtbuwol4yM5+uhO89o5Ma9pdxTClZJ6
        PrSRgPEhrZO75j4YHVE+uUZA1w==
X-Google-Smtp-Source: APBJJlFsoKY+woHCMzwvV5W1Cu/3Q5IgoeL9FXNymEogOTKOX+kJMULHzkNOLRYSjMUd7VRENccOJQ==
X-Received: by 2002:a05:620a:4001:b0:767:f50e:533 with SMTP id h1-20020a05620a400100b00767f50e0533mr21123926qko.77.1689697040616;
        Tue, 18 Jul 2023 09:17:20 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:83d4::7a9])
        by smtp.gmail.com with ESMTPSA id pe8-20020a05620a850800b00767502e8601sm704062qkn.35.2023.07.18.09.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:17:20 -0700 (PDT)
Message-ID: <f8ed402ba1afb88e9e90925333b2e593ba42900e.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH] media: amphion: fix some issues reported by
 coverity
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Jul 2023 12:17:19 -0400
In-Reply-To: <DB8PR04MB6346BDF7F2E00FC8DBB32CB7E738A@DB8PR04MB6346.eurprd04.prod.outlook.com>
References: <20230717074006.22372-1-ming.qian@nxp.com>
         <a40c81a39de214c756a36fde535bfc775d82b922.camel@ndufresne.ca>
         <DB8PR04MB6346BDF7F2E00FC8DBB32CB7E738A@DB8PR04MB6346.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 juillet 2023 =C3=A0 01:50 +0000, Ming Qian a =C3=A9crit=C2=A0:
> > > diff --git a/drivers/media/platform/amphion/venc.c
> > > b/drivers/media/platform/amphion/venc.c
> > > index 58480e2755ec..4eb57d793a9c 100644
> > > --- a/drivers/media/platform/amphion/venc.c
> > > +++ b/drivers/media/platform/amphion/venc.c
> > > @@ -268,7 +268,7 @@ static int venc_g_parm(struct file *file, void
> > > *fh, struct v4l2_streamparm *parm=C2=A0 {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vpu_inst *inst =3D to_ins=
t(file);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct venc_t *venc =3D inst->pr=
iv;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_fract *timeperframe =3D &parm->=
parm.capture.timeperframe;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct v4l2_fract *timeperframe;
> >=20
> > Could be just me, but I feel I'm missing some context to understand why=
 this
> > change. Perhaps the commit message could be improved ?
> >=20
> > All other changes looks like improvement to me, so with a good explanat=
ion
> > on this one (and the change seems to be equivalent), you can add:
> >=20
> > Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> >=20
>=20
> Hi Nicolas,
> =C2=A0=C2=A0=C2=A0 The Coverity scan report a REVERSE_INULL issue here, t=
hat directly dereferencing pointer "param", before Null-checking "parm".=
=20
> =C2=A0=C2=A0=C2=A0 I'll split this patch into several patches, one topic =
one patch.
>=20
> Ming

Make sense now, looking forward a split version with more explanation.

regards,
Nicolas

