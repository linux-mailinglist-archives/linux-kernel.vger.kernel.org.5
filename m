Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCC7DF39F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbjKBNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjKBNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:24:10 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC5D7;
        Thu,  2 Nov 2023 06:24:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50906f941so13041831fa.2;
        Thu, 02 Nov 2023 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698931446; x=1699536246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVyozoiaeEmN1Mqspc/fEt9AeFWqakfpxz9o248h/pM=;
        b=UML5CullAlYhiUYRshJaR+HWM22zcYguZHjyQSQhjxF2gm4NqXVRddxeP2O8sm1RQR
         PoXCNQFM+NNW1npnXU1QwDJjySWY8sobkEll8rf5UJ1jndDJgHZlScBQAK6dFpV4BDlP
         tpdhmIqL1DcxB+nQ/W1+DrJdcs6Ea3QuTh4m2zLY+8UImcQ6kIdjX8QIM4UugL1kDcbL
         BhfumCVp7YDl12gvGdh9DHAcQaYnHd5cFUBXiTsHwJbhggK8P98lxG5x/NRwRR1dpLGk
         VlQuqhOHfDrn5N/qOwDURyiYtXBZSHe6bf4aeUfrNiULy6rPIMphAcW0sCqPmds38BLJ
         zzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698931446; x=1699536246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVyozoiaeEmN1Mqspc/fEt9AeFWqakfpxz9o248h/pM=;
        b=sy4ybIQFacRJmCwlGApPw0NueXPHeTtEGmkGubo1cesUubXvdynKY5jNqJrzhym+vv
         i2Q703d987rXU65LHlu5K0M7pL0cRq7xwvXuT9PVk7BWG4vF/Jj7ShTKkw4zwL7cTBvl
         +K9VjEVpCiJAWFK15s2xY7Uas73PJjyOeulsva1WP9g4Lu8uKJKCFNztt+sJsssCn682
         bNHpHP7IYYjIIFu46BHTcT4Z20ZxN2etS42jfjFBlufDtXFp1jIZ0OQ3VpYIDSNkRUcM
         84OelOW/an3GzE2DG18gXdECqc2wSAqn8ootHizllktF+FDIqhZxbLlLIHP/x8yriRPI
         plew==
X-Gm-Message-State: AOJu0Yxxe7AAn2/JxkuP1x0Xbf46y2B25NbqdQiJplDVQIiJ8b8Datvg
        BnwG/zmek2G1jlVxlaQWrTHVKVFKLWc/LUAcyQ==
X-Google-Smtp-Source: AGHT+IFw8HNGzdISsA+wihixwdCY6OGHchatKKYXsaUOf/XMUPEES0QyeTbJFs3CMlJoKYUCvmxw0QjnLeqQO6kPsOM=
X-Received: by 2002:a2e:bc29:0:b0:2c5:b583:f167 with SMTP id
 b41-20020a2ebc29000000b002c5b583f167mr17564967ljf.34.1698931445262; Thu, 02
 Nov 2023 06:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231102052426.12006-1-naomi.chu@mediatek.com> <20231102052426.12006-2-naomi.chu@mediatek.com>
In-Reply-To: <20231102052426.12006-2-naomi.chu@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Thu, 2 Nov 2023 22:23:53 +0900
Message-ID: <CAGaU9a8Vn20Bx71mtUPYJgSgO11FXv4bNzScso7Dn2n36etaFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ufs: core: Expand MCQ queue slot to
 DeviceQueueDepth + 1
To:     naomi.chu@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, wsd_upstream@mediatek.com,
        peter.wang@mediatek.com, casper.li@mediatek.com,
        powen.kao@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
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

On Thu, Nov 2, 2023 at 2:26=E2=80=AFPM <naomi.chu@mediatek.com> wrote:
>
> From: Naomi Chu <naomi.chu@mediatek.com>
>
> The UFSHCI 4.0 specification mandates that there should always be at
> least one empty slot in each queue for distinguishing between full and
> empty states. Enlarge the `hwq->max_entries` to `DeviceQueueDepth +1`
> to allow UFSHCI 4.0 controllers to fully utilize MCQ queue slots.
>
> Fixes: 4682abfae2eb ("scsi: ufs: core: mcq: Allocate memory for MCQ mode"=
)
> Signed-off-by: Naomi Chu <naomi.chu@mediatek.com>
> ---
>  drivers/ufs/core/ufs-mcq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
