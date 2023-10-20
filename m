Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C6B7D1546
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbjJTR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjJTR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:56:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF12D5D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:56:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-778940531dbso63101085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1697824586; x=1698429386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hbkkUKQ9rVszrJk3+DYjUAAjOhmB5UW1peE3XGvWZbw=;
        b=xwKCNyp097moqUXYegtMUiyYDgkyioHFs+NeuTuGCTHpteVlhwhmbaqTJLgW230r8u
         bot0rT1uhokkkS8+99aynJ6FXpPHGZsiZXYu44z20w+afgLW+X5UqT0MmnmPuKpg5WTu
         3HKYxiWqDYTLxxCineIRKCu4wVNuetsmaEfCDPkehmyciWgq0cwmMoU4/9cGcMSjXC/3
         /nFFz2SyMABUHU1r/6J/MNP1AXU0IN5trSs8/OZjCZffO/+W9N98I+hlyqnJUm4kdoQZ
         IKg6tJF5VaPVtpDkfJSPmDWGy+lo8wLmQrcKakBNaQeouro1VRCYSelCV9kU1rK3SHaq
         Nrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824586; x=1698429386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hbkkUKQ9rVszrJk3+DYjUAAjOhmB5UW1peE3XGvWZbw=;
        b=J2+QqdkPYnpTg0yUaxOmlS4+8P1gtoGqg/9lcAsKAQsyLVV4y5KGtI3ATN0Vrsm0OQ
         S2AUa68dGOKxWBKccajhXpgNvjfMPdBT21mgWKafYwSz9ZiuhKPvUhbSKpqtn7NsgQnm
         FZ4ZcTK3rZPnNxlPUlOfSaLdl9/Ra4pvrx2qzhH+Cfti/JmAI6yVn9J1WYad3mZCWu9w
         I6hRpXz6gdf9YjuYZwN0KxFOdyV7+AwAfN5yIhub6Yx/S+mj30BoKV+Gr1o92V9eJwJ9
         H3Cio0m8G9dvBT7hYKwf6/nZnBivELYHqpEhXr7SXhB0nTCziOPreThRbll0moXa8MT9
         FKBA==
X-Gm-Message-State: AOJu0YzwHXI1SiUoxx2KggWIGB0FjvRedKLw0LFNRL7xL5R34pO82niD
        7eKx/XX2p/cZez5cHGhNfpY1BaPv2CRVFeIS6e4=
X-Google-Smtp-Source: AGHT+IH5Tt4h+q22iOzKEQi1leENzRlNyYmJoxaEV8glb2XUtndT8bKzXZppV16rc1iDSjFYl98nnw==
X-Received: by 2002:a05:6214:2129:b0:66d:6705:5c50 with SMTP id r9-20020a056214212900b0066d67055c50mr2972282qvc.44.1697824585741;
        Fri, 20 Oct 2023 10:56:25 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6dc0::580])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cfc49000000b0066d11c1f578sm854225qvp.97.2023.10.20.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:56:25 -0700 (PDT)
Message-ID: <437e4ea0c2c2681c1b333ad109f8f02fc229537f.camel@ndufresne.ca>
Subject: Re: V4L2 Encoders Pre-Processing Support Questions
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Oct 2023 13:56:23 -0400
In-Reply-To: <ZTD5TXND4R7JqvCD@aptenodytes>
References: <ZTD5TXND4R7JqvCD@aptenodytes>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Le jeudi 19 octobre 2023 =C3=A0 11:39 +0200, Paul Kocialkowski a =C3=A9crit=
=C2=A0:
> Hello,
>=20
> While working on the Allwinner Video Engine H.264 encoder, I found that i=
t has
> some pre-processing capabilities. This includes things like chroma
> down-sampling, colorspace conversion and scaling.

Similar with Hantro H1.

