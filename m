Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC887A6EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjISWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjISWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:30:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242FC0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:30:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59bdad64411so63265527b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695162632; x=1695767432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWE12E4GSEQPScLBBOQ9P6hDatI6KkLL6gqpAgFkrJo=;
        b=soJyAgZiT4Cl7Zd2UErM9QgPsoV+TWtECVkyzApg8RgfBkCVmq++TeHLMxGN4JQvdC
         JC1JY1D+T4gmIgV3LHMka6wvWCDNq/OrVM6vjYTtbJEe0v4LnoNXhWtZe/DhSN1jX3ZW
         ninZ1J+7mXQ0cMMISmlrIT8FVutMPdQX4WuH1qO5L3aom8xYy0Oyxww+r7d/YVUfEYPQ
         b8pKQ1lOXj2wIoRatfTCnjRMoIh8SYslIdt2xaTwQiZYo3vqu1JWn03RP+RU9Es5CAf9
         GOsVIG1mIb1rURhhaMZtZX+2QGts9z+H6Ir1MdvV49b2VzIMo/jZcSX8aYuBY8JJFKXV
         bMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695162632; x=1695767432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWE12E4GSEQPScLBBOQ9P6hDatI6KkLL6gqpAgFkrJo=;
        b=EcHKwNguR0B5QqLtO0kwRwT2KQmf8MNEzhiLiAbxfi2jDtELcNC/l514l68XC94Mlm
         KdsX8RcTNkQQVB5deikg44tgrXUG4BQgfUgnuKvilLizzUYlLYsqcsZzMwQX70hHWzEn
         RyKmhqN8pIfc9Xg1ZrBxd8MfSocoen7lx2yXcUKofuLD2GczScmgIxZNsWzI29FeyP34
         OhUVD3vz3S8qSAPS9qKvMD8JgSKoYsTq8P8fr6qFGJTDH8C0FBkt6DIMGP37WhjlhOfm
         tKVx091IrjagShe40C86dKkCFneQ6BoA42PN56OKPECFi7ylw5gzlZPDdd0UD/i/fWKa
         FyPQ==
X-Gm-Message-State: AOJu0Yw6UVe6zrap4F4g1sn0xrkSwVgv5nK0eA7wsYjzUZNzGpsn63kp
        pvUXyGOl5nhq7hZIBo2+h5XxB3LAtRpRgGEFnCSIFg==
X-Google-Smtp-Source: AGHT+IEV8SVk5WgId3f74CGiOEcj5v/vf1O/cO2KcQDyXtlP/RbqH7RmWLEiFf0qFc30CL2l7x/95xY4aKHQ9wEx8sQ=
X-Received: by 2002:a0d:d88e:0:b0:58f:96d8:e7ad with SMTP id
 a136-20020a0dd88e000000b0058f96d8e7admr899833ywe.18.1695162632620; Tue, 19
 Sep 2023 15:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-5-git-send-email-quic_cang@quicinc.com> <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
 <20230919121524.GD4732@thinkpad>
In-Reply-To: <20230919121524.GD4732@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 20 Sep 2023 01:30:21 +0300
Message-ID: <CAA8EJpoqRBxS7HJrFdRAvv677hKJw+d_K+fN_4ABDrj+68r28w@mail.gmail.com>
Subject: Re: [PATCH 4/6] phy: qualcomm: phy-qcom-qmp-ufs: Move data structs
 and setting tables to header
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 15:15, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Thu, Sep 14, 2023 at 03:28:59PM +0300, Dmitry Baryshkov wrote:
> > On Mon, 11 Sept 2023 at 09:01, Can Guo <quic_cang@quicinc.com> wrote:
> > >
> > > To make the code more readable, move the data structs and PHY settting
> > > tables to a header file, namely the phy-qcom-qmp-ufs.h.
> > >
> > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > ---
> > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 802 +------------------------------
> > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.h | 805 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 806 insertions(+), 801 deletions(-)
> > >  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.h
> >
> > Is there any reason to do so? Other than just moving stuff around, it
> > doesn't give us anything. This header will not be shared with any
> > other driver. Just moving data tables to the header (ugh, static data
> > in the header) doesn't make code more readable.
> >
>
> I think the motive here is to move the static tables to one file and have the
> rest of the code in another. Because, the static tables itself occupy 1.2k LoC
> now and it is going to grow. So let's keep them in a single file to avoid mixing
> it with rest of the driver code.

My 2c is that this is mostly useless. The headers are for sharing, not
for moving the data out of the .c files. Not to mention that the
driver code comes after the tables.
I'd really suggest starting such a move with separating common parts
of all the QMP drivers.

>
> - Mani
>
> > If you really would like to clean up the QMP drivers, please consider
> > splitting _common_ parts. But at this point I highly doubt that it is
> > possible in a useful way.


-- 
With best wishes
Dmitry
