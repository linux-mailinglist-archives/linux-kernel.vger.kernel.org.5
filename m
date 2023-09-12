Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1541279D638
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjILQ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjILQ1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:27:06 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDCE115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:27:02 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-450a670565dso1474556137.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694536021; x=1695140821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pseX5mxL0XGzXErSRsw7i0t8QwNrs2tSMGIB1qfdxus=;
        b=RMfdOWrc44XJy4OGGhz9R9MjFJQL87EaWFfhnxGgUwlFTQHbjPyeVDhtQOXqKMiU5K
         M+lff2+vwdiqmAGWSu2QVAwUcAAB5sDyCd4eRvBgp9iqu5cPUYozJeZ4gY0Kj5u0Ie3+
         LpkK4eyuNHnLEqgQ/VnfHBeh6YZPFe+ggVrfyUnQIGR7/oHE/OKIHSDXNyWFmMQZ6Pd6
         wCrOtNjY400CXu8eQWpR95OeOD9ycdXOfacupDlS9cYK7NMUwd94dvL9ff4aFGWPIUXQ
         NRwivSUXydFSZuRMSy4gcS921oQVivfWFgxtVuDrA4j3V9WVd4RHAmMCAqp0wLzTvCRX
         GokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536021; x=1695140821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pseX5mxL0XGzXErSRsw7i0t8QwNrs2tSMGIB1qfdxus=;
        b=t7xkRd1M9ssvO6LB/2d/n9nje/SdON+zFZNefNtsbaGczhoA6rsGmjj5PuDE7ZfhSm
         Z6/2VPcxZKKg9/uAfbE3qJl/l6h9hKRIpJtd3MbQ+rcenUFwckqBc5gduqIkSQR9t8qp
         94ZN+p/7C8UdmL7bWMLe58UgLGLbybeCE/4jYusCjn7CFIMvGe3f7tBOBUfpHTPV1xyN
         8oEtV836iMWkdmg2N5xJY6qYHc18dj/M480+SpwrnvyF+33IMwvWy3sG3UGrACl0ESQt
         MSslBYTtgDtNnB98ZgPSuYz7xQiq0ZtooJZ5o7R1RKtih8oMP1wLR+qm+HhpUkbteZpe
         DGLA==
X-Gm-Message-State: AOJu0Yw9fw9oEeLlhjlNRCyYek0rBhnOoDyPbg6nXBQsGPdti7a2+NEH
        xxK+EkrLPg7kht/rh0mpeiBUiw==
X-Google-Smtp-Source: AGHT+IFDtSC5zf72fWLWq0KidTMLnnuiCSs2m6UzTaQRvRZ5DF8LMG6gf0LjN9NM/ZzZ9GASPC7izA==
X-Received: by 2002:a67:ce12:0:b0:44e:b30a:c0da with SMTP id s18-20020a67ce12000000b0044eb30ac0damr11417266vsl.26.1694536021760;
        Tue, 12 Sep 2023 09:27:01 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id r17-20020a67c311000000b0044e97414232sm1719149vsj.33.2023.09.12.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:27:00 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:26:58 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: venus: Fix firmware path for resources
Message-ID: <ZQCRUkR9brqK0Fn7@fedora>
References: <6afa314b-ca5e-a924-de2f-f1db90770623@linaro.org>
 <20230719214943.22641-1-patrick.whewell@sightlineapplications.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MJaqVacy1OGcgh3o"
Content-Disposition: inline
In-Reply-To: <20230719214943.22641-1-patrick.whewell@sightlineapplications.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MJaqVacy1OGcgh3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 02:49:42PM -0700, Patrick Whewell wrote:
> The firmware path for some of the resources is still the old format. This
> fixes the path to address the firmware correctly using the new .mbn
> format.
>=20
> Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
> ---
> I've updated all .fwname to match the .mbn format. There is a
> qcom/venus-4.4/venus.mdt for the sdm660 that still remains but the linux-=
firmware
> package does not contain that firmware file anymore, so i left as is.

I noticed this patch hasn't been picked up yet. Is there anything
pending left for approval, or can it be merged now?

William Breathitt Gray

--MJaqVacy1OGcgh3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZQCRUgAKCRC1SFbKvhIj
K2p6AQC+12yl4i8rRO64p9Haennv4cMxjYHP55D91KkhvyLLtwD/VzljGXG7tbUY
qKV12MX45Zui13uOcezWMP2zCjewdQM=
=jLan
-----END PGP SIGNATURE-----

--MJaqVacy1OGcgh3o--
