Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872937E0CE6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 01:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjKDAq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 20:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjKDAq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 20:46:57 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E3DC;
        Fri,  3 Nov 2023 17:46:54 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-581edcde26cso1466211eaf.1;
        Fri, 03 Nov 2023 17:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699058813; x=1699663613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTmKPjcRZJist4lZxNa147OmNAqZvh+S7QiW2Uxgbjc=;
        b=l/dZ/prZDhu5ZxCaaK7MNEriHndlLxBzIiyqrY7Jm6den9u/gkHd/CYcSKCXfsBZem
         G5SrJgz8IkB+4oZI1WluKt+q6apq7piq4I8ctndPtg3S/ieWSSFHfRKNR1prZp/lyMYB
         jKwptS2iPA2rpl9TReQ986WuZsto27iEYzJIvBdL626mcVEp5rndRFHeVMohmNln2XLl
         p1XRS4BsNAuwoiP6WTpQfkJriVYQqKwqgd0cSwbySCkFzO7I4shV9yATG33v+DIpfHR1
         4bv3OQhrG7LLgRlXolp43CQnGKnRpaO+fhum3E2CqX2Lpg2vj3XhCoi1Wa0DwGJJ58JY
         7nZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699058813; x=1699663613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTmKPjcRZJist4lZxNa147OmNAqZvh+S7QiW2Uxgbjc=;
        b=Wily4vMvYS07MQuK2W5auFaoEdIvAdG+1Moy3L9JGFbhY/HyC+xuHJME4hpCBaR/+L
         l5pYh0+lf/LH+uR3Ogmw3gK0Fb80TrzPc5gxHVySPfzFu5R0UaTA1l+8VWG57gbneFi0
         1ZsScq9oyqZE0tdQnDT/c51u7MR5Vz2GIi/5iGoteK5q1KXN2pcGipGWjkEQ4Aoo0Epg
         sVKRHSylnR9sYQAPnC2EsIgAnZ1OM7pZDglCZqfpCY1/BZ58wW4RVrUceFWNFCNpEjkx
         MVvgrLd0OQYE1vZYV2VJbU6Fn/x/FTLl3L+0plfI9o4/xUcKabtmZQmdhcu8uGcRTm9L
         fdQQ==
X-Gm-Message-State: AOJu0Yw8u0iFlFrnJ8JOQOcmSPyb+Jtvn5/Mwcj88jdz0dl9sGAIVYVu
        A5srrBSVjLVbgeRA1QaUFUM=
X-Google-Smtp-Source: AGHT+IGIpnRR+mGcX0p/yhWRFfucs3KqPF4qSgw09Em6DZaK6+xYkJkoGOWhuJl8pvFMe36lnCrykQ==
X-Received: by 2002:a05:6358:903:b0:168:dc03:5b90 with SMTP id r3-20020a056358090300b00168dc035b90mr31425074rwi.23.1699058813362;
        Fri, 03 Nov 2023 17:46:53 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a018900b00280469602bcsm2183224pjc.2.2023.11.03.17.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 17:46:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C00A1803A590; Sat,  4 Nov 2023 07:46:48 +0700 (WIB)
Date:   Sat, 4 Nov 2023 07:46:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>, jkosina@suse.cz
Cc:     benjamin.tissoires@redhat.com, davidrevoy@protonmail.com,
        jason.gerecke@wacom.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        nils@nilsfuhler.de, peter.hutterer@who-t.net, ping.cheng@wacom.com
Subject: Re: Requesting your attention and expertise regarding a
 Tablet/Kernel issue
Message-ID: <ZUWUeEYtvpldMTp1@debian.me>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPUkFEtqwjEqRlrq"
Content-Disposition: inline
In-Reply-To: <20231103200524.53930-1-ostapyshyn@sra.uni-hannover.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GPUkFEtqwjEqRlrq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:05:25PM +0100, Illia Ostapyshyn wrote:
> Hello David, Hello Jiri,
>=20
> The XP-Pen hardware reports the Eraser usage for the upper stylus button.
> Generally, styli report Invert usages when erasing, as described in [1].
> XP-Pen digitizers, however, tend to omit them.
>=20
> The generic driver maps the Eraser usage to BTN_TOUCH and the Invert
> usage to BTN_TOOL_RUBBER.  Pens conforming to [1] send the Invert usage
> first (switching the tool to BTN_TOOL_RUBBER) followed by Eraser, which
> appears in userspace as a BTN_TOUCH event with the rubber tool set.
>=20
> Due to an oversight, devices not reporting Invert had the BTN_TOOL_RUBBER
> event masked.  This has caused the kernel to send only BTN_TOUCH events
> without the tool switch when erasing.
>=20
> The situation got worse with refactoring done in 87562fcd1342.  An eraser
> without Invert caused the hidinput_hid_event state machine to get stuck
> with BTN_TOOL_RUBBER internally (due to it being masked).  For the
> userspace, this looked as if the pen was never hovering again, rendering
> it unusable until the next reset.  276e14e6c3 fixes this by adding
> support for digitizers that do not report Invert usages when erasing.
>=20
> ---
>=20
> David, we are sorry that our patch broke your workflow.  However,
> forwarding hardware events *as-is* to the userspace has always been the
> intended behavior, with a kernel bug preventing it so far.  You can still
> remap the eraser button to a right click using xsetwacom:
>=20
> xsetwacom set "UGTABLET 24 inch PenDisplay eraser" "Button" "1" "3"
>=20
> Replace the device name with the corresponding *eraser* device from
> "xsetwacom list devices".  You can also do this with "xinput set-button-m=
ap",
> which works for libinput as well.  We have tested this with several
> XP-Pen devices, including Artist 24.
>=20
> [1] https://learn.microsoft.com/en-us/windows-hardware/design/component-g=
uidelines/windows-pen-states

Thanks for the explanation!

--=20
An old man doll... just what I always wanted! - Clara

--GPUkFEtqwjEqRlrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUWUcwAKCRD2uYlJVVFO
o7foAQD9gE01APXiONGlCkh8yPLpMWJGLXm/0vOpOjVeITU34QEA5B4nwPEHixv4
t6bPBwtMOmcY02/OpcpxAZIdWNIrQQg=
=wMbT
-----END PGP SIGNATURE-----

--GPUkFEtqwjEqRlrq--
