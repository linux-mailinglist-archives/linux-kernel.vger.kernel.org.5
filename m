Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723FE811049
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377557AbjLMLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjLMLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:38:33 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC4AA5;
        Wed, 13 Dec 2023 03:38:39 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9f7fe6623so86032871fa.3;
        Wed, 13 Dec 2023 03:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702467517; x=1703072317; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=erM8V8RgO6KRLO/yh7jID1/baZLh+uPtPuh+atBa3V8=;
        b=nhwUp3kwWdijRB46PbhVx0WQfR69/iV7strFztaFgKqOZ06Ok3IFKHeLOgvUIqm0Fg
         YdDF/uOGsJzL/SocLsI/78wLKhNMAQrLjxa4sW6rbFapEhRbKJ9MVROSzhPmB5Dvd/Cl
         YGs/AHfGIRcoaGyAT75K0yXxVcL7ovj3z7WXwQqR7wsir9GnHFH3smfMhrYsAgKQ00mH
         II7rCOZHJ9lwYNI8VSVmcU1L2TfhhO40Yl6gEUkLiU8PIhaH58LiQeAcqdJ4Xr9nvNrl
         s9+FxNjPGkLllRmh6WU51sL3GAbXYW2lxkh928fxUAPbWZFPGZ028cR1FTuVS5Cgmvhm
         jp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702467517; x=1703072317;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erM8V8RgO6KRLO/yh7jID1/baZLh+uPtPuh+atBa3V8=;
        b=N333lWZ4bUkQGK5MU16ZmMDPkA2XqI23RhXlwimSlbJqe9zbX6gpGkuAFr3l4jXBJ6
         H2eSlX3aYRGDACKTtNqTkjYOunaSdk3/Lf8WT9lNN8oSJNzbCRsDqXkNrN/Hyi36aLiy
         8PKH20LAa0eoS6mOhigjJlKU2YC3mpc/0ZEj9eGbiMq9/By1wiBI/4mk3j7FfvwdEaTl
         DBXdY8F80I9sw3zM9WJIl6UoHooIv20J7Ux47VERU+oAdiP6op8uieX8pEAxY7SlXvvu
         tgT2hYAprUKWs3Nr8tOMW8W1dqVQG48zBFkSBlLJ8d/Bn2u+XWH+qwPhAVAwRBgCPn0a
         72fA==
X-Gm-Message-State: AOJu0YxGaeIhjHdr11xMFOfVKyTJI8LbOV9r6sc7jvl5X5kyAhmIFV05
        ymki4tbODHRCMfXKO4Ve2FY=
X-Google-Smtp-Source: AGHT+IGrw7mppJSoNS7Dsgtj7c74Wvr4sERgMIvNl5Jx450IZ2/p127Sh3s8TK2qiUjKMuJrmp211w==
X-Received: by 2002:a2e:330e:0:b0:2ca:226:423b with SMTP id d14-20020a2e330e000000b002ca0226423bmr2342385ljc.48.1702467517050;
        Wed, 13 Dec 2023 03:38:37 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q6-20020a2e2a06000000b002c9e9c29670sm1767204ljq.47.2023.12.13.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 03:38:36 -0800 (PST)
Date:   Wed, 13 Dec 2023 13:38:25 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Joakim Bech <joakim.bech@linaro.org>
Cc:     Simon Ser <contact@emersion.fr>, Yong Wu <yong.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        ckoenig.leichtzumerken@gmail.com, linaro-mm-sig@lists.linaro.org,
        linux-mediatek@lists.infradead.org, tjmercier@google.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] dma-buf: heaps: Add secure heap
Message-ID: <20231213133825.0a329864@eldfell>
In-Reply-To: <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
        <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
        <20231213110517.6ce36aca@eldfell>
        <20231213101549.lioqfzjxcvmqxqu3@pop-os.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xTcL2+m+K.KNDg_qGM9LG9u";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xTcL2+m+K.KNDg_qGM9LG9u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Dec 2023 11:15:49 +0100
Joakim Bech <joakim.bech@linaro.org> wrote:

> On Wed, Dec 13, 2023 at 11:05:17AM +0200, Pekka Paalanen wrote:
> > On Tue, 12 Dec 2023 16:36:35 +0000
> > Simon Ser <contact@emersion.fr> wrote:
> >  =20
> > > Is there a chance to pick a better name than "secure" here?
> > >=20
> > > "Secure" is super overloaded, it's not clear at all what it means from
> > > just the name. Something like "restricted" would be an improvement.
> > >  =20
> >=20
> > My thoughts exactly. Every time I see "secure" used for something that
> > either gives you garbage, refuses to work, or crashes your whole machine
> > *intentionally* when you try to do normal usual things to it in
> > userspace (like use it for GL texturing, or try to use KMS writeback), I
> > get an unscratchable itch.
> >=20
> > There is nothing "secure" from security perspective there for end users
> > and developers. It's just inaccessible buffers.
> >=20
> > I've been biting my lip until now, thinking it's too late.
> >  =20
> The characteristics we're looking for here is a buffer where the content
> is inaccessible to the normal OS and user space, i.e., Non-secure EL0 to
> EL2. I.e, the content of the buffer is meant to be used and accessible
> primarily by the secure side and other devices that has been granted

