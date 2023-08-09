Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49877546A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjHIHtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHIHti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:49:38 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20B19A1;
        Wed,  9 Aug 2023 00:49:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b2b60731so41001515ad.2;
        Wed, 09 Aug 2023 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691567376; x=1692172176;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I7R8nlVGLuiSPOLBhq2QOhIEsWu1cNAXuEA6AAZ6Y4=;
        b=gplYjsedbl+L0IMXDxKHXFkPZeM9BKJ6vdw3uzY4RBtaoSoSqNugVSLPiVcFHB6+VS
         1F9tOA7VwRg2TU839OuuOBCz/4mG+v9oV+DBtG9rZXzcxiS+kH1WSeEsv5noTTKNlOrr
         k/bkejas5fOq6sR2HYvbwEVdA62KFSVNFRJgy1vbEpDHSU3Klfhyns64kMeiJeIsy31n
         NUGlpFDMuZfzSVAMxAptr9XrmEKQKK2iHZdrFCUvqxkXoyBWyPMBE2UctCo2EXeAw0zq
         ocscXGUIQ/RRw9j3PYU33dYnln80vFeLbKBsxbqJsoKg4o2DXHJRi9KJCUla5BwV35WT
         18UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691567376; x=1692172176;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8I7R8nlVGLuiSPOLBhq2QOhIEsWu1cNAXuEA6AAZ6Y4=;
        b=dU8UiHC24+ae5KU8V+7UIvPP/VzTgDORkfN8/SXIYmJlkVz8/TjmmnPePxGlehUf8h
         VoRzFfv+WEn12/tt96tfBTPL/iVms2JNzvdfKzxxm95SZLVFW62vCjE23DiHmXAJ1CQk
         C2P7bdTZ4cmBSn4kjoOd0RYAMJ7AUVkPROrJNQTwcO+q72yMxSBt0WtKIfNTXd9AB3dN
         jgK7xpWQUU0asIgjEoBm04RP6xQ4z3kWjnuYNWmL/p4iYCYPHGhFBNkjU7D9mdN59fUW
         ATXwqk+c0Q8C/mZYVQjEG0AR514MulPjrAxJfF3KybNPj/ok+Rhu9zBBJcq6ZbYlVJjB
         nHqA==
X-Gm-Message-State: AOJu0YyzlrhFI71maaJ2l6Gie59C1oAmrO2PPH1hbqMUTbeUS4SmwZ5J
        gPl7PnOiSFZJM71jBOPmHZY=
X-Google-Smtp-Source: AGHT+IG1mqiqcQOPg+6OklA7lwp3XuUGcNchKQNJtVUmasQCc5+fZq7s0O2q3Rrn9aR1oooYJYwE+Q==
X-Received: by 2002:a17:902:ea09:b0:1b9:e1d6:7c7d with SMTP id s9-20020a170902ea0900b001b9e1d67c7dmr1518767plg.47.1691567376420;
        Wed, 09 Aug 2023 00:49:36 -0700 (PDT)
Received: from smtpclient.apple ([2001:e60:a880:2dc4:934:4e53:662c:983c])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001b0358848b0sm10359361pll.161.2023.08.09.00.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:49:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: Feedback on Qualcomm's minidump (debug) solution for end user device crash
From:   Kukjin Kim <kgene.kim@gmail.com>
In-Reply-To: <ZNEJAh0in/fjq6s9@brian-x1>
Date:   Wed, 9 Aug 2023 16:49:23 +0900
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Message-Id: <1DAA278D-BDFE-4880-8453-99F098D4E259@gmail.com>
References: <ZNEJAh0in/fjq6s9@brian-x1>
To:     Brian Masney <bmasney@redhat.com>
X-Mailer: iPhone Mail (20G75)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023. 8. 8. =EC=98=A4=EC=A0=84 12:08, Brian Masney <bmasney@redhat.com> =EC=
=9E=91=EC=84=B1:
>=20
> =EF=BB=BFOn Mon, Aug 07, 2023 at 06:01:27PM +0530, Mukesh Ojha wrote:
>>> On 7/30/2023 5:14 PM, Krzysztof Kozlowski wrote:
>>> On 24/07/2023 18:59, Brian Masney wrote:
>>>> + linux-arm-kernel list
>>>>=20
>>>> On Thu, Jul 20, 2023 at 08:32:24PM +0530, Mukesh Ojha wrote:
>>>>> Hi Samsung/MTK/Any other SOC vendors,
>>>>>=20
>>>>> This is to bring to your notice that, we (Qualcomm) are working on
>>>>> upstreaming our minidump solution which is to address the problem of
>>>>> debugging on field device crashes where collecting entire ddr dump
>>>>> would not be feasible and collecting minimal data from the ddr would
>>>>> help in debug direction or even help in root causing issue.
>>>>>=20
>>>>> We have recently posted v4 version here [1]
>>>>>=20
>>>>> Based on comments[2], community is more worried about, if each SOC
>>>>> vendor come up with their own dumping method today or in future and
>>>>> whether it can have a common solution to a similar problem faced by
>>>>> other SOC vendor.
>>>>>=20
>>>>> We wanted to take your feedback if you also encounter a similar proble=
m
>>>>> or maintain something similar solution in downstream which can be
>>>>> upstreamed. This will help us in a way to have a common solution in
>>>>> upstream.
>>>>>=20
>>>>> [1]
>>>>> https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quic=
inc.com/
>>>>>=20
>>>>> [2]
>>>>> https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiy=
ei-u9=3DCv=3Dw@mail.gmail.com/
>>>>=20
>>>> Adding the main ARM list to solicit feedback from other silicon
>>>> manufacturers.
>>>>=20
>>>> The cover sheet on the v4 patch set is available at:
>>>> https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_moj=
ha@quicinc.com/
>>>=20
>>> I doubt anyone follows the lists, so at least Cc some maintainers.
>>>=20
>>> +Cc Alim, Kukjin, Vignesh, Nishanth, Matthias.
>>=20
>> Thanks @Krzysztof/@Brian for extending the list.
>=20
> Hi Mukesh,
>=20
> Since no one has responded yet: I suspect your best bet to land the
> minidump functionality upstream is to refactor it to use the pstore
> functionality that Rob suggested:
>=20
> https://lore.kernel.org/lkml/CAL_JsqK7MHR09U5h01=3DGf1ZLeDVCgZdN-W1hQRH3AX=
+E94_uUg@mail.gmail.com/
>=20
> Brian
>=20
Hi all,

Sorry for the late response and thanks for the asking.

In Samsung side, we=E2=80=99re checking about that internally as well. I=E2=80=
=99d like to know whether the minidump upstreaming is considered to be used i=
n other chipset or some logic of that can be used. In addition, if Samsung w=
ants, own the way upstreaming can be acceptable. It doesn=E2=80=99t mean we h=
ave a plan at this moment though.

Thanks,
Kukjin Kim <kgene(at)kernel.org>=
