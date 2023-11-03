Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E177E00B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbjKCIzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346459AbjKCIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:55:22 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ACDD46
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 01:55:18 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so25758221fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 01:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699001717; x=1699606517; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KieNi2VRLuqIWbngtceJ+14hQSrE87wAqVWYboYUpn4=;
        b=MM6PDCGIOiwVSjUGZzDlbDYpc2sZ1lpMF9ddFCUhOZAx+fBKY9pekPj3/jQZ3BlpuR
         dcyxwPOr0f9vmHZZS3DZQoTy6671jY0FHawn2h9qkDj/H+UwuSd4+NP5KoK/WXJPICQY
         vVI05+25+qCCDLZaflrb6bv/wBgMo6prOj7/qaiUvQvru0cRAyZJqT9NiuwjNfR7KgF8
         zj2UO1/wJ2J/LYRsqZeIB0JFaGtHv/qvokfeFjEekjbLE53r9j9aHWCRgo61ueyfzFoZ
         PKzkwsL9dSRcHo2yNYg6czOUWqOy17lBLX/45jmExZoJPczoyGRlcW/1By1wJMx85KPw
         4HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699001717; x=1699606517;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KieNi2VRLuqIWbngtceJ+14hQSrE87wAqVWYboYUpn4=;
        b=VxAq1lcqzxuqr+2wfSnpq67fQP2VothjMXdb03jdz1pGF1uS0XPhCNYgD770mNPktK
         2sBHpoFEPrgK+nU4FudmO1376lE32k+eV83IXVoAyPaoNv+yCwzDr9Izi0QU071NmXp5
         T6m2ukn4RgZ/Xtf8+izdrHM5EFklB2fkDnNsxz0UVIGk6tQGiHIzlpC+LsDBNQCLIVSQ
         ODOh4KsMOIu80jn1TotHrHe+5Iz27gPzDZDnyG04gurbLJlPafOa8TBS5gkkU+fTgU5Y
         wnLgjTeYdi+8NinG98T1inhjJzpeFMfBMVjAL5P+J3iTeGwarXPkSciKy9d3reyeWYIf
         zUbg==
X-Gm-Message-State: AOJu0YyVbCF5xvtJCr2clb8ZFB1phpGQjDXtclecFV+h99Ih4mKGC2EG
        TkvIlTNkFpHHX6FV89Gh6JA5TQ==
X-Google-Smtp-Source: AGHT+IEYRvVYkfBTF/mOXtwir2LnzxGG4Rje2WMX1tbKT95meecl682m7l7wZoe8w7hwACwzCgDjfg==
X-Received: by 2002:a2e:ba88:0:b0:2c5:18a9:620b with SMTP id a8-20020a2eba88000000b002c518a9620bmr13056346ljf.23.1699001716954;
        Fri, 03 Nov 2023 01:55:16 -0700 (PDT)
Received: from localhost ([2a01:e0a:448:76e0:d676:8e27:951e:9cf2])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c1c9900b004067e905f44sm1784917wms.9.2023.11.03.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 01:55:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 03 Nov 2023 09:55:15 +0100
Message-Id: <CWP1UD343WSC.32F81J6ROV2YO@burritosblues>
Subject: Re: [PATCH v8] rtc: tps6594: Add driver for TPS6594 RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>, <u-kumar1@ti.com>
X-Mailer: aerc 0.14.0
References: <20231102132616.1130960-1-eblanc@baylibre.com>
 <CAHp75VdvR0H7XVLWGqdZqSgoHprUUPQHGiyWEEaHjTgEbeinqQ@mail.gmail.com>
 <CWOGMAUT9MKY.2IBKELIOR1CF7@burritosblues>
 <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
In-Reply-To: <CAHp75VdV5A+WpWj2eY9o_2wwPB7GTi6Eig7YyV8urdv1P3utgQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 2, 2023 at 5:46 PM CET, Andy Shevchenko wrote:
> On Thu, Nov 2, 2023 at 6:17=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com=
> wrote:
> > On Thu Nov 2, 2023 at 5:00 PM CET, Andy Shevchenko wrote:
> > > On Thu, Nov 2, 2023 at 3:26=E2=80=AFPM Esteban Blanc <eblanc@baylibre=
.com> wrote:
> > >
> > > > Notes:
> > > >     This patch was picked from a series since there is no dependenc=
y between
> > > >     the two patches.
> > >
> > > Not sure if RTC maintainer uses the b4 tool, but as I said in previou=
s
> > > email for pinctrl change, there is no need to resend. b4 has an
> > > ability to select patches from the series to be applied.
> >
> > Oh that's good to know, I was not aware of that.
> > I resent it because there was some minor nits that I fixed on both
> > patches.
>
> Ah, that was not reflected in the changelog...

Just after the line you quoted, there is "Changes since v7". Maybe I
should have put it near the other ones. Sorry about that.

Best regards,

--=20
Esteban Blanc
BayLibre
