Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CA7D33E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjJWLfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjJWLfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:35:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8BDB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:35:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c54c8934abso43970861fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1698060907; x=1698665707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKv/1jMR+An6Sd0wIyrhfjGh0OgkF6whzW/ih74CHzs=;
        b=F9dr2HK/+bAF3Ezlv7Ak3I/z/DHrVbelVXPam5M2NSmKmuQX0swZFcrUyzsCl2g9wn
         oL2AJztSxa2QtvWMZxQuTAH0KuGQXnTpEs9OJpsNyXf1Cr3S2OWgz4T8DRwk+3jKUsGF
         qz3y8AqwQGwSFhs1VUTEGb4Y6U8nqHK1uqFD6FJ0Z+FWsrZnCG5/qGHaPG68NO0dhv0c
         a18mxR8NLWwBXCNA2oIZib843W2p2CHn51wzS+xB0a46buJxbTlABim4oQ6sFqjkuNll
         Xs/GhnZxUEH/LECjoxbnUV5t0AP2U5eDjhJ7RKA5V217VL8HQ18vIihTImQqAA8ynccG
         Hzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698060907; x=1698665707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKv/1jMR+An6Sd0wIyrhfjGh0OgkF6whzW/ih74CHzs=;
        b=MT72LGBzMSE7/IHso3HbOhl9MsVI6PbcjKWlCXypgxZhKKwzeh1+k0e112cl3NdL7c
         Udb0Djx2my6CkSglYdeL+MavEUSQ0lkoT7S5T+TSXAWnOMOuvctdSDFUc4bnVXbYPQhc
         WeDfEazUhSUhT6PbwsR3fkQgCgDCHFe8DqEv3sAV3wSq+U/XBi7uGJESkw5/msNQjTwX
         HVuKvFP4HiXegHk02zGieNZGhxTsPHDtPO5zQ777HqkO9+fKWjQjYAKv5/JH8WLXFJhh
         QKABUbdUZH70Dr/24LycbGp9Jj+cLXtohmMGsN9u6DPBfXcgCCx665djkGFE3GnyxbRr
         v7GQ==
X-Gm-Message-State: AOJu0YzDznW6pCPVCWx9/CLIoIr8X0zIhB2VJf1K5XSBREFzq+U6lCRU
        q9mn04SdYdH9jrp+qTyZab6lEVFli8IaV3UUT3oUT+yfB2eIZeg9Se0=
X-Google-Smtp-Source: AGHT+IE64xqFVniHCfQ3wlMwdoEVGW8KwKdDwb4LQRoc0HO9bOWP71y7YsiCSV5qpB8RkrBYCdnNpGwbBroK6Q7pjcM=
X-Received: by 2002:a2e:9a92:0:b0:2c5:106f:540f with SMTP id
 p18-20020a2e9a92000000b002c5106f540fmr7002887lji.43.1698060906729; Mon, 23
 Oct 2023 04:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697719099.git.dberlin@dberlin.org> <d2ef482bcf01fc515224cd508d730590a5294df2.1697719099.git.dberlin@dberlin.org>
 <CAF4BwTVQf25uCCVovtce+kjz0pFFMZX=Ln36R4Vd-1LEsxrcMw@mail.gmail.com> <bfe4ee3e-a136-a7ed-5fcd-0377c9f35726@broadcom.com>
In-Reply-To: <bfe4ee3e-a136-a7ed-5fcd-0377c9f35726@broadcom.com>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Mon, 23 Oct 2023 07:34:55 -0400
Message-ID: <CAF4BwTWJy7ct0xzAGBX7dGDKS7Y+rB6aHhkEan3+QYvV+OgQzA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [brcmfmac] Fix regulatory domain handling to reset
 bands properly
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 4:38=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 10/21/2023 4:40 PM, Daniel Berlin wrote:
> > As an aside, the alternative would be to simply not ignore any
> > attempts to set the regulatory domain, regardless of whether it's 00
> > or the chip is already set to that country.
> > It doesn't happen that often, so it's not clear it's worth avoiding it =
at all.
> > There are some things i'd have to fix to make it work resiliently well
> > (for example, i know we set the 2g bw cap where we do because it has
> > to be done with the interface down), but i can fix those if needed.
>
> Please do not top post.
>
> The firmware has its own regulatory information (actually the CLM blob
> holds that information) which is independent of the wireless regulatory
> database in the kernel. As such trying to configure country '00' will
> simply fail as it is not known inside CLM blob.
>
> The firmware needs a
> country abbreviation *and* a revision. Hence we require a mapping of
> country code to <abbrev,rev> tuple. If that mapping is not in place we
> bail out setting the country in the regulatory notifier.
>
>  From the description below it is not clear what problem is fixed here
> in terms of user experience.


As far as the stack and kernel are concerned, it gets stuck in the
custom regulatory domain ('99') and sets the max power levels,
bandwidth caps, etc in the capabilities to match.

If you look at the phy info, it will clearly show you this.
You are correct that the chip maintains its own view of power levels
(though most drivers set them, we do not), but the bandwidth caps are
respected, for example.
Note also that '00' is recognized by at least this firmware, though I
agree it depends on whether/what is done in the CLM blob.

All that said, even if it changed nothing in the chip itself, it would
still be displaying completely wrong info to the user.
I'm happy to update the description if that is your main concern.


>
> Regards,
> Arend
>
> > On Thu, Oct 19, 2023 at 10:18=E2=80=AFAM Daniel Berlin <dberlin@dberlin=
.org> wrote:
> >>
> >> Currently, we ignore the default country in the reg notifier.
> >> We also register a custom regulatory domain, which is set
> >> as the default.
> >> As a result, the chip is likely to be set to the correct country,
> >> but the regulatory domain will not match it.
> >>
> >> When the regulatory notifier is then called, we see the countries
> >> are the same and do not change anything, even though the domain
> >> is wrong.
> >>
> >> This patch forces us to reset the bands on the first country change
> >> even if the chip is already set to that country.
> >>
> >> We also restore the original band info before reconstructing channel
> >> info, as the new regdom power limits may be higher than what is
> >> currently set.
> >>
> >> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> >> ---
> >>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 38 +++++++++++++++--=
--
> >>   .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
> >>   2 files changed, 33 insertions(+), 7 deletions(-)
