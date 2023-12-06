Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E31480735A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442391AbjLFPHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379080AbjLFPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:07:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D207D44;
        Wed,  6 Dec 2023 07:07:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-286f3e0d010so306948a91.0;
        Wed, 06 Dec 2023 07:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875227; x=1702480027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFG4UQm/cuvqI2sLEzxUtNVUy9Dp6b45Fjtf+xUWjI8=;
        b=D8VZS8jErHLA7v+DdigBOqs1SSfHa6rGMvOqPPt4Z96bOMu0YkUHEh76vX1B9XXzPl
         91RxLeYD/xDyamasLMOyPo2unMiSDeKV2UOE/oFFaWDBSNUYZUT3mvjg5LU3MfXNLFdY
         sUutxEpuwDoKHMgMu2Dzq1CGSuLp8bcEPjH6bhIquO8VCvbaq/SooleACDWh2kZWao6s
         Z2n2GcM7knDo4+SZoCSOVStfENprd+WvaSH4arvdS+j6SpY5t2W0fCzl8J8ghROI36Wh
         ITEVdZwrMLXe8YhkTCAClLYffFfDYTPuNWfuczoAlw6cEQi1UUBYGqXErVpmT9Q3DWac
         oZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875227; x=1702480027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFG4UQm/cuvqI2sLEzxUtNVUy9Dp6b45Fjtf+xUWjI8=;
        b=IXRf3hH1hvD/dR+pHnTFDrn3Rydi1EgX+pNn89+zBw+YOKZaQfj6nQqCjedM8QeLN4
         XBfXiig+uIm74ryvrwPyzTcZy/iKv+3wYpj+2U7g3Ac0lu4qjv8RznNDm/Teaimy0Q08
         LOECsPqyuqu45+g+TFbcwLLHpqPecR/xxGPa42k2N0QDCfIQDIHgp2LMvNre6SemORGb
         zlYuHuArhxEjXER57B1LJaaG9lFWrKO0S3kXxro1Gr3PEUj+A6bSthE9ccStConWjzmZ
         zJ3qQJ/P4Y2Gax7weCnTo45MNZnXq2vVlEP9tCqihu/2YYSkmI7hzo1LHM3cTbDnnce9
         JfEg==
X-Gm-Message-State: AOJu0Yz1qc6b0ZNW9a1mO/G5O55wfQ9MZKV75PjoMWz3AH8MN0cCskTH
        VbDTcJ5MwtfPA3GzMe9h4Oye5wWA54O9R9VDBhY=
X-Google-Smtp-Source: AGHT+IGsvVanu197ZHrD1hlRlXiNPmpRNQQHswLoZtK5tsaiOwgjX+5fWvmFa23faIerbfynS/RWyTySBFlBT1CWUXw=
X-Received: by 2002:a17:90b:4b4a:b0:286:5123:ddaf with SMTP id
 mi10-20020a17090b4b4a00b002865123ddafmr2023530pjb.3.1701875227104; Wed, 06
 Dec 2023 07:07:07 -0800 (PST)
MIME-Version: 1.0
References: <20231206144201.46911-1-frieder@fris.de> <20231206144201.46911-2-frieder@fris.de>
 <CAOMZO5Akp9PsFf2GrSFTKyM1c3kSUEeU=W9ODgiMkyHATRWHOw@mail.gmail.com> <ce45d170-9331-47b5-b8c3-6feff489db1b@kontron.de>
In-Reply-To: <ce45d170-9331-47b5-b8c3-6feff489db1b@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 6 Dec 2023 12:06:55 -0300
Message-ID: <CAOMZO5Cx00a8DJbm3gzQAsLrQNXmTnCcDmrtMTtRg7XvYBVi_g@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] arm64: dts: imx8mm-kontron: Add support for
 display bridges on BL i.MX8MM
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     Frieder Schrempf <frieder@fris.de>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 11:54=E2=80=AFAM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> Indeed, but it's correct. From the binding docs:
>
>   v1p2-supply:
>     description:
>       A supply that powers up the V1P2 pin. It can be either 1.2V
>       or 1.8V for ADV7533 but only 1.8V for ADV7535.

Thanks for the clarification. It looks good then.
