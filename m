Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11D7F3644
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKUSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjKUSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:40:39 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912EA193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:40:35 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5cc3dd21b0cso430227b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700592034; x=1701196834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJi+hwHIFMEK75b+gn7N3ATHUD4KW+X7YkfL5jpJno0=;
        b=hrdgv90scQ4yUIzJlsUMbmA1tgnuWnWqJ3sYXRRFDGbKkXTFir4Y0zukJEBb/+tIBP
         iakgS1Y48/wLMYv96yupuakHMN3TG3ATE3QhdhgE9/MCB09bBXDQRo2ykZIUIFLVdK8g
         D4P0sOk+sby4avP9UBgxkHrAVELIT+U2cspg9Hpadtafk/h/IdZd7kh+R1Jd2/iQK618
         EhO3zYhtYQi3fF8n3gg3VyNKa6QZ14JSdG9+5Ig8OuAtfp89foyKHi7oAWDjiyiXdkWS
         fCV6oyEx1trE4s9I6qi2e2eZiO5WVMJ8pmeRA3L5Jh+HtDzK1GUpGGLb4v6VpQ3rOeQK
         87Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592034; x=1701196834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJi+hwHIFMEK75b+gn7N3ATHUD4KW+X7YkfL5jpJno0=;
        b=DsD4o4U1cofrDyijEhHPuUo0nLs5tqO1NpU6+Im+4p8u6zhIr0nClQhCHCUTBZvJ6f
         maWq+h7VigMWj+NQfXhMX2ez4fP9KCjZpEBF4Brh7ttTJDh5p00AQqJYNsqqJdu5znuJ
         ocwSwF942ol79qm+D/FR2HucCov16QjSIZ8kyOvlhs/aRciUjKcY+OsaHnL6Pza2f9ZC
         EOiR7fuWeT/FVIgXOrgLqMZnACsGnjO/EkYzwe++5RievEulb0sEggLlOqzF5QVPedH7
         vbUjSffZXlu4IStL/F1mRnFiFthruoGnHH4IZclfkPBFE0TTCTzJhaOzjMa36Drk2dPa
         LR2w==
X-Gm-Message-State: AOJu0YxxA5Is49VkwmqWVROkEgXBYUODoqQ6pErnQYOEgrtdu7wmUfQO
        dmPUhhaOJ6mk4xKbAiIOukZ+6nie9rZkH0uTfErIUg==
X-Google-Smtp-Source: AGHT+IGo9pi90+0YW1WgYDu2cpBw4ag/fwWszyzluW/acVk/pI4XfP2FVzn6cSZRSsVDe7lfiSGR4LwIsnI7Xd5IyxA=
X-Received: by 2002:a0d:dc43:0:b0:59b:ec85:54ee with SMTP id
 f64-20020a0ddc43000000b0059bec8554eemr13643015ywe.39.1700592034763; Tue, 21
 Nov 2023 10:40:34 -0800 (PST)
MIME-Version: 1.0
References: <1700577493-18538-1-git-send-email-quic_msarkar@quicinc.com> <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
In-Reply-To: <1700577493-18538-2-git-send-email-quic_msarkar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Nov 2023 20:40:23 +0200
Message-ID: <CAA8EJprOwxFUk_=uE+5788+N5bSKTMa1=t77nRWVu9M7xnjJ3w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 16:38, Mrinmay Sarkar <quic_msarkar@quicinc.com> wro=
te:
>
> In a multiprocessor system cache snooping maintains the consistency
> of caches. Snooping logic is disabled from HW on this platform.
> Cache coherency doesn=E2=80=99t work without enabling this logic.
>
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> platform. Assign no_snoop_override flag into struct qcom_pcie_cfg and
> set it true in cfg_1_34_0 and enable cache snooping if this particular
> flag is true.

Thank you!

>
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



--=20
With best wishes
Dmitry
