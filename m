Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2087D6F24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbjJYOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjJYOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:35:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A068137;
        Wed, 25 Oct 2023 07:35:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9adca291f99so850289866b.2;
        Wed, 25 Oct 2023 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698244520; x=1698849320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wa2G+lxO+loR/ZXT0iDtzSScXiPVh25VRSHqQvCFhZA=;
        b=f0Spdrci34wXz5639Gl8cg+bcFP6JqSbWh5EyzPZZ6oIjIdRKW6aWhZ6Yfi1R7kS39
         sYBc7DUuejjFgxq3qcJ55i74ihpFU99pTsN83/bLqjwJZa22wrQjN9A5PqEHiYMpNj1r
         sAMWJTm5po9zU5MlJ+28XT9kZYpe/jBP/WWWavR6Vya3ErPtRR58IJvtMNddSy++EDR5
         bKlkUuld07/cqgDUXQRjEqt6OeyAuSFkuFgtS4ZmN+KlXALwYZwBQNOwySL09prsVurj
         cBkaO+w/kCSfYBPyWg3PzlfXeYxQt1PYcYWxSkevLXPPvT9Jh7HCOhVlk0z4J1YfPNko
         7Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244520; x=1698849320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wa2G+lxO+loR/ZXT0iDtzSScXiPVh25VRSHqQvCFhZA=;
        b=o6A+H3D79zhFh5Z5pdnFPP/Uhk41Icp3UDWK38kTcP87f9u9d8V6CGImHaUibrcOtx
         CRU71vteEsuKaC79HkbrTEyxu0gX5Gr4qyz9vOVbOCk8DjS+mKFOSt2lTMruqlK1PIvp
         GHji7YhyzkpTcksFCFgNjf+0Qcu8D6iLznVp7xOfVvAJEVPktQb21z11b1rp9pOeGw8W
         Bosqc82ddTbvbpa5cUgoJ156G7O7mlY/Ut4kvVpMQe/YRVQaUQYpiKZvtqfJi2XOZYqo
         PuJVS9j1uhcscX2P+oxxGQxZmy3XBkn/nmLnC9bAS2t4gjO+/Pl1uyxqCIXIGe2zvvkq
         9ONQ==
X-Gm-Message-State: AOJu0Yz614E6bvNOfB4haghEbKTTzjJnLLPO+cTnrQ/WULHs9bMcrfEp
        nXMHNc4Q0h0/59OioeblldM=
X-Google-Smtp-Source: AGHT+IEJqDsloM/YroQyh74Z7dfLKajJ+dw1JlaYJw2anzB5FtuM1hIRt2JDymqT07lazEOdUQv3Fg==
X-Received: by 2002:a17:906:9fc1:b0:9b2:b15b:383f with SMTP id hj1-20020a1709069fc100b009b2b15b383fmr13571020ejc.43.1698244519276;
        Wed, 25 Oct 2023 07:35:19 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id vg18-20020a170907d31200b009adc77fe164sm10005667ejc.66.2023.10.25.07.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:35:18 -0700 (PDT)
Message-ID: <d914069815f76245ef91b6b7b0c6b382b054b562.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: adding support for pac193x
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 25 Oct 2023 16:38:10 +0200
In-Reply-To: <20231025134404.131485-3-marius.cristea@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 16:44 +0300, marius.cristea@microchip.com wrote:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the iio driver for Microchip
> PAC193X series of Power Monitor with Accumulator chip family.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---

Hi Marius,

I'll be honest and I just looked at this for 5min. But I'm seeing things li=
ke
shunt resistors, vsense, power, energy... This seems to me that it belong t=
o
drivers/hwmon. Any special reason for IIO?

- Nuno S=C3=A1


