Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B78039E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344621AbjLDQPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344660AbjLDQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:15:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71AB9;
        Mon,  4 Dec 2023 08:15:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c0a0d068bso12968245e9.3;
        Mon, 04 Dec 2023 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701706548; x=1702311348; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FSQGhYW0bY66ZvocdwYpg6HVOl8T1zzGGaHQNQEHYQw=;
        b=gep/beJZh8/0CpGTZq9VIqTzFtZtdpkUgirDdFVhoUnxXQCG4oQgbOtAiYbXprzKbD
         ctEPyNMk5yXRa7HCfmsqwhARLpesQpQE3UvxqNPgL5ArmgYiO9NE/6sjGImbKX6s4ngY
         uXaBV4GEqEjldgO7bM81avLeqZIifxexrPfp9ffaD9uTJpW3bOMd9I6phpO/Zdau/Kbs
         y/Ehp7FSK6GkFN+8bmpNfmUvMjxPsPYR97O1lGdWsjvor0PT780UAf9TonXDrz9p5ppy
         o8MVAj5PvNHg4J4oPpbFY5Aeq5WUhrLc79Ln3dts7pRsZcOIErMywmwFOA4LM/rwiy5s
         Vc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701706548; x=1702311348;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSQGhYW0bY66ZvocdwYpg6HVOl8T1zzGGaHQNQEHYQw=;
        b=IcbANF4L5OY3Vzi/7gnHZEFJMNNitRuvmliPQ5PGKmacf1gyVcoGQENnzpodFj+q/m
         UMMl4cg7PjVVZh6B1I1QlFK0pLb1O3HoYuMA3U3alDq19LJ6QjOREfND4S7FmT18m30a
         2cO74YGICwz4NXZ9cDla3t8qY9CM5/FWURVcTkNsEYnC2oeFY07daLGzyCBXfPbc0jxJ
         Ee5llnUjduNjwFdHXopN/o6fCQ8S/c8WbfdpVGsnJ6+tH1asCNtPzI4ly/eqLUVTaQap
         y1xl5GB57CNiyg2omPfEzuoJestUAIBTvNZB7Ns1pMjLeaMRBvSkBoqIwF5uM0BK1YS2
         +wtw==
X-Gm-Message-State: AOJu0YzGxFC083GoVky+MsriLrZ+ximD0RI+Z42Mrd7glZ6l2qmrMqYm
        r7Gn2fJOxShwcvIKIJBVY6mzW3/Hq7njtpL8oDs=
X-Google-Smtp-Source: AGHT+IFCLef+MGGwqb5ZAEG7DSBNXfIILNOv0fP9FLHKiqMc3ojxTjqD/l+uXV57yX0c9CNb6Aj8fA==
X-Received: by 2002:a05:600c:470a:b0:3f5:fff8:d4f3 with SMTP id v10-20020a05600c470a00b003f5fff8d4f3mr3613370wmo.7.1701706547930;
        Mon, 04 Dec 2023 08:15:47 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id x16-20020adfec10000000b003333beb564asm6615666wrn.5.2023.12.04.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:15:47 -0800 (PST)
Message-ID: <3d03874e6426fa0bc94929262acc4d40e2d93d46.camel@gmail.com>
Subject: Re: [PATCH 11/12] iio: adc: adi-axi-adc: convert to regmap
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno Sa via B4 Relay 
        <devnull+nuno.sa.analog.com@kernel.org>
Cc:     nuno.sa@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Date:   Mon, 04 Dec 2023 17:15:47 +0100
In-Reply-To: <20231204155158.411b4bbd@jic23-huawei>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
         <20231121-dev-iio-backend-v1-11-6a3d542eba35@analog.com>
         <20231204155158.411b4bbd@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 15:51 +0000, Jonathan Cameron wrote:
> On Tue, 21 Nov 2023 11:20:24 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Use MMIO regmap interface. It makes things easier for manipulating bits=
.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Perhaps put this in the precursor set as well. Looks fine to me and will =
just
> be noise in the main discussion.
>=20

will do...


- Nuno S=C3=A1
