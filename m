Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61307655D1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjG0OUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjG0OUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:20:39 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8810110CB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:20:38 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a3efee1d44so835718b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1690467638; x=1691072438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mC/8dT0tbAgVPKUdoYex0WCuu0voI4R5OMKo5aDOKZM=;
        b=Oele9AnG3ahVCgEL7oOMUC6ZgJCO0eufkr86ZMpvFvAuohGbxNOE6LC7Ripx/UoCk5
         gv2dkZy06BpAnsyABkfNUizbH3hNqGJgp5tK56pN9unGXH9kg+TM2d4W4+TQZr4bfbWB
         b5AJk4OTF5H0S+TzViJR2ob0AkxdCo+X2jCc6gp4Js/dRRb1ECRrm2sILEBYcFZNRVfK
         Y6aTwdWoW2xzc5P5j/mgukYsnRWijhbxe3UrlkIHvqreSyJdVepbthR2ZF1vcN51bjlT
         aGmnACLfdRUONpRmap0i2ZLgPPk0DcCtUAdtmXJKQNXaqigtG75Hagq4G5bZUR9pAzGz
         QFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690467638; x=1691072438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mC/8dT0tbAgVPKUdoYex0WCuu0voI4R5OMKo5aDOKZM=;
        b=mF+lSFxHaAWSInXRrI/MC3+sEweC3CcWN8sVmGScAmEdw/1hUXT+kmvrVwMLBcPh6t
         7L5lMusIZY2yhIzsLhDj+9pzjCbt+90hzQR5U0nTYSX1stT48Q/p6dTDof+c0Pa8Mu0d
         IIRclLGWWBnBZCsG1sKKQ/jDbsj17pfqMC7v4oQVRZjyhYNVicExP4bci2RFaOWNkvLy
         qc2SbhyZ3rNg0SyGiHvrLS6olQhvLLDzXl+6tW8bZv75EPjMdtDTYNhBi7T6Nl9oi71l
         7/uXPn+btEZpx6+WkYG1L1DguMxQ3HkR6qZJLD9y0EoQc8qhSIK/FZZ4GXR3as9DI82H
         IRLg==
X-Gm-Message-State: ABy/qLZn2bP1KwzjVrNo85dvJ4iecVyUM2hw7WUnggnQO28XYcKbLlGY
        MwO3CqspaMvGLTMTtX11HRzwwg==
X-Google-Smtp-Source: APBJJlFERWkt+8NnUJfszQzEUSanMHktHMuKfMAKA6dmMjeCPBSe0dzn0I3d/DlYO4abwGOj1HeEYQ==
X-Received: by 2002:a05:6808:2085:b0:3a3:7245:d36c with SMTP id s5-20020a056808208500b003a37245d36cmr3468249oiw.43.1690467637836;
        Thu, 27 Jul 2023 07:20:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:580::7a9])
        by smtp.gmail.com with ESMTPSA id t13-20020ac8530d000000b004033992e2dbsm449569qtn.45.2023.07.27.07.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:20:02 -0700 (PDT)
Message-ID: <51e4ece5250c3345dae4956fbb4d4dbb5ffdde38.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: imagination: Add E5010 JPEG Encoder driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, eugen.hristev@collabora.com,
        ezequiel@vanguardiasur.com.ar, u.kleine-koenig@pengutronix.de,
        sakari.ailus@linux.intel.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
        p-mantena@ti.com, vijayp@ti.com
Date:   Thu, 27 Jul 2023 10:19:29 -0400
In-Reply-To: <ef4825d6-1016-cbf2-0cd3-94b0fc4165f4@linaro.org>
References: <20230727112546.2201995-1-devarsht@ti.com>
         <20230727112546.2201995-3-devarsht@ti.com>
         <ef4825d6-1016-cbf2-0cd3-94b0fc4165f4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le jeudi 27 juillet 2023 =C3=A0 14:13 +0200, Krzysztof Kozlowski a =C3=A9cr=
it=C2=A0:
> On 27/07/2023 13:25, Devarsh Thakkar wrote:
> ...
>=20
> > +
> > +static int e5010_release(struct file *file)
> > +{
> > +	struct e5010_dev *dev =3D video_drvdata(file);
> > +	struct e5010_context *ctx =3D file->private_data;
> > +
> > +	dprintk(dev, 1, "Releasing instance: 0x%p, m2m_ctx: 0x%p\n", ctx, ctx=
->fh.m2m_ctx);
>=20
> Why do you print pointers? Looks like code is buggy and you still keep
> debugging it.

Its relatively common practice in linux-media to leave a certain level of t=
races
to help future debugging if a bug is seen. These uses v4l2 debug helper, an=
d are
only going to print if users enable them through the associated sysfs
configuration. I do hope though there isn't any issue with IRQ triggering a=
fter
the instance is released, that would be buggy for sure, but I don't think t=
his
is the case considering the level of documented testing that have been done=
.

I'd be happy to see what others have to say on the subject, as its been a
recurrent subject of confrontation lately. With pretty agressive messages
associated with that.

regards,
Nicolas

p.s. does not invalidate the question, since for this driver, there is only=
 ever
going to be one m2m_ctx, so the question "Why do you print pointers?" is
entirely valid I believe.

. . .
