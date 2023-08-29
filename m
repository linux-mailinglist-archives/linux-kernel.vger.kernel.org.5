Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEE78C106
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjH2JMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjH2JMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:12:01 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3397;
        Tue, 29 Aug 2023 02:11:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c353a395cso532540666b.2;
        Tue, 29 Aug 2023 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693300314; x=1693905114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uzSuIOJ3sqvXAI3VO2/i5132hzppV1oPr0EHGMgWBHI=;
        b=Pm3pqOVX/mOZ7WHkGFW6WyTXfRRw2ptaRtfbVrfVoVdFHjicbkavWitLv7DRPoaTej
         bQ4CcaCgyGB99A4JZcYaxLE6Ns7/U/4TjIuyiAgSfJqlFKERbxIZAZFwXirFM2HWNZen
         vCnKOJFuv6OrNPhjSC2Sk/OBRgQnyPrjawimAjXTNpirFFNCcoBqJqO5ZYSwTLM9OrZ7
         NeCondDF18l5m8XZDOmoOFXRR7tOU1nI1e42VprCbhbisrO3bWe9HfAsQNsR1wDVPf4Q
         FMXdpV5yzLHm3tbv6lMFNuDXZ5gnmUUO9KP0Jpq+X3d30Lfy36t6v7QsyXhRUlQ+r482
         hYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693300314; x=1693905114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uzSuIOJ3sqvXAI3VO2/i5132hzppV1oPr0EHGMgWBHI=;
        b=go5na+Y760846PH9W4eOGdpMDmRDpJ0g2huqniqgomFr+WSIoz1bzeBHaHOgQZctZu
         McfpeyKBg3TOJFcmEcOvDjeLN07ZHtz5chjmA0R2xCC2QsaiXNkYnz4X2njMfIXW8RtW
         blc059hkL+rdO/ysIrGw8oZgyOvHC3YPCCnaSVlu3sdh0xFn6kR/BIiiqrFKBwFAMs8y
         xgqdw2/9CXQX9Fg+UCi6Lc6kmyOyWg9BGSNYcJCZBXslnMMTHccI6uZe0dMVZgSZhAbn
         p00saQfOXZ39k7SRW+z63xxJMoSJ2WrhIrLDt0KbvtlELHT8NdsBNN2enhNXGWueBb1+
         jd9g==
X-Gm-Message-State: AOJu0Yy3kmh3VllAVA5USCrFwKLNgnDQHqNzfVdZbrDXmqiO2keFyqP+
        6G1h9THb3qGztewqrctCo0w=
X-Google-Smtp-Source: AGHT+IHyQe8RnjtzcC0yd6y6svQSSefXBSCX188B5o03d8S1ty9U2ZhHzFiVv8/Gx7MPhSRriaDvGQ==
X-Received: by 2002:a17:906:ef8c:b0:9a5:cc73:a2a6 with SMTP id ze12-20020a170906ef8c00b009a5cc73a2a6mr778916ejb.14.1693300313749;
        Tue, 29 Aug 2023 02:11:53 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef34:6000:bd39:43a2:571c:1c76? (p200300f6ef346000bd3943a2571c1c76.dip0.t-ipconnect.de. [2003:f6:ef34:6000:bd39:43a2:571c:1c76])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b009a1fd22257fsm5715350ejc.207.2023.08.29.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 02:11:52 -0700 (PDT)
Message-ID: <5a31871d0e0322b9704633bd2dca2503c554c358.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 29 Aug 2023 11:14:31 +0200
In-Reply-To: <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
         <20230810093322.593259-2-mitrutzceclan@gmail.com>
         <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
         <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-08-10 at 18:36 +0300, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 01:57:02PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2023-08-10 at 12:33 +0300, Dumitru Ceclan wrote:
>=20
> ...
>=20
> > Is ad717x_gpio_cleanup() being used anywhere? Moreover I would maybe ju=
st
> > get rid of
> > the #ifdef wrapper and just select GPIOLIB. How often will it be disabl=
ed
> > anyways?
>=20
> The agreement is that users are depend on and not selecting GPIOLIB.
> Any news in these agreement terms?
>=20

Hmm no idea about that. If you say so, it's just one new thing I'm learning=
 :)

- Nuno S=C3=A1