s/secure side/proprietary side/

I presume nothing of the other side can ever be in any way open?

Maybe the other side is even less secure than the FOSS side...

> access to it (for example decoders, display controllers if we're talking
> about video use cases). However, since the use cases for this exercises
> the whole stack, from non-secure user space (EL0) all the way to secure
> user space (S-EL0), with various devices needing access to the buffer at
> various times, it makes sense to let Linux manage the buffers, although
> it still cannot access the content. That's the overall context.

Yes, we know all this (except for the exact meaning of EL0 etc.).

> As for the name, it's always difficult to find a name suitable precisely
> describing what it is. "Secure" is perhaps vague, but it might still a
> good choice, if you carefully describe what secure means for this
> particular heap (in the source code and the documentation for it). For

Carefully describe, as in, re-define.

> example, the definition of "secure" for a secure heap as here could mean
> that buffer content is inaccessible to the host OS and user space
> running in normal world (using Arm nomenclature). I wouldn't have any
> problems with calling it secure if, as said it's defined what we mean by
> saying so. But I'm all ears for other suggestions as well.
>=20
> Safe, protected, shielded, unreachable, isolated, inaccessible,
> unaccessible, fortified, ... would any of these make more sense?

"Restricted" sounds like a good compromise to me. The buffers' usage is
severely restricted.

It is the opposite of "safe", because accessing the contents the wrong
way can return garbage or intentionally crash the whole system,
depending on the hardware implementation. One example is attempting to
put such a buffer on a KMS plane while the connector HDCP state is not
high enough, or a writeback connector is connected to the CRTC. It is
really fragile. (Do KMS drivers fail an atomic commit that would
violate the heap rules? Somehow I doubt that, who'd even know what the
rules are.)

It is protected/shielded/fortified from all the kernel and userspace,
but a more familiar word to describe that is inaccessible.
"Inaccessible buffer" per se OTOH sounds like a useless concept.

It is not secure, because it does not involve security in any way. In
fact, given it's so fragile, I'd classify it as mildly opposite of
secure, as e.g. clients of a Wayland compositor can potentially DoS the
compositor with it by simply sending such a dmabuf. Or DoS the whole
system.

"Poisonous heap" would be fitting but politically inappropriate I
guess. After all, "poison" is data that is not meant to be read by
anything normal.


Thanks,
pq

--Sig_/xTcL2+m+K.KNDg_qGM9LG9u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmV5l7EACgkQI1/ltBGq
qqd21w/7B5AOlcm0BJvZ+kXMgngEgshf4OR5HVOLoGtC3uQwgQJLmIotDzGjaXnM
YNpvxE7i3jgF/MvfUynt58CspSm4fcgJzP5fjqD5zTAQ7BH2PFxnyl8Ko1AemP1A
yauV0Fco65ZDgsZRGCxZeCI60vtceCYPECULnQSC67w2ToHsdQsgaSH2DnTmNPgZ
TSqV553NtqYEc4U1XcfN0kwwwG7l3B5k7Fv57eEcLbpYjHhVHDc2Lbr138SWn7fx
APC3vIZGlAKGPSDwHCApb/xA9SiCprT1nxKtqsPnYON3OWeivPqd8w3ehdaHGI93
d5F6GM6c7XyTxSpde5H9UueQROreZB1JOrF81Pw4u3dJ0NMYjludA64BBnbDx4u7
HDPQDMMtpq2Gvg+FosmzYa3Pf1laWztXyqcjhrvr9W7FPvzDOvnA8Jt05jgRYHBO
Fi+ghVDeIkuiv3Yk5Ien7FStcO6OKjSeRErZvR3Cqu1ZdTZOd7+Pg7eZe+bdNtsN
lEaSLNF8x9hRQjBE3hsP9El2dcOIZbvxElDhczpHy+mEfHyf4wp6slc8be+dFiwq
b/kHVXxALVcRSBoa7E26WS0zcXgE0CyHkFAoMI/E6S2Ijxxf1UIGwTQyVzaUQ/V4
5FZEBlGLow3ax7wAl+aXTOAubzc4cm+LI17q6TbeRqcL9y0EBcU=
=P1qu
-----END PGP SIGNATURE-----

--Sig_/xTcL2+m+K.KNDg_qGM9LG9u--
