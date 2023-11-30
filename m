Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9E7FEBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjK3JUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjK3JUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:20:07 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D81A8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:20:13 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9c39b7923so9169971fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701336012; x=1701940812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6b6KMY0n/M+YsXFiDbvehOF3zPBGbEVpkXj4Ck+RiQ=;
        b=qYUBe5NbUG421ICdyVbZLL2FOGrYAQStxioh9oAH6v7FFdQdiKhTVgkoCMUCq8MnhK
         Qbkcolp6fGBEcEFCkoMibAn1GRGhOuVwSYeRZ1qGi5Q7eENPmtqpcM9ZRRV0XtXx04Z6
         C0Dpj2dPCBFqUwEfROS4T1yKMT1kV5pD94VSNs+Lwq8CFvPXwWTIrjQyRIKu8t8jzU6r
         bXsU5IAtefvdWNkQJiaoZ1WkC6i79UUEE6vH06tpuGK0Whr2q5VCZCWF9/RTpF8w0AsK
         Yf2qv5hXh41NCI6fGLfDXsWbK4nnqJhUJiTV0TudexR2vDivhiJ6LUgkmBsho4vJ7U3m
         cQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336012; x=1701940812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6b6KMY0n/M+YsXFiDbvehOF3zPBGbEVpkXj4Ck+RiQ=;
        b=a8YwwTzcZkWUrwgx3Ek4LVqpgCRuXBlB6B5jxvAbLIXuHV5GmieJYV0FL2TT1ekPmj
         XWvA/SeNMV5ldIXz9GD1bwQ17zZonjgRGXmb3rISniSnYE+s5AAlBWU1Rp4QPwdNznhK
         2FeVTBrzcdzxMR3c0piE9/S/eh2dwymvSiVXORfHj8P7nRRu0ePlWJDNQ0IGctaqqiwL
         /hrdNVo7ADLwZUaS2d0WQY0Wk5qCCKcycQqbMWipaayD79nilvLuUvUYpEud/KxvVyXr
         WQiYhrUzSys4/mqa/15ywZYVvsJ4EME1tPxskyGhbz32W6TrzXg2iMtGk9tvHLuk2W/F
         Gliw==
X-Gm-Message-State: AOJu0YyeitAa6oZtFZ26YMs/oEmva+/5Zn48RsVrOy+FgcIkijBzNq0Y
        0veW33nYSQosF8T+GQmiy3EiZQ==
X-Google-Smtp-Source: AGHT+IEaYhPPx9yJTn+Tt40iUWKql5jCkfrMLBxyzujYNVF6glNzpgT0IKlw+OZMcX2IHP9baN/WqA==
X-Received: by 2002:a2e:8ed2:0:b0:2c9:c0dc:b074 with SMTP id e18-20020a2e8ed2000000b002c9c0dcb074mr3036689ljl.3.1701336012029;
        Thu, 30 Nov 2023 01:20:12 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d44cc000000b00332c6a52040sm955607wrr.100.2023.11.30.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:20:11 -0800 (PST)
Message-ID: <ce0800c9-513c-41f8-bb02-43b2f1d60092@linaro.org>
Date:   Thu, 30 Nov 2023 09:20:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] mtd: spi-nor: Stop reporting warning message when
 soft reset is not suported
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     AceLan Kao <acelan.kao@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129064311.272422-1-acelan.kao@canonical.com>
 <20231129064311.272422-2-acelan.kao@canonical.com>
 <9c97e28e-fbb8-4a7f-8205-821fcbd579f6@linaro.org>
 <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2e88fbd7-64ac-41a1-8368-edd430e86e6c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 21:19, Mark Brown wrote:
> On Wed, Nov 29, 2023 at 07:46:02AM +0000, Tudor Ambarus wrote:
> 
>> You haven't specified who shall take these patches. Is it fine for you
>> if I take just the SPI NOR bits? If you want Mark to queue both:
> 
> I can certainly take both.  I guess there's no build time dependency so
> we could each take the subsystem specific patch, though there'd be some
> bisection drift if that happens?

Right, please take both then. Thanks!
