Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982BD79B5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378075AbjIKWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237665AbjIKNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:06:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2316E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:06:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fb2e9ebcdso951596b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1694437612; x=1695042412; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UC0qFPbWeIAnNY2crnDoiyfH4L4DNcPUzmyIOiPmNaw=;
        b=Nc6pxsYSDhU2XR53fLm2q5bivwl1huFVoTDg52/c4uVC1Q4RiQ9q9g2QPkMnMqN1GQ
         GEfauhXqPUBDQrQ7zcalT/yhOgzL0HpEKL9zCTmpcfSuu/mP/88A2Y+RUrkrAIJKwBc4
         NdR2ope/qfoBVlSMEoY1fdLB6yMzojnmYkS6EVoWtMlj3v6aghj8Rz3ZUWCtI/yVuVvi
         BjkLg7tWsdLgdn/dNFG2F/WTdDXNneYDwtjYBl28sHRtlEGrN+1J/w+dAkLMwUVPOG2W
         oWFcmsPw0V6g9Jg2VMirRPPxKVtm+ieF5yM5hy9zQB6QQ6quIRxLhND/+xRnaX7QaIJm
         cPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437612; x=1695042412;
        h=to:references:message-id:content-transfer-encoding:reply-to:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UC0qFPbWeIAnNY2crnDoiyfH4L4DNcPUzmyIOiPmNaw=;
        b=bw6VKZPRdfoqu5237k9hYIJrZW9EAyofxvUQXq87ohkObv3kH3AGrPlks+wy0av9Dk
         RBsvzao9r2ywv+WZcuoXKyQcO2Nf993kf+MrUPGu4yl3r3A0pC8U4KttxnCnSPsBzfDV
         k6vm1QQRSzHyh7FelZxTl14bt+sLKzf/RJOL2QpKUvJAsEFMmUOGzAOqcvL+n45WxWMj
         KYnSRDY8kvgzdYV2es8PTPVunCqezujvhMZsT1Z41drsTt3kDR1Cl3lL4PHsiG0XzCZX
         THAuljGW319rupUrvYCuno8k6A2mWN9glQ5E8vOiEvkxqvJvg1dV80jA7p/9PV/HiD0j
         gHEQ==
X-Gm-Message-State: AOJu0YxpevclDbSI9qJiwuYS5BCpKe6Twr/rGJGyI9nvozr1ZNHCF1Gx
        yIMucGGJyYuuvVhxoCTKsgspCQ==
X-Google-Smtp-Source: AGHT+IHHHsd8mK5/qRvQGb/rxDKfPMV90hFOs3PpoPszjaiqIs9Gy83oAs6eYTFLtxvjaV6gsb9LYA==
X-Received: by 2002:a05:6a00:22c2:b0:68e:2c3a:8775 with SMTP id f2-20020a056a0022c200b0068e2c3a8775mr9544336pfj.33.1694437612188;
        Mon, 11 Sep 2023 06:06:52 -0700 (PDT)
Received: from ?IPv6:2402:7500:4dc:9c7e:4872:7ce3:318e:18f5? ([2402:7500:4dc:9c7e:4872:7ce3:318e:18f5])
        by smtp.gmail.com with ESMTPSA id s21-20020a62e715000000b0068991abe1desm5787400pfh.176.2023.09.11.06.06.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:06:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v4 10/12] RISC-V: crypto: add Zvkned accelerated AES
 encryption implementation
From:   Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20230721054036.GD847@sol.localdomain>
Date:   Mon, 11 Sep 2023 21:06:47 +0800
Cc:     Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Reply-To: 20230721054036.GD847@sol.localdomain
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCA32056-CCE2-4FB5-8CFC-62444CDDA89F@sifive.com>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-11-heiko@sntech.de>
 <20230721054036.GD847@sol.localdomain>
To:     Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21, 2023, at 13:40, Eric Biggers <ebiggers@kernel.org> wrote:

> I'm looking forward to having direct support for these AES modes, =
especially the
> modes needed for storage encryption: XTS, and CBC or CTS!  None of =
these AES
> modes is actually implemented in this patch yet, though, so they can't =
be
> claimed in the kconfig help text yet.  This patch is just a starting =
point, as
> it just adds support for the bare AES block cipher ("aes" in the =
crypto API).
>=20
> (BTW, I'm much more interested in, say, AES-XTS support than SM4 =
support, which
> this patchset does include.  SM4 is a "national pride cipher" which is =
somewhat
> of a niche thing.  I suppose there are already people pushing it for =
RISC-V
> though, as they are everywhere else, so that's to be expected...)
>=20

We have further optimization for RISC-V platform in OpenSSL PR[1]. It =
will include
AES with CBC, CTR, and XTS mode. Comparing to the generic AES =
implementation,
the specialized AES-XTS one have about 3X performance improvement using
OpenSSL benchmark tool. If OpenSSL accepts that PR, we will create the
corresponding patch for Linux kernel.

[1]
https://github.com/openssl/openssl/pull/21923

-Jerry