>=20
> For example this means that you can feed the encoder with YUV 4:2:2 data =
and
> it will downsample it to 4:2:0 since that's the only thing the hardware c=
an do.
> It can also happen when e.g. providing RGB source pictures which will be
> converted to YUV 4:2:0 internally.
>=20
> I was wondering how all of this is dealt with currently and whether this =
should
> be a topic of attention. As far as I can see there is currently no practi=
cal way
> for userspace to know that such downsampling will take place, although th=
is is
> useful to know.

Userspace already know that the driver will be downsample through the selec=
ted
profile. The only issue would be if a users want to force a profile with 42=
2
support, but have its  422 data downsampled anyway. This is legal in the sp=
ec,
but I'd question myself if its worth supporting.

>=20
> Would it make sense to have an additional media entity between the source=
 video
> node and the encoder proc and have the actual pixel format configured in =
that
> link (this would still be a video-centric device so userspace would not b=
e
> expected to configure that link). But then what if the hardware can eithe=
r
> down-sample or keep the provided sub-sampling? How would userspace indica=
te
> which behavior to select? It is maybe not great to let userspace configur=
e the
> pads when this is a video-node-centric driver.
>=20
> Perhaps this could be a control or the driver could decide to pick the le=
ast
> destructive sub-sampling available based on the selected codec profile
> (but this is still a guess that may not match the use case). With a contr=
ol
> we probably don't need an extra media entity.

Yes, for the cases not covered by the profile, I'd consider a control to fo=
rce
downsampling. A menu, so we can use the available menu items to get enumera=
te
what is supported.

>=20
> Another topic is scaling. We can generally support scaling by allowing a
> different size for the coded queue after configuring the picture queue.
> However there would be some interaction with the selection rectangle, whi=
ch is
> used to set the cropping rectangle from the *source*. So the driver will =
need
> to take this rectangle and scale it to match with the coded size.
>=20
> The main inconsistency here is that the rectangle would no longer corresp=
ond to
> what will be set in the bitstream, nor would the destination size since i=
t does
> not count the cropping rectangle by definition. It might be more sensible=
 to
> have the selection rectangle operate on the coded/destination queue inste=
ad,
> but things are already specified to be the other way round.
>=20
> Maybe a selection rectangle could be introduced for the coded queue too, =
which
> would generally be propagated from the picture-side one, except in the ca=
se of
> scaling where it would be used to clarify the actual final size (coded si=
ze
> taking the cropping in account). It this case the source selection rectan=
gle
> would be understood as an actual source crop (may not be supported by har=
dware)
> instead of an indication for the codec metadata crop fields. And the code=
d
> queue dimensions would need to take in account this source cropping, whic=
h is
> kinda contradictory with the current semantics. Perhaps we could define t=
hat
> the source crop rectangle should be entirely ignored when scaling is used=
,
> which would simplify things (although we lose the ability to support sour=
ce
> cropping if the hardware can do it).

Yes, we should use selection on both queue (fortunately there is a v4l2_buf=
_type
in that API). Otherwise we cannot model all the scaling and cropping option=
s.
What the spec must do is define the configuration sequence, so that a
negotiation is possible. We need a convention regarding the order, so that =
there
is a way to converge with the driver, and also to conclude if the driver ca=
nnot
handle it.

>=20
> If operating on the source selection rectangle only (no second rectangle =
on the
> coded queue) some cases would be impossible to reach, for instance going =
from
> some aligned dimensions to unaligned ones (e.g. 1280x720 source scaled to
> 1920x1088 and we want the codec cropping fields to indicate 1920x1080).
>=20
> Anyway just wanted to check if people have already thought about these to=
pics,
> but I'm mostly thinking out loud and I'm of course not saying we need to =
solve
> these problems now.

We might find extra corner case by implementing the spec, but I think the A=
PI we
have makes most of this possible already. Remember that we have fwht sw cod=
ec in
kernel for the purpose of developing this kind of feature. A simple bob sca=
ler
can be added for testing scaling.

>=20
> Sorry again for the long email, I hope the points I'm making are somewhat
> understandable.
>=20
> Cheers,
>=20
> Paul
>=20

regards,
Nicolas

