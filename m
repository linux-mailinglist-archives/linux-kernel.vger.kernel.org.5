Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC277B0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjHNFLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjHNFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:11:24 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3FE5B;
        Sun, 13 Aug 2023 22:11:24 -0700 (PDT)
Date:   Mon, 14 Aug 2023 05:11:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1691989881; x=1692249081;
        bh=dMXTRVAdHOzOWl3TQzLt+EUoA1USWn39sDFBE+YdmV4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=KmKjhD2qGGj2E4PnnW9rgLop+39tITGW29AJtDZKt1ZXye3KQ4Ty/Euo519lQddyq
         stQdsXuVyzdhYIBR5Zl056PuJs2uV5V46cmUVsLT5NR6bcP6FWAKIATxcQUHyRoMYl
         Cif3hkmfz0Q3g79bmtJ5dUpyZfFe0np9gzm839S+mHZPLrnNiZA9geCcFpDyJhfr43
         w2xt5Vm6xf7cpDS9WIUIXG/wjxtCiNFmy72nurPUDMJ+fVWCDHQn2B9d9yDCEjkOFp
         ENHJD0c9DixoqAz4r9nzLEjWE3Z3AuJ28cBF9Xj9UXm2e4r//yJ/WNc+g1HQYGcYbe
         dwbgxAA3nNIkg==
To:     Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: Add "Hailuck" to the list of non-apple apple keyboards
Message-ID: <874jl2tdi3.fsf@protonmail.com>
In-Reply-To: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu>
References: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Aug, 2023 13:29:31 -0700 "Nils Tonnaett" <ntonnatt@ccrma.Stanfor=
d.EDU> wrote:
> Powzan keyboards KB750 and KB770 identify as
> "Hailuck Co.,Ltd USB Keyboard". Adding "Hailuck" to the list
> of non-apple apple keyboards fixes function keys for these models.
>
> Signed-off-by: Nils Tonnaett <ntonnatt@ccrma.stanford.edu>
> ---

You will likely want to resubmit this patch using "HID: apple:" in
place of "hid:" in the commit message subject.

  https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/drivers/h=
id/hid-apple.c

>  drivers/hid/hid-apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index d7b932925730..6664f90cecaf 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -343,7 +343,8 @@ static const struct apple_non_apple_keyboard non_appl=
e_keyboards[] =3D {
>  =09{ "SONiX USB DEVICE" },
>  =09{ "Keychron" },
>  =09{ "AONE" },
> -=09{ "GANSS" }
> +=09{ "GANSS" },
> +=09{ "Hailuck" }

This isn't a must, but maybe it makes sense to comma terminate the last
member in this array specifically if you will be resubmitting this
change as a v2. This way, future keyboards added will only touch one
line in the patch rather than two.

>  };
>
>  static bool apple_is_non_apple_keyboard(struct hid_device *hdev)

--
Thanks,

Rahul Rameshbabu

