Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7917CAB92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjJPOdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjJPOdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:33:36 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846E9C;
        Mon, 16 Oct 2023 07:33:34 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49dc95be894so1239092e0c.2;
        Mon, 16 Oct 2023 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697466813; x=1698071613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKbVtZEcxrlUrif4l+3ZGL6RWVrOciPsrJ6sBAx6X9g=;
        b=dyiCuyOCHGbTyqoDNvx9FF66mZysg19dfSv/9TM0skI9usZQ260a6FquctHFuzRcr6
         VuKpg2G8Mv25e91as27FjDTGBuk64+OwWKiVb3ATHv4ATuofilYXsD2kaWzOdCtcbSlL
         bnoP5RvyMamsGrK7atcAmJOJ63Hun/wGbl9yXiY8IKzu3qm+pGCz+IifRdJDeHmOqLEc
         ZeOe+04frMnksQ2WEp8S15PW+pIRjTgk8zzIl8z2GON64p886ANu0Kor3k8BCHOLtq75
         A1Yy3bjRpd9gbs+8HbYrya4BFX8ZnLldsFhYnEPrX3OYHh5m+6oXtpchP49/mzDawkL2
         wOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697466813; x=1698071613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKbVtZEcxrlUrif4l+3ZGL6RWVrOciPsrJ6sBAx6X9g=;
        b=m1zWdHx7KBT+Tz9H/np4P7ixswen5t3U7+K95eKdYtYBw4ctNg7rMWyCvJLyUimGYI
         /vK7FpSYhyoUn0esCZXvb6O2WH+zyQ3Xkyl62X7c60Q8gvbLakarAFXh8s3yzFKVvyE2
         Jce7iwyrzysMMnIr4i6EX9SU1VnzLywunShK4GiBRnylL/ztbFY5buQyzuze1j7odLp3
         RG9qmnLxD8aTfR1uAStC2MZxkmsnv3q3Zk4od7QKjfAIa1ziIWxjw2lgxiJ00mhC9ytW
         yJ+s85Uk3TtPb7MQxp+VmKlW8WH8mXZI2o0uzxWJwiVfPjbqmp9ylFMUAIV3e/lQ9t2X
         Noeg==
X-Gm-Message-State: AOJu0YyS3mjq6a5ixiD8UGpXTh2NF/FGNtn0K1tRIMMrK6c2bX3eIYe7
        5J56bJavKK+8LwTO+OJMjhYa2f3qCgSWL1IMDdQ=
X-Google-Smtp-Source: AGHT+IEiHoKuEeEu3QjUpjWt2jSpomVBuxgwgkzSyuPOUSNBkFo7dTBa8GlsonlmQDcbuZLiZgys6QjIfAS9Ef9zdGQ=
X-Received: by 2002:a1f:e2c3:0:b0:496:1f95:209a with SMTP id
 z186-20020a1fe2c3000000b004961f95209amr23134232vkg.15.1697466813052; Mon, 16
 Oct 2023 07:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230913151606.69494-1-romain.perier@gmail.com>
 <20230913151606.69494-2-romain.perier@gmail.com> <2023101521480226f64b51@mail.local>
In-Reply-To: <2023101521480226f64b51@mail.local>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 16 Oct 2023 16:33:22 +0200
Message-ID: <CABgxDoK12ZLbc-js1fFRAtZ3sV--19xu3DhV1aC46DE5R+3n5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rtc: Add support for the SSD202D RTC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim. 15 oct. 2023 =C3=A0 23:48, Alexandre Belloni
<alexandre.belloni@bootlin.com> a =C3=A9crit :
>
> Hello Romain,
>
> Sorry for the very long delay,

Hi,

np,

>
> On 13/09/2023 17:16:04+0200, Romain Perier wrote:
> > +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
> > +MODULE_AUTHOR("Romain Perier <romain.perier@gmail.com>");
> > +MODULE_DESCRIPTION("MStar SSD202D RTC Driver");
> > +MODULE_LICENSE("GPL v2");
>
> checkpatch complains rightfully about GPL v2 here. If you agree, I'll
> change this to simply GPL.

Aah, good catch , yes I agree, it will be simpler.

Thanks,
Regards,
Romain
