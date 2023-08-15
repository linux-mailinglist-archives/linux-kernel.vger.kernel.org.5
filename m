Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AE77CC49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjHOMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbjHOMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:04:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63FF10F4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:04:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so7476029e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1692101085; x=1692705885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZNL+lyJXlDowNIbWWyMureRuKR8rAj9k/oL5v5izxc=;
        b=blx3s3KVk/ndOnqHTKt1sHABOS2zy30PgIpcc/O3edhtSyYXL+U1vhVumuylgW5tns
         PKn3ytyiaJ6ytk2jEB/9Y/J9r5dk+ECrQ8vP4fej7ZsaU90zLfEL8c5WI+Y+8xWL7GW3
         KswpYBcmpN6pV/a+B2pCHEfuxyWJUCwAjpH2mPtA3biPXRAtjZpn0IFqE1E899EVbR7n
         Y/ODrxDrHnG5GIrN6lh+n36NQgDf4TBZ4lF1rmh+YNoBvMi5vs1ccqgom3bKi+Yllnvo
         FayWUVMZFe7cgqXwrjm8M2RKP8c7WkbJPnMmhNfF99W3HC5Apb8ulBsdcZ2u/0pdbAe+
         JiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692101085; x=1692705885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZNL+lyJXlDowNIbWWyMureRuKR8rAj9k/oL5v5izxc=;
        b=SrSM1MHbFOMLywCems6vDsW1iS2BM2dn/iVHZH/EYcBNf1QvzcxLsW42AEtYfvbO9i
         IsMhULpPg8twh1rzDJGgAoIr5E5n5K5Eda1taKDuRhzOyyilsj5Fd42Cv42zdhwMhPYz
         +9z6V1tw/OHwGZaShJ4D+gMNZ56+Mw0r5NpRom9FehD4XfjTuh5oCuXFhvHO/wHXVuWD
         MiJJD1JAgfQWdE/UipAA8SHis3/5VlREbeV0+TdMM2Qr4wsHmxObB6xInxkvcW+HY7U7
         tdixmguP/eMjyBaT+RAGdROdk3IvYTrMOhXxPl4+HBivpFAf+BeLizVTX2KVCEme8u7x
         QnSQ==
X-Gm-Message-State: AOJu0Yz0letxj7aY4GDvTHYQPfp+JnWna4CqpCHhg61sfrfZAequ/TUS
        IxkEJpk0+jx2CXA99LJAH/+b54Ug/nVRNKlAyK3iKQ==
X-Google-Smtp-Source: AGHT+IE8gqnACIFDnu3Op7a3XdWdZvfD0AG054fdNXDttJp1YBYTEtCJFVXxXzSJqp5uo73PYYcNwsR3tNOjvzRqhzI=
X-Received: by 2002:a05:6512:710:b0:4fb:103f:7d56 with SMTP id
 b16-20020a056512071000b004fb103f7d56mr469965lfs.14.1692101085051; Tue, 15 Aug
 2023 05:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230814181823.3662-1-aboutphysycs@gmail.com> <20230814194335.GV1428172@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20230814194335.GV1428172@hu-bjorande-lv.qualcomm.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 15 Aug 2023 15:04:34 +0300
Message-ID: <CAH3L5QrLyAHyA3zdtjM7+eNQk5vExq=d9LWaOegXpv+-6s4Jzw@mail.gmail.com>
Subject: Re: [PATCH] power: reset: qcom-pon: removed unneeded call to platform_set_drvdata()
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sre@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:43=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> On Mon, Aug 14, 2023 at 09:18:23PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalen=
t
> > platform_get_drvdata() call to access the private data of the driver. A=
lso,
> > the private data is defined in this driver, so there is no risk of it b=
eing
> > accessed outside of this driver file.
> >
> > Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>
> Regards,
> Bjorn
