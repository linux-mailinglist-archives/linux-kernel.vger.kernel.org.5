Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF476E454
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjHCJ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjHCJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:28:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C51702
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:28:49 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583d63ca1e9so7913547b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1691054928; x=1691659728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPf/DhBfYOXvHBKonH2IymFP4pV5nyzM2qqAWXWq22A=;
        b=nvRhlx3RKrMSDt0Zuc+myu9tFV2g0lK7zhUf5+vgZoGn04BXuqG2K4hQzoOyzZVdT9
         2crnCI2OM7vbmiQbRXPS5TqxCO2VUOfR2SJXWMpJc3kYMB1mhi2iJWxTuWK/8B1EAbhv
         l3fy+treICAr4vKN0PWbxMCyspG1oeVBlww6JTdpwRZaswn9FVMXc1Lxah9zUYEm0aIc
         p1/sxFrBm4W7dqN+NnIMGSx+Sr3iTy6DiuagqT4+fqxYxwkrSMJ5Sa4iUMoErrtGUcyW
         KzdXSTU4VPNWj/2xvu3G+2I4qiDHYYvsbj+SJU5amUBbn3AY7IixJmDZq/Ak2IGSvxwF
         Gh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054928; x=1691659728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPf/DhBfYOXvHBKonH2IymFP4pV5nyzM2qqAWXWq22A=;
        b=hiTJjdqAQzGTPoM9rpvHdTz9THX9tXlsHkSAXzZfGT6I2FA6qlRZv5ztdCfex49OaH
         AssM992SRJuBYJgUxCDpXnNN6fWxkPVBkVRbUif90pzBhrl9z4P6S+U9EzOxiXRyH18I
         da3goeiyD7yS9ziCVCKsRFzMa/c39okUN68PwDOaOGFrjhloPi3DczmfE7KGZ+5elqIi
         l5jEV1vonaAZCFhzBzRP3kyt5DIrb4Pm0w+X+WuIWJEcd7u/uA21/029NSD/rojnINqP
         S0yl+djBtudtgpaDrRXUa354dtbj/KYSt/8RBrYyXRm19wt7OLicECjy8mV9KGSm1kHb
         JExw==
X-Gm-Message-State: ABy/qLYqJ6wTfuYsHYQuH0spkYPoMg4dsj8/rd8P2pVHV5jcA9h5KsW5
        KayANvEKYh/w7/AC4ifVMBJ/2I2RtPOHNGIQgSYK+OgKlqA+iSmSbWI=
X-Google-Smtp-Source: APBJJlFp3C9muFBq6D0MrZecgIa2l1jTs2IKHm59WpOG88pYICmMaCXa10IkEqz/8+2ECNYlmZL4zUSVMdMAzlJFvhA=
X-Received: by 2002:a81:9242:0:b0:583:9c78:9a84 with SMTP id
 j63-20020a819242000000b005839c789a84mr17812965ywg.43.1691054928381; Thu, 03
 Aug 2023 02:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230803085734.340-1-nylon.chen@sifive.com> <20230803085734.340-2-nylon.chen@sifive.com>
 <20230803-avenge-vaporizer-8258cd3ed423@wendy>
In-Reply-To: <20230803-avenge-vaporizer-8258cd3ed423@wendy>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Thu, 3 Aug 2023 17:28:37 +0800
Message-ID: <CAHh=Yk8Y0VFcSKVGTREcQtHVTyyha93k8N5FsYG970Gg=JeijQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] riscv: dts: sifive: unleashed/unmatched: Remove
 PWM controlled LED's active-low properties
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        pavel@ucw.cz, vincent.chen@sifive.com,
        emil.renner.berthing@canonical.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor@kernel.org, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

I apologize for forgetting about this update earlier. Just now,
I tried to pull rebase master and noticed that other developers seem
to have made some fixes to the algorithm. Upon closer inspection, I
found that they addressed the part we previously discussed with Emil
and Uwe, such as "first pwm_apply_state."

Therefore, my instinct tells me that they have already taken care of
the issues we discussed before.

I will review the conflicting parts in the pwm-sifive.c code in my v4
version once again to ensure there are no omissions. If I find any, I
will submit v5 accordingly.

Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2023=E5=B9=B48=E6=9C=88=
3=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:19=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, Aug 03, 2023 at 04:57:34PM +0800, Nylon Chen wrote:
> > This removes the active-low properties of the PWM-controlled LEDs in
> > the HiFive Unmatched device tree.
> >
> > The reference is hifive-unleashed-a00.pdf[0] and hifive-unmatched-schem=
atics-v3.pdf[1].
> >
> > Link: https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-7bf8=
453f8698_hifive-unleashed-a00-schematics-1.pdf [0]
> > Link: https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-e68c=
e76f4192_hifive-unmatched-schematics-v3.pdf [1]
> >
>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Since there is no PWM driver patch for this to go along with, this ack
> doesn't mean anything anymore. Please drop it if you resubmit.
>
