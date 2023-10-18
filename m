Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B87CE4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjJRRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjJRRcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:32:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E11BCC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:09 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so87166311fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650148; x=1698254948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z7yiUweEg23BwK7zcSyTWxXFB2LkcpzcFHHPWHt2IQ=;
        b=vYhMbNyulohFq9QOPd2x9cJOdUVEhe8ID+eudIovN4H2IYpqjm9Vt3pUzshFlb0JOz
         lWJaBjSDh08k5AYafNbasXLjTDAmXNaqpQ20RtVjyud3EzH9RymZADIotwEIIEZodBcN
         NocCFZY+emoOcgGOhmxa23Uz5Ws8dVJ3Q8tfBW71rnjPztQZ3fnYdzCa1RR4qYheE95l
         TeeJHZWcjNThIS669/b8Xsqw/+H6ZqcP4saubh8o6SKiBKvgtB8O8m405BUNak5ecNFf
         /G4L1kmT941P6Ci6AWvr/mBjG4JIC+FIdboXMdk9hOaU2rh8VHIL27xigEiDY8TRefrT
         aUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650148; x=1698254948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z7yiUweEg23BwK7zcSyTWxXFB2LkcpzcFHHPWHt2IQ=;
        b=vd/L9v0UAfL1qZ+BLSFumfnLz9LfT7/0LmtnnmZQdO3yMw0Th9k+blWt6YgHZSC/xB
         Qq8Jh1mkKlLeBK7SL6gxGxKgnmvVF6gbg0X8xi50mtEnYavzZWZ2GSCRapdEhegv6t+y
         YwRpatyUrS0jz479GexBNvtCoMQ4wS3T8c690P/H8v0Rig+p0AgSd0tpQ9CBuTN7Z7YK
         US1l5asdxwZ21DKgclZI+V/N1tc2KzUthp4YdvfA/JTzlzeYltv/zHlAMeK47E0A0RQv
         HdnX4KLFAtrFDvoAsrlnZhSqPois/Hvq7V3Sg4NhqbAq+pKMeSjRVoSFhLXTv13oOxwG
         nn1g==
X-Gm-Message-State: AOJu0YyQpodPiwNZPvJeSo2+MgWKSh4IgJl+CEFIuCe0V4n5UCwLJpMR
        O94Am2+1Ybr+22h9+JrKtmELkEY4BY6byTkbrV3h9P5L0SFUush4
X-Google-Smtp-Source: AGHT+IGo8MWu21Tet2EOfE5+wEjwJOt2gHO9Cv9qIsNHDtqKivVuDg+TfiVa/BHwF8TahWAz+g7w3WQIL7DGU1ZQdrY=
X-Received: by 2002:a2e:a7ca:0:b0:2b9:ee3e:2412 with SMTP id
 x10-20020a2ea7ca000000b002b9ee3e2412mr6279909ljp.22.1697650147521; Wed, 18
 Oct 2023 10:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-13-cleger@rivosinc.com>
In-Reply-To: <20231017131456.2053396-13-cleger@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:28:31 -0700
Message-ID: <CALs-HstrnSM981utJD8tUdjwTc+rLTP9Eiep8A8Pbx29Gz4Xdg@mail.gmail.com>
Subject: Re: [PATCH v2 12/19] riscv: hwprobe: export Zhintntl ISA extension
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 6:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Export Zihintntl extension[1] through hwprobe.
>
> Link: https://drive.google.com/file/d/13_wsN8YmRfH8YWysFyTX-DjTkCnBd9hj/v=
iew [1]
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>
