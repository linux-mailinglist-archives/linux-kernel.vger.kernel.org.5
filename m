Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748A786EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241340AbjHXMTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbjHXMSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:18:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CF019B4;
        Thu, 24 Aug 2023 05:18:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2690803a368so1125767a91.1;
        Thu, 24 Aug 2023 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692879526; x=1693484326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlrwwqTITMhKtvHsPQuVmQL/Kh4vzSe7uyS+aD745jU=;
        b=koMPnyXn6Igj4hcEbLjqmvUXvWdPF22PQ1eOUIB/NDEaftA4pNLvYDLE8iv3qr5PRU
         uBFIuKQcGMWwQEzGTrfTcAmnRq7N9m3x07niU3KimvJDZx4vQy4LL3ZIaotq5YX3L1KQ
         1eiy96mitwWkxnWr94pnXWjKujPLAxX9qwtiIyfGehMbsrvdD+FnU3n2VMyYRfHa1AAU
         CwD5LgkQrpo0bcRYc5Y9ySArIN1woeaU9kD1DmduHGrvXgktq1PLtEtvSshk2E4X/PeA
         7BGwWz5q9LvJALDdZ11pP7YquIDNKo7q52A/+8O3cHg7n6PcksfRsz5UtszS53Zoor1q
         1IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692879526; x=1693484326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlrwwqTITMhKtvHsPQuVmQL/Kh4vzSe7uyS+aD745jU=;
        b=IYXoYd9k75qSjJJ5QeEGkPpDhdMg2rbJQUUt1Jw2/OItAoesZSaJmMRiW9bg+RS2Tr
         b/WFnST512E+xOaPjrPshrubAd8fjSHkjL+ifUFetojfiYLQNrwIVJPX+6j73jfMj9dr
         7Q9BTlKpxii52M0d+6LJutc1d5xXPjdAgbihXKWAlsKFxeDMNV3BZPcWe3fHRiCQqPK3
         WGJifcqx5RPezHfXogOvteTnGy7/tKPUyyOwIKgAyQqMC2Zt0YoKd8sz7rdIHgVH+vhZ
         rKBBBTvxvxe+3tqAAN9K5A2bb84aiTH3vlavBUSfdX5NKoJdCBTD4xR4bc+4c8WhFj/y
         X9/w==
X-Gm-Message-State: AOJu0YzqnsnwpsDMikMa0TrirMX/Dqnuj8rFZWvetLAdjdICMoRnHinW
        2DQG07pecmB0uIPeIkPfrl9/NUWS9gHjotE8wqK+Z6l2
X-Google-Smtp-Source: AGHT+IEAoiKfYXAZ/wDNtwk7GNCrx6ELbsv4RClO7gblygmbcag2A2VLQgTJ9cLSOHt3L1H4LymrOeJ7i/vQNkmXYpg=
X-Received: by 2002:a17:90a:6e4b:b0:269:34a6:d4ca with SMTP id
 s11-20020a17090a6e4b00b0026934a6d4camr14130881pjm.0.1692879525718; Thu, 24
 Aug 2023 05:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230824112705.451411-1-festevam@gmail.com> <a2a613ce-be6e-6bd9-774d-9e3ed994f45e@linaro.org>
In-Reply-To: <a2a613ce-be6e-6bd9-774d-9e3ed994f45e@linaro.org>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 24 Aug 2023 09:18:34 -0300
Message-ID: <CAOMZO5D=kzVMEeHqEBj2uos=BLDhKbOE7SZNL4kvpdVaMZkDww@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: imx8mm: Allow reboot after critical temperature
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, Aug 24, 2023 at 8:57=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> Is it possible to set the .critical ops at init time instead and get rid
> of the thermal_zone_device_critical(tz) call ?

Yes, I have just tested your suggestion and it works.

It also looks better :-)

I will send a v3, thanks.
