Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DB97EA131
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjKMQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:21:52 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295BC6;
        Mon, 13 Nov 2023 08:21:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32df66c691dso2691418f8f.3;
        Mon, 13 Nov 2023 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699892507; x=1700497307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6isXPs0sflYE9m4fOOkPNOo14+5QhUVptrDTcdlr+qo=;
        b=C+se6vbBk2dshH1TYDc0XuOWG6yLbjM3QelxHtAsN6ztcQEbuBoLBVlefAcvDEEuuB
         P0LhbBP80oN5uCjMg9cEDAklHxeBeyXs6GK2KdgxEie/jMpUv24cXxaFgJeozw1MsewG
         nks3tmzqOUrKMZH0UCn7pBqjo1vrJNsDee/WvYwErCf9ID2jRSyFom4QfHAGSfjiEKE6
         WLC6pdn9HXNQMIdYYnlxhIC50OCx6Q5IYJDeFY4WG98DRWv80t9SPXPMN8TGehIkRyqk
         5OF8zFB4+LXowP8d4HGtLi5Ci3GkJzsgmrVBR2KLWab7FjkPvxyC0krHAL36mKJWdDoq
         OTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699892507; x=1700497307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6isXPs0sflYE9m4fOOkPNOo14+5QhUVptrDTcdlr+qo=;
        b=Ea4Z6c50tbPYBE21BjG/1w+m3UqnB2CjQ4EZ39Asi5e4cahkfE0qBtTzXv8VeGkJmp
         KgiuPEQeUWUpi8q5zSwG6mnhxmEyk41efFE5IM3D0S2BOoCxxTozXjMytR2/A941Af/l
         jg7613GxfPivA3TgsNgCUDXnPOjFq61ZW2W88uinM70hv7GccTNCiAVAGBKfz3Ewjjcf
         hos92PWslH+bZdBH+xEVZvkIv51v9ObbTTVR9MPWUJkGmeEIIoTTAhiZxW9Q6Ct3dBxH
         USFu5sxat8BXSBmwa2TZWxTg7M4kovBXNm4hE7wEVJMgA2XCV8TxEdphZHfZh98NLRyE
         ioAw==
X-Gm-Message-State: AOJu0Yzl6TONMxZJvWfh+UpN2FgqUcCkcXngC9Zq6J7PE8vRMsVHDWFH
        WwEV0/CPalsY1R1deqwgAB9O/ryCua+di1CKFTI=
X-Google-Smtp-Source: AGHT+IGH5cy4DsubHL/XylXgpUblwWeL3F6iuwanO8ohcoJVAu0Bwf3MZeyChqUcj8ZiHZaht5eLzm3V9SNQ3bWEDPg=
X-Received: by 2002:adf:e64b:0:b0:32d:b551:3fb8 with SMTP id
 b11-20020adfe64b000000b0032db5513fb8mr3662969wrn.62.1699892507347; Mon, 13
 Nov 2023 08:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
 <20231113160751.620810-1-debug.penguin32@gmail.com> <ZVJLhbvXSbmnEfwb@smile.fi.intel.com>
In-Reply-To: <ZVJLhbvXSbmnEfwb@smile.fi.intel.com>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Tue, 14 Nov 2023 02:21:35 +1000
Message-ID: <CALk6Uxo-Ojc8U7b5wDUJMA-uY1MeXqLBRXSrt6YeSwMnRkhy1w@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 2:15=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 14, 2023 at 02:07:49AM +1000, Ronald Monthero wrote:
>
> I'm not sure if it's a dup email of the previously sent v2. In any case I=
 have
> commented on v1 and v2, please consider addressing them.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Andy jfyi, the 2 emails of v2 are the same except that the latter has
the stable tag, which was missed.
I will address the review comments and send it.

BR,
Ron
